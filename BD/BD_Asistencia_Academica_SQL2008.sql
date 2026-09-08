/*
    SISTEMA DE ASISTENCIA ACADÉMICA
    Script compatible con SQL Server 2008 / 2008 R2

    Modelo:
      Carrera 1:N Materia
      Materia 1:N Comision
      PeriodoLectivo 1:N Comision
      Usuario 1:N Comision (docente)
      Comision 1:N ComisionDias
      Alumno 1:N Inscripcion
      Comision 1:N Inscripcion
      Inscripcion 1:N Asistencia
      Usuario 1:N Asistencia (usuario que registra)

    Reglas principales:
      - Una materia pertenece a una sola carrera.
      - Una comisión pertenece a una materia y a un período lectivo.
      - Una comisión tiene un único docente.
      - Un alumno se inscribe a una única comisión por materia y período.
      - Un alumno no cambia de comisión durante el período.
      - Un alumno puede tener muchas asistencias, pero solo una por inscripción y fecha.
      - Tipos de asistencia: P=Presente, A=Ausente, T=Tarde, J=Justificada.
*/

/* ================================================================
   1. CREACIÓN DE BASE DE DATOS
   ================================================================ */
IF DB_ID(N'AsistenciaAcademica') IS NULL
BEGIN
    CREATE DATABASE AsistenciaAcademica;
END
GO

USE AsistenciaAcademica;
GO

/* ================================================================
   2. TABLAS
   ================================================================ */

/* ---------------------------------------------------------------
   PERIODOS LECTIVOS
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.PeriodosLectivos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.PeriodosLectivos
    (
        IdPeriodo       INT IDENTITY(1,1) NOT NULL,
        Anio            INT NOT NULL,
        Descripcion     VARCHAR(100) NOT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_PeriodosLectivos_Activo DEFAULT (1),

        CONSTRAINT PK_PeriodosLectivos PRIMARY KEY CLUSTERED (IdPeriodo),
        CONSTRAINT UQ_PeriodosLectivos_Anio UNIQUE (Anio),
        CONSTRAINT CK_PeriodosLectivos_Anio CHECK (Anio BETWEEN 2000 AND 2100)
    );
END
GO

/* ---------------------------------------------------------------
   USUARIOS
   NivelUsuario:
      1 = Administrador / Preceptor
      2 = Docente
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Usuarios', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Usuarios
    (
        IdUsuario       INT IDENTITY(1,1) NOT NULL,
        Usuario         VARCHAR(50) NOT NULL,
        PasswordHash    VARCHAR(255) NOT NULL,
        Nombre          VARCHAR(50) NOT NULL,
        Apellido        VARCHAR(50) NOT NULL,
        DNI             VARCHAR(20) NOT NULL,
        NivelUsuario    INT NOT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_Usuarios_Activo DEFAULT (1),

        CONSTRAINT PK_Usuarios PRIMARY KEY CLUSTERED (IdUsuario),
        CONSTRAINT UQ_Usuarios_Usuario UNIQUE (Usuario),
        CONSTRAINT UQ_Usuarios_DNI UNIQUE (DNI),
        CONSTRAINT CK_Usuarios_Nivel CHECK (NivelUsuario IN (1,2))
    );
END
GO

/* ---------------------------------------------------------------
   CARRERAS
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Carreras', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Carreras
    (
        IdCarrera       INT IDENTITY(1,1) NOT NULL,
        NombreCarrera   VARCHAR(150) NOT NULL,
        Sede             VARCHAR(100) NOT NULL,
        Activo           BIT NOT NULL CONSTRAINT DF_Carreras_Activo DEFAULT (1),

        CONSTRAINT PK_Carreras PRIMARY KEY CLUSTERED (IdCarrera),
        CONSTRAINT UQ_Carreras_Nombre_Sede UNIQUE (NombreCarrera, Sede)
    );
END
GO

/* ---------------------------------------------------------------
   MATERIAS
   Una materia pertenece a una única carrera.
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Materias', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Materias
    (
        IdMateria       INT IDENTITY(1,1) NOT NULL,
        NombreMateria   VARCHAR(150) NOT NULL,
        Curso           INT NOT NULL,
        IdCarrera       INT NOT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_Materias_Activo DEFAULT (1),

        CONSTRAINT PK_Materias PRIMARY KEY CLUSTERED (IdMateria),
        CONSTRAINT FK_Materias_Carreras FOREIGN KEY (IdCarrera)
            REFERENCES dbo.Carreras (IdCarrera),
        CONSTRAINT CK_Materias_Curso CHECK (Curso BETWEEN 1 AND 10),
        CONSTRAINT UQ_Materias_Carrera_Nombre_Curso UNIQUE (IdCarrera, NombreMateria, Curso)
    );
END
GO

/* ---------------------------------------------------------------
   COMISIONES
   Cada comisión tiene un único docente.
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Comisiones', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Comisiones
    (
        IdComision      INT IDENTITY(1,1) NOT NULL,
        IdMateria       INT NOT NULL,
        IdPeriodo       INT NOT NULL,
        Grupo            VARCHAR(10) NOT NULL,
        Turno            VARCHAR(20) NOT NULL,
        IdUsuario       INT NOT NULL,
        Activo           BIT NOT NULL CONSTRAINT DF_Comisiones_Activo DEFAULT (1),

        CONSTRAINT PK_Comisiones PRIMARY KEY CLUSTERED (IdComision),
        CONSTRAINT FK_Comisiones_Materias FOREIGN KEY (IdMateria)
            REFERENCES dbo.Materias (IdMateria),
        CONSTRAINT FK_Comisiones_Periodos FOREIGN KEY (IdPeriodo)
            REFERENCES dbo.PeriodosLectivos (IdPeriodo),
        CONSTRAINT FK_Comisiones_Usuarios FOREIGN KEY (IdUsuario)
            REFERENCES dbo.Usuarios (IdUsuario),
        CONSTRAINT UQ_Comisiones_Materia_Periodo_Grupo UNIQUE (IdMateria, IdPeriodo, Grupo)
    );
END
GO

/* ---------------------------------------------------------------
   DÍAS / HORARIOS DE LA COMISIÓN
   DiaSemana:
      1 = Lunes
      2 = Martes
      3 = Miércoles
      4 = Jueves
      5 = Viernes
      6 = Sábado
      7 = Domingo
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.ComisionDias', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ComisionDias
    (
        IdComisionDia   INT IDENTITY(1,1) NOT NULL,
        IdComision      INT NOT NULL,
        DiaSemana       TINYINT NOT NULL,
        HoraDesde       TIME NOT NULL,
        HoraHasta       TIME NOT NULL,
        Aula             VARCHAR(30) NULL,

        CONSTRAINT PK_ComisionDias PRIMARY KEY CLUSTERED (IdComisionDia),
        CONSTRAINT FK_ComisionDias_Comisiones FOREIGN KEY (IdComision)
            REFERENCES dbo.Comisiones (IdComision),
        CONSTRAINT CK_ComisionDias_DiaSemana CHECK (DiaSemana BETWEEN 1 AND 7),
        CONSTRAINT CK_ComisionDias_Horario CHECK (HoraHasta > HoraDesde),
        CONSTRAINT UQ_ComisionDias_Comision_Dia_Hora UNIQUE (IdComision, DiaSemana, HoraDesde)
    );
END
GO

/* ---------------------------------------------------------------
   ALUMNOS
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Alumnos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Alumnos
    (
        IdAlumno        INT IDENTITY(1,1) NOT NULL,
        Nombre          VARCHAR(50) NOT NULL,
        Apellido        VARCHAR(50) NOT NULL,
        DNI             VARCHAR(20) NOT NULL,
        Cohorte         INT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_Alumnos_Activo DEFAULT (1),

        CONSTRAINT PK_Alumnos PRIMARY KEY CLUSTERED (IdAlumno),
        CONSTRAINT UQ_Alumnos_DNI UNIQUE (DNI),
        CONSTRAINT CK_Alumnos_Cohorte CHECK (Cohorte IS NULL OR Cohorte BETWEEN 2000 AND 2100)
    );
END
GO

/* ---------------------------------------------------------------
   INSCRIPCIONES
   Relaciona un alumno con una comisión.

   Estado:
      ACTIVA
      FINALIZADA
      BAJA
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Inscripciones', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Inscripciones
    (
        IdInscripcion   INT IDENTITY(1,1) NOT NULL,
        IdAlumno        INT NOT NULL,
        IdComision      INT NOT NULL,
        Estado          VARCHAR(20) NOT NULL CONSTRAINT DF_Inscripciones_Estado DEFAULT ('ACTIVA'),

        CONSTRAINT PK_Inscripciones PRIMARY KEY CLUSTERED (IdInscripcion),
        CONSTRAINT FK_Inscripciones_Alumnos FOREIGN KEY (IdAlumno)
            REFERENCES dbo.Alumnos (IdAlumno),
        CONSTRAINT FK_Inscripciones_Comisiones FOREIGN KEY (IdComision)
            REFERENCES dbo.Comisiones (IdComision),
        CONSTRAINT UQ_Inscripciones_Alumno_Comision UNIQUE (IdAlumno, IdComision),
        CONSTRAINT CK_Inscripciones_Estado CHECK (Estado IN ('ACTIVA','FINALIZADA','BAJA'))
    );
END
GO

/* ---------------------------------------------------------------
   ASISTENCIAS
   TipoAsistencia:
      P = Presente
      A = Ausente
      T = Tarde
      J = Justificada
   --------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.Asistencias', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Asistencias
    (
        IdAsistencia    INT IDENTITY(1,1) NOT NULL,
        IdInscripcion   INT NOT NULL,
        Fecha           DATE NOT NULL,
        TipoAsistencia  CHAR(1) NOT NULL,
        IdUsuario       INT NOT NULL,
        Observacion     VARCHAR(500) NULL,

        CONSTRAINT PK_Asistencias PRIMARY KEY CLUSTERED (IdAsistencia),
        CONSTRAINT FK_Asistencias_Inscripciones FOREIGN KEY (IdInscripcion)
            REFERENCES dbo.Inscripciones (IdInscripcion),
        CONSTRAINT FK_Asistencias_Usuarios FOREIGN KEY (IdUsuario)
            REFERENCES dbo.Usuarios (IdUsuario),
        CONSTRAINT UQ_Asistencias_Inscripcion_Fecha UNIQUE (IdInscripcion, Fecha),
        CONSTRAINT CK_Asistencias_Tipo CHECK (TipoAsistencia IN ('P','A','T','J'))
    );
END
GO

/* ================================================================
   3. ÍNDICES ADICIONALES
   ================================================================ */

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Materias_IdCarrera'
      AND object_id = OBJECT_ID('dbo.Materias')
)
BEGIN
    CREATE INDEX IX_Materias_IdCarrera
        ON dbo.Materias (IdCarrera);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Comisiones_IdPeriodo'
      AND object_id = OBJECT_ID('dbo.Comisiones')
)
BEGIN
    CREATE INDEX IX_Comisiones_IdPeriodo
        ON dbo.Comisiones (IdPeriodo);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Comisiones_IdUsuario'
      AND object_id = OBJECT_ID('dbo.Comisiones')
)
BEGIN
    CREATE INDEX IX_Comisiones_IdUsuario
        ON dbo.Comisiones (IdUsuario);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_ComisionDias_DiaSemana'
      AND object_id = OBJECT_ID('dbo.ComisionDias')
)
BEGIN
    CREATE INDEX IX_ComisionDias_DiaSemana
        ON dbo.ComisionDias (DiaSemana);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Inscripciones_IdAlumno'
      AND object_id = OBJECT_ID('dbo.Inscripciones')
)
BEGIN
    CREATE INDEX IX_Inscripciones_IdAlumno
        ON dbo.Inscripciones (IdAlumno);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Inscripciones_IdComision'
      AND object_id = OBJECT_ID('dbo.Inscripciones')
)
BEGIN
    CREATE INDEX IX_Inscripciones_IdComision
        ON dbo.Inscripciones (IdComision);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Asistencias_Fecha'
      AND object_id = OBJECT_ID('dbo.Asistencias')
)
BEGIN
    CREATE INDEX IX_Asistencias_Fecha
        ON dbo.Asistencias (Fecha);
END
GO

IF NOT EXISTS
(
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_Asistencias_IdUsuario'
      AND object_id = OBJECT_ID('dbo.Asistencias')
)
BEGIN
    CREATE INDEX IX_Asistencias_IdUsuario
        ON dbo.Asistencias (IdUsuario);
END
GO

/* ================================================================
   4. TRIGGER DE INTEGRIDAD

   Regla:
   Un alumno no puede estar inscripto en dos comisiones diferentes
   de la misma materia durante el mismo período lectivo.

   Esta regla no puede resolverse solamente con un UNIQUE porque
   Materia y Periodo están en Comisiones.
   ================================================================ */

IF OBJECT_ID(N'dbo.TR_Inscripciones_UnaComisionPorMateriaPeriodo', N'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.TR_Inscripciones_UnaComisionPorMateriaPeriodo;
END
GO

CREATE TRIGGER dbo.TR_Inscripciones_UnaComisionPorMateriaPeriodo
ON dbo.Inscripciones
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Inscripciones I
        INNER JOIN dbo.Comisiones C
            ON C.IdComision = I.IdComision
        INNER JOIN inserted X
            ON X.IdInscripcion = I.IdInscripcion
        WHERE EXISTS
        (
            SELECT 1
            FROM dbo.Inscripciones I2
            INNER JOIN dbo.Comisiones C2
                ON C2.IdComision = I2.IdComision
            WHERE I2.IdAlumno = I.IdAlumno
              AND C2.IdMateria = C.IdMateria
              AND C2.IdPeriodo = C.IdPeriodo
              AND I2.IdInscripcion <> I.IdInscripcion
        )
    )
    BEGIN
        RAISERROR (
            'El alumno ya esta inscripto en otra comision de la misma materia y periodo lectivo.',
            16,
            1
        );
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

/* ================================================================
   5. DATOS INICIALES OPCIONALES

   Se cargan solamente valores de referencia para poder comenzar
   a probar la aplicación.
   ================================================================ */

IF NOT EXISTS (SELECT 1 FROM dbo.PeriodosLectivos WHERE Anio = 2026)
BEGIN
    INSERT INTO dbo.PeriodosLectivos (Anio, Descripcion, Activo)
    VALUES (2026, 'Ciclo Lectivo 2026', 1);
END
GO

/* ================================================================
   6. VISTA ÚTIL PARA EL DOCENTE

   Devuelve las comisiones y horarios asociados al día actual.
   La aplicación puede filtrar además por IdUsuario.
   ================================================================ */

IF OBJECT_ID(N'dbo.vw_ComisionesHorarios', N'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_ComisionesHorarios;
END
GO

CREATE VIEW dbo.vw_ComisionesHorarios
AS
SELECT
    C.IdComision,
    C.IdUsuario,
    U.Apellido + ', ' + U.Nombre AS Docente,
    C.IdPeriodo,
    PL.Anio AS AnioLectivo,
    C.Grupo,
    C.Turno,
    M.IdMateria,
    M.NombreMateria,
    M.Curso,
    CA.IdCarrera,
    CA.NombreCarrera,
    CA.Sede,
    CD.DiaSemana,
    CD.HoraDesde,
    CD.HoraHasta,
    CD.Aula,
    C.Activo AS ComisionActiva
FROM dbo.Comisiones C
INNER JOIN dbo.Usuarios U
    ON U.IdUsuario = C.IdUsuario
INNER JOIN dbo.PeriodosLectivos PL
    ON PL.IdPeriodo = C.IdPeriodo
INNER JOIN dbo.Materias M
    ON M.IdMateria = C.IdMateria
INNER JOIN dbo.Carreras CA
    ON CA.IdCarrera = M.IdCarrera
INNER JOIN dbo.ComisionDias CD
    ON CD.IdComision = C.IdComision;
GO

/* ================================================================
   7. VISTA ÚTIL PARA LISTADO DE ALUMNOS DE UNA COMISIÓN
   ================================================================ */

IF OBJECT_ID(N'dbo.vw_AlumnosComision', N'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_AlumnosComision;
END
GO

CREATE VIEW dbo.vw_AlumnosComision
AS
SELECT
    I.IdInscripcion,
    I.IdAlumno,
    A.Apellido,
    A.Nombre,
    A.DNI,
    I.IdComision,
    C.Grupo,
    C.Turno,
    M.IdMateria,
    M.NombreMateria,
    M.Curso,
    CA.IdCarrera,
    CA.NombreCarrera,
    PL.IdPeriodo,
    PL.Anio AS AnioLectivo,
    I.Estado
FROM dbo.Inscripciones I
INNER JOIN dbo.Alumnos A
    ON A.IdAlumno = I.IdAlumno
INNER JOIN dbo.Comisiones C
    ON C.IdComision = I.IdComision
INNER JOIN dbo.Materias M
    ON M.IdMateria = C.IdMateria
INNER JOIN dbo.Carreras CA
    ON CA.IdCarrera = M.IdCarrera
INNER JOIN dbo.PeriodosLectivos PL
    ON PL.IdPeriodo = C.IdPeriodo;
GO

/* ================================================================
   8. VISTA ÚTIL PARA HISTORIAL DE ASISTENCIA
   ================================================================ */

IF OBJECT_ID(N'dbo.vw_HistorialAsistencias', N'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_HistorialAsistencias;
END
GO

CREATE VIEW dbo.vw_HistorialAsistencias
AS
SELECT
    ASI.IdAsistencia,
    ASI.Fecha,
    ASI.TipoAsistencia,
    CASE ASI.TipoAsistencia
        WHEN 'P' THEN 'Presente'
        WHEN 'A' THEN 'Ausente'
        WHEN 'T' THEN 'Tarde'
        WHEN 'J' THEN 'Justificada'
    END AS DescripcionAsistencia,
    ASI.Observacion,
    AL.IdAlumno,
    AL.Apellido + ', ' + AL.Nombre AS Alumno,
    AL.DNI,
    I.IdInscripcion,
    C.IdComision,
    C.Grupo,
    C.Turno,
    M.IdMateria,
    M.NombreMateria,
    M.Curso,
    CA.IdCarrera,
    CA.NombreCarrera,
    PL.IdPeriodo,
    PL.Anio AS AnioLectivo,
    U.IdUsuario,
    U.Apellido + ', ' + U.Nombre AS UsuarioRegistro
FROM dbo.Asistencias ASI
INNER JOIN dbo.Inscripciones I
    ON I.IdInscripcion = ASI.IdInscripcion
INNER JOIN dbo.Alumnos AL
    ON AL.IdAlumno = I.IdAlumno
INNER JOIN dbo.Comisiones C
    ON C.IdComision = I.IdComision
INNER JOIN dbo.Materias M
    ON M.IdMateria = C.IdMateria
INNER JOIN dbo.Carreras CA
    ON CA.IdCarrera = M.IdCarrera
INNER JOIN dbo.PeriodosLectivos PL
    ON PL.IdPeriodo = C.IdPeriodo
INNER JOIN dbo.Usuarios U
    ON U.IdUsuario = ASI.IdUsuario;
GO

/* ================================================================
   9. COMPROBACIÓN FINAL
   ================================================================ */

SELECT 'PeriodosLectivos' AS Tabla, COUNT(*) AS Registros FROM dbo.PeriodosLectivos
UNION ALL
SELECT 'Usuarios', COUNT(*) FROM dbo.Usuarios
UNION ALL
SELECT 'Carreras', COUNT(*) FROM dbo.Carreras
UNION ALL
SELECT 'Materias', COUNT(*) FROM dbo.Materias
UNION ALL
SELECT 'Comisiones', COUNT(*) FROM dbo.Comisiones
UNION ALL
SELECT 'ComisionDias', COUNT(*) FROM dbo.ComisionDias
UNION ALL
SELECT 'Alumnos', COUNT(*) FROM dbo.Alumnos
UNION ALL
SELECT 'Inscripciones', COUNT(*) FROM dbo.Inscripciones
UNION ALL
SELECT 'Asistencias', COUNT(*) FROM dbo.Asistencias;
GO

PRINT 'Base de datos AsistenciaAcademica creada/verificada correctamente.';
GO
