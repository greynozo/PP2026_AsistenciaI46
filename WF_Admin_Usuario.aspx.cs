using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PresentismoWebI46
{
    public partial class WF_Admin_Usuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int nivel = Convert.ToInt32(Session["NivelUsuario"]);

            if (nivel != 3)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
        
        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            string cadena =
            @"Data Source=SMS-NTBK-457\SQLEXPRESS;
              Initial Catalog=AsistenciaAcademica;
              Integrated Security=True";

            using (SqlConnection cn = new SqlConnection(cadena))
            {
                string sql = @"
                INSERT INTO Usuarios
                (
                    Usuario,
                    PasswordHash,
                    Nombre,
                    Apellido,
                    DNI,
                    NivelUsuario,
                    Activo
                )
                VALUES
                (
                    @Usuario,
                    @Password,
                    @Nombre,
                    @Apellido,
                    @DNI,
                    2,
                    1
                )";

                SqlCommand cmd = new SqlCommand(sql, cn);

                cmd.Parameters.AddWithValue("@Usuario", txtUsuarioNuevo.Text);
                cmd.Parameters.AddWithValue("@Password", txtPasswordNuevo.Text);
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                cmd.Parameters.AddWithValue("@Apellido", txtApellido.Text);
                cmd.Parameters.AddWithValue("@DNI", txtDni.Text);

                cn.Open();

                Response.Write(
    "DNI: " + txtDni.Text +
    " Usuario: " + txtUsuarioNuevo.Text);
                return;

                cmd.ExecuteNonQuery();
            }

            CargarUsuarios();
        }
    }
}
    

