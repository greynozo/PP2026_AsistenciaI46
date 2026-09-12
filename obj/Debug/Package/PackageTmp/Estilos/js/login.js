/**
 * Controlador de la Pantalla de Login y Acceso
 */

document.addEventListener('DOMContentLoaded', () => {
  renderTeachersList();
});

function renderTeachersList() {
  const container = document.getElementById('teachers-list-container');
  if (!container) return;

  const teachers = getTeachers();

  if (teachers.length === 0) {
    container.innerHTML = `
      <div class="text-center p-4 bg-slate-50 rounded-xl border border-slate-200 text-xs text-slate-500">
        No hay docentes registrados todavía.
      </div>
    `;
    return;
  }

  container.innerHTML = teachers.map(teacher => {
    const initials = teacher.name
      .replace(/^(Prof\.|Lic\.|Ing\.)\s*/i, '')
      .split(' ')
      .map(n => n[0])
      .slice(0, 2)
      .join('')
      .toUpperCase();

    const courses = getCoursesByTeacher(teacher.id);

    return `
      <div class="flex items-center justify-between p-3.5 bg-slate-50 hover:bg-indigo-50/50 hover:border-indigo-300 border border-slate-200 rounded-xl transition-all cursor-pointer group" onclick="loginDocente('${teacher.id}')">
        <div class="flex items-center gap-3">
          <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold flex items-center justify-center text-xs shrink-0 border border-indigo-200">
            ${initials || 'DC'}
          </div>
          <div>
            <h4 class="font-bold text-slate-800 text-xs group-hover:text-indigo-900 transition-colors">
              ${teacher.name}
            </h4>
            <p class="text-[11px] text-slate-500">
              ${teacher.email} • <span class="text-indigo-600 font-semibold">${courses.length} comisiones</span>
            </p>
          </div>
        </div>
        <button 
          type="button" 
          onclick="event.stopPropagation(); loginDocente('${teacher.id}')"
          class="py-1.5 px-3 bg-white group-hover:bg-indigo-600 group-hover:text-white text-xs text-indigo-700 font-bold border border-slate-200 group-hover:border-indigo-600 rounded-lg shrink-0 transition-colors shadow-2xs cursor-pointer"
        >
          Ingresar
        </button>
      </div>
    `;
  }).join('');
}

function handleQuickTeacherSubmit(event) {
  event.preventDefault();
  const nameInput = document.getElementById('new-teacher-name');
  const emailInput = document.getElementById('new-teacher-email');

  const name = nameInput.value.trim();
  const email = emailInput.value.trim();

  if (!name || !email) {
    alert('Por favor complete el nombre y el correo.');
    return;
  }

  addTeacher(name, email);
  showToast(`Docente ${name} registrado con éxito.`);
  nameInput.value = '';
  emailInput.value = '';
  toggleRegisterForm();
  renderTeachersList();
}

function switchTab(tab) {
  const tabDoc = document.getElementById('tab-docentes');
  const tabAdm = document.getElementById('tab-admin');
  const viewDoc = document.getElementById('view-docentes');
  const viewAdm = document.getElementById('view-admin');

  if (tab === 'docentes') {
    tabDoc.className = "w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 bg-white text-indigo-700 shadow-sm border border-slate-200/80 cursor-pointer";
    tabAdm.className = "w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 text-slate-500 hover:text-slate-800 cursor-pointer";
    viewDoc.classList.remove('hidden');
    viewAdm.classList.add('hidden');
  } else {
    tabAdm.className = "w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 bg-white text-indigo-700 shadow-sm border border-slate-200/80 cursor-pointer";
    tabDoc.className = "w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 text-slate-500 hover:text-slate-800 cursor-pointer";
    viewAdm.classList.remove('hidden');
    viewDoc.classList.add('hidden');
  }
}

function toggleRegisterForm() {
  const form = document.getElementById('register-form');
  if (form) {
    form.classList.toggle('hidden');
  }
}

function handleAdminLoginSubmit(event) {
  event.preventDefault();
  const emailInput = document.getElementById('admin-email');
  const email = emailInput ? emailInput.value.trim() : 'bedelia@instituto.edu.ar';
  loginAdmin(email);
}
