/**
 * Sistema de Presentismo - Control de Sesión y Autenticación
 */

function requireAuth(allowedRoles = ['docente', 'administrativo']) {
  const session = getUserSession();
  const currentPage = window.location.pathname.split('/').pop();

  if (!session) {
    if (currentPage !== 'index.html' && currentPage !== '01-login-portal-acceso.html') {
      window.location.href = 'index.html';
    }
    return null;
  }

  if (allowedRoles.length > 0 && !allowedRoles.includes(session.role)) {
    alert('Acceso restringido para su perfil actual.');
    window.location.href = session.role === 'docente' ? 'asistencia.html' : 'materias.html';
    return null;
  }

  return session;
}

function loginDocente(teacherId) {
  const teacher = getTeacherById(teacherId);
  if (!teacher) {
    alert('Docente no encontrado.');
    return;
  }

  setUserSession({
    role: 'docente',
    teacherId: teacher.id,
    name: teacher.name,
    email: teacher.email
  });

  // Guardar curso activo predeterminado
  const courses = getCoursesByTeacher(teacher.id);
  if (courses.length > 0) {
    localStorage.setItem('presentismo_active_course', courses[0].id);
  }

  window.location.href = 'asistencia.html';
}

function loginAdmin(email = 'bedelia@instituto.edu.ar') {
  setUserSession({
    role: 'administrativo',
    name: 'Bedelía Central',
    email: email
  });

  const courses = getCourses();
  if (courses.length > 0) {
    localStorage.setItem('presentismo_active_course', courses[0].id);
  }

  window.location.href = 'materias.html';
}

function logout() {
  clearUserSession();
  window.location.href = 'index.html';
}

function getActiveCourseId() {
  const stored = localStorage.getItem('presentismo_active_course');
  const courses = getCourses();
  if (stored && courses.some(c => c.id === stored)) {
    return stored;
  }
  return courses.length > 0 ? courses[0].id : null;
}

function setActiveCourseId(courseId) {
  localStorage.setItem('presentismo_active_course', courseId);
}
