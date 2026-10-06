using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

// Compatible con Visual Studio 2010 / .NET 4.0 / C# 4:
// sin interpolacion de strings, sin "?.", sin async/await.
namespace PresentismoWebI46.Datos
{
    /// <summary>Un renglon de la planilla: lo que el docente marco para un alumno.</summary>
    public class ItemAsistencia
    {
        public int IdInscripcion { get; set; }
        public string Tipo { get; set; }          // "P", "A", "T" o "J"
        public string Observacion { get; set; }
    }

    public static class Db
    {
        // Nombre de la cadena en Web.config. Para desarrollar local conviene
        // tener otra ("CadenaLocal") y cambiar solo este nombre.
        public const string NombreCadena = "CadenaProd";

        public static string Cadena
        {
            get { return ConfigurationManager.ConnectionStrings[NombreCadena].ConnectionString; }
        }

        /// <summary>Ejecuta un procedimiento almacenado y devuelve el resultado como DataTable.</summary>
        public static DataTable Tabla(string procedimiento, params SqlParameter[] parametros)
        {
            using (SqlConnection cn = new SqlConnection(Cadena))
            using (SqlCommand cmd = new SqlCommand(procedimiento, cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(parametros);
                DataTable dt = new DataTable();
                da.Fill(dt);   // Fill abre y cierra la conexion solo
                return dt;
            }
        }
    }

    public static class AsistenciaDAL
    {
        // ---------- Comisiones del docente ----------
        public static DataTable Comisiones(int idUsuario)
        {
            return Db.Tabla("dbo.usp_Docente_Comisiones",
                new SqlParameter("@IdUsuario", idUsuario));
        }

        // ---------- PLANILLA DIARIA ----------
        public static DataTable Planilla(int idComision, int idUsuario, DateTime fecha)
        {
            SqlParameter pFecha = new SqlParameter("@Fecha", SqlDbType.Date);
            pFecha.Value = fecha.Date;

            return Db.Tabla("dbo.usp_Docente_Planilla",
                new SqlParameter("@IdComision", idComision),
                new SqlParameter("@IdUsuario", idUsuario),
                pFecha);
        }

        /// <summary>Guarda toda la planilla en UNA transaccion: o se guardan todos o ninguno.</summary>
        public static void GuardarPlanilla(int idUsuario, DateTime fecha, List<ItemAsistencia> items)
        {
            using (SqlConnection cn = new SqlConnection(Db.Cadena))
            {
                cn.Open();
                using (SqlTransaction tx = cn.BeginTransaction())
                {
                    try
                    {
                        foreach (ItemAsistencia it in items)
                        {
                            using (SqlCommand cmd = new SqlCommand("dbo.usp_Docente_GuardarAsistencia", cn, tx))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@IdInscripcion", SqlDbType.Int).Value = it.IdInscripcion;
                                cmd.Parameters.Add("@Fecha", SqlDbType.Date).Value = fecha.Date;
                                cmd.Parameters.Add("@TipoAsistencia", SqlDbType.Char, 1).Value = it.Tipo;
                                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = idUsuario;

                                object obs = string.IsNullOrEmpty(it.Observacion)
                                    ? (object)DBNull.Value
                                    : (object)Recortar(it.Observacion, 500);
                                cmd.Parameters.Add("@Observacion", SqlDbType.VarChar, 500).Value = obs;

                                cmd.ExecuteNonQuery();
                            }
                        }
                        tx.Commit();
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;   // que la pagina muestre el error
                    }
                }
            }
        }

        private static string Recortar(string s, int max)
        {
            s = s.Trim();
            return s.Length <= max ? s : s.Substring(0, max);
        }

        // ---------- SABANA MENSUAL ----------
        /// <summary>
        /// Devuelve una tabla lista para un GridView: una fila por alumno,
        /// una columna por cada dia con clase cargada ("dd/MM") y los totales P/A/T/J.
        /// </summary>
        public static DataTable Sabana(int idComision, int idUsuario, int anio, int mes)
        {
            DataTable largo = Db.Tabla("dbo.usp_Docente_Sabana",
                new SqlParameter("@IdComision", idComision),
                new SqlParameter("@IdUsuario", idUsuario),
                new SqlParameter("@Anio", anio),
                new SqlParameter("@Mes", mes));

            // 1) Fechas distintas del mes, ordenadas
            List<DateTime> fechas = new List<DateTime>();
            foreach (DataRow r in largo.Rows)
            {
                if (r["Fecha"] == DBNull.Value) continue;
                DateTime f = ((DateTime)r["Fecha"]).Date;
                if (!fechas.Contains(f)) fechas.Add(f);
            }
            fechas.Sort();

            // 2) Estructura de la tabla resultado
            DataTable res = new DataTable();
            res.Columns.Add("Alumno", typeof(string));
            res.Columns.Add("DNI", typeof(string));
            foreach (DateTime f in fechas)
                res.Columns.Add(NombreCol(f), typeof(string));
            string[] tipos = new string[] { "P", "A", "T", "J" };
            foreach (string t in tipos)
            {
                DataColumn c = res.Columns.Add(t, typeof(int));
                c.DefaultValue = 0;
            }

            // 3) Pivot: pasar de "una fila por alumno-fecha" a "una fila por alumno"
            Dictionary<int, DataRow> filas = new Dictionary<int, DataRow>();
            foreach (DataRow r in largo.Rows)
            {
                int id = (int)r["IdInscripcion"];
                DataRow fila;
                if (!filas.TryGetValue(id, out fila))
                {
                    fila = res.NewRow();
                    fila["Alumno"] = r["Alumno"];
                    fila["DNI"] = r["DNI"];
                    res.Rows.Add(fila);
                    filas[id] = fila;
                }

                if (r["Fecha"] == DBNull.Value) continue;
                string tipo = Convert.ToString(r["TipoAsistencia"]);
                fila[NombreCol((DateTime)r["Fecha"])] = tipo;
                fila[tipo] = (int)fila[tipo] + 1;
            }
            return res;
        }

        private static string NombreCol(DateTime f)
        {
            return f.ToString("dd/MM", CultureInfo.InvariantCulture);
        }

        // ---------- ALUMNOS ----------
        public static DataTable EstadoAlumnos(int idComision, int idUsuario)
        {
            return Db.Tabla("dbo.usp_Docente_EstadoAlumnos",
                new SqlParameter("@IdComision", idComision),
                new SqlParameter("@IdUsuario", idUsuario));
        }
    }
}
