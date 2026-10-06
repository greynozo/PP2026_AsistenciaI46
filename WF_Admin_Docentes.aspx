<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="WF_Admin_Docentes.aspx.cs" Inherits="PresentismoWebI46.WF_Admin_Docentes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Campos ocultos de estado (los usa el JavaScript y el code-behind) -->
    <asp:HiddenField ID="hfIdEdit" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfIdDelete" runat="server" ClientIDMode="Static" />

    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6">

    <!-- Header Principal -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div class="flex items-center gap-3.5">
        <div class="w-12 h-12 bg-indigo-50 text-indigo-700 rounded-2xl flex items-center justify-center text-xl shrink-0 border border-indigo-100">
          <i class="fa-solid fa-chalkboard-user"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <span class="px-2 py-0.5 bg-indigo-50 text-indigo-700 text-[10px] font-bold uppercase rounded-md border border-indigo-100">Cuerpo Académico</span>
            <span class="text-xs text-slate-400 font-semibold">Personal Activo</span>
          </div>
          <h1 class="text-xl font-bold text-slate-900 tracking-tight mt-0.5">
            Gestión del Plantel Docente
          </h1>
          <p class="text-xs text-slate-500">
            Administración de profesores, cuentas de acceso y cátedras asignadas.
          </p>
        </div>
      </div>
      <button type="button" onclick="abrirNuevo()" class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer self-start md:self-auto">
        <i class="fa-solid fa-user-plus text-xs"></i>
        <span>Nuevo Docente</span>
      </button>
    </header>

    <!-- Tabla de Plantel Docente -->
    <div class="bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/80 border-b border-slate-200 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
              <th class="py-3 px-4 w-12 text-center">#</th>
              <th class="py-3 px-4">Docente</th>
              <th class="py-3 px-4">Materias a Cargo</th>
              <th class="py-3 px-4 text-right">Acciones</th>
            </tr>
          </thead>
          <tbody id="docentes-tbody" class="divide-y divide-slate-100 text-xs">
            <asp:Repeater ID="rptDocentes" runat="server">
                <ItemTemplate>
                    <tr class="hover:bg-slate-50/70 transition-colors">
                        <td class="py-3.5 px-4 text-center font-bold text-slate-400">
                            <%# Container.ItemIndex + 1 %>
                        </td>
                        <td class="py-3.5 px-4">
                            <div class="flex items-center gap-3">
                                <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center border border-indigo-200 shrink-0">
                                    <%# Server.HtmlEncode(Eval("Nombre").ToString().Substring(0,1) + Eval("Apellido").ToString().Substring(0,1)) %>
                                </div>
                                <div>
                                    <h4 class="font-bold text-slate-900"><%# Server.HtmlEncode(Eval("Nombre") + " " + Eval("Apellido")) %></h4>
                                    <p class="text-[11px] text-slate-400 font-mono"><%# Server.HtmlEncode(Eval("email").ToString()) %></p>
                                </div>
                            </div>
                        </td>
                        <td class="py-3.5 px-4">
                            <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-semibold rounded-md">
                                Sin Asignar
                            </span>
                        </td>
                        <td class="py-3.5 px-4 text-right">
                            <div class="flex items-center justify-end gap-1.5">
                                <button type="button" title="Editar Docente"
                                    data-id='<%# Eval("IdUsuario") %>'
                                    data-usuario='<%# Server.HtmlEncode(Eval("Usuario").ToString()) %>'
                                    data-nombre='<%# Server.HtmlEncode(Eval("Nombre").ToString()) %>'
                                    data-apellido='<%# Server.HtmlEncode(Eval("Apellido").ToString()) %>'
                                    data-dni='<%# Server.HtmlEncode(Eval("DNI").ToString()) %>'
                                    data-email='<%# Server.HtmlEncode(Eval("email").ToString()) %>'
                                    data-telefono='<%# Server.HtmlEncode(Eval("telefono").ToString()) %>'
                                    onclick="editarDesde(this)"
                                    class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                                <button type="button" title="Eliminar Docente"
                                    data-id='<%# Eval("IdUsuario") %>'
                                    data-nombre='<%# Server.HtmlEncode(Eval("Nombre") + " " + Eval("Apellido")) %>'
                                    onclick="confirmarEliminar(this)"
                                    class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
          </tbody>
        </table>
      </div>
    </div>

    <!-- ================= MODAL DE ALTA / EDICIÓN ================= -->
    <div id="modalDocente" class="fixed inset-0 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 z-50 hidden">
      <div class="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl border border-slate-100 space-y-4">
        <div class="flex justify-between items-center border-b pb-3">
          <h3 id="modalTitulo" class="text-base font-bold text-slate-900">Agregar Nuevo Docente</h3>
          <button type="button" onclick="cerrarModalDocente()" class="text-slate-400 hover:text-slate-600">
            <i class="fa-solid fa-xmark text-lg"></i>
          </button>
        </div>

        <!-- Cartel de error de validación (dentro del modal) -->
        <div id="modalError" class="hidden text-xs font-semibold text-rose-700 bg-rose-50 border border-rose-200 rounded-lg p-2"></div>

        <div class="space-y-3">
          <div>
            <label class="block text-xs font-semibold text-slate-600 mb-1">Usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" ClientIDMode="Static" placeholder="Usuario de red" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none read-only:bg-slate-100 read-only:text-slate-400"></asp:TextBox>
          </div>
          <div>
            <label class="block text-xs font-semibold text-slate-600 mb-1">Contraseña <span id="lblPassHint" class="text-[10px] text-slate-400 font-normal"></span></label>
            <asp:TextBox ID="txtPassword" runat="server" ClientIDMode="Static" TextMode="Password" placeholder="Contraseña" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
          </div>
          <div class="grid grid-cols-2 gap-2">
            <div>
              <label class="block text-xs font-semibold text-slate-600 mb-1">Nombre</label>
              <asp:TextBox ID="txtNombre" runat="server" ClientIDMode="Static" placeholder="Nombre" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
            </div>
            <div>
              <label class="block text-xs font-semibold text-slate-600 mb-1">Apellido</label>
              <asp:TextBox ID="txtApellido" runat="server" ClientIDMode="Static" placeholder="Apellido" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
            </div>
          </div>
          <div>
            <label class="block text-xs font-semibold text-slate-600 mb-1">DNI</label>
            <asp:TextBox ID="txtDNI" runat="server" ClientIDMode="Static" placeholder="Número de DNI" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
          </div>
          <div>
            <label class="block text-xs font-semibold text-slate-600 mb-1">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" placeholder="correo@instituto.edu.ar" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
          </div>
          <div>
            <label class="block text-xs font-semibold text-slate-600 mb-1">Teléfono</label>
            <asp:TextBox ID="txtTelefono" runat="server" ClientIDMode="Static" placeholder="Teléfono" class="w-full p-2 text-xs border border-slate-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"></asp:TextBox>
          </div>
        </div>
        <div class="flex justify-end gap-2 pt-3 border-t">
          <button type="button" onclick="cerrarModalDocente()" class="px-3 py-2 text-xs font-semibold text-slate-500 hover:bg-slate-100 rounded-xl transition-colors">
            Cancelar
          </button>
          <asp:Button ID="btnGuardar" runat="server" Text="Guardar Docente" OnClientClick="return validarFormulario();" OnClick="btnGuardar_Click" CssClass="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-colors cursor-pointer" />
        </div>
      </div>
    </div>

    <!-- ================= MODAL CONFIRMAR ELIMINACIÓN ================= -->
    <div id="modalEliminar" class="fixed inset-0 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 z-50 hidden">
      <div class="bg-white rounded-2xl max-w-sm w-full p-6 shadow-2xl border border-slate-100 space-y-4 text-center">
        <i class="fa-solid fa-triangle-exclamation text-4xl text-rose-500"></i>
        <h3 class="text-base font-bold text-slate-900">¿Eliminar docente?</h3>
        <p class="text-sm text-slate-600">Vas a eliminar definitivamente a <span id="delNombre" class="font-bold text-slate-800"></span>. Esta acción no se puede deshacer. ¿Confirmás?</p>
        <div class="flex justify-center gap-2 pt-1">
          <button type="button" onclick="cerrarModalEliminar()" class="px-3 py-2 text-xs font-semibold text-slate-500 hover:bg-slate-100 rounded-xl transition-colors">
            Cancelar
          </button>
          <asp:Button ID="btnConfirmarEliminar" runat="server" Text="Sí, eliminar" OnClick="btnConfirmarEliminar_Click" CssClass="px-4 py-2 bg-rose-600 hover:bg-rose-700 text-white font-bold text-xs rounded-xl shadow-xs transition-colors cursor-pointer" />
        </div>
      </div>
    </div>

    <!-- ================= MODAL DE FEEDBACK (éxito / error) ================= -->
    <div id="modalFeedback" class="fixed inset-0 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 z-50 hidden">
      <div class="bg-white rounded-2xl max-w-sm w-full p-6 shadow-2xl border border-slate-100 space-y-3 text-center">
        <i id="fbIcon" class="fa-solid fa-circle-check text-4xl text-emerald-500"></i>
        <p id="fbMsg" class="text-sm font-semibold text-slate-700"></p>
        <button type="button" onclick="cerrarFeedback()" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl transition-colors cursor-pointer">
          Aceptar
        </button>
      </div>
    </div>

    <script type="text/javascript">
        function $id(id) { return document.getElementById(id); }
        function show(id) { $id(id).classList.remove('hidden'); }
        function hide(id) { $id(id).classList.add('hidden'); }
        function val(id) { return $id(id).value.trim(); }

        function setError(msg) {
            var e = $id('modalError');
            e.textContent = msg;
            if (msg) { e.classList.remove('hidden'); } else { e.classList.add('hidden'); }
        }

        // Abrir modal en modo ALTA
        function abrirNuevo() {
            $id('hfIdEdit').value = '';
            ['txtUsuario', 'txtPassword', 'txtNombre', 'txtApellido', 'txtDNI', 'txtEmail', 'txtTelefono']
                .forEach(function (id) { $id(id).value = ''; });
            $id('txtUsuario').readOnly = false;
            $id('modalTitulo').textContent = 'Agregar Nuevo Docente';
            $id('lblPassHint').textContent = '';
            setError('');
            show('modalDocente');
        }

        // Abrir modal en modo EDICIÓN (el usuario NO se puede modificar)
        function editarDesde(btn) {
            var d = btn.dataset;
            $id('hfIdEdit').value = d.id;
            $id('txtUsuario').value = d.usuario;
            $id('txtUsuario').readOnly = true;
            $id('txtPassword').value = '';
            $id('txtNombre').value = d.nombre;
            $id('txtApellido').value = d.apellido;
            $id('txtDNI').value = d.dni;
            $id('txtEmail').value = d.email;
            $id('txtTelefono').value = d.telefono;
            $id('modalTitulo').textContent = 'Editar Docente';
            $id('lblPassHint').textContent = '(dejar vacío para no cambiarla)';
            setError('');
            show('modalDocente');
        }

        function cerrarModalDocente() { hide('modalDocente'); }

        // Validación de cliente (antes de mandar al servidor)
        function validarFormulario() {
            var editando = $id('hfIdEdit').value !== '';
            var usuario = val('txtUsuario'), pass = val('txtPassword'),
                nombre = val('txtNombre'), apellido = val('txtApellido'),
                dni = val('txtDNI'), email = val('txtEmail');
            var errs = [];
            if (!editando && !usuario) errs.push('El usuario es obligatorio.');
            if (!editando && !pass) errs.push('La contraseña es obligatoria.');
            if (!nombre) errs.push('El nombre es obligatorio.');
            if (!apellido) errs.push('El apellido es obligatorio.');
            if (!dni) errs.push('El DNI es obligatorio.');
            else if (!/^[0-9.\-]{6,}$/.test(dni)) errs.push('El DNI debe contener solo números (mínimo 6 dígitos).');
            if (email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) errs.push('El email no tiene un formato válido.');
            if (errs.length) { setError(errs.join(' ')); return false; }
            setError('');
            return true;
        }

        // ELIMINAR: pide confirmación antes de borrar
        function confirmarEliminar(btn) {
            $id('hfIdDelete').value = btn.dataset.id;
            $id('delNombre').textContent = btn.dataset.nombre;
            show('modalEliminar');
        }
        function cerrarModalEliminar() { hide('modalEliminar'); }

        // Llamada desde el servidor cuando la validación de servidor falla
        function reabrirConError(msg) {
            if ($id('hfIdEdit').value !== '') {
                $id('txtUsuario').readOnly = true;
                $id('modalTitulo').textContent = 'Editar Docente';
            }
            show('modalDocente');
            setError(msg);
        }

        // Modal de feedback propio (reemplaza el alert nativo)
        function mostrarFeedback(tipo, msg) {
            hide('modalDocente'); hide('modalEliminar');
            var ic = $id('fbIcon');
            $id('fbMsg').textContent = msg;
            ic.className = (tipo === 'ok')
                ? 'fa-solid fa-circle-check text-4xl text-emerald-500'
                : 'fa-solid fa-circle-xmark text-4xl text-rose-500';
            show('modalFeedback');
        }
        function cerrarFeedback() { hide('modalFeedback'); }
    </script>
    </main>
</asp:Content>
