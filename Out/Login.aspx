<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Portal de Acceso - Control de Asistencia y Presentismo</title>
  
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- FontAwesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <!-- Estilos Propios -->
  <link rel="stylesheet" href="Estilos/css/styles.css" />
</head>
<body class="min-h-screen bg-slate-100 flex flex-col justify-center items-center p-4 antialiased">

  <div class="w-full max-w-md bg-white rounded-3xl shadow-xl border border-slate-200/90 overflow-hidden my-8">

    <!-- Encabezado Institucional -->
    <div class="bg-gradient-to-br from-indigo-900 via-indigo-800 to-indigo-950 p-7 text-white text-center relative">
      <div class="w-14 h-14 bg-white/10 backdrop-blur-md rounded-2xl flex items-center justify-center text-2xl mx-auto mb-3 shadow-inner border border-white/20">
        <i class="fa-solid fa-graduation-cap text-indigo-200"></i>
      </div>
      <h1 class="text-xl font-black tracking-wide uppercase">
        Instituto Terciario
      </h1>
      <p class="text-xs text-indigo-200 font-medium tracking-tight mt-1">
        Sistema Autónomo de Asistencia y Bedelía
      </p>
    </div>

    <!-- Pestañas de Perfiles de Acceso -->
    <div class="p-6">
      <div class="flex p-1 bg-slate-100 rounded-2xl mb-6">
        <button 
          id="tab-docentes"
          type="button" 
          onclick="switchTab('docentes')"
          class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 bg-white text-indigo-700 shadow-sm border border-slate-200/80 cursor-pointer"
        >
          <i class="fa-solid fa-chalkboard-user"></i>
          <span>Docentes</span>
        </button>
        <button 
          id="tab-admin"
          type="button" 
          onclick="switchTab('admin')"
          class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 text-slate-500 hover:text-slate-800 cursor-pointer"
        >
          <i class="fa-solid fa-user-shield"></i>
          <span>Administrativo</span>
        </button>
      </div>

      <!-- VISTA 1: Perfil Docente -->
      <div id="view-docentes" class="space-y-4">
        <div class="flex items-center justify-between">
          <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">
            Seleccionar Profesor Titular
          </span>
          <button 
            type="button" 
            onclick="toggleRegisterForm()" 
            class="text-xs font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1 cursor-pointer"
          >
            <i class="fa-solid fa-user-plus text-[11px]"></i>
            <span>Nuevo Docente</span>
          </button>
        </div>

        <!-- Formulario Desplegable para Alta Rápida de Docente -->
        <form id="register-form" onsubmit="handleQuickTeacherSubmit(event)" class="hidden bg-indigo-50/50 p-4 rounded-2xl border border-indigo-100 space-y-3">
          <h3 class="text-xs font-bold text-indigo-900 uppercase">Alta Rápida de Docente</h3>
          <div>
            <label class="block text-[10px] font-bold text-slate-600 uppercase mb-1">Nombre Completo y Título</label>
            <input 
              id="new-teacher-name" 
              type="text" 
              required 
              placeholder="Ej: Lic. Hernán Cortés" 
              class="w-full px-3 py-2 text-xs bg-white border border-slate-200 rounded-xl focus:outline-none focus:border-indigo-600" 
            />
          </div>
          <div>
            <label class="block text-[10px] font-bold text-slate-600 uppercase mb-1">Correo Electrónico</label>
            <input 
              id="new-teacher-email" 
              type="email" 
              required 
              placeholder="docente@instituto.edu.ar" 
              class="w-full px-3 py-2 text-xs bg-white border border-slate-200 rounded-xl focus:outline-none focus:border-indigo-600" 
            />
          </div>
          <div class="flex gap-2 pt-1">
            <button type="submit" class="flex-1 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs cursor-pointer">
              Registrar
            </button>
            <button type="button" onclick="toggleRegisterForm()" class="px-3 py-2 bg-slate-200 hover:bg-slate-300 text-slate-700 font-bold text-xs rounded-xl cursor-pointer">
              Cancelar
            </button>
          </div>
        </form>

        <!-- Listado Interactivo de Docentes -->
        <div id="teachers-list-container" class="space-y-2 max-h-64 overflow-y-auto pr-1">
          <!-- Renderizado dinámicamente por js/login.js -->
        </div>

        <p class="text-center text-[11px] text-slate-400 pt-2">
          Haga clic en un docente para acceder directamente a sus comisiones y planilla.
        </p>
      </div>

      <!-- VISTA 2: Perfil Administrativo (Bedelía) -->
      <div id="view-admin" class="hidden space-y-4">
        <div class="p-4 bg-amber-50/70 border border-amber-200 rounded-2xl">
          <div class="flex items-start gap-2.5">
            <i class="fa-solid fa-shield-halved text-amber-600 text-base mt-0.5"></i>
            <div>
              <h4 class="text-xs font-bold text-amber-900">Consola de Bedelía & Secretaría</h4>
              <p class="text-[11px] text-amber-700 mt-0.5 leading-relaxed">
                Gestión integral de materias, comisiones, matrícula de estudiantes y nómina docente.
              </p>
            </div>
          </div>
        </div>

        <form onsubmit="handleAdminLoginSubmit(event)" class="space-y-3">
          <div>
            <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">
              Usuario / Correo Administrativo
            </label>
            <input 
              id="admin-email"
              type="email" 
              value="bedelia@instituto.edu.ar" 
              required
              class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white"
            />
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">
              Clave de Acceso
            </label>
            <input 
              type="password" 
              value="secretaria2026" 
              class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white"
            />
          </div>

          <button 
            type="submit" 
            class="w-full py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center justify-center gap-2 cursor-pointer mt-2"
          >
            <i class="fa-solid fa-lock-open text-xs"></i>
            <span>Ingresar al Panel de Gestión</span>
          </button>
        </form>
      </div>

    </div>

    <!-- Pie de Seguridad -->
    <div class="px-6 py-4 bg-slate-50 border-t border-slate-100 text-center">
      <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider flex items-center justify-center gap-1.5">
        <i class="fa-solid fa-lock text-slate-400"></i>
        <span>Frontend Autónomo • HTML5 + CSS + JS Vanilla</span>
      </span>
    </div>

  </div>

  <!-- Scripts Modulares del Frontend Completo -->
  <script src="Estilos/js/storage.js"></script>
  <script src="Estilos/js/auth.js"></script>
  <script src="Estilos/js/ui.js"></script>
  <script src="Estilos/js/login.js"></script>
</body>
</html>
