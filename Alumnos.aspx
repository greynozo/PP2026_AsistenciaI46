<%@ Page Title="Nómina y Matriculación de Alumnos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Alumnos.aspx.cs" Inherits="PresentismoWebI46.Alumnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="space-y-6">

        <!-- Encabezado -->
        <div class="bg-white p-6 rounded-3xl border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div class="space-y-1">
                <div class="flex items-center gap-2">
                    <span class="px-2.5 py-0.5 bg-blue-50 text-blue-700 text-xs font-bold rounded-full border border-blue-200">
                        Alumnos
                    </span>
                    <h1 class="text-lg font-bold text-slate-900">Matriculación y Nómina de Estudiantes</h1>
                </div>
                <p class="text-xs text-slate-500">
                    Filtre por comisión, inscriba nuevos alumnos y administre los estados (Activo / Baja).
                </p>
            </div>

            <!-- Selector de Comisión -->
            <div>
                <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">Filtrar por Materia</label>
                <asp:DropDownList ID="ddlFiltroMateria" runat="server" AutoPostBack="true" 
                    CssClass="px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold focus:outline-none focus:border-indigo-500">
                </asp:DropDownList>
            </div>
        </div>

        <!-- Alerta de Notificación -->
        <asp:Panel ID="pnlMensajeAlumno" runat="server" Visible="false" CssClass="p-4 bg-emerald-50 border border-emerald-200 rounded-2xl text-xs text-emerald-900 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <i class="fa-solid fa-circle-check text-emerald-600"></i>
                <asp:Label ID="lblMensajeAlumno" runat="server"></asp:Label>
            </div>
            <asp:Button ID="btnCerrarMsgAlumno" runat="server" Text="×" CssClass="text-emerald-700 font-bold hover:text-emerald-900 cursor-pointer text-base leading-none" />
        </asp:Panel>

        <!-- Formulario para Agregar Alumno -->
        <div class="bg-white p-6 rounded-3xl border border-slate-200/80 shadow-xs space-y-4">
            <div class="flex items-center gap-2 border-b border-slate-100 pb-3">
                <i class="fa-solid fa-user-plus text-indigo-600"></i>
                <h2 class="text-sm font-bold text-slate-800">Inscribir Alumno en la Materia</h2>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-4 gap-3">
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">Apellido y Nombre</label>
                    <asp:TextBox ID="txtAlumnoNombre" runat="server" placeholder="Ej. Gómez Lucas"
                        CssClass="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs focus:outline-none focus:border-indigo-500"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">D.N.I.</label>
                    <asp:TextBox ID="txtAlumnoDni" runat="server" placeholder="42.345.678"
                        CssClass="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs focus:outline-none focus:border-indigo-500"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">Correo Electrónico</label>
                    <asp:TextBox ID="txtAlumnoEmail" runat="server" placeholder="alumno@instituto.edu.ar"
                        CssClass="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs focus:outline-none focus:border-indigo-500"></asp:TextBox>
                </div>
                <div class="flex items-end">
                    <asp:Button ID="btnInscribirAlumno" runat="server" Text="Matricular Alumno" 
                        CssClass="w-full py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold rounded-xl shadow-xs cursor-pointer transition-all" />
                </div>
            </div>
        </div>

        <!-- Grilla de Alumnos -->
        <div class="bg-white rounded-3xl border border-slate-200/80 shadow-xs overflow-hidden">
            <div class="p-4 px-6 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                <span class="text-xs font-bold text-slate-700 uppercase tracking-wider">Estudiantes Registrados</span>
                <asp:Label ID="lblContadorAlumnos" runat="server" CssClass="text-xs font-bold text-indigo-700" Text="0 alumnos"></asp:Label>
            </div>

            <div class="overflow-x-auto">
                <asp:GridView ID="gvAlumnos" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Id"
                    CssClass="w-full text-left border-collapse table-custom">
                    <Columns>
                        <asp:TemplateField HeaderText="#" ItemStyle-CssClass="w-12 text-center text-slate-400 font-bold">
                            <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Nombre" HeaderText="Apellido y Nombre" ItemStyle-Font-Bold="true" />
                        <asp:BoundField DataField="Dni" HeaderText="D.N.I." ItemStyle-CssClass="font-mono text-xs text-slate-600" />
                        <asp:BoundField DataField="Email" HeaderText="Correo" ItemStyle-CssClass="text-xs text-slate-500" />
                        <asp:BoundField DataField="MateriaNombre" HeaderText="Materia" ItemStyle-CssClass="text-xs text-indigo-700 font-semibold" />

                        <asp:TemplateField HeaderText="Estado" ItemStyle-CssClass="text-center">
                            <ItemTemplate>
                                <span class='<%# Eval("Estado").ToString() == "activo" ? "px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200" : "px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-slate-100 text-slate-500 border border-slate-200" %>'>
                                    <%# Eval("Estado").ToString().ToUpper() %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-right space-x-2">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnToggleEstado" runat="server" CommandName="ToggleEstado" CommandArgument='<%# Eval("Id") + ";" + Eval("Estado") %>'
                                    CssClass="text-xs font-semibold text-slate-600 hover:text-indigo-600">
                                    <%# Eval("Estado").ToString() == "activo" ? "<i class='fa-solid fa-user-slash'></i> Dar de Baja" : "<i class='fa-solid fa-user-check'></i> Reactivar" %>
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnEliminarAlumno" runat="server" CommandName="Delete" 
                                    CssClass="text-rose-600 hover:text-rose-800 text-xs font-bold ml-2">
                                    <i class="fa-solid fa-trash-can"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
