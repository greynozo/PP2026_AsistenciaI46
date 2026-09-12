<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="WF_Admin_Materias.aspx.cs" Inherits="PresentismoWebI46.WF_Admin_Materias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6">

    <!-- Header Principal -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div class="flex items-center gap-3.5">
        <div class="w-12 h-12 bg-indigo-50 text-indigo-700 rounded-2xl flex items-center justify-center text-xl shrink-0 border border-indigo-100">
          <i class="fa-solid fa-book-bookmark"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <span class="px-2 py-0.5 bg-indigo-50 text-indigo-700 text-[10px] font-bold uppercase rounded-md border border-indigo-100">Plan de Estudios</span>
            <span class="text-xs text-slate-400 font-semibold">Ciclo Lectivo 2026</span>
          </div>
          <h1 class="text-xl font-bold text-slate-900 tracking-tight mt-0.5">
            Gestión de Materias y Comisiones
          </h1>
          <p class="text-xs text-slate-500">
            Administración de cátedras, asignación de docentes a cargo y cronogramas de cursada.
          </p>
        </div>
      </div>

      <button type="button" onclick="openAddCourseModal()" class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer self-start md:self-auto">
        <i class="fa-solid fa-plus text-xs"></i>
        <span>Nueva Materia</span>
      </button>
    </header>

    <!-- Filtro por Carrera y Búsqueda -->
    <div class="bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs flex flex-col sm:flex-row items-center justify-between gap-3">
      <div class="flex items-center gap-2 w-full sm:w-auto">
        <label for="filter-career" class="text-xs font-bold text-slate-500 uppercase shrink-0">Filtrar por Carrera:</label>
        <select id="filter-career" onchange="renderCourses()" class="px-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer w-full sm:w-64">
      <option value="all">Todas las Carreras (3)</option>
      <option value="car1">Tecnicatura Superior en Desarrollo de Software (TSDS)</option><option value="car2">Tecnicatura Superior en Análisis de Sistemas (TSAS)</option><option value="car3">Tecnicatura Superior en Redes e Infraestructura (TSRI)</option>
    </select>
      </div>
      <div id="materias-counter" class="text-xs font-semibold text-slate-500">Mostrando 3 materia(s)</div>
    </div>

    <!-- Grid de Materias / Comisiones -->
    <div id="courses-grid-container" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <div class="flex items-center gap-1.5 flex-wrap">
              
                <span class="px-2 py-0.5 bg-indigo-100 text-indigo-800 text-[10px] font-black uppercase rounded-md border border-indigo-200">
                  TSDS
                </span>
              
              <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-bold uppercase rounded-md border border-slate-200">
                1er Año
              </span>
            </div>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCourseModal('c1')" title="Editar Materia" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCourse('c1')" title="Eliminar Materia" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">
            Desarrollo de Software I
          </h3>
          <p class="text-[11px] text-slate-400 font-medium line-clamp-1 mt-0.5">Tecnicatura Superior en Desarrollo de Software</p>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-chalkboard-user text-indigo-500 w-4"></i>
              <span class="font-semibold text-slate-800">Prof. Carlos Rodríguez</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-regular fa-clock text-slate-400 w-4"></i>
              <span class="text-slate-500">Lun y Mié 18:30 a 21:00 hs</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-users text-slate-400 w-4"></i>
              <span class="font-bold text-slate-700">6 alumnos activos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <button type="button" onclick="seleccionarMateriaYPasarLista('c1')" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Pasar Lista</span>
          </button>
          
          <a href="reporte-mensual.html" onclick="setActiveCourseId('c1')" title="Ver Sábana Mensual" class="p-2 bg-white hover:bg-emerald-50 text-emerald-700 border border-slate-200 rounded-xl transition-all shrink-0">
            <i class="fa-solid fa-file-excel"></i>
          </a>
        </div>
      </div>
    
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <div class="flex items-center gap-1.5 flex-wrap">
              
                <span class="px-2 py-0.5 bg-indigo-100 text-indigo-800 text-[10px] font-black uppercase rounded-md border border-indigo-200">
                  TSDS
                </span>
              
              <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-bold uppercase rounded-md border border-slate-200">
                2do Año
              </span>
            </div>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCourseModal('c2')" title="Editar Materia" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCourse('c2')" title="Eliminar Materia" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">
            Base de Datos II
          </h3>
          <p class="text-[11px] text-slate-400 font-medium line-clamp-1 mt-0.5">Tecnicatura Superior en Desarrollo de Software</p>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-chalkboard-user text-indigo-500 w-4"></i>
              <span class="font-semibold text-slate-800">Lic. Laura González</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-regular fa-clock text-slate-400 w-4"></i>
              <span class="text-slate-500">Mar y Jue 19:00 a 22:00 hs</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-users text-slate-400 w-4"></i>
              <span class="font-bold text-slate-700">3 alumnos activos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <button type="button" onclick="seleccionarMateriaYPasarLista('c2')" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Pasar Lista</span>
          </button>
          
          <a href="reporte-mensual.html" onclick="setActiveCourseId('c2')" title="Ver Sábana Mensual" class="p-2 bg-white hover:bg-emerald-50 text-emerald-700 border border-slate-200 rounded-xl transition-all shrink-0">
            <i class="fa-solid fa-file-excel"></i>
          </a>
        </div>
      </div>
    
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <div class="flex items-center gap-1.5 flex-wrap">
              
                <span class="px-2 py-0.5 bg-indigo-100 text-indigo-800 text-[10px] font-black uppercase rounded-md border border-indigo-200">
                  TSDS
                </span>
              
              <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-bold uppercase rounded-md border border-slate-200">
                3er Año
              </span>
            </div>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCourseModal('c3')" title="Editar Materia" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCourse('c3')" title="Eliminar Materia" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">
            Práctica Profesionalizante
          </h3>
          <p class="text-[11px] text-slate-400 font-medium line-clamp-1 mt-0.5">Tecnicatura Superior en Desarrollo de Software</p>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-chalkboard-user text-indigo-500 w-4"></i>
              <span class="font-semibold text-slate-800">Ing. Marcos Martínez</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-regular fa-clock text-slate-400 w-4"></i>
              <span class="text-slate-500">Viernes 18:00 a 22:30 hs</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-users text-slate-400 w-4"></i>
              <span class="font-bold text-slate-700">2 alumnos activos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <button type="button" onclick="seleccionarMateriaYPasarLista('c3')" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Pasar Lista</span>
          </button>
          
          <a href="reporte-mensual.html" onclick="setActiveCourseId('c3')" title="Ver Sábana Mensual" class="p-2 bg-white hover:bg-emerald-50 text-emerald-700 border border-slate-200 rounded-xl transition-all shrink-0">
            <i class="fa-solid fa-file-excel"></i>
          </a>
        </div>
      </div>
    </div>

  </main>
</asp:Content>
