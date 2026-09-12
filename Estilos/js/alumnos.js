/**
 * Controlador de Nómina y Matriculación de Alumnos
 */

let editingStudentId = null;

document.addEventListener('DOMContentLoaded', () => {
  requireAuth(['docente', 'administrativo']);
  renderNavbar('alumnos');
  populateCourseSelectors();
  renderStudentsList();
});

function populateCourseSelectors() {
  const courses = getCourses();
  const filterSelect = document.getElementById('filter-course-select');
  const modalSelect = document.getElementById('modal-student-course');

  const activeCourseId = getActiveCourseId();

  if (filterSelect) {
    filterSelect.innerHTML = `
      <option value="ALL">Todas las comisiones</option>
      ${courses.map(c => `
        <option value="${c.id}" ${c.id === activeCourseId ? 'selected' : ''}>
          ${c.name} (${c.year})
        </option>
      `).join('')}
    `;
  }

  if (modalSelect) {
    modalSelect.innerHTML = courses.map(c => `
      <option value="${c.id}" ${c.id === activeCourseId ? 'selected' : ''}>
        ${c.name} (${c.year})
      </option>
    `).join('');
  }
}

function renderStudentsList() {
  const tbody = document.getElementById('students-table-body');
  if (!tbody) return;

  const searchInput = document.getElementById('search-student');
  const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
  
  const filterSelect = document.getElementById('filter-course-select');
  const selectedCourseId = filterSelect ? filterSelect.value : 'ALL';

  let students = getStudents();

  if (selectedCourseId !== 'ALL') {
    students = students.filter(s => s.courseId === selectedCourseId);
  }

  if (searchTerm) {
    students = students.filter(s => 
      s.name.toLowerCase().includes(searchTerm) || 
      s.dni.toLowerCase().includes(searchTerm) ||
      (s.email && s.email.toLowerCase().includes(searchTerm))
    );
  }

  const countBadge = document.getElementById('total-students-count');
  if (countBadge) {
    countBadge.innerText = `${students.length} alumnos`;
  }

  if (students.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="py-8 text-center text-slate-400 text-xs">
          No se encontraron alumnos con los criterios seleccionados.
        </td>
      </tr>
    `;
    return;
  }

  const courses = getCourses();

  tbody.innerHTML = students.map((student, index) => {
    const course = courses.find(c => c.id === student.courseId);
    const courseName = course ? `${course.name} (${course.year})` : 'Sin comisión';
    const isActivo = student.status === 'activo';

    const initials = student.name
      .split(',')
      .map(n => n.trim()[0])
      .join('')
      .toUpperCase();

    return `
      <tr class="hover:bg-slate-50/70 transition-colors ${!isActivo ? 'opacity-60 bg-slate-50/40' : ''}">
        <td class="py-3 px-4 text-center font-bold text-slate-400">${index + 1}</td>
        
        <td class="py-3 px-4">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full ${isActivo ? 'bg-indigo-100 text-indigo-700' : 'bg-slate-200 text-slate-500'} font-bold text-xs flex items-center justify-center shrink-0 border border-slate-200">
              ${initials || 'AL'}
            </div>
            <div>
              <h4 class="font-bold text-slate-900">${student.name}</h4>
              <p class="text-[11px] text-slate-400">${student.email || 'Sin correo'}</p>
            </div>
          </div>
        </td>

        <td class="py-3 px-4 font-mono font-semibold text-slate-700">${student.dni}</td>

        <td class="py-3 px-4">
          <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md text-[11px] font-semibold">
            ${courseName}
          </span>
        </td>

        <td class="py-3 px-4 text-center">
          <button 
            type="button" 
            onclick="toggleStatus('${student.id}')"
            class="px-2.5 py-1 rounded-full text-[10px] font-bold border cursor-pointer ${
              isActivo 
                ? 'bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100' 
                : 'bg-rose-50 text-rose-700 border-rose-200 hover:bg-rose-100'
            }"
          >
            <i class="fa-solid ${isActivo ? 'fa-circle-check' : 'fa-circle-xmark'} mr-1"></i>
            ${isActivo ? 'Activo' : 'Baja'}
          </button>
        </td>

        <td class="py-3 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditStudentModal('${student.id}')" title="Editar alumno" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteStudent('${student.id}')" title="Eliminar alumno" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    `;
  }).join('');
}

function openAddStudentModal() {
  editingStudentId = null;
  document.getElementById('modal-student-title').innerText = 'Matricular Nuevo Alumno';
  document.getElementById('modal-student-name').value = '';
  document.getElementById('modal-student-dni').value = '';
  document.getElementById('modal-student-email').value = '';
  document.getElementById('student-modal').classList.remove('hidden');
}

function openEditStudentModal(studentId) {
  const student = getStudents().find(s => s.id === studentId);
  if (!student) return;

  editingStudentId = studentId;
  document.getElementById('modal-student-title').innerText = 'Editar Datos de Alumno';
  document.getElementById('modal-student-name').value = student.name;
  document.getElementById('modal-student-dni').value = student.dni;
  document.getElementById('modal-student-email').value = student.email || '';
  document.getElementById('modal-student-course').value = student.courseId;
  document.getElementById('student-modal').classList.remove('hidden');
}

function closeStudentModal() {
  document.getElementById('student-modal').classList.add('hidden');
  editingStudentId = null;
}

function handleSaveStudentSubmit(event) {
  event.preventDefault();
  const name = document.getElementById('modal-student-name').value.trim();
  const dni = document.getElementById('modal-student-dni').value.trim();
  const email = document.getElementById('modal-student-email').value.trim();
  const courseId = document.getElementById('modal-student-course').value;

  if (!name || !dni) {
    alert('Nombre y DNI son obligatorios.');
    return;
  }

  if (editingStudentId) {
    editStudent(editingStudentId, name, dni, email, courseId);
    showToast(`Alumno ${name} actualizado correctamente.`);
  } else {
    addStudent(courseId, name, dni, email);
    showToast(`Alumno ${name} matriculado con éxito.`);
  }

  closeStudentModal();
  renderStudentsList();
}

function toggleStatus(studentId) {
  const student = getStudents().find(s => s.id === studentId);
  if (!student) return;

  const nextStatus = student.status === 'activo' ? 'baja' : 'activo';
  updateStudentStatus(studentId, nextStatus);
  showToast(`Estado de ${student.name} cambiado a: ${nextStatus.toUpperCase()}`);
  renderStudentsList();
}

function handleDeleteStudent(studentId) {
  const student = getStudents().find(s => s.id === studentId);
  if (!student) return;

  if (confirm(`¿Está seguro de eliminar a ${student.name} de la nómina?`)) {
    deleteStudent(studentId);
    showToast(`Alumno eliminado de la nómina.`);
    renderStudentsList();
  }
}
