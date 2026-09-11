<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Portal Académico - Control de Presentismo</title>
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- FontAwesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="min-h-screen bg-slate-100/70 flex flex-col items-center justify-center p-4 antialiased font-sans text-slate-800">

  <!-- Contenedor Principal del Formulario de Acceso -->
  <div class="w-full max-w-md bg-white rounded-2xl shadow-xl border border-slate-200/80 overflow-hidden">
    
    <!-- Encabezado Institucional -->
    <div class="bg-gradient-to-br from-indigo-700 via-indigo-800 to-indigo-950 p-7 text-white relative">
      <div class="absolute right-6 top-6 bg-white/10 p-2.5 rounded-xl backdrop-blur-sm">
        <i class="fa-solid fa-graduation-cap text-2xl text-indigo-200"></i>
      </div>
      <p class="text-xs font-semibold tracking-wider text-indigo-200 uppercase mb-1">
        PORTAL ACADÉMICO TERCIARIO
      </p>
      <h1 class="text-2xl font-bold tracking-tight">
        Control de Presentismo
      </h1>
      <p class="text-xs text-indigo-100/80 mt-1">
        Ingreso segregado para Docentes y Personal de Cómputos/Registro.
      </p>
    </div>

    <!-- Pestañas de Selección de Perfil -->
    <div class="flex border-b border-slate-200 bg-slate-50/60 p-1.5 gap-1.5">
      <button 
        type="button" 
        id="tab-docentes" 
        onclick="switchTab('docentes')"
        class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 bg-white text-indigo-700 shadow-sm border border-slate-200/80 cursor-pointer"
      >
        <i class="fa-solid fa-chalkboard-user text-sm"></i>
        Acceso Docentes
      </button>

      <button 
        type="button" 
        id="tab-admin" 
        onclick="switchTab('admin')"
        class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 text-slate-500 hover:text-slate-800 cursor-pointer"
      >
        <i class="fa-solid fa-shield-halved text-sm"></i>
        Administrativos
      </button>
    </div>

    <!-- Panel 1: Vista Docentes -->
    <div id="view-docentes" class="p-6 space-y-4">
      
      <div class="flex items-center justify-between mb-2">
        <h2 class="text-xs font-bold text-slate-500 uppercase tracking-wider">
          SELECCIONE SU USUARIO DOCENTE
        </h2>
        <button 
          type="button" 
          onclick="toggleRegisterForm()"
          class="text-xs font-bold text-indigo-600 hover:text-indigo-800 transition-colors flex items-center gap-1.5 cursor-pointer"
        >
          <i class="fa-solid fa-user-plus text-xs"></i>
          <span>Registrar Docente</span>
        </button>
      </div>

      <!-- Formulario Desplegable de Nuevo Docente -->
      <form id="register-form" class="hidden p-4 bg-indigo-50/60 border border-indigo-200 rounded-xl space-y-3 mb-3">
        <h3 class="text-xs font-bold text-indigo-900 uppercase">Alta Rápida de Docente</h3>
        <div>
          <label class="block text-xs font-medium text-slate-600 mb-1">Nombre Completo</label>
          <input 
            type="text" 
            placeholder="Ej: Lic. Martín Sosa" 
            class="w-full px-3 py-2 bg-white border border-indigo-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
        </div>
        <div>
          <label class="block text-xs font-medium text-slate-600 mb-1">Correo Electrónico</label>
          <input 
            type="email" 
            placeholder="docente@instituto.edu.ar" 
            class="w-full px-3 py-2 bg-white border border-indigo-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
        </div>
        <div class="flex justify-end gap-2 pt-1">
          <button 
            type="button" 
            onclick="toggleRegisterForm()" 
            class="px-3 py-1.5 text-xs text-slate-600 hover:text-slate-800 font-medium"
          >
            Cancelar
          </button>
          <button 
            type="button" 
            onclick="alert('Docente registrado correctamente (demo)'); toggleRegisterForm();" 
            class="px-3 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold rounded-lg shadow-sm"
          >
            Guardar Docente
          </button>
        </div>
      </form>

      <!-- Lista de Docentes Activos -->
      <div class="space-y-2.5">
        
        <!-- Docente 1 -->
        <div class="flex items-center justify-between p-3.5 bg-slate-50 hover:bg-indigo-50/50 hover:border-indigo-300 border border-slate-200 rounded-xl transition-all cursor-pointer group">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold flex items-center justify-center text-xs shrink-0">
              CR
            </div>
            <div>
              <h4 class="font-bold text-slate-800 text-xs group-hover:text-indigo-900 transition-colors">
                Prof. Carlos Rodríguez
              </h4>
              <p class="text-[11px] text-slate-500">
                carlos.rodriguez@instituto.edu.ar
              </p>
            </div>
          </div>
          <button 
            type="button" 
            onclick="alert('Ingresando como Prof. Carlos Rodríguez')"
            class="py-1.5 px-3 bg-white group-hover:bg-indigo-600 group-hover:text-white text-xs text-indigo-700 font-bold border border-slate-200 group-hover:border-indigo-600 rounded-lg shrink-0 transition-colors shadow-2xs cursor-pointer"
          >
            Ingresar
          </button>
        </div>

        <!-- Docente 2 -->
        <div class="flex items-center justify-between p-3.5 bg-slate-50 hover:bg-indigo-50/50 hover:border-indigo-300 border border-slate-200 rounded-xl transition-all cursor-pointer group">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold flex items-center justify-center text-xs shrink-0">
              LG
            </div>
            <div>
              <h4 class="font-bold text-slate-800 text-xs group-hover:text-indigo-900 transition-colors">
                Lic. Laura González
              </h4>
              <p class="text-[11px] text-slate-500">
                laura.gonzalez@instituto.edu.ar
              </p>
            </div>
          </div>
          <button 
            type="button" 
            onclick="alert('Ingresando como Lic. Laura González')"
            class="py-1.5 px-3 bg-white group-hover:bg-indigo-600 group-hover:text-white text-xs text-indigo-700 font-bold border border-slate-200 group-hover:border-indigo-600 rounded-lg shrink-0 transition-colors shadow-2xs cursor-pointer"
          >
            Ingresar
          </button>
        </div>

        <!-- Docente 3 -->
        <div class="flex items-center justify-between p-3.5 bg-slate-50 hover:bg-indigo-50/50 hover:border-indigo-300 border border-slate-200 rounded-xl transition-all cursor-pointer group">
          <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-indigo-100 text-indigo-700 font-bold flex items-center justify-center text-xs shrink-0">
              MM
            </div>
            <div>
              <h4 class="font-bold text-slate-800 text-xs group-hover:text-indigo-900 transition-colors">
                Ing. Marcos Martínez
              </h4>
              <p class="text-[11px] text-slate-500">
                marcos.martinez@instituto.edu.ar
              </p>
            </div>
          </div>
          <button 
            type="button" 
            onclick="alert('Ingresando como Ing. Marcos Martínez')"
            class="py-1.5 px-3 bg-white group-hover:bg-indigo-600 group-hover:text-white text-xs text-indigo-700 font-bold border border-slate-200 group-hover:border-indigo-600 rounded-lg shrink-0 transition-colors shadow-2xs cursor-pointer"
          >
            Ingresar
          </button>
        </div>

      </div>

      <p class="text-xs text-slate-400 mt-5 text-center">
        El docente ingresará para cargar el presentismo diario de sus comisiones.
      </p>

    </div>

    <!-- Panel 2: Vista Administrativos -->
    <div id="view-admin" class="p-6 space-y-4 hidden">
      
      <div class="flex items-center gap-2 p-3 bg-amber-50 border border-amber-200 rounded-xl text-amber-800 text-xs">
        <i class="fa-solid fa-lock text-amber-600 text-sm"></i>
        <span>Acceso restringido a personal de bedelía, secretaría y dirección.</span>
      </div>

      <form onsubmit="event.preventDefault(); alert('Acceso concedido a Consola Bedelía');" class="space-y-4">
        <div>
          <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
            Usuario o Email de Bedelía
          </label>
          <div class="relative">
            <i class="fa-regular fa-envelope absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
            <input 
              type="text" 
              required
              value="bedelia@instituto.edu.ar"
              class="w-full pl-9 pr-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white"
            />
          </div>
        </div>

        <div>
          <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
            Clave de Acceso
          </label>
          <div class="relative">
            <i class="fa-solid fa-key absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
            <input 
              type="password" 
              required
              value="••••••••"
              class="w-full pl-9 pr-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white"
            />
          </div>
        </div>

        <button 
          type="submit" 
          class="w-full py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-md transition-all flex items-center justify-center gap-2 cursor-pointer"
        >
          <i class="fa-solid fa-shield-halved"></i>
          Ingresar a la Consola Administrativa
        </button>
      </form>

      <p class="text-xs text-slate-400 mt-4 text-center">
        Desde este panel podrá crear materias, matricular alumnos y gestionar profesores.
      </p>

    </div>

  </div>

  <script>
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
      form.classList.toggle('hidden');
    }
  </script>
</body>
</html>
