<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="WF_Admin_Carreras.aspx.cs" Inherits="PresentismoWebI46.WF_Admin_Carreras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6">

    <!-- Header Principal -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div class="flex items-center gap-3.5">
        <div class="w-12 h-12 bg-indigo-50 text-indigo-700 rounded-2xl flex items-center justify-center text-xl shrink-0 border border-indigo-100">
          <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <span class="px-2 py-0.5 bg-indigo-50 text-indigo-700 text-[10px] font-bold uppercase rounded-md border border-indigo-100">Oferta Académica</span>
            <span class="text-xs text-slate-400 font-semibold">Nivel Superior Técnico</span>
          </div>
          <h1 class="text-xl font-bold text-slate-900 tracking-tight mt-0.5">
            Gestión de Carreras Académicas
          </h1>
          <p class="text-xs text-slate-500">
            Define carreras oficiales de la institución para vincular materias, docentes y comisiones.
          </p>
        </div>
      </div>

      <button type="button" onclick="openAddCareerModal()" class="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer self-start md:self-auto">
        <i class="fa-solid fa-plus text-xs"></i>
        <span>Nueva Carrera</span>
      </button>
    </header>

    <!-- Resumen de Estadísticas -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
      <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs flex items-center gap-4">
        <div class="w-11 h-11 bg-indigo-50 text-indigo-600 rounded-xl flex items-center justify-center text-lg">
          <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <div>
          <div id="stat-total-carreras" class="text-2xl font-black text-slate-900">3</div>
          <div class="text-xs text-slate-500 font-medium">Carreras Activas</div>
        </div>
      </div>

      <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs flex items-center gap-4">
        <div class="w-11 h-11 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center text-lg">
          <i class="fa-solid fa-book-bookmark"></i>
        </div>
        <div>
          <div id="stat-total-materias" class="text-2xl font-black text-slate-900">3</div>
          <div class="text-xs text-slate-500 font-medium">Materias Asignadas</div>
        </div>
      </div>

      <div class="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs flex items-center gap-4">
        <div class="w-11 h-11 bg-emerald-50 text-emerald-600 rounded-xl flex items-center justify-center text-lg">
          <i class="fa-solid fa-user-graduate"></i>
        </div>
        <div>
          <div id="stat-total-alumnos" class="text-2xl font-black text-slate-900">11</div>
          <div class="text-xs text-slate-500 font-medium">Alumnos Cursando</div>
        </div>
      </div>
    </div>

    <!-- Grid de Carreras -->
    <div id="careers-grid-container" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <span class="px-2.5 py-1 bg-indigo-50 text-indigo-700 text-[11px] font-black uppercase rounded-lg border border-indigo-100 tracking-wider">
              TSDS
            </span>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCareerModal('car1')" title="Editar Carrera" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCareer('car1')" title="Eliminar Carrera" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors leading-snug">
            Tecnicatura Superior en Desarrollo de Software
          </h3>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-calendar-days text-indigo-500 w-4"></i>
              <span class="font-medium text-slate-700">Duración: 3 Años</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-file-contract text-slate-400 w-4"></i>
              <span class="text-slate-500 truncate" title="Res. Ministerial N° 245/21">
                Res. Ministerial N° 245/21
              </span>
            </div>

            <div class="flex items-center gap-2 pt-2 border-t border-slate-100">
              <i class="fa-solid fa-book-bookmark text-indigo-400 w-4"></i>
              <span class="font-bold text-slate-800">3 Materias asociadas</span>
              <span class="text-slate-300">•</span>
              <span class="font-semibold text-slate-600">11 Alumnos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <a href="materias.html" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-arrow-right text-[10px]"></i>
            <span>Ver Materias de la Carrera</span>
          </a>
        </div>
      </div>
    
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <span class="px-2.5 py-1 bg-indigo-50 text-indigo-700 text-[11px] font-black uppercase rounded-lg border border-indigo-100 tracking-wider">
              TSAS
            </span>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCareerModal('car2')" title="Editar Carrera" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCareer('car2')" title="Eliminar Carrera" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors leading-snug">
            Tecnicatura Superior en Análisis de Sistemas
          </h3>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-calendar-days text-indigo-500 w-4"></i>
              <span class="font-medium text-slate-700">Duración: 3 Años</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-file-contract text-slate-400 w-4"></i>
              <span class="text-slate-500 truncate" title="Res. Ministerial N° 112/19">
                Res. Ministerial N° 112/19
              </span>
            </div>

            <div class="flex items-center gap-2 pt-2 border-t border-slate-100">
              <i class="fa-solid fa-book-bookmark text-indigo-400 w-4"></i>
              <span class="font-bold text-slate-800">0 Materias asociadas</span>
              <span class="text-slate-300">•</span>
              <span class="font-semibold text-slate-600">0 Alumnos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <a href="materias.html" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-arrow-right text-[10px]"></i>
            <span>Ver Materias de la Carrera</span>
          </a>
        </div>
      </div>
    
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <span class="px-2.5 py-1 bg-indigo-50 text-indigo-700 text-[11px] font-black uppercase rounded-lg border border-indigo-100 tracking-wider">
              TSRI
            </span>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCareerModal('car3')" title="Editar Carrera" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCareer('car3')" title="Eliminar Carrera" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors leading-snug">
            Tecnicatura Superior en Redes e Infraestructura
          </h3>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-calendar-days text-indigo-500 w-4"></i>
              <span class="font-medium text-slate-700">Duración: 3 Años</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-file-contract text-slate-400 w-4"></i>
              <span class="text-slate-500 truncate" title="Res. Ministerial N° 580/22">
                Res. Ministerial N° 580/22
              </span>
            </div>

            <div class="flex items-center gap-2 pt-2 border-t border-slate-100">
              <i class="fa-solid fa-book-bookmark text-indigo-400 w-4"></i>
              <span class="font-bold text-slate-800">0 Materias asociadas</span>
              <span class="text-slate-300">•</span>
              <span class="font-semibold text-slate-600">0 Alumnos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <a href="materias.html" class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all">
            <i class="fa-solid fa-arrow-right text-[10px]"></i>
            <span>Ver Materias de la Carrera</span>
          </a>
        </div>
      </div>
    </div>

  </main>
</asp:Content>
