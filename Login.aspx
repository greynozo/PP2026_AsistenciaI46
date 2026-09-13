<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PresentismoWebI46.Login" %>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal de Acceso - Control de Asistencia y Presentismo</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Estilos Propios -->
    <link rel="stylesheet" href="css/styles.css">
    <style>*, ::before, ::after{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }::backdrop{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }/* ! tailwindcss v3.4.17 | MIT License | https://tailwindcss.com */*,::after,::before{box-sizing:border-box;border-width:0;border-style:solid;border-color:#e5e7eb}::after,::before{--tw-content:''}:host,html{line-height:1.5;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4;font-family:ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";font-feature-settings:normal;font-variation-settings:normal;-webkit-tap-highlight-color:transparent}body{margin:0;line-height:inherit}hr{height:0;color:inherit;border-top-width:1px}abbr:where([title]){-webkit-text-decoration:underline dotted;text-decoration:underline dotted}h1,h2,h3,h4,h5,h6{font-size:inherit;font-weight:inherit}a{color:inherit;text-decoration:inherit}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;font-feature-settings:normal;font-variation-settings:normal;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{text-indent:0;border-color:inherit;border-collapse:collapse}button,input,optgroup,select,textarea{font-family:inherit;font-feature-settings:inherit;font-variation-settings:inherit;font-size:100%;font-weight:inherit;line-height:inherit;letter-spacing:inherit;color:inherit;margin:0;padding:0}button,select{text-transform:none}button,input:where([type=button]),input:where([type=reset]),input:where([type=submit]){-webkit-appearance:button;background-color:transparent;background-image:none}:-moz-focusring{outline:auto}:-moz-ui-invalid{box-shadow:none}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}blockquote,dd,dl,figure,h1,h2,h3,h4,h5,h6,hr,p,pre{margin:0}fieldset{margin:0;padding:0}legend{padding:0}menu,ol,ul{list-style:none;margin:0;padding:0}dialog{padding:0}textarea{resize:vertical}input::placeholder,textarea::placeholder{opacity:1;color:#9ca3af}[role=button],button{cursor:pointer}:disabled{cursor:default}audio,canvas,embed,iframe,img,object,svg,video{display:block;vertical-align:middle}img,video{max-width:100%;height:auto}[hidden]:where(:not([hidden=until-found])){display:none}.relative{position:relative}.mx-auto{margin-left:auto;margin-right:auto}.my-8{margin-top:2rem;margin-bottom:2rem}.mb-1{margin-bottom:0.25rem}.mb-2{margin-bottom:0.5rem}.mb-3{margin-bottom:0.75rem}.mb-6{margin-bottom:1.5rem}.mt-0\.5{margin-top:0.125rem}.mt-1{margin-top:0.25rem}.mt-2{margin-top:0.5rem}.block{display:block}.flex{display:flex}.hidden{display:none}.h-14{height:3.5rem}.h-8{height:2rem}.h-9{height:2.25rem}.max-h-48{max-height:12rem}.min-h-screen{min-height:100vh}.w-1\/2{width:50%}.w-14{width:3.5rem}.w-8{width:2rem}.w-full{width:100%}.w-9{width:2.25rem}.max-w-md{max-width:28rem}.flex-1{flex:1 1 0%}.shrink-0{flex-shrink:0}.cursor-pointer{cursor:pointer}.flex-col{flex-direction:column}.items-start{align-items:flex-start}.items-center{align-items:center}.justify-center{justify-content:center}.justify-between{justify-content:space-between}.gap-1{gap:0.25rem}.gap-1\.5{gap:0.375rem}.gap-2{gap:0.5rem}.gap-2\.5{gap:0.625rem}.gap-3{gap:0.75rem}.space-y-2 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.5rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.5rem * var(--tw-space-y-reverse))}.space-y-3 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.75rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.75rem * var(--tw-space-y-reverse))}.space-y-4 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(1rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(1rem * var(--tw-space-y-reverse))}.overflow-hidden{overflow:hidden}.overflow-y-auto{overflow-y:auto}.rounded-2xl{border-radius:1rem}.rounded-3xl{border-radius:1.5rem}.rounded-full{border-radius:9999px}.rounded-lg{border-radius:0.5rem}.rounded-xl{border-radius:0.75rem}.border{border-width:1px}.border-t{border-top-width:1px}.border-amber-200{--tw-border-opacity:1;border-color:rgb(253 230 138 / var(--tw-border-opacity, 1))}.border-indigo-100{--tw-border-opacity:1;border-color:rgb(224 231 255 / var(--tw-border-opacity, 1))}.border-indigo-200{--tw-border-opacity:1;border-color:rgb(199 210 254 / var(--tw-border-opacity, 1))}.border-slate-100{--tw-border-opacity:1;border-color:rgb(241 245 249 / var(--tw-border-opacity, 1))}.border-slate-200{--tw-border-opacity:1;border-color:rgb(226 232 240 / var(--tw-border-opacity, 1))}.border-slate-200\/80{border-color:rgb(226 232 240 / 0.8)}.border-slate-200\/90{border-color:rgb(226 232 240 / 0.9)}.border-white\/20{border-color:rgb(255 255 255 / 0.2)}.bg-amber-50\/70{background-color:rgb(255 251 235 / 0.7)}.bg-indigo-100{--tw-bg-opacity:1;background-color:rgb(224 231 255 / var(--tw-bg-opacity, 1))}.bg-indigo-50\/50{background-color:rgb(238 242 255 / 0.5)}.bg-indigo-50\/70{background-color:rgb(238 242 255 / 0.7)}.bg-indigo-600{--tw-bg-opacity:1;background-color:rgb(79 70 229 / var(--tw-bg-opacity, 1))}.bg-slate-100{--tw-bg-opacity:1;background-color:rgb(241 245 249 / var(--tw-bg-opacity, 1))}.bg-slate-200{--tw-bg-opacity:1;background-color:rgb(226 232 240 / var(--tw-bg-opacity, 1))}.bg-slate-50{--tw-bg-opacity:1;background-color:rgb(248 250 252 / var(--tw-bg-opacity, 1))}.bg-white{--tw-bg-opacity:1;background-color:rgb(255 255 255 / var(--tw-bg-opacity, 1))}.bg-white\/10{background-color:rgb(255 255 255 / 0.1)}.bg-gradient-to-br{background-image:linear-gradient(to bottom right, var(--tw-gradient-stops))}.from-indigo-900{--tw-gradient-from:#312e81 var(--tw-gradient-from-position);--tw-gradient-to:rgb(49 46 129 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.via-indigo-800{--tw-gradient-to:rgb(55 48 163 / 0)  var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), #3730a3 var(--tw-gradient-via-position), var(--tw-gradient-to)}.to-indigo-950{--tw-gradient-to:#1e1b4b var(--tw-gradient-to-position)}.p-1{padding:0.25rem}.p-3{padding:0.75rem}.p-4{padding:1rem}.p-6{padding:1.5rem}.p-7{padding:1.75rem}.p-3\.5{padding:0.875rem}.px-2\.5{padding-left:0.625rem;padding-right:0.625rem}.px-3{padding-left:0.75rem;padding-right:0.75rem}.px-3\.5{padding-left:0.875rem;padding-right:0.875rem}.px-6{padding-left:1.5rem;padding-right:1.5rem}.py-1{padding-top:0.25rem;padding-bottom:0.25rem}.py-2{padding-top:0.5rem;padding-bottom:0.5rem}.py-2\.5{padding-top:0.625rem;padding-bottom:0.625rem}.py-3{padding-top:0.75rem;padding-bottom:0.75rem}.py-4{padding-top:1rem;padding-bottom:1rem}.py-1\.5{padding-top:0.375rem;padding-bottom:0.375rem}.pr-1{padding-right:0.25rem}.pt-1{padding-top:0.25rem}.pt-3{padding-top:0.75rem}.text-center{text-align:center}.text-2xl{font-size:1.5rem;line-height:2rem}.text-\[10px\]{font-size:10px}.text-\[11px\]{font-size:11px}.text-base{font-size:1rem;line-height:1.5rem}.text-xl{font-size:1.25rem;line-height:1.75rem}.text-xs{font-size:0.75rem;line-height:1rem}.font-black{font-weight:900}.font-bold{font-weight:700}.font-medium{font-weight:500}.font-semibold{font-weight:600}.uppercase{text-transform:uppercase}.leading-relaxed{line-height:1.625}.tracking-tight{letter-spacing:-0.025em}.tracking-wide{letter-spacing:0.025em}.tracking-wider{letter-spacing:0.05em}.text-amber-600{--tw-text-opacity:1;color:rgb(217 119 6 / var(--tw-text-opacity, 1))}.text-amber-700{--tw-text-opacity:1;color:rgb(180 83 9 / var(--tw-text-opacity, 1))}.text-amber-900{--tw-text-opacity:1;color:rgb(120 53 15 / var(--tw-text-opacity, 1))}.text-indigo-200{--tw-text-opacity:1;color:rgb(199 210 254 / var(--tw-text-opacity, 1))}.text-indigo-600{--tw-text-opacity:1;color:rgb(79 70 229 / var(--tw-text-opacity, 1))}.text-indigo-700{--tw-text-opacity:1;color:rgb(67 56 202 / var(--tw-text-opacity, 1))}.text-indigo-900{--tw-text-opacity:1;color:rgb(49 46 129 / var(--tw-text-opacity, 1))}.text-slate-400{--tw-text-opacity:1;color:rgb(148 163 184 / var(--tw-text-opacity, 1))}.text-slate-500{--tw-text-opacity:1;color:rgb(100 116 139 / var(--tw-text-opacity, 1))}.text-slate-600{--tw-text-opacity:1;color:rgb(71 85 105 / var(--tw-text-opacity, 1))}.text-slate-700{--tw-text-opacity:1;color:rgb(51 65 85 / var(--tw-text-opacity, 1))}.text-slate-800{--tw-text-opacity:1;color:rgb(30 41 59 / var(--tw-text-opacity, 1))}.text-white{--tw-text-opacity:1;color:rgb(255 255 255 / var(--tw-text-opacity, 1))}.antialiased{-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}.shadow-inner{--tw-shadow:inset 0 2px 4px 0 rgb(0 0 0 / 0.05);--tw-shadow-colored:inset 0 2px 4px 0 var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-md{--tw-shadow:0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);--tw-shadow-colored:0 4px 6px -1px var(--tw-shadow-color), 0 2px 4px -2px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-sm{--tw-shadow:0 1px 2px 0 rgb(0 0 0 / 0.05);--tw-shadow-colored:0 1px 2px 0 var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.shadow-xl{--tw-shadow:0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);--tw-shadow-colored:0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.backdrop-blur-md{--tw-backdrop-blur:blur(12px);-webkit-backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);backdrop-filter:var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia)}.transition-all{transition-property:all;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.transition-colors{transition-property:color, background-color, border-color, fill, stroke, -webkit-text-decoration-color;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke, -webkit-text-decoration-color;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.hover\:border-indigo-300:hover{--tw-border-opacity:1;border-color:rgb(165 180 252 / var(--tw-border-opacity, 1))}.hover\:bg-indigo-50\/50:hover{background-color:rgb(238 242 255 / 0.5)}.hover\:bg-indigo-700:hover{--tw-bg-opacity:1;background-color:rgb(67 56 202 / var(--tw-bg-opacity, 1))}.hover\:bg-slate-300:hover{--tw-bg-opacity:1;background-color:rgb(203 213 225 / var(--tw-bg-opacity, 1))}.hover\:text-indigo-800:hover{--tw-text-opacity:1;color:rgb(55 48 163 / var(--tw-text-opacity, 1))}.hover\:text-slate-800:hover{--tw-text-opacity:1;color:rgb(30 41 59 / var(--tw-text-opacity, 1))}.focus\:border-indigo-500:focus{--tw-border-opacity:1;border-color:rgb(99 102 241 / var(--tw-border-opacity, 1))}.focus\:border-indigo-600:focus{--tw-border-opacity:1;border-color:rgb(79 70 229 / var(--tw-border-opacity, 1))}.focus\:bg-white:focus{--tw-bg-opacity:1;background-color:rgb(255 255 255 / var(--tw-bg-opacity, 1))}.focus\:outline-none:focus{outline:2px solid transparent;outline-offset:2px}.group:hover .group-hover\:border-indigo-600{--tw-border-opacity:1;border-color:rgb(79 70 229 / var(--tw-border-opacity, 1))}.group:hover .group-hover\:bg-indigo-600{--tw-bg-opacity:1;background-color:rgb(79 70 229 / var(--tw-bg-opacity, 1))}.group:hover .group-hover\:text-indigo-900{--tw-text-opacity:1;color:rgb(49 46 129 / var(--tw-text-opacity, 1))}.group:hover .group-hover\:text-white{--tw-text-opacity:1;color:rgb(255 255 255 / var(--tw-text-opacity, 1))}</style>
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
                <button id="tab-docentes" type="button" onclick="switchTab('docentes')" class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 bg-white text-indigo-700 shadow-sm border border-slate-200/80 cursor-pointer">
                    <i class="fa-solid fa-chalkboard-user"></i><span>Docentes</span>
                </button>
                <button id="tab-admin" type="button" onclick="switchTab('admin')" class="w-1/2 py-2.5 rounded-xl text-xs font-bold transition-all flex items-center justify-center gap-2 text-slate-500 hover:text-slate-800 cursor-pointer">
                    <i class="fa-solid fa-user-shield"></i><span>Administrativo</span>
                </button>
            </div>
            <!-- VISTA 1: Perfil Docente -->
            <div id="view-docentes" class="space-y-4">
                <!-- Banner Informativo de Perfil Docente (Idéntico estilo a Consola de Bedelía) -->
                <div class="p-4 bg-indigo-50/70 border border-indigo-200 rounded-2xl">
                    <div class="flex items-start gap-2.5">
                        <i class="fa-solid fa-chalkboard-user text-indigo-600 text-base mt-0.5"></i>
                        <div>
                            <h4 class="text-xs font-bold text-indigo-900">
                                Portal de Acceso para Docentes</h4>
                            <p class="text-[11px] text-indigo-700 mt-0.5 leading-relaxed">
                                Toma de presentismo diario por comisión, control de regularidad y registro de asistencias.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Formulario de Acceso Docente con datos dentro del HTML (armado igual al de administración) -->
                <form onsubmit="handleDocenteLoginSubmit(event)" class="space-y-3">
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                        Usuario / Correo Institucional
                    </label>
                    <input id="docente-email" type="email" value="carlos.rodriguez@instituto.edu.ar"
                        required="" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white">
                </div>
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                        Contraseña de Acceso
                    </label>
                    <input id="docente-password" type="password" value="••••••••" required="" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white">
                </div>
                <button type="submit" class="w-full py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-md transition-all flex items-center justify-center gap-2 cursor-pointer mt-2">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i><span>Ingresar al Panel Docente</span>
                </button>
                </form>
                <!-- Accesos Rápidos con datos dentro del HTML -->
                <div class="pt-3 border-t border-slate-100">
                    <div class="flex items-center justify-between mb-2">
                        <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Nómina de
                            Docentes Disponibles </span>
                        <button type="button" onclick="toggleRegisterForm()" class="text-[11px] font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1 cursor-pointer">
                            <i class="fa-solid fa-user-plus text-[10px]"></i><span>Alta Rápida</span>
                        </button>
                    </div>
                    <!-- Formulario Desplegable para Alta Rápida de Docente -->
                    <form id="register-form" onsubmit="handleQuickTeacherSubmit(event)" class="mb-3 bg-indigo-50/50 p-4 rounded-2xl border border-indigo-100 space-y-3 hidden">
                    <h3 class="text-xs font-bold text-indigo-900 uppercase">
                        Alta Rápida de Docente</h3>
                    <div>
                        <label class="block text-[10px] font-bold text-slate-600 uppercase mb-1">
                            Nombre Completo y Título</label>
                        <input id="new-teacher-name" type="text" required="" placeholder="Ej: Lic. Hernán Cortés"
                            class="w-full px-3 py-2 text-xs bg-white border border-slate-200 rounded-xl focus:outline-none focus:border-indigo-600">
                    </div>
                    <div>
                        <label class="block text-[10px] font-bold text-slate-600 uppercase mb-1">
                            Correo Electrónico</label>
                        <input id="new-teacher-email" type="email" required="" placeholder="docente@instituto.edu.ar"
                            class="w-full px-3 py-2 text-xs bg-white border border-slate-200 rounded-xl focus:outline-none focus:border-indigo-600">
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
                </div>
            </div>
            <!-- VISTA 2: Perfil Administrativo (Bedelía) -->
            <div id="view-admin" class="space-y-4 hidden">
                <div class="p-4 bg-amber-50/70 border border-amber-200 rounded-2xl">
                    <div class="flex items-start gap-2.5">
                        <i class="fa-solid fa-shield-halved text-amber-600 text-base mt-0.5"></i>
                        <div>
                            <h4 class="text-xs font-bold text-amber-900">
                                Consola de Bedelía &amp; Secretaría</h4>
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
                    <input id="admin-email" type="email" value="bedelia@instituto.edu.ar" required=""
                        class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white">
                </div>
                <div>
                    <label class="block text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                        Clave de Acceso
                    </label>
                    <input type="password" value="secretaria2026" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 focus:bg-white">
                </div>
                <button type="submit" class="w-full py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-xs transition-all flex items-center justify-center gap-2 cursor-pointer mt-2">
                    <i class="fa-solid fa-lock-open text-xs"></i><span>Ingresar al Panel de Gestión</span>
                </button>
                </form>
            </div>
        </div>
        <!-- Pie de Seguridad -->
        <div class="px-6 py-4 bg-slate-50 border-t border-slate-100 text-center">
            <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider flex items-center justify-center gap-1.5">
                <i class="fa-solid fa-lock text-slate-400"></i><span>Frontend Autónomo • HTML5 + CSS
                    + JS Vanilla</span> </span>
        </div>
    </div>
    <!-- Scripts Modulares del Frontend Completo -->
    <%--  <script src="js/storage.js"></script>
  <script src="js/auth.js"></script>--%>
  <script src="Estilos/js/ui.js"></script>
  <script src="Estilos/js/login.js"></script>
</body>
</html>
