<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="WF_Admin_Docentes.aspx.cs" Inherits="PresentismoWebI46.WF_Admin_Docentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

      <button type="button" onclick="openAddTeacherModal()" class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer self-start md:self-auto">
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
              <th class="py-3 px-4 text-center">Estado</th>
              <th class="py-3 px-4 text-center">Sesión Rápida</th>
              <th class="py-3 px-4 text-right">Acciones</th>
            </tr>
          </thead>
          <tbody id="docentes-tbody" class="divide-y divide-slate-100 text-xs">
      <tr class="hover:bg-slate-50/70 transition-colors">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">1</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center border border-indigo-200 shrink-0">
              CR
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Prof. Carlos Rodríguez</h4>
              <p class="text-[11px] text-slate-400 font-mono">carlos.rodriguez@instituto.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <div class="flex flex-wrap gap-1">
            
                  <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-semibold rounded-md">
                    Desarrollo de Software I (1er Año)
                  </span>
                
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 text-[10px] font-bold rounded-full inline-flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Habilitado
          </span>
        </td>

        <td class="py-3.5 px-4 text-center">
          <button type="button" onclick="loginDocente('t1')" class="px-2.5 py-1 bg-indigo-50 hover:bg-indigo-600 hover:text-white text-indigo-700 text-[11px] font-bold rounded-lg transition-colors cursor-pointer border border-indigo-100">
            <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>
            Ingresar
          </button>
        </td>

        <td class="py-3.5 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditTeacherModal('t1')" title="Editar Docente" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteTeacher('t1')" title="Eliminar Docente" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">2</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center border border-indigo-200 shrink-0">
              LG
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Lic. Laura González</h4>
              <p class="text-[11px] text-slate-400 font-mono">laura.gonzalez@instituto.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <div class="flex flex-wrap gap-1">
            
                  <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-semibold rounded-md">
                    Base de Datos II (2do Año)
                  </span>
                
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 text-[10px] font-bold rounded-full inline-flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Habilitado
          </span>
        </td>

        <td class="py-3.5 px-4 text-center">
          <button type="button" onclick="loginDocente('t2')" class="px-2.5 py-1 bg-indigo-50 hover:bg-indigo-600 hover:text-white text-indigo-700 text-[11px] font-bold rounded-lg transition-colors cursor-pointer border border-indigo-100">
            <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>
            Ingresar
          </button>
        </td>

        <td class="py-3.5 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditTeacherModal('t2')" title="Editar Docente" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteTeacher('t2')" title="Eliminar Docente" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">3</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center border border-indigo-200 shrink-0">
              MM
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Ing. Marcos Martínez</h4>
              <p class="text-[11px] text-slate-400 font-mono">marcos.martinez@instituto.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <div class="flex flex-wrap gap-1">
            
                  <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-semibold rounded-md">
                    Práctica Profesionalizante (3er Año)
                  </span>
                
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 text-[10px] font-bold rounded-full inline-flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Habilitado
          </span>
        </td>

        <td class="py-3.5 px-4 text-center">
          <button type="button" onclick="loginDocente('t3')" class="px-2.5 py-1 bg-indigo-50 hover:bg-indigo-600 hover:text-white text-indigo-700 text-[11px] font-bold rounded-lg transition-colors cursor-pointer border border-indigo-100">
            <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>
            Ingresar
          </button>
        </td>

        <td class="py-3.5 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditTeacherModal('t3')" title="Editar Docente" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteTeacher('t3')" title="Eliminar Docente" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    </tbody>
        </table>
      </div>
    </div>

  </main>
</asp:Content>
