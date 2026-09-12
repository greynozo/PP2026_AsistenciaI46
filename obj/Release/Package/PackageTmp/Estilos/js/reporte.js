/**
 * Controlador de la Sábana de Asistencia Mensual y Exportador a Excel
 */

let currentMonthDates = [];
let currentMatrixData = [];

document.addEventListener('DOMContentLoaded', () => {
  requireAuth(['docente', 'administrativo']);
  renderNavbar('reporte');
  populateCourseFilter();
  initReport();
});

function populateCourseFilter() {
  const select = document.getElementById('report-course-select');
  if (!select) return;

  const courses = getCourses();
  const activeCourseId = getActiveCourseId();

  select.innerHTML = courses.map(c => `
    <option value="${c.id}" ${c.id === activeCourseId ? 'selected' : ''}>
      ${c.name} (${c.year})
    </option>
  `).join('');
}

function initReport() {
  const courseSelect = document.getElementById('report-course-select');
  const monthSelect = document.getElementById('report-month-select');

  const courseId = courseSelect ? courseSelect.value : getActiveCourseId();
  const selectedMonth = monthSelect ? monthSelect.value : '2026-06';

  renderMonthlySheet(courseId, selectedMonth);
}

function renderMonthlySheet(courseId, monthStr) {
  const course = getCourseById(courseId);
  const teacher = course ? getTeacherById(course.teacherId) : null;
  const students = getStudentsByCourse(courseId);

  // Filter attendance records for this course & month
  const allRecords = getAttendanceRecords();
  const monthRecords = allRecords
    .filter(r => r.courseId === courseId && r.date.startsWith(monthStr))
    .sort((a, b) => a.date.localeCompare(b.date));

  currentMonthDates = monthRecords.map(r => r.date);

  // Build the matrix header (Day columns)
  const theadRow = document.getElementById('matrix-thead-row');
  if (theadRow) {
    let daysHtml = '';
    if (currentMonthDates.length > 0) {
      daysHtml = currentMonthDates.map(d => {
        const dayNum = d.split('-')[2];
        return `<th class="py-3 px-2 text-center w-10 border-l border-slate-200">${dayNum}</th>`;
      }).join('');
    } else {
      daysHtml = `<th class="py-3 px-2 text-center text-slate-400 border-l border-slate-200">Sin clases en este mes</th>`;
    }

    theadRow.innerHTML = `
      <th class="py-3 px-3 w-10 text-center">#</th>
      <th class="py-3 px-4 min-w-[180px]">Apellido y Nombre</th>
      <th class="py-3 px-3 w-28">DNI</th>
      ${daysHtml}
      <th class="py-3 px-2 text-center w-12 bg-emerald-50/70 text-emerald-800 border-l border-slate-200">P</th>
      <th class="py-3 px-2 text-center w-12 bg-rose-50/70 text-rose-800">A</th>
      <th class="py-3 px-2 text-center w-12 bg-amber-50/70 text-amber-800">T</th>
      <th class="py-3 px-2 text-center w-12 bg-blue-50/70 text-blue-800">J</th>
      <th class="py-3 px-3 text-center min-w-[85px] bg-slate-200/50">% Asist.</th>
      <th class="py-3 px-3 text-center w-28">Condición</th>
    `;
  }

  // Build rows
  const tbody = document.getElementById('matrix-tbody');
  if (!tbody) return;

  if (students.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="12" class="py-8 text-center text-slate-400 text-xs">
          No hay alumnos matriculados en esta materia.
        </td>
      </tr>
    `;
    return;
  }

  let totalPresenteAll = 0;
  let totalOpportunities = 0;
  let studentsAtRisk = 0;
  currentMatrixData = [];

  tbody.innerHTML = students.map((student, index) => {
    let p = 0, a = 0, t = 0, j = 0;
    const dayCells = currentMonthDates.map(date => {
      const record = monthRecords.find(r => r.date === date);
      const status = (record && record.records) ? (record.records[student.id] || '-') : '-';
      
      if (status === 'P') p++;
      else if (status === 'A') a++;
      else if (status === 'T') t++;
      else if (status === 'J') j++;

      let colorClass = 'text-slate-400 bg-slate-50/30';
      if (status === 'P') colorClass = 'font-bold text-emerald-600 bg-emerald-50/30';
      else if (status === 'A') colorClass = 'font-bold text-rose-600 bg-rose-50/30';
      else if (status === 'T') colorClass = 'font-bold text-amber-600 bg-amber-50/30';
      else if (status === 'J') colorClass = 'font-bold text-blue-600 bg-blue-50/30';

      return `<td class="py-3 px-2 text-center ${colorClass} border-l border-slate-200">${status}</td>`;
    }).join('');

    const totalClasses = currentMonthDates.length;
    const rate = totalClasses > 0 ? Math.round(((p + t) / totalClasses) * 100) : 100;
    
    totalPresenteAll += (p + t);
    totalOpportunities += totalClasses;

    const isRegular = rate >= 75;
    if (!isRegular) studentsAtRisk++;

    currentMatrixData.push({
      index: index + 1,
      name: student.name,
      dni: student.dni,
      p, a, t, j,
      rate,
      condicion: isRegular ? 'Regular' : 'En Riesgo'
    });

    return `
      <tr class="hover:bg-slate-50 transition-colors">
        <td class="py-3 px-3 text-center font-bold text-slate-400">${index + 1}</td>
        <td class="py-3 px-4 font-bold text-slate-900">${student.name}</td>
        <td class="py-3 px-3 font-mono text-slate-500">${student.dni}</td>
        ${dayCells}
        <td class="py-3 px-2 text-center font-bold text-emerald-700 bg-emerald-50/70 border-l border-slate-200">${p}</td>
        <td class="py-3 px-2 text-center font-bold text-rose-700 bg-rose-50/70">${a}</td>
        <td class="py-3 px-2 text-center font-bold text-amber-700 bg-amber-50/70">${t}</td>
        <td class="py-3 px-2 text-center font-bold text-blue-700 bg-blue-50/70">${j}</td>
        <td class="py-3 px-3 text-center font-bold ${isRegular ? 'text-emerald-700' : 'text-rose-700'} bg-slate-100/60">${rate}%</td>
        <td class="py-3 px-3 text-center">
          <span class="px-2 py-0.5 text-[10px] font-bold rounded-full border ${
            isRegular ? 'bg-emerald-50 text-emerald-700 border-emerald-200' : 'bg-rose-50 text-rose-700 border-rose-200'
          }">
            ${isRegular ? 'Regular' : 'En Riesgo'}
          </span>
        </td>
      </tr>
    `;
  }).join('');

  // Update Summary Metrics
  const avgRate = totalOpportunities > 0 ? Math.round((totalPresenteAll / totalOpportunities) * 100) : 0;
  
  const elClasses = document.getElementById('metric-total-classes');
  const elRate = document.getElementById('metric-avg-rate');
  const elRisk = document.getElementById('metric-risk-count');
  
  if (elClasses) elClasses.innerText = `${currentMonthDates.length} clases`;
  if (elRate) elRate.innerText = `${avgRate}%`;
  if (elRisk) elRisk.innerText = `${studentsAtRisk} alumno${studentsAtRisk === 1 ? '' : 's'}`;

  // Footer signatures info
  const footerTeacher = document.getElementById('footer-teacher-name');
  if (footerTeacher && teacher) {
    footerTeacher.innerText = teacher.name;
  }
}

/**
 * Generador y Descargador de Excel / CSV nativo en UTF-8
 */
function exportarExcel() {
  const courseSelect = document.getElementById('report-course-select');
  const monthSelect = document.getElementById('report-month-select');

  const courseId = courseSelect ? courseSelect.value : getActiveCourseId();
  const course = getCourseById(courseId);
  const monthStr = monthSelect ? monthSelect.value : '2026-06';

  if (!course) {
    alert('Seleccione una materia válida.');
    return;
  }

  // Header row
  let csv = `\uFEFF`; // UTF-8 BOM for Excel
  csv += `SISTEMA DE ASISTENCIA Y PRESENTISMO ACADÉMICO\r\n`;
  csv += `Materia:;${course.name};Año:;${course.year};Período:;${monthStr}\r\n\r\n`;

  // Columns
  let colHeaders = ['Nro', 'Apellido y Nombre', 'DNI'];
  currentMonthDates.forEach(d => {
    colHeaders.push(`Día ${d.split('-')[2]}`);
  });
  colHeaders.push('Presentes (P)', 'Ausentes (A)', 'Tardes (T)', 'Justificados (J)', '% Asistencia', 'Condición');

  csv += colHeaders.join(';') + '\r\n';

  // Rows
  const students = getStudentsByCourse(courseId);
  const allRecords = getAttendanceRecords();
  const monthRecords = allRecords.filter(r => r.courseId === courseId && r.date.startsWith(monthStr));

  students.forEach((student, index) => {
    let p = 0, a = 0, t = 0, j = 0;
    const dayValues = currentMonthDates.map(date => {
      const record = monthRecords.find(r => r.date === date);
      const st = (record && record.records) ? (record.records[student.id] || '-') : '-';
      if (st === 'P') p++;
      else if (st === 'A') a++;
      else if (st === 'T') t++;
      else if (st === 'J') j++;
      return st;
    });

    const totalClasses = currentMonthDates.length;
    const rate = totalClasses > 0 ? Math.round(((p + t) / totalClasses) * 100) : 100;
    const condicion = rate >= 75 ? 'Regular' : 'En Riesgo';

    const row = [
      index + 1,
      `"${student.name}"`,
      student.dni,
      ...dayValues,
      p,
      a,
      t,
      j,
      `${rate}%`,
      condicion
    ];

    csv += row.join(';') + '\r\n';
  });

  // Blob & Download trigger
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  
  const cleanName = course.name.replace(/[^a-zA-Z0-9]/g, '_');
  link.setAttribute('href', url);
  link.setAttribute('download', `Sabana_Asistencia_${cleanName}_${monthStr}.csv`);
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);

  showToast('Archivo Excel/CSV generado y descargado con éxito.');
}
