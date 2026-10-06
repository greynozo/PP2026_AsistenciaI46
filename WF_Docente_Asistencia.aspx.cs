using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;
using PresentismoWebI46.Datos;


namespace PresentismoWebI46
{
    public partial class WF_Docente_Asistencia : System.Web.UI.Page
    {
        // ---------------------------------------------------------------
        // Usuario logueado. DEPENDE DEL LOGIN (Login.aspx.cs hoy esta vacio):
        // al validar usuario y clave, el Login debe hacer
        //     Session["IdUsuario"] = <IdUsuario de la tabla Usuarios>;
        // Si no hay sesion, se vuelve al Login.
        // ---------------------------------------------------------------
        private int IdUsuario
        {
            get
            {
                object o = Session["IdUsuario"];
                if (o == null) { return 3; }   // TEMPORAL: poné acá el IdUsuario del docente
                return (int)o;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // En .NET 4.0 TextMode="Date" no existe: se pide el selector de fecha por atributo HTML.
            txtFecha.Attributes["type"] = "date";

            if (!IsPostBack)
            {
                ddlComision.DataSource = AsistenciaDAL.Comisiones(IdUsuario);
                ddlComision.DataBind();

                txtFecha.Text = DateTime.Today.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                CargarPlanilla();
            }
        }

        protected void Filtro_Changed(object sender, EventArgs e)
        {
            CargarPlanilla();
        }

        // Devuelve false si la fecha esta vacia, mal escrita o es futura.
        private bool TryFecha(out DateTime fecha)
        {
            if (DateTime.TryParseExact(txtFecha.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                                       DateTimeStyles.None, out fecha))
            {
                return fecha.Date <= DateTime.Today;
            }
            return false;
        }

        private void Mostrar(string texto, bool esError)
        {
            lblMensaje.Text = Server.HtmlEncode(texto);
            lblMensaje.ForeColor = esError ? System.Drawing.Color.Firebrick : System.Drawing.Color.SeaGreen;
        }

        private void CargarPlanilla()
        {
            rptAlumnos.DataSource = null;
            rptAlumnos.DataBind();

            DateTime fecha;
            if (ddlComision.SelectedValue == "") { return; }
            if (!TryFecha(out fecha))
            {
                Mostrar("Elegí una fecha válida (no puede ser futura).", true);
                return;
            }

            try
            {
                int idComision = int.Parse(ddlComision.SelectedValue);
                DataTable dt = AsistenciaDAL.Planilla(idComision, IdUsuario, fecha);
                rptAlumnos.DataSource = dt;
                rptAlumnos.DataBind();
                if (dt.Rows.Count == 0)
                    Mostrar("La comisión no tiene alumnos activos.", true);
            }
            catch (SqlException ex)
            {
                Mostrar(ex.Message, true);
            }
        }

        protected void rptAlumnos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            DataRowView fila = (DataRowView)e.Item.DataItem;

            // Si todavia no hay asistencia cargada se sugiere "P" (como el mockup).
            // Ojo: al guardar, quedan grabados todos los alumnos con lo que se ve en pantalla.
            RadioButtonList rbl = (RadioButtonList)e.Item.FindControl("rblTipo");
            rbl.SelectedValue = fila["TipoAsistencia"] == DBNull.Value
                ? "P"
                : Convert.ToString(fila["TipoAsistencia"]);

            TextBox txt = (TextBox)e.Item.FindControl("txtObs");
            txt.Text = fila["Observacion"] == DBNull.Value ? "" : Convert.ToString(fila["Observacion"]);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            DateTime fecha;
            if (!TryFecha(out fecha))
            {
                Mostrar("Elegí una fecha válida (no puede ser futura).", true);
                return;
            }

            List<ItemAsistencia> items = new List<ItemAsistencia>();
            foreach (RepeaterItem ri in rptAlumnos.Items)
            {
                HiddenField hf = (HiddenField)ri.FindControl("hfIdInscripcion");
                RadioButtonList rbl = (RadioButtonList)ri.FindControl("rblTipo");
                TextBox txt = (TextBox)ri.FindControl("txtObs");

                ItemAsistencia it = new ItemAsistencia();
                it.IdInscripcion = int.Parse(hf.Value);
                it.Tipo = rbl.SelectedValue;
                it.Observacion = txt.Text;
                items.Add(it);
            }

            if (items.Count == 0)
            {
                Mostrar("No hay alumnos para guardar.", true);
                return;
            }

            try
            {
                // El procedimiento vuelve a verificar que cada inscripcion sea de este docente.
                AsistenciaDAL.GuardarPlanilla(IdUsuario, fecha, items);
                CargarPlanilla();   // recarga para refrescar los porcentajes
                Mostrar("Planilla del " + fecha.ToString("dd/MM/yyyy") + " guardada (" + items.Count + " alumnos).", false);
            }
            catch (SqlException ex)
            {
                Mostrar("No se pudo guardar: " + ex.Message, true);
            }
        }
    }
}
