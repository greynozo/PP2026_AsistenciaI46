/**
 * Controlador de Gestión del Plantel Docente
 */

let editingTeacherId = null;

document.addEventListener('DOMContentLoaded', () => {
  requireAuth(['administrativo']);
  renderNavbar('docentes');
  renderDocentesTable();
});

function renderDocentesTable() {
  const tbody = document.getElementById('docentes-tbody');
  if (!tbody) return;

  const teachers = getTeachers();
  const courses = getCourses();

  if (teachers.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="py-8 text-center text-slate-400 text-xs">
          No hay docentes registrados.
        </td>
      </tr>
    `;
    return;
  }

  tbody.innerHTML = teachers.map((teacher, index) => {
    const initials = teacher.name
      .replace(/^(Prof\.|Lic\.|Ing\.)\s*/i, '')
      .split(' ')
      .map(n => n[0])
      .slice(0, 2)
      .join('')
      .toUpperCase();

    const assignedCourses = courses.filter(c => c.teacherId === teacher.id);

    return `
      <tr class="hover:bg-slate-50/70 transition-colors">
        <td class="py-3.5 px-4 text-center font-bold text-slate-400">${index + 1}</td>
        
        <td class="py-3.5 px-4">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center border border-indigo-200 shrink-0">
              ${initials || 'DC'}
            </div>
            <div>
              <h4 class="font-bold text-slate-900">${teacher.name}</h4>
              <p class="text-[11px] text-slate-400 font-mono">${teacher.email}</p>
            </div>
          </div>
        </td>

        <td class="py-3.5 px-4">
          <div class="flex flex-wrap gap-1">
            ${assignedCourses.length > 0 
              ? assignedCourses.map(c => `
                  <span class="px-2 py-0.5 bg-slate-100 text-slate-700 text-[10px] font-semibold rounded-md">
                    ${c.name} (${c.year})
                  </span>
                `).join('')
              : '<span class="text-slate-400 italic text-[11px]">Sin materias asignadas</span>'
            }
          </div>
        </td>

        <td class="py-3.5 px-4 text-center">
          <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 text-[10px] font-bold rounded-full inline-flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Habilitado
          </span>
        </td>

        <td class="py-3.5 px-4 text-center">
          <button 
            type="button" 
            onclick="loginDocente('${teacher.id}')"
            class="px-2.5 py-1 bg-indigo-50 hover:bg-indigo-600 hover:text-white text-indigo-700 text-[11px] font-bold rounded-lg transition-colors cursor-pointer border border-indigo-100"
          >
            <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>
            Ingresar
          </button>
        </td>

        <td class="py-3.5 px-4 text-right">
          <div class="flex items-center justify-end gap-1.5">
            <button type="button" onclick="openEditTeacherModal('${teacher.id}')" title="Editar Docente" class="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button type="button" onclick="handleDeleteTeacher('${teacher.id}')" title="Eliminar Docente" class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100 cursor-pointer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    `;
  }).join('');
}

function openAddTeacherModal() {
  editingTeacherId = null;
  document.getElementById('modal-teacher-title').innerText = 'Nuevo Docente';
  document.getElementById('modal-teacher-name').value = '';
  document.getElementById('modal-teacher-email').value = '';
  document.getElementById('teacher-modal').classList.remove('hidden');
}

function openEditTeacherModal(teacherId) {
  const teacher = getTeacherById(teacherId);
  if (!teacher) return;

  editingTeacherId = teacherId;
  document.getElementById('modal-teacher-title').innerText = 'Editar Docente';
  document.getElementById('modal-teacher-name').value = teacher.name;
  document.getElementById('modal-teacher-email').value = teacher.email;
  document.getElementById('teacher-modal').classList.remove('hidden');
}

function closeTeacherModal() {
  document.getElementById('teacher-modal').classList.add('hidden');
  editingTeacherId = null;
}

function handleSaveTeacherSubmit(event) {
  event.preventDefault();
  const name = document.getElementById('modal-teacher-name').value.trim();
  const email = document.getElementById('modal-teacher-email').value.trim();

  if (!name || !email) {
    alert('Nombre y correo son requeridos.');
    return;
  }

  if (editingTeacherId) {
    editTeacher(editingTeacherId, name, email);
    showToast(`Docente ${name} actualizado.`);
  } else {
    addTeacher(name, email);
    showToast(`Docente ${name} incorporado.`);
  }

  closeTeacherModal();
  renderDocentesTable();
}

function handleDeleteTeacher(teacherId) {
  const teacher = getTeacherById(teacherId);
  if (!teacher) return;

  if (confirm(`¿Confirma eliminar a "${teacher.name}"?`)) {
    deleteTeacher(teacherId);
    showToast(`Docente eliminado.`);
    renderDocentesTable();
  }
}
