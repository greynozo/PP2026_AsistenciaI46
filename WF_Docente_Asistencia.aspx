<%@ Page Title="" Language="C#" MasterPageFile="~/Docentes.Master" AutoEventWireup="true"
    CodeBehind="WF_Docente_Asistencia.aspx.cs" Inherits="PresentismoWebI46.WF_Docente_Asistencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6" id="attendance-content">

    <!-- Encabezado de la Comisión y Asignatura -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div>
        <div class="flex items-center gap-2 mb-1">
          <span id="course-year" class="px-2.5 py-0.5 bg-indigo-50 text-indigo-700 text-xs font-bold uppercase rounded-md border border-indigo-100">1er Año</span>
          <span class="text-xs text-slate-400 font-semibold">• Ciclo Lectivo 2026</span>
        </div>
        <h1 id="course-title" class="text-xl md:text-2xl font-black text-slate-900 tracking-tight">Desarrollo de Software I</h1>
        <p class="text-xs text-slate-500 mt-1 flex flex-wrap items-center gap-3">
          <span><i class="fa-solid fa-chalkboard-user text-indigo-500 mr-1"></i> Titular: <strong id="course-teacher" class="text-slate-700">Prof. Carlos Rodríguez</strong></span>
          <span class="hidden sm:inline">•</span>
          <span><i class="fa-regular fa-clock text-slate-400 mr-1"></i> <span id="course-schedule">Lun y Mié 18:30 a 21:00 hs</span></span>
        </p>
      </div>

      <div class="flex items-center gap-2 self-start md:self-auto">
        <a href="reporte-mensual.html" class="px-3.5 py-2.5 bg-emerald-50 hover:bg-emerald-100 text-emerald-700 text-xs font-bold rounded-xl border border-emerald-200 transition-all flex items-center gap-1.5">
          <i class="fa-solid fa-file-excel"></i>
          <span>Sábana Mensual</span>
        </a>
        <button type="button" onclick="marcarTodosPresentes()" class="px-3.5 py-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold rounded-xl transition-all flex items-center gap-1.5 cursor-pointer">
          <i class="fa-solid fa-check-double text-emerald-600"></i>
          <span>Todos Presentes</span>
        </button>
      </div>
    </header>

    <!-- Barra de Selección de Fecha y Métricas en Tiempo Real -->
    <div class="bg-white rounded-2xl p-5 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      
      <!-- Selector de Fecha de la Clase -->
      <div class="flex items-center gap-3">
        <label class="text-xs font-bold text-slate-600 uppercase tracking-wider whitespace-nowrap">
          <i class="fa-regular fa-calendar text-indigo-600 mr-1"></i> Fecha de Clase:
        </label>
        <input id="fecha-presentismo" type="date" value="2026-06-09" class="px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white cursor-pointer">
      </div>

      <!-- Contadores Vivos (P, A, T, J) -->
      <div class="flex items-center gap-2 overflow-x-auto pb-1 md:pb-0">
        <div class="flex items-center gap-2 px-3 py-1.5 bg-emerald-50 border border-emerald-200/80 rounded-xl text-xs font-bold text-emerald-700">
          <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
          <span>Presentes:</span>
          <span id="count-p" class="text-sm font-black">6</span>
        </div>

        <div class="flex items-center gap-2 px-3 py-1.5 bg-rose-50 border border-rose-200/80 rounded-xl text-xs font-bold text-rose-700">
          <span class="w-2 h-2 rounded-full bg-rose-500"></span>
          <span>Ausentes:</span>
          <span id="count-a" class="text-sm font-black">0</span>
        </div>

        <div class="flex items-center gap-2 px-3 py-1.5 bg-amber-50 border border-amber-200/80 rounded-xl text-xs font-bold text-amber-700">
          <span class="w-2 h-2 rounded-full bg-amber-500"></span>
          <span>Tardes:</span>
          <span id="count-t" class="text-sm font-black">0</span>
        </div>

        <div class="flex items-center gap-2 px-3 py-1.5 bg-blue-50 border border-blue-200/80 rounded-xl text-xs font-bold text-blue-700">
          <span class="w-2 h-2 rounded-full bg-blue-500"></span>
          <span>Justificados:</span>
          <span id="count-j" class="text-sm font-black">0</span>
        </div>
      </div>

    </div>

    <!-- Tabla Principal de Asistencia Diaria -->
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
          <tbody id="students-attendance-tbody" class="divide-y divide-slate-100 text-xs">
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s101">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">1</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              AA
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Alvarez, Agustín</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 42.119.882</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s101', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s101', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s101', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s101', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-emerald-700 bg-emerald-50 border-emerald-200">
            <span class="text-xs">100%</span>
            <span class="text-[10px] opacity-80">(Regular)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s101'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s102">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">2</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              BM
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Benítez, Micaela</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 43.550.114</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s102', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s102', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s102', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s102', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-rose-700 bg-rose-50 border-rose-200">
            <span class="text-xs">67%</span>
            <span class="text-[10px] opacity-80">(En riesgo)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s102'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s103">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">3</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              CF
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Castro, Facundo</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 41.884.209</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s103', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s103', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s103', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s103', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-emerald-700 bg-emerald-50 border-emerald-200">
            <span class="text-xs">100%</span>
            <span class="text-[10px] opacity-80">(Regular)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s103'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s104">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">4</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              DS
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Duarte, Sofía</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 44.019.330</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s104', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s104', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s104', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s104', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-emerald-700 bg-emerald-50 border-emerald-200">
            <span class="text-xs">100%</span>
            <span class="text-[10px] opacity-80">(Regular)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s104'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s105">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">5</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              GF
            </div>
            <div>
              <h4 class="font-bold text-slate-900">Gómez, Federico</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 42.981.402</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s105', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s105', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s105', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s105', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-rose-700 bg-rose-50 border-rose-200">
            <span class="text-xs">67%</span>
            <span class="text-[10px] opacity-80">(En riesgo)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s105'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="s106">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">6</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              LV
            </div>
            <div>
              <h4 class="font-bold text-slate-900">López, Valentina</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: 43.112.980</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('s106', 'P')" class="status-pill selected-P">P</button>
            <button type="button" onclick="setStudentStatus('s106', 'A')" class="status-pill ">A</button>
            <button type="button" onclick="setStudentStatus('s106', 'T')" class="status-pill ">T</button>
            <button type="button" onclick="setStudentStatus('s106', 'J')" class="status-pill ">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border text-emerald-700 bg-emerald-50 border-emerald-200">
            <span class="text-xs">100%</span>
            <span class="text-[10px] opacity-80">(Regular)</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input type="text" placeholder="Nota u observación..." value="" onchange="currentNotesState['s106'] = this.value" class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400">
        </td>
      </tr>
    </tbody>
        </table>
      </div>

      <!-- Barra Inferior de Acción y Guardado -->
      <div class="p-5 bg-slate-50/80 border-t border-slate-200 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div id="last-saved-msg" class="text-xs text-slate-500">Nueva planilla para el <strong>2026-06-09</strong> (sin guardar aún)</div>

        <div class="flex items-center gap-3">
          <button type="button" onclick="guardarPlanillaAsistencia()" class="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center justify-center gap-2 cursor-pointer">
            <i class="fa-solid fa-cloud-arrow-up text-sm"></i>
            <span>Guardar Planilla de Asistencia</span>
          </button>
        </div>
      </div>

    </div>

  </main>
</asp:Content>
