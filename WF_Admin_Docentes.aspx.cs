using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace PresentismoWebI46
{
     
    public partial class WF_Admin_Docentes : System.Web.UI.Page
    {
        // Cadena de conexión centralizada
        private static string Cadena = ConfigurationManager.ConnectionStrings["CadenaProd"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDocentes();
            }
        }

        // Lista los docentes (NivelUsuario = 2) desde SQL Server
        private void CargarDocentes()
        {
            string query = @"SELECT IdUsuario, Usuario, Nombre, Apellido, DNI, Email, Telefono
                             FROM Usuarios
                             WHERE NivelUsuario = 2 AND Activo = 1
                             ORDER BY Apellido, Nombre";
            using (SqlConnection con = new SqlConnection(Cadena))
            using (SqlCommand cmd = new SqlCommand(query, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptDocentes.DataSource = dt;
                rptDocentes.DataBind();
            }
        }

        // ================= ALTA y MODIFICACIÓN =================
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string id = hfIdEdit.Value.Trim();
            string usuario = txtUsuario.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string nombre = txtNombre.Text.Trim();
            string apellido = txtApellido.Text.Trim();
            string dni = txtDNI.Text.Trim();
            string email = txtEmail.Text.Trim();
            string telefono = txtTelefono.Text.Trim();

            // Validación de servidor (respaldo de la de cliente)
            if (nombre == "" || apellido == "" || dni == "")
            {
                ReabrirConError("Nombre, Apellido y DNI son obligatorios.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(Cadena))
                {
                    con.Open();

                    if (id == "")   // ---------- ALTA ----------
                    {
                        if (usuario == "" || pass == "")
                        {
                            ReabrirConError("Usuario y Contraseña son obligatorios.");
                            return;
                        }

                        // Usuario único
                        using (SqlCommand chk = new SqlCommand("SELECT COUNT(*) FROM Usuarios WHERE Usuario = @u", con))
                        {
                            chk.Parameters.AddWithValue("@u", usuario);
                            int existe = (int)chk.ExecuteScalar();
                            if (existe > 0)
                            {
                                ReabrirConError("El usuario \"" + usuario + "\" ya existe. Elegí otro.");
                                return;
                            }
                        }

                        string ins = @"INSERT INTO Usuarios (Usuario, PasswordHash, Nombre, Apellido, DNI, NivelUsuario, Activo, email, telefono)
                                       VALUES (@usuario, @password, @nombre, @apellido, @dni, 2, 1, @email, @telefono)";
                        using (SqlCommand cmd = new SqlCommand(ins, con))
                        {
                            cmd.Parameters.AddWithValue("@usuario", usuario);
                            cmd.Parameters.AddWithValue("@password", pass);
                            cmd.Parameters.AddWithValue("@nombre", nombre);
                            cmd.Parameters.AddWithValue("@apellido", apellido);
                            cmd.Parameters.AddWithValue("@dni", dni);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@telefono", telefono);
                            cmd.ExecuteNonQuery();
                        }

                        CargarDocentes();
                        MostrarFeedback(true, "Docente registrado con éxito.");
                    }
                    else            // ---------- MODIFICACIÓN (el Usuario NO se cambia) ----------
                    {
                        string setPass = (pass != "") ? ", PasswordHash = @password" : "";
                        string upd = "UPDATE Usuarios SET Nombre=@nombre, Apellido=@apellido, DNI=@dni, email=@email, telefono=@telefono"
                                     + setPass + " WHERE IdUsuario = @id";
                        using (SqlCommand cmd = new SqlCommand(upd, con))
                        {
                            cmd.Parameters.AddWithValue("@nombre", nombre);
                            cmd.Parameters.AddWithValue("@apellido", apellido);
                            cmd.Parameters.AddWithValue("@dni", dni);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@telefono", telefono);
                            if (pass != "") cmd.Parameters.AddWithValue("@password", pass);
                            cmd.Parameters.AddWithValue("@id", id);
                            cmd.ExecuteNonQuery();
                        }

                        CargarDocentes();
                        MostrarFeedback(true, "Docente modificado con éxito.");
                    }
                }
            }
            catch (SqlException ex)
            {
                // 2627 / 2601 = violación de restricción UNIQUE (por ejemplo, DNI repetido)
                string msg = (ex.Number == 2627 || ex.Number == 2601)
                    ? "Ya existe un docente con ese DNI o Usuario."
                    : "Error de base de datos: " + ex.Message.Replace("'", " ").Replace("\r\n", " ");
                ReabrirConError(msg);
            }
            catch (Exception ex)
            {
                ReabrirConError("Error: " + ex.Message.Replace("'", " ").Replace("\r\n", " "));
            }
        }

        // ================= BAJA (física: borra la fila de SQL) =================
        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            string id = hfIdDelete.Value.Trim();
            if (id == "")
            {
                MostrarFeedback(false, "No se recibió el docente a eliminar.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(Cadena))
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Usuarios WHERE IdUsuario = @id AND NivelUsuario = 2", con))
                {
                    cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));
                    con.Open();
                    int filas = cmd.ExecuteNonQuery();

                    hfIdDelete.Value = "";
                    CargarDocentes();

                    if (filas > 0)
                        MostrarFeedback(true, "Docente eliminado correctamente.");
                    else
                        MostrarFeedback(false, "No se encontró el docente. Puede que ya haya sido eliminado.");
                }
            }
            catch (SqlException ex)
            {
                // 547 = conflicto con clave foránea (el docente está referenciado en otra tabla)
                if (ex.Number == 547)
                    MostrarFeedback(false, "No se puede eliminar: el docente tiene materias u otros registros asociados. Quitalo de esas materias primero.");
                else
                    MostrarFeedback(false, "Error de base de datos: " + ex.Message.Replace("'", " ").Replace("\r\n", " "));
            }
            catch (Exception ex)
            {
                MostrarFeedback(false, "No se pudo eliminar: " + ex.Message.Replace("'", " ").Replace("\r\n", " "));
            }
        }

        // ================= Helpers para mostrar los modales desde el servidor =================
        private void MostrarFeedback(bool ok, string mensaje)
        {
            string tipo = ok ? "ok" : "error";
            string script = "mostrarFeedback('" + tipo + "', '" + Escapar(mensaje) + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "fb", script, true);
        }

        private void ReabrirConError(string mensaje)
        {
            string script = "reabrirConError('" + Escapar(mensaje) + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "err", script, true);
        }

        private string Escapar(string s)
        {
            return s.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", " ").Replace("\n", " ");
        }
    }
}