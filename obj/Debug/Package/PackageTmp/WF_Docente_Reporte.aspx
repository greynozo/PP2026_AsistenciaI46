<%@ Page Title="" Language="C#" MasterPageFile="~/Docentes.Master" AutoEventWireup="true"
    CodeBehind="WF_Docente_Reporte.aspx.cs" Inherits="PresentismoWebI46.WF_Docente_Reporte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="max-w-7xl mx-auto p-4 md:p-8 space-y-6">

    <!-- Header Principal -->
    <header class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div class="flex items-center gap-3.5">
        <div class="w-12 h-12 bg-emerald-50 text-emerald-700 rounded-2xl flex items-center justify-center text-xl shrink-0 border border-emerald-100">
          <i class="fa-solid fa-file-spreadsheet"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <span class="px-2 py-0.5 bg-emerald-50 text-emerald-700 text-[10px] font-bold uppercase rounded-md border border-emerald-100">Planilla Oficial</span>
            <span class="text-xs text-slate-400 font-semibold">Resumen de Regularidad</span>
          </div>
          <h1 class="text-xl font-bold text-slate-900 tracking-tight mt-0.5">
            Sábana de Asistencia Mensual
          </h1>
          <p class="text-xs text-slate-500">
            Matriz consolidada día por día con cálculo automático de porcentajes y exportador directo a Excel.
          </p>
        </div>
      </div>

      <div class="flex items-center gap-2 self-start md:self-auto">
        <button type="button" onclick="window.print()" class="px-3.5 py-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold rounded-xl transition-all flex items-center gap-1.5 cursor-pointer no-print">
          <i class="fa-solid fa-print"></i>
          <span>Imprimir</span>
        </button>
        <button type="button" onclick="exportarExcel()" class="px-4 py-2.5 bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center gap-2 cursor-pointer">
          <i class="fa-solid fa-file-excel text-sm"></i>
          <span>Exportar a Excel (.xlsx)</span>
        </button>
      </div>
    </header>

    <!-- Barra de Filtros y Configuración -->
    <div class="bg-white rounded-2xl p-5 border border-slate-200/80 shadow-xs flex flex-col md:flex-row md:items-center justify-between gap-4 no-print">
      
      <div class="flex flex-wrap items-center gap-3">
        <div>
          <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">Materia / Comisión</label>
          <select id="report-course-select" onchange="initReport()" class="px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer">
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

        <div>
          <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">Mes y Período</label>
          <select id="report-month-select" onchange="initReport()" class="px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 cursor-pointer">
            <option value="2026-06" selected="">Junio 2026</option>
            <option value="2026-05">Mayo 2026</option>
            <option value="2026-04">Abril 2026</option>
            <option value="2026-03">Marzo 2026</option>
          </select>
        </div>
      </div>

      <!-- Resumen de Métricas del Período -->
      <div class="flex items-center gap-4 text-xs">
        <div class="text-right">
          <span class="text-slate-400 block text-[10px] uppercase font-bold">Clases registradas</span>
          <span id="metric-total-classes" class="text-base font-bold text-slate-800">3 clases</span>
        </div>
        <div class="h-8 w-px bg-slate-200"></div>
        <div class="text-right">
          <span class="text-slate-400 block text-[10px] uppercase font-bold">Promedio Asistencia</span>
          <span id="metric-avg-rate" class="text-base font-bold text-emerald-600">89%</span>
        </div>
        <div class="h-8 w-px bg-slate-200"></div>
        <div class="text-right">
          <span class="text-slate-400 block text-[10px] uppercase font-bold">En Riesgo (&lt;75%)</span>
          <span id="metric-risk-count" class="text-base font-bold text-rose-600">2 alumnos</span>
        </div>
      </div>

    </div>

    <!-- Sábana Matricial de Asistencia -->
    <div class="bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden card">
      
      <div class="px-5 py-3 bg-slate-50/80 border-b border-slate-200 flex flex-col sm:flex-row sm:items-center justify-between gap-2">
        <span class="text-xs font-bold text-slate-700 uppercase tracking-wider">
          Planilla Mensual Consolidada de Presentismo
        </span>
        <div class="flex items-center gap-3 text-[11px]">
          <span class="flex items-center gap-1 font-bold text-emerald-700"><span class="w-2 h-2 rounded-full bg-emerald-500"></span> Presente (P)</span>
          <span class="flex items-center gap-1 font-bold text-rose-700"><span class="w-2 h-2 rounded-full bg-rose-500"></span> Ausente (A)</span>
          <span class="flex items-center gap-1 font-bold text-amber-700"><span class="w-2 h-2 rounded-full bg-amber-500"></span> Tarde (T)</span>
          <span class="flex items-center gap-1 font-bold text-blue-700"><span class="w-2 h-2 rounded-full bg-blue-500"></span> Justificado (J)</span>
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse text-xs">
          <thead>
            <tr id="matrix-thead-row" class="bg-slate-100/70 border-b border-slate-200 font-bold text-slate-600 text-[11px]">
      <th class="py-3 px-3 w-10 text-center">#</th>
      <th class="py-3 px-4 min-w-[180px]">Apellido y Nombre</th>
      <th class="py-3 px-3 w-28">DNI</th>
      <th class="py-3 px-2 text-center w-10 border-l border-slate-200">01</th><th class="py-3 px-2 text-center w-10 border-l border-slate-200">03</th><th class="py-3 px-2 text-center w-10 border-l border-slate-200">08</th>
      <th class="py-3 px-2 text-center w-12 bg-emerald-50/70 text-emerald-800 border-l border-slate-200">P</th>
      <th class="py-3 px-2 text-center w-12 bg-rose-50/70 text-rose-800">A</th>
      <th class="py-3 px-2 text-center w-12 bg-amber-50/70 text-amber-800">T</th>
      <th class="py-3 px-2 text-center w-12 bg-blue-50/70 text-blue-800">J</th>
      <th class="py-3 px-3 text-center min-w-[85px] bg-slate-200/50">% Asist.</th>
      <th class="py-3 px-3 text-center w-28">Condición</th>
    </tr>
          </thead>
          <tbody id="matrix-tbody" class="divide-y divide-slate-100 font-medium">
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">1</td>
        <td class="py-3 px-4 font-bold text-slate-900">Alvarez, Agustín</td>
        <td class="py-3 px-3 font-mono text-slate-500">42.119.882</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">3</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-emerald-700 bg-slate-100/60">100%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-emerald-50 text-emerald-700 border-emerald-200">
            Regular
          </span>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">2</td>
        <td class="py-3 px-4 font-bold text-slate-900">Benítez, Micaela</td>
        <td class="py-3 px-3 font-mono text-slate-500">43.550.114</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-rose-600 bg-rose-50/30 border-l border-slate-200">A</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">2</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">1</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-rose-700 bg-slate-100/60">67%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-rose-50 text-rose-700 border-rose-200">
            En Riesgo
          </span>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">3</td>
        <td class="py-3 px-4 font-bold text-slate-900">Castro, Facundo</td>
        <td class="py-3 px-3 font-mono text-slate-500">41.884.209</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">3</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-emerald-700 bg-slate-100/60">100%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-emerald-50 text-emerald-700 border-emerald-200">
            Regular
          </span>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">4</td>
        <td class="py-3 px-4 font-bold text-slate-900">Duarte, Sofía</td>
        <td class="py-3 px-3 font-mono text-slate-500">44.019.330</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-amber-600 bg-amber-50/30 border-l border-slate-200">T</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">2</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">1</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-emerald-700 bg-slate-100/60">100%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-emerald-50 text-emerald-700 border-emerald-200">
            Regular
          </span>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">5</td>
        <td class="py-3 px-4 font-bold text-slate-900">Gómez, Federico</td>
        <td class="py-3 px-3 font-mono text-slate-500">42.981.402</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-rose-600 bg-rose-50/30 border-l border-slate-200">A</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">2</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">1</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-rose-700 bg-slate-100/60">67%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-rose-50 text-rose-700 border-rose-200">
            En Riesgo
          </span>
        </td>
      </tr>
    
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">6</td>
        <td class="py-3 px-4 font-bold text-slate-900">López, Valentina</td>
        <td class="py-3 px-3 font-mono text-slate-500">43.112.980</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-emerald-600 bg-emerald-50/30 border-l border-slate-200">P</td><td class="py-3 px-2 text-center font-bold text-amber-600 bg-amber-50/30 border-l border-slate-200">T</td>
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">2</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">0</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">1</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">0</td>
        <td class="py-3 px-3 text-center font-bold text-emerald-700 bg-slate-100/60">100%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border bg-emerald-50 text-emerald-700 border-emerald-200">
            Regular
          </span>
        </td>
      </tr>
    </tbody>
        </table>
      </div>

      <!-- Pie de Informe Oficial -->
      <div class="p-6 bg-slate-50 border-t border-slate-200 flex flex-col sm:flex-row sm:items-center justify-between gap-6 text-xs text-slate-600 mt-4">
        <div>
          Firma del Docente Titular: 
          <span id="footer-teacher-name" class="font-bold text-slate-800 ml-1">Prof. Carlos Rodríguez</span>
          <div class="border-b border-slate-400 w-56 mt-6"></div>
        </div>
        <div>
          Recibido por Bedelía / Secretaría:
          <div class="border-b border-slate-400 w-56 mt-6"></div>
        </div>
      </div>

    </div>

  </main>
</asp:Content>
