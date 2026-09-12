/**
 * Controlador de la Planilla Diaria de Presentismo
 */

let currentAttendanceState = {}; // studentId -> 'P' | 'A' | 'T' | 'J'
let currentNotesState = {};      // studentId -> note

document.addEventListener('DOMContentLoaded', () => {
  const session = requireAuth(['docente', 'administrativo']);
  renderNavbar('asistencia');
  initAttendanceSheet();
});

function initAttendanceSheet() {
  const courseId = getActiveCourseId();
  const course = getCourseById(courseId);

  if (!course) {
    document.getElementById('attendance-content').innerHTML = `
      <div class="p-8 text-center bg-white rounded-2xl border border-slate-200">
        <p class="text-sm font-bold text-slate-700">No hay materias disponibles o seleccionadas.</p>
        <a href="materias.html" class="mt-3 inline-block px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-bold">Ver Materias</a>
      </div>
    `;
    return;
  }

  // Update Header Context
  const teacher = getTeacherById(course.teacherId);
  document.getElementById('course-title').innerText = course.name;
  document.getElementById('course-year').innerText = course.year;
  document.getElementById('course-teacher').innerText = teacher ? teacher.name : 'Sin asignar';
  if (course.horario) {
    document.getElementById('course-schedule').innerText = course.horario;
  }

  // Bind date change
  const dateInput = document.getElementById('fecha-presentismo');
  if (dateInput) {
    dateInput.addEventListener('change', () => {
      loadAttendanceForDate(dateInput.value);
    });
    loadAttendanceForDate(dateInput.value);
  }
}

function loadAttendanceForDate(dateStr) {
  const courseId = getActiveCourseId();
  const students = getStudentsByCourse(courseId).filter(s => s.status === 'activo');
  const existingRecord = getAttendanceRecord(courseId, dateStr);

  currentAttendanceState = {};
  
  if (existingRecord && existingRecord.records) {
    currentAttendanceState = { ...existingRecord.records };
  } else {
    // Default to P for all active students
    students.forEach(s => {
      currentAttendanceState[s.id] = 'P';
    });
  }

  renderStudentsTable(students);
  recalcularContadores();

  // Show status note
  const statusMsg = document.getElementById('last-saved-msg');
  if (statusMsg) {
    if (existingRecord) {
      statusMsg.innerHTML = `Registro existente del <strong>${dateStr}</strong> guardado por <strong>${existingRecord.updatedBy || 'Docente'}</strong>`;
    } else {
      statusMsg.innerHTML = `Nueva planilla para el <strong>${dateStr}</strong> (sin guardar aún)`;
    }
  }
}

function renderStudentsTable(students) {
  const tbody = document.getElementById('students-attendance-tbody');
  if (!tbody) return;

  if (students.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="5" class="py-8 text-center text-slate-400 text-xs">
          No hay alumnos activos matriculados en esta materia.
          <br />
          <a href="alumnos.html" class="text-indigo-600 font-bold hover:underline mt-2 inline-block">
            + Matricular Alumnos
          </a>
        </td>
      </tr>
    `;
    return;
  }

  const allRecords = getAttendanceRecords();
  const courseId = getActiveCourseId();
  const courseHistory = allRecords.filter(r => r.courseId === courseId);

  tbody.innerHTML = students.map((student, index) => {
    const initials = student.name
      .split(',')
      .map(n => n.trim()[0])
      .join('')
      .toUpperCase();

    const selectedStatus = currentAttendanceState[student.id] || 'P';

    // Calculate historical attendance rate
    const studentHistory = courseHistory.filter(r => r.records && r.records[student.id]);
    let rate = 100;
    if (studentHistory.length > 0) {
      const presents = studentHistory.filter(r => {
        const st = r.records[student.id];
        return st === 'P' || st === 'T';
      }).length;
      rate = Math.round((presents / studentHistory.length) * 100);
    }

    const rateClass = rate >= 75 ? 'text-emerald-700 bg-emerald-50 border-emerald-200' : 'text-rose-700 bg-rose-50 border-rose-200';
    const rateLabel = rate >= 75 ? 'Regular' : 'En riesgo';

    return `
      <tr class="hover:bg-slate-50/70 transition-colors" data-student-id="${student.id}">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">${index + 1}</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-700 font-bold text-xs flex items-center justify-center border border-slate-200 shrink-0">
              ${initials || 'AL'}
            </div>
            <div>
              <h4 class="font-bold text-slate-900">${student.name}</h4>
              <p class="text-[11px] text-slate-500 font-mono">DNI: ${student.dni}</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center justify-center gap-1.5">
            <button type="button" onclick="setStudentStatus('${student.id}', 'P')" class="status-pill ${selectedStatus === 'P' ? 'selected-P' : ''}">P</button>
            <button type="button" onclick="setStudentStatus('${student.id}', 'A')" class="status-pill ${selectedStatus === 'A' ? 'selected-A' : ''}">A</button>
            <button type="button" onclick="setStudentStatus('${student.id}', 'T')" class="status-pill ${selectedStatus === 'T' ? 'selected-T' : ''}">T</button>
            <button type="button" onclick="setStudentStatus('${student.id}', 'J')" class="status-pill ${selectedStatus === 'J' ? 'selected-J' : ''}">J</button>
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <div class="inline-flex items-center gap-1.5 font-bold px-2.5 py-1 rounded-full border ${rateClass}">
            <span class="text-xs">${rate}%</span>
            <span class="text-[10px] opacity-80">(${rateLabel})</span>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <input 
            type="text" 
            placeholder="Nota u observación..." 
            value="${currentNotesState[student.id] || ''}"
            onchange="currentNotesState['${student.id}'] = this.value"
            class="w-full px-2.5 py-1 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:outline-none focus:border-indigo-400" 
          />
        </td>
      </tr>
    `;
  }).join('');
}

function setStudentStatus(studentId, status) {
  currentAttendanceState[studentId] = status;
  
  const row = document.querySelector(`tr[data-student-id="${studentId}"]`);
  if (row) {
    const pills = row.querySelectorAll('.status-pill');
    pills.forEach(p => {
      p.className = 'status-pill';
    });

    const statusIndex = { 'P': 0, 'A': 1, 'T': 2, 'J': 3 }[status];
    if (pills[statusIndex]) {
      pills[statusIndex].className = `status-pill selected-${status}`;
    }
  }

  recalcularContadores();
}

function recalcularContadores() {
  let p = 0, a = 0, t = 0, j = 0;
  Object.values(currentAttendanceState).forEach(st => {
    if (st === 'P') p++;
    else if (st === 'A') a++;
    else if (st === 'T') t++;
    else if (st === 'J') j++;
  });

  const elP = document.getElementById('count-p');
  const elA = document.getElementById('count-a');
  const elT = document.getElementById('count-t');
  const elJ = document.getElementById('count-j');

  if (elP) elP.innerText = p;
  if (elA) elA.innerText = a;
  if (elT) elT.innerText = t;
  if (elJ) elJ.innerText = j;
}

function marcarTodosPresentes() {
  const courseId = getActiveCourseId();
  const students = getStudentsByCourse(courseId).filter(s => s.status === 'activo');
  students.forEach(s => {
    setStudentStatus(s.id, 'P');
  });
  showToast('Todos los alumnos han sido marcados como Presentes');
}

function guardarPlanillaAsistencia() {
  const courseId = getActiveCourseId();
  const dateInput = document.getElementById('fecha-presentismo');
  const dateStr = dateInput ? dateInput.value : new Date().toISOString().split('T')[0];

  const session = getUserSession();
  const userName = session ? session.name : 'Docente';

  saveAttendance(courseId, dateStr, currentAttendanceState, userName);
  showToast(`Planilla del ${dateStr} guardada con éxito en el sistema.`);

  const statusMsg = document.getElementById('last-saved-msg');
  if (statusMsg) {
    statusMsg.innerHTML = `Guardado exitosamente hoy a las ${new Date().toLocaleTimeString()} por <strong>${userName}</strong>`;
  }
}
