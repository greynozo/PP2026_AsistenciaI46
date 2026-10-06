using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentismoWebI46
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int nivel = Convert.ToInt32(Session["NivelUsuario"]);

            menuUsuarios.Visible = (nivel == 3);
        }

    }
}




