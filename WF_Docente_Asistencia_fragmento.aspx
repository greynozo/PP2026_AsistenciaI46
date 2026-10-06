<%--
  FRAGMENTO para reemplazar el contenido de <asp:Content> en WF_Docente_Asistencia.aspx.
  Es una version FUNCIONAL y minima: primero que guarde en la base, despues se le
  devuelve el diseno Tailwind del mockup (las clases CssClass se pueden reusar tal cual).

  Al pegar los controles, Visual Studio regenera WF_Docente_Asistencia.aspx.designer.cs
  (o hay que hacer clic derecho > "Convert to Web Application" / "View Designer" si no lo hace).
--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblMensaje" runat="server" EnableViewState="false" />

    <div>
        <asp:Label runat="server" AssociatedControlID="ddlComision" Text="Comisión:" />
        <asp:DropDownList ID="ddlComision" runat="server" AutoPostBack="true"
            OnSelectedIndexChanged="Filtro_Changed"
            DataTextField="Descripcion" DataValueField="IdComision" />

        <asp:Label runat="server" AssociatedControlID="txtFecha" Text="Fecha de clase:" />
        <%-- TextMode="Date" recien existe en .NET 4.5; en 4.0 se agrega type="date" desde el code-behind --%>
        <asp:TextBox ID="txtFecha" runat="server" AutoPostBack="true"
            OnTextChanged="Filtro_Changed" />
    </div>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Estudiante</th>
                <th>DNI</th>
                <th>Estado</th>
                <th>% Asist.</th>
                <th>Observación</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptAlumnos" runat="server" OnItemDataBound="rptAlumnos_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("Apellido"))) %>,
                            <%# Server.HtmlEncode(Convert.ToString(Eval("Nombre"))) %>
                            <%-- El Id real viaja en un HiddenField; NUNCA confiar en el orden de las filas --%>
                            <asp:HiddenField ID="hfIdInscripcion" runat="server" Value='<%# Eval("IdInscripcion") %>' />
                        </td>
                        <td><%# Server.HtmlEncode(Convert.ToString(Eval("DNI"))) %></td>
                        <td>
                            <asp:RadioButtonList ID="rblTipo" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow">
                                <asp:ListItem Value="P" Text="P" />
                                <asp:ListItem Value="A" Text="A" />
                                <asp:ListItem Value="T" Text="T" />
                                <asp:ListItem Value="J" Text="J" />
                            </asp:RadioButtonList>
                        </td>
                        <td><%# Eval("Porcentaje", "{0:0.#}") %> %</td>
                        <td>
                            <%-- El texto se carga en ItemDataBound (la columna puede venir NULL) --%>
                            <asp:TextBox ID="txtObs" runat="server" MaxLength="500" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>

    <asp:Button ID="btnGuardar" runat="server" Text="Guardar planilla de asistencia"
        OnClick="btnGuardar_Click" />

</asp:Content>
