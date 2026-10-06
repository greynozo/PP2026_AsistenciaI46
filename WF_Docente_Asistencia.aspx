<%@ Page Title="" Language="C#" MasterPageFile="~/Docentes.Master" AutoEventWireup="true"
    CodeBehind="WF_Docente_Asistencia.aspx.cs" Inherits="PresentismoWebI46.WF_Docente_Asistencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6" id="attendance-content">

    <!-- Encabezado -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div>
        <div class="flex items-center gap-2 mb-1">
          <span class="px-2.5 py-0.5 bg-indigo-50 text-indigo-700 text-xs font-bold uppercase rounded-md border border-indigo-100">Planilla Diaria</span>
          <span class="text-xs text-slate-400 font-semibold">• Ciclo Lectivo 2026</span>
        </div>
        <h1 class="text-xl md:text-2xl font-black text-slate-900 tracking-tight">Asistencia de alumnos</h1>
        <p class="text-xs text-slate-500 mt-1">Elegí la comisión y la fecha de la clase.</p>
      </div>

      <div class="flex items-center gap-2 self-start md:self-auto">
        <a href="WF_Docente_Reporte.aspx" class="px-3.5 py-2.5 bg-emerald-50 hover:bg-emerald-100 text-emerald-700 text-xs font-bold rounded-xl border border-emerald-200 transition-all flex items-center gap-1.5">
          <i class="fa-solid fa-file-excel"></i>
          <span>Sábana Mensual</span>
        </a>
      </div>
    </header>

    <!-- Selección de comisión y fecha -->
    <div class="bg-white rounded-2xl p-5 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center gap-4">

      <div class="flex items-center gap-3">
        <label for="<%= ddlComision.ClientID %>" class="text-xs font-bold text-slate-600 uppercase tracking-wider whitespace-nowrap">
          <i class="fa-solid fa-chalkboard-user text-indigo-600 mr-1"></i> Comisión:
        </label>
        <asp:DropDownList ID="ddlComision" runat="server" AutoPostBack="true"
            OnSelectedIndexChanged="Filtro_Changed"
            DataTextField="Descripcion" DataValueField="IdComision"
            CssClass="px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer" />
      </div>

      <div class="flex items-center gap-3">
        <label for="<%= txtFecha.ClientID %>" class="text-xs font-bold text-slate-600 uppercase tracking-wider whitespace-nowrap">
          <i class="fa-regular fa-calendar text-indigo-600 mr-1"></i> Fecha de Clase:
        </label>
        <%-- El type="date" se agrega desde el code-behind (TextMode="Date" no existe en .NET 4.0) --%>
        <asp:TextBox ID="txtFecha" runat="server" AutoPostBack="true"
            OnTextChanged="Filtro_Changed"
            CssClass="px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer" />
      </div>

    </div>

    <!-- Mensajes (errores / guardado correcto) -->
    <div class="text-xs font-bold">
      <asp:Label ID="lblMensaje" runat="server" EnableViewState="false" />
    </div>

    <!-- Tabla principal -->
    <div class="bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">

      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/80 border-b border-slate-200 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
              <th class="py-3 px-4 w-12 text-center">#</th>
              <th class="py-3 px-4">Estudiante</th>
              <th class="py-3 px-4 text-center w-56">Estado Hoy</th>
              <th class="py-3 px-4 text-center w-40">Regularidad</th>
              <th class="py-3 px-4 min-w-[200px]">Observación / Justificación</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-100 text-xs">

            <asp:Repeater ID="rptAlumnos" runat="server" OnItemDataBound="rptAlumnos_ItemDataBound">
              <ItemTemplate>
                <tr class="hover:bg-slate-50/70 transition-colors">
                  <td class="py-3.5 px-4 text-center font-bold text-slate-400"><%# Container.ItemIndex + 1 %></td>

                  <td class="py-3.5 px-4">
                    <h4 class="font-bold text-slate-900">
                      <%# Server.HtmlEncode(Convert.ToString(Eval("Apellido"))) %>,
                      <%# Server.HtmlEncode(Convert.ToString(Eval("Nombre"))) %>
                    </h4>
                    <p class="text-[11px] text-slate-500 font-mono">DNI: <%# Server.HtmlEncode(Convert.ToString(Eval("DNI"))) %></p>
                    <%-- El Id real de la inscripcion viaja aca. NO borrar. --%>
                    <asp:HiddenField ID="hfIdInscripcion" runat="server" Value='<%# Eval("IdInscripcion") %>' />
                  </td>

                  <td class="py-3.5 px-4 text-center">
                    <asp:RadioButtonList ID="rblTipo" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" CssClass="inline-flex items-center gap-3 font-bold">
                      <asp:ListItem Value="P" Text="P" />
                      <asp:ListItem Value="A" Text="A" />
                      <asp:ListItem Value="T" Text="T" />
                      <asp:ListItem Value="J" Text="J" />
                    </asp:RadioButtonList>
                  </td>

                  <td class="py-3.5 px-4 text-center">
                    <%-- Umbral de regularidad: 75 (ajustar si el docente define otro) --%>
                    <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border <%# Convert.ToDecimal(Eval("Porcentaje")) >= 75 ? "text-emerald-700 bg-emerald-50 border-emerald-200" : "text-rose-700 bg-rose-50 border-rose-200" %>">
                      <span class="text-xs"><%# Eval("Porcentaje", "{0:0.#}") %>%</span>
                      <span class="text-[10px] opacity-80">(<%# Convert.ToDecimal(Eval("Porcentaje")) >= 75 ? "Regular" : "En riesgo" %>)</span>
                    </div>
                  </td>

                  <td class="py-3.5 px-4">
                    <asp:TextBox ID="txtObs" runat="server" MaxLength="500" placeholder="Nota u observación..."
                        CssClass="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400" />
                  </td>
                </tr>
              </ItemTemplate>
            </asp:Repeater>

          </tbody>
        </table>
      </div>

      <!-- Barra inferior de guardado -->
      <div class="p-5 bg-slate-50/80 border-t border-slate-200 flex justify-end">
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Planilla de Asistencia"
            OnClick="btnGuardar_Click"
            CssClass="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all cursor-pointer" />
      </div>

    </div>

  </main>
</asp:Content>
