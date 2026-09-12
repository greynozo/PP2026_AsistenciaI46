/**
 * Sistema de Presentismo - Capa de Persistencia Local (LocalStorage)
 * Maneja datos de Profesores, Cursos/Materias, Alumnos, Asistencias y Sesiones.
 */

const STORAGE_KEYS = {
  TEACHERS: 'presentismo_teachers',
  COURSES: 'presentismo_courses',
  STUDENTS: 'presentismo_students',
  ATTENDANCE: 'presentismo_attendance',
  SESSION: 'presentismo_session'
};

// Datos Semilla Iniciales
const SEED_TEACHERS = [
  { id: 't1', name: 'Prof. Carlos Rodríguez', email: 'carlos.rodriguez@instituto.edu.ar' },
  { id: 't2', name: 'Lic. Laura González', email: 'laura.gonzalez@instituto.edu.ar' },
  { id: 't3', name: 'Ing. Marcos Martínez', email: 'marcos.martinez@instituto.edu.ar' }
];

const SEED_COURSES = [
  { id: 'c1', name: 'Desarrollo de Software I', year: '1er Año', teacherId: 't1', createdAt: '2026-03-10T14:00:00Z', horario: 'Lun y Mié 18:30 a 21:00 hs' },
  { id: 'c2', name: 'Base de Datos II', year: '2do Año', teacherId: 't2', createdAt: '2026-03-11T16:30:00Z', horario: 'Mar y Jue 19:00 a 22:00 hs' },
  { id: 'c3', name: 'Práctica Profesionalizante', year: '3er Año', teacherId: 't3', createdAt: '2026-03-12T19:00:00Z', horario: 'Viernes 18:00 a 22:30 hs' }
];

const SEED_STUDENTS = [
  // Comisión 1
  { id: 's101', courseId: 'c1', name: 'Alvarez, Agustín', dni: '42.119.882', email: 'agustin.alvarez@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's102', courseId: 'c1', name: 'Benítez, Micaela', dni: '43.550.114', email: 'mika.benitez@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's103', courseId: 'c1', name: 'Castro, Facundo', dni: '41.884.209', email: 'facu.castro@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's104', courseId: 'c1', name: 'Duarte, Sofía', dni: '44.019.330', email: 'sofia.duarte@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's105', courseId: 'c1', name: 'Gómez, Federico', dni: '42.981.402', email: 'fede.gomez@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-13' },
  { id: 's106', courseId: 'c1', name: 'López, Valentina', dni: '43.112.980', email: 'valen.lopez@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-13' },

  // Comisión 2
  { id: 's201', courseId: 'c2', name: 'Morales, Nicolás', dni: '40.876.543', email: 'nico.morales@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's202', courseId: 'c2', name: 'Navarro, Camila', dni: '41.456.789', email: 'cami.navarro@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's203', courseId: 'c2', name: 'Peralta, Ignacio', dni: '39.123.444', email: 'nacho.peralta@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-13' },

  // Comisión 3
  { id: 's301', courseId: 'c3', name: 'Rossi, Matías', dni: '38.987.654', email: 'matias.rossi@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' },
  { id: 's302', courseId: 'c3', name: 'Sosa, Julieta', dni: '40.231.112', email: 'julieta.sosa@alumnos.edu.ar', status: 'activo', createdAt: '2026-03-12' }
];

const SEED_ATTENDANCE = [
  {
    id: 'c1_2026-06-01',
    courseId: 'c1',
    date: '2026-06-01',
    records: { s101: 'P', s102: 'P', s103: 'P', s104: 'P', s105: 'P', s106: 'P' },
    updatedAt: '2026-06-01T21:00:00Z',
    updatedBy: 'Prof. Carlos Rodríguez'
  },
  {
    id: 'c1_2026-06-03',
    courseId: 'c1',
    date: '2026-06-03',
    records: { s101: 'P', s102: 'A', s103: 'P', s104: 'T', s105: 'P', s106: 'P' },
    updatedAt: '2026-06-03T21:05:00Z',
    updatedBy: 'Prof. Carlos Rodríguez'
  },
  {
    id: 'c1_2026-06-08',
    courseId: 'c1',
    date: '2026-06-08',
    records: { s101: 'P', s102: 'P', s103: 'P', s104: 'P', s105: 'A', s106: 'T' },
    updatedAt: '2026-06-08T21:10:00Z',
    updatedBy: 'Prof. Carlos Rodríguez'
  }
];

// Inicialización de LocalStorage
function initStorage() {
  if (!localStorage.getItem(STORAGE_KEYS.TEACHERS)) {
    localStorage.setItem(STORAGE_KEYS.TEACHERS, JSON.stringify(SEED_TEACHERS));
  }
  if (!localStorage.getItem(STORAGE_KEYS.COURSES)) {
    localStorage.setItem(STORAGE_KEYS.COURSES, JSON.stringify(SEED_COURSES));
  }
  if (!localStorage.getItem(STORAGE_KEYS.STUDENTS)) {
    localStorage.setItem(STORAGE_KEYS.STUDENTS, JSON.stringify(SEED_STUDENTS));
  }
  if (!localStorage.getItem(STORAGE_KEYS.ATTENDANCE)) {
    localStorage.setItem(STORAGE_KEYS.ATTENDANCE, JSON.stringify(SEED_ATTENDANCE));
  }
}

// ----------------- DOCENTES -----------------
function getTeachers() {
  initStorage();
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.TEACHERS) || '[]');
  } catch (e) {
    return SEED_TEACHERS;
  }
}

function getTeacherById(id) {
  return getTeachers().find(t => t.id === id) || null;
}

function addTeacher(name, email) {
  const teachers = getTeachers();
  const newTeacher = {
    id: 't_' + Date.now(),
    name: name.trim(),
    email: email.trim()
  };
  teachers.push(newTeacher);
  localStorage.setItem(STORAGE_KEYS.TEACHERS, JSON.stringify(teachers));
  return newTeacher;
}

function editTeacher(id, name, email) {
  const teachers = getTeachers().map(t => {
    if (t.id === id) {
      return { ...t, name: name.trim(), email: email.trim() };
    }
    return t;
  });
  localStorage.setItem(STORAGE_KEYS.TEACHERS, JSON.stringify(teachers));
}

function deleteTeacher(id) {
  const teachers = getTeachers().filter(t => t.id !== id);
  localStorage.setItem(STORAGE_KEYS.TEACHERS, JSON.stringify(teachers));
}

// ----------------- MATERIAS / CURSOS -----------------
function getCourses() {
  initStorage();
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.COURSES) || '[]');
  } catch (e) {
    return SEED_COURSES;
  }
}

function getCourseById(id) {
  return getCourses().find(c => c.id === id) || null;
}

function getCoursesByTeacher(teacherId) {
  return getCourses().filter(c => c.teacherId === teacherId);
}

function addCourse(name, year, teacherId, horario = '') {
  const courses = getCourses();
  const newCourse = {
    id: 'c_' + Date.now(),
    name: name.trim(),
    year: year.trim(),
    teacherId,
    horario: horario.trim(),
    createdAt: new Date().toISOString()
  };
  courses.push(newCourse);
  localStorage.setItem(STORAGE_KEYS.COURSES, JSON.stringify(courses));
  return newCourse;
}

function editCourse(id, name, year, teacherId, horario = '') {
  const courses = getCourses().map(c => {
    if (c.id === id) {
      return { ...c, name: name.trim(), year: year.trim(), teacherId, horario: horario.trim() };
    }
    return c;
  });
  localStorage.setItem(STORAGE_KEYS.COURSES, JSON.stringify(courses));
}

function deleteCourse(id) {
  const courses = getCourses().filter(c => c.id !== id);
  localStorage.setItem(STORAGE_KEYS.COURSES, JSON.stringify(courses));
}

// ----------------- ALUMNOS -----------------
function getStudents() {
  initStorage();
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.STUDENTS) || '[]');
  } catch (e) {
    return SEED_STUDENTS;
  }
}

function getStudentsByCourse(courseId) {
  return getStudents().filter(s => s.courseId === courseId);
}

function addStudent(courseId, name, dni, email = '') {
  const students = getStudents();
  const newStudent = {
    id: 's_' + Date.now(),
    courseId,
    name: name.trim(),
    dni: dni.trim(),
    email: email.trim(),
    status: 'activo',
    createdAt: new Date().toISOString().split('T')[0]
  };
  students.push(newStudent);
  localStorage.setItem(STORAGE_KEYS.STUDENTS, JSON.stringify(students));
  return newStudent;
}

function editStudent(id, name, dni, email = '', courseId = null) {
  const students = getStudents().map(s => {
    if (s.id === id) {
      return {
        ...s,
        name: name.trim(),
        dni: dni.trim(),
        email: email.trim(),
        ...(courseId ? { courseId } : {})
      };
    }
    return s;
  });
  localStorage.setItem(STORAGE_KEYS.STUDENTS, JSON.stringify(students));
}

function updateStudentStatus(id, status) {
  const students = getStudents().map(s => {
    if (s.id === id) {
      return { ...s, status };
    }
    return s;
  });
  localStorage.setItem(STORAGE_KEYS.STUDENTS, JSON.stringify(students));
}

function deleteStudent(id) {
  const students = getStudents().filter(s => s.id !== id);
  localStorage.setItem(STORAGE_KEYS.STUDENTS, JSON.stringify(students));
}

// ----------------- ASISTENCIA -----------------
function getAttendanceRecords() {
  initStorage();
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.ATTENDANCE) || '[]');
  } catch (e) {
    return SEED_ATTENDANCE;
  }
}

function getAttendanceRecord(courseId, date) {
  const records = getAttendanceRecords();
  return records.find(r => r.courseId === courseId && r.date === date) || null;
}

function saveAttendance(courseId, date, recordsMap, updatedBy = 'Docente') {
  const allRecords = getAttendanceRecords();
  const existingIndex = allRecords.findIndex(r => r.courseId === courseId && r.date === date);

  const recordObject = {
    id: `${courseId}_${date}`,
    courseId,
    date,
    records: recordsMap,
    updatedAt: new Date().toISOString(),
    updatedBy
  };

  if (existingIndex >= 0) {
    allRecords[existingIndex] = recordObject;
  } else {
    allRecords.push(recordObject);
  }

  localStorage.setItem(STORAGE_KEYS.ATTENDANCE, JSON.stringify(allRecords));
  return recordObject;
}

// ----------------- SESIÓN Y AUTENTICACIÓN -----------------
function getUserSession() {
  try {
    const raw = localStorage.getItem(STORAGE_KEYS.SESSION);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
}

function setUserSession(session) {
  localStorage.setItem(STORAGE_KEYS.SESSION, JSON.stringify(session));
}

function clearUserSession() {
  localStorage.removeItem(STORAGE_KEYS.SESSION);
}

// Inicializar automáticamente al cargar el script
initStorage();
