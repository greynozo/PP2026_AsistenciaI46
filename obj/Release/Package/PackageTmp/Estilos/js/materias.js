/**
 * Controlador de Gestión de Materias y Comisiones
 */

let editingCourseId = null;

document.addEventListener('DOMContentLoaded', () => {
  requireAuth(['administrativo', 'docente']);
  renderNavbar('materias');
  populateTeacherSelect();
  renderCourses();
});

function populateTeacherSelect() {
  const select = document.getElementById('modal-course-teacher');
  if (!select) return;

  const teachers = getTeachers();
  select.innerHTML = teachers.map(t => `
    <option value="${t.id}">${t.name} (${t.email})</option>
  `).join('');
}

function renderCourses() {
  const container = document.getElementById('courses-grid-container');
  if (!container) return;

  const courses = getCourses();
  const teachers = getTeachers();
  const students = getStudents();

  if (courses.length === 0) {
    container.innerHTML = `
      <div class="col-span-full p-8 text-center bg-white rounded-2xl border border-slate-200 text-slate-500 text-xs">
        No hay materias registradas actualmente.
      </div>
    `;
    return;
  }

  container.innerHTML = courses.map(course => {
    const teacher = teachers.find(t => t.id === course.teacherId);
    const courseStudents = students.filter(s => s.courseId === course.id);
    const activeStudents = courseStudents.filter(s => s.status === 'activo');

    return `
      <div class="bg-white rounded-2xl border border-slate-200/90 shadow-xs hover:shadow-md transition-all flex flex-col justify-between overflow-hidden group">
        <div class="p-6">
          <div class="flex items-start justify-between gap-3 mb-3">
            <span class="px-2.5 py-0.5 bg-indigo-50 text-indigo-700 text-[10px] font-bold uppercase rounded-md border border-indigo-100">
              ${course.year}
            </span>
            <div class="flex items-center gap-1">
              <button type="button" onclick="openEditCourseModal('${course.id}')" title="Editar Materia" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-pen-to-square text-xs"></i>
              </button>
              <button type="button" onclick="handleDeleteCourse('${course.id}')" title="Eliminar Materia" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100">
                <i class="fa-solid fa-trash text-xs"></i>
              </button>
            </div>
          </div>

          <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">
            ${course.name}
          </h3>

          <div class="mt-4 space-y-2 text-xs text-slate-600">
            <div class="flex items-center gap-2">
              <i class="fa-solid fa-chalkboard-user text-indigo-500 w-4"></i>
              <span class="font-semibold text-slate-800">${teacher ? teacher.name : 'Sin docente asignado'}</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-regular fa-clock text-slate-400 w-4"></i>
              <span class="text-slate-500">${course.horario || 'Horario a confirmar'}</span>
            </div>

            <div class="flex items-center gap-2">
              <i class="fa-solid fa-users text-slate-400 w-4"></i>
              <span class="font-bold text-slate-700">${activeStudents.length} alumnos activos</span>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-2">
          <button 
            type="button" 
            onclick="seleccionarMateriaYPasarLista('${course.id}')"
            class="w-full py-2 bg-white hover:bg-indigo-600 hover:text-white border border-slate-200 hover:border-indigo-600 text-indigo-700 font-bold text-xs rounded-xl flex items-center justify-center gap-2 shadow-2xs transition-all"
          >
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Pasar Lista</span>
          </button>
          
          <a 
            href="reporte-mensual.html" 
            onclick="setActiveCourseId('${course.id}')"
            title="Ver Sábana Mensual"
            class="p-2 bg-white hover:bg-emerald-50 text-emerald-700 border border-slate-200 rounded-xl transition-all shrink-0"
          >
            <i class="fa-solid fa-file-excel"></i>
          </a>
        </div>
      </div>
    `;
  }).join('');
}

function seleccionarMateriaYPasarLista(courseId) {
  setActiveCourseId(courseId);
  window.location.href = 'asistencia.html';
}

function openAddCourseModal() {
  editingCourseId = null;
  populateTeacherSelect();
  document.getElementById('modal-course-title').innerText = 'Nueva Materia / Comisión';
  document.getElementById('modal-course-name').value = '';
  document.getElementById('modal-course-year').value = '1er Año';
  document.getElementById('modal-course-horario').value = '';
  document.getElementById('course-modal').classList.remove('hidden');
}

function openEditCourseModal(courseId) {
  const course = getCourseById(courseId);
  if (!course) return;

  editingCourseId = courseId;
  populateTeacherSelect();
  document.getElementById('modal-course-title').innerText = 'Editar Materia / Comisión';
  document.getElementById('modal-course-name').value = course.name;
  document.getElementById('modal-course-year').value = course.year;
  document.getElementById('modal-course-teacher').value = course.teacherId;
  document.getElementById('modal-course-horario').value = course.horario || '';
  document.getElementById('course-modal').classList.remove('hidden');
}

function closeCourseModal() {
  document.getElementById('course-modal').classList.add('hidden');
  editingCourseId = null;
}

function handleSaveCourseSubmit(event) {
  event.preventDefault();
  const name = document.getElementById('modal-course-name').value.trim();
  const year = document.getElementById('modal-course-year').value;
  const teacherId = document.getElementById('modal-course-teacher').value;
  const horario = document.getElementById('modal-course-horario').value.trim();

  if (!name) {
    alert('El nombre de la materia es obligatorio.');
    return;
  }

  if (editingCourseId) {
    editCourse(editingCourseId, name, year, teacherId, horario);
    showToast(`Materia ${name} actualizada.`);
  } else {
    addCourse(name, year, teacherId, horario);
    showToast(`Materia ${name} creada exitosamente.`);
  }

  closeCourseModal();
  renderCourses();
}

function handleDeleteCourse(courseId) {
  const course = getCourseById(courseId);
  if (!course) return;

  if (confirm(`¿Confirma eliminar la materia "${course.name}"? Los alumnos quedarán sin asignar.`)) {
    deleteCourse(courseId);
    showToast(`Materia eliminada.`);
    renderCourses();
  }
}
