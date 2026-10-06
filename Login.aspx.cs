using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace PresentismoWebI46
{
    public partial class Login : System.Web.UI.Page
    {
        private static string Cadena = ConfigurationManager.ConnectionStrings["CadenaProd"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtDocente.Text.Trim();
            string password = txtPasswordDocente.Text.Trim();

//            string cadena = @"Data Source=SMS-NTBK-457\SQLEXPRESS;
//                            Initial Catalog=AsistenciaAcademica;
//                            Integrated Security=True";

            using (SqlConnection cn = new SqlConnection(Cadena))
            {
                string sql = @"
            SELECT NivelUsuario
            FROM Usuarios
            WHERE Usuario = @Usuario
            AND PasswordHash = @Password
            AND Activo = 1
            AND NivelUsuario = 2";

                SqlCommand cmd = new SqlCommand(sql, cn);

                cmd.Parameters.AddWithValue("@Usuario", usuario);
                cmd.Parameters.AddWithValue("@Password", password);

                cn.Open();

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                {
                    int nivel = Convert.ToInt32(resultado);

                    Session["Usuario"] = usuario;
                    Session["NivelUsuario"] = nivel;

                    if (nivel == 2)
                    {
                        Response.Redirect("WF_Docente_Alumnos.aspx");
                    }
                    else
                    {
                        Response.Redirect("WF_Docente_Alumnos.aspx");
                    }
                }
                else
                {
                    lblMensaje.Text = "Usuario o contraseña incorrectos.";
                }
            }
        }

        protected void btnLogin_Click2(object sender, EventArgs e)
        {
            string usuario = TxtAdmin.Text.Trim();
            string password = TxtPasswordAdmin.Text.Trim();

//            string cadena =
//            @"Data Source=SMS-NTBK-457\SQLEXPRESS;
//      Initial Catalog=AsistenciaAcademica;
//      Integrated Security=True";

            using (SqlConnection cn = new SqlConnection(Cadena))
            {
                string sql = @"
            SELECT NivelUsuario
            FROM Usuarios
            WHERE Usuario = @Usuario
            AND PasswordHash = @Password
            AND Activo = 1
            AND NivelUsuario IN (1,3)";

                SqlCommand cmd = new SqlCommand(sql, cn);

                cmd.Parameters.AddWithValue("@Usuario", usuario);
                cmd.Parameters.AddWithValue("@Password", password);

                cn.Open();

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                {
                    int nivel = Convert.ToInt32(resultado);

                    Session["Usuario"] = usuario;
                    Session["NivelUsuario"] = nivel;

                   if (nivel == 3)
{
                   Response.Redirect("WF_Admin_Usuario.aspx");
}
                   else if (nivel == 1)
{
                   Response.Redirect("WF_Admin_Alumnos.aspx");
}
                    else
{
                   Response.Redirect("WF_Docente_Alumnos.aspx");
}
                    }
                }
            }
        }
    }


