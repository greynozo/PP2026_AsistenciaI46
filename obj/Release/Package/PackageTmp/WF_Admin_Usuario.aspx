<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="WF_Admin_Usuario.aspx.cs" Inherits="PresentismoWebI46.WF_Admin_Usuario" %>

<asp:Content
    ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    ...


<h2>Administración de Usuarios</h2>

<asp:TextBox ID="txtUsuarioNuevo" runat="server"></asp:TextBox>

<asp:TextBox ID="txtPasswordNuevo" runat="server"></asp:TextBox>

<asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>

<asp:TextBox ID="txtApellido" runat="server"></asp:TextBox>

<asp:TextBox ID="txtDni" runat="server"></asp:TextBox>

<asp:Button
    ID="btnAgregar"
    runat="server"
    Text="Crear Usuario"
    OnClick="btnAgregar_Click" />

<asp:Button
    ID="Button1"
    runat="server"
    Text="Crear Usuario"
    OnClick="btnAgregar_Click"
    CssClass="px-4 py-2 bg-indigo-600 text-white rounded-xl" />

<br /><br />

<asp:GridView
    ID="gvUsuarios"
    runat="server"
    AutoGenerateColumns="true">
</asp:GridView>

</asp:Content>

