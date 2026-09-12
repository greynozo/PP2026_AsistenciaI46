<%@ Page Title="" Language="C#" MasterPageFile="~/Docentes.Master" AutoEventWireup="true"
    CodeBehind="WF_Docente_Alumnos.aspx.cs" Inherits="PresentismoWebI46.WF_Docente_Alumnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6">

    <!-- Header Principal -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div class="flex items-center gap-3.5">
        <div class="w-12 h-12 bg-indigo-50 text-indigo-700 rounded-2xl flex items-center justify-center text-xl shrink-0 border border-indigo-100">
          <i class="fa-solid fa-users"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <span class="px-2 py-0.5 bg-indigo-50 text-indigo-700 text-[10px] font-bold uppercase rounded-md border border-indigo-100">Bedelía</span>
            <span id="total-students-count" class="text-xs text-slate-400 font-semibold">6 alumnos</span>
          </div>
          <h1 class="text-xl font-bold text-slate-900 tracking-tight mt-0.5">
            Nómina y Matriculación de Alumnos
          </h1>
          <p class="text-xs text-slate-500">
            Padrón oficial de estudiantes matriculados por comisión con registro de altas, bajas y legajos.
          </p>
        </div>
      </div>

      <button type="button" onclick="openAddStudentModal()" class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer self-start md:self-auto">
        <i class="fa-solid fa-user-plus text-xs"></i>
        <span>Matricular Alumno</span>
      </button>
    </header>

    <!-- Barra de Filtros y Búsqueda -->
    <div class="bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs flex flex-col md:flex-row items-center justify-between gap-4">
      
      <!-- Buscador en tiempo real -->
      <div class="relative w-full md:w-96">
        <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
        <input id="search-student" type="text" oninput="renderStudentsList()" placeholder="Buscar por apellido, nombre o DNI..." class="w-full pl-9 pr-4 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white">
      </div>

      <!-- Filtro por Comisión -->
      <div class="flex items-center gap-2 w-full md:w-auto">
        <label class="text-xs font-bold text-slate-500 whitespace-nowrap">Comisión:</label>
        <select id="filter-course-select" onchange="renderStudentsList()" class="w-full md:w-auto px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer">
      <option value="ALL">Todas las comisiones</option>
      
        <option value="c1" selected="">
          Desarrollo de Software I (1er Año)
        </option>
      
        <option value="c2">
          Base de Datos II (2do Año)
        </option>
      
        <option value="c3">
          Práctica Profesionalizante (3er Año)
        </option>
      
    </select>
      </div>

    </div>

    <!-- Tabla de Nómina de Alumnos -->
    <div class="bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/80 border-b border-slate-200 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
              <th class="py-3 px-4 w-12 text-center">#</th>
              <th class="py-3 px-4">Alumno</th>
              <th class="py-3 px-4">DNI</th>
              <th class="py-3 px-4">Materia / Comisión</th>
              <th class="py-3 px-4 text-center">Condición</th>
              <th class="py-3 px-4 text-right">Acciones</th>
            </tr>
          </thead>
          <tbody id="students-table-body" class="divide-y divide-slate-100 text-xs">
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">1</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              AA
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Alvarez, Agustín</h4>
              <p class="text-[11px] text-slate-400">agustin.alvarez@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">42.119.882</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s101')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s101')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s101')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">2</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              BM
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Benítez, Micaela</h4>
              <p class="text-[11px] text-slate-400">mika.benitez@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">43.550.114</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s102')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s102')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s102')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">3</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              CF
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Castro, Facundo</h4>
              <p class="text-[11px] text-slate-400">facu.castro@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">41.884.209</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s103')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s103')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s103')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">4</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              DS
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Duarte, Sofía</h4>
              <p class="text-[11px] text-slate-400">sofia.duarte@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">44.019.330</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s104')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s104')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s104')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">5</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              GF
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Gómez, Federico</h4>
              <p class="text-[11px] text-slate-400">fede.gomez@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">42.981.402</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s105')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s105')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s105')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors ">
        <td class="py-3 px-4 text-center font-bold text-slate-400">6</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              LV
            </div>
            <div>
              <h4 class="font-bold text-slate-900">López, Valentina</h4>
              <p class="text-[11px] text-slate-400">valen.lopez@alumnos.edu.ar</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">43.112.980</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            Desarrollo de Software I (1er Año)
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button type="button" onclick="toggleStatus('s106')" class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
            <i class="fa-solid fa-circle-check mr-1"></i>
            Activo
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('s106')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('s106')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
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
