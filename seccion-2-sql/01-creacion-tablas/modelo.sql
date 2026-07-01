-- 1. Tabla: profesor
CREATE TABLE profesor (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

-- 2. Tabla: sala
CREATE TABLE sala (
    id_sala SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL
);

-- 3. Tabla: alumno
CREATE TABLE alumno (
    id_alumno SERIAL PRIMARY KEY,
    rut VARCHAR(12) UNIQUE NOT NULL, 
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE
);

-- 4. Tabla: curso
CREATE TABLE curso (
    id_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_curso VARCHAR(20) UNIQUE NOT NULL,
    id_profesor INTEGER NOT NULL REFERENCES profesor(id_profesor)
);

-- 5. Tabla: alumno_curso
CREATE TABLE alumno_curso (
    id_alumno INTEGER NOT NULL REFERENCES alumno(id_alumno),
    id_curso INTEGER NOT NULL REFERENCES curso(id_curso),
    PRIMARY KEY (id_alumno, id_curso)
);

-- 6. Tabla: horario
CREATE TABLE horario (
    id_curso INTEGER NOT NULL REFERENCES curso(id_curso),
    id_sala INTEGER NOT NULL REFERENCES sala(id_sala),
    dia VARCHAR(15) NOT NULL, -- Ej: 'Lunes', 'Martes'
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY (id_curso, dia, hora_inicio)
);