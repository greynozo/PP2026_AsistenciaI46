/**
 * Sistema de Presentismo - Componentes de Interfaz Compartidos
 */

function renderNavbar(activePage = '') {
  const container = document.getElementById('navbar-container');
  if (!container) return;

  const session = getUserSession();
  const activeCourseId = getActiveCourseId();
  const allCourses = getCourses();
  const currentCourse = allCourses.find(c => c.id === activeCourseId) || allCourses[0];

  const isDocente = session && session.role === 'docente';
  const isAdmin = session && session.role === 'administrativo';

  let navLinksHtml = '';

  if (isDocente) {
    navLinksHtml = `
      <a href="asistencia.html" class="nav-link ${activePage === 'asistencia' ? 'active' : ''}">
        <i class="fa-solid fa-clipboard-check"></i>
        <span>Planilla Diaria</span>
      </a>
      <a href="reporte-mensual.html" class="nav-link ${activePage === 'reporte' ? 'active' : ''}">
        <i class="fa-solid fa-file-excel text-emerald-600"></i>
        <span>Sábana Mensual</span>
      </a>
      <a href="alumnos.html" class="nav-link ${activePage === 'alumnos' ? 'active' : ''}">
        <i class="fa-solid fa-users"></i>
        <span>Alumnos</span>
      </a>
    `;
  } else if (isAdmin) {
    navLinksHtml = `
      <a href="materias.html" class="nav-link ${activePage === 'materias' ? 'active' : ''}">
        <i class="fa-solid fa-book-bookmark"></i>
        <span>Materias</span>
      </a>
      <a href="alumnos.html" class="nav-link ${activePage === 'alumnos' ? 'active' : ''}">
        <i class="fa-solid fa-users"></i>
        <span>Alumnos</span>
      </a>
      <a href="docentes.html" class="nav-link ${activePage === 'docentes' ? 'active' : ''}">
        <i class="fa-solid fa-chalkboard-user"></i>
        <span>Docentes</span>
      </a>
      <a href="asistencia.html" class="nav-link ${activePage === 'asistencia' ? 'active' : ''}">
        <i class="fa-solid fa-clipboard-check"></i>
        <span>Pasar Lista</span>
      </a>
      <a href="reporte-mensual.html" class="nav-link ${activePage === 'reporte' ? 'active' : ''}">
        <i class="fa-solid fa-file-excel text-emerald-600"></i>
        <span>Sábana Mensual</span>
      </a>
    `;
  } else {
    navLinksHtml = `
      <a href="index.html" class="nav-link active">
        <i class="fa-solid fa-arrow-right-to-bracket"></i>
        <span>Ingresar</span>
      </a>
    `;
  }

  // Course selector for navbar
  let courseSelectHtml = '';
  if (session && allCourses.length > 0) {
    const userCourses = isDocente 
      ? allCourses.filter(c => c.teacherId === session.teacherId)
      : allCourses;

    const availableCourses = userCourses.length > 0 ? userCourses : allCourses;

    courseSelectHtml = `
      <div class="flex items-center gap-1.5 bg-slate-100 px-3 py-1.5 rounded-xl border border-slate-200 text-xs">
        <i class="fa-solid fa-graduation-cap text-indigo-600"></i>
        <select id="global-course-select" onchange="handleNavbarCourseChange(this.value)" class="bg-transparent font-bold text-slate-800 focus:outline-none cursor-pointer">
          ${availableCourses.map(c => `
            <option value="${c.id}" ${c.id === (currentCourse ? currentCourse.id : '') ? 'selected' : ''}>
              ${c.name} (${c.year})
            </option>
          `).join('')}
        </select>
      </div>
    `;
  }

  container.innerHTML = `
    <nav class="bg-white border-b border-slate-200 sticky top-0 z-50 shadow-2xs">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          
          <!-- Logo y Marca -->
          <div class="flex items-center gap-4">
            <a href="${session ? (isDocente ? 'asistencia.html' : 'materias.html') : 'index.html'}" class="flex items-center gap-2.5 text-slate-900 no-underline">
              <div class="w-9 h-9 rounded-xl bg-indigo-600 text-white flex items-center justify-center font-bold text-base shadow-sm">
                <i class="fa-solid fa-graduation-cap"></i>
              </div>
              <div class="hidden sm:block">
                <span class="block text-xs font-black tracking-wider text-slate-800 uppercase leading-none">INSTITUTO TERCIARIO</span>
                <span class="block text-[10px] text-slate-500 font-semibold tracking-tight mt-0.5">Control de Presentismo</span>
              </div>
            </a>

            <!-- Selector de Materia Activa -->
            ${courseSelectHtml}
          </div>

          <!-- Enlaces de Navegación -->
          <div class="hidden md:flex items-center gap-1.5">
            ${navLinksHtml}
          </div>

          <!-- Perfil de Usuario y Logout -->
          <div class="flex items-center gap-3">
            ${session ? `
              <div class="flex items-center gap-2.5 pl-3 border-l border-slate-200">
                <div class="text-right hidden sm:block">
                  <span class="block text-xs font-bold text-slate-800 leading-tight">${session.name}</span>
                  <span class="block text-[10px] font-semibold ${isDocente ? 'text-indigo-600' : 'text-amber-600'} uppercase">
                    ${isDocente ? 'Docente' : 'Administrativo'}
                  </span>
                </div>
                <button type="button" onclick="logout()" title="Cerrar sesión" class="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50 transition-colors cursor-pointer">
                  <i class="fa-solid fa-arrow-right-from-bracket text-sm"></i>
                </button>
              </div>
            ` : `
              <a href="index.html" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold rounded-xl shadow-xs">
                Ingresar
              </a>
            `}
          </div>

        </div>
      </div>
    </nav>
  `;
}

function handleNavbarCourseChange(courseId) {
  setActiveCourseId(courseId);
  window.location.reload();
}

function showToast(message, type = 'success') {
  let toast = document.getElementById('toast-notification');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast-notification';
    document.body.appendChild(toast);
  }

  const bgColors = {
    success: 'bg-emerald-600 text-white',
    error: 'bg-rose-600 text-white',
    info: 'bg-indigo-600 text-white'
  };

  const icons = {
    success: 'fa-circle-check',
    error: 'fa-circle-exclamation',
    info: 'fa-circle-info'
  };

  toast.className = `px-4 py-3 rounded-xl shadow-lg font-bold text-xs flex items-center gap-2 ${bgColors[type] || bgColors.success} show`;
  toast.innerHTML = `
    <i class="fa-solid ${icons[type] || icons.success} text-sm"></i>
    <span>${message}</span>
  `;

  setTimeout(() => {
    toast.classList.remove('show');
  }, 3200);
}
