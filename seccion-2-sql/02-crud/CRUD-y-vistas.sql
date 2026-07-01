SELECT id_alumno, nombre, apellido
FROM alumno;

SELECT c.nombre AS nombre_curso, p.nombre AS nombre_profesor, p.apellido AS apellido_profesor
FROM curso c
JOIN profesor p ON c.id_profesor = p.id_profesor;

SELECT c.nombre AS nombre_curso
FROM curso c
JOIN alumno_curso ac ON c.id_curso = ac.id_curso
WHERE ac.id_alumno = 1;

SELECT c.nombre AS nombre_curso, COUNT(ac.id_alumno) AS total_alumnos
FROM curso c
LEFT JOIN alumno_curso ac ON c.id_curso = ac.id_curso
GROUP BY c.id_curso, c.nombre;

SELECT h.dia, h.hora_inicio, h.hora_fin, s.nombre AS nombre_sala
FROM horario h
JOIN curso c ON h.id_curso = c.id_curso
JOIN sala s ON h.id_sala = s.id_sala
WHERE c.nombre = 'Programación';

SELECT id_sala, nombre
FROM sala
WHERE id_sala NOT IN (
    SELECT id_sala
    FROM horario
    WHERE dia = 'Martes'
);

-----------------------------------------------------------------------------------------

UPDATE alumno
SET nombre = 'Javier', apellido = 'Díaz Fernández'
WHERE id_alumno = 10;

UPDATE sala
SET capacidad = capacidad * 1.05
WHERE capacidad < 30;

UPDATE curso
SET id_profesor = 3
WHERE id_curso = 6;

UPDATE horario
SET hora_inicio = hora_inicio + INTERVAL '15 minutes'
WHERE id_curso IN (
    SELECT id_curso 
    FROM curso 
    WHERE nombre = 'Filosofía'
);

----------------------------------------------------------------------------------------

DELETE FROM alumno_curso
WHERE id_alumno = 4 AND id_curso = 8;

DELETE FROM horario
WHERE id_curso = 2;

DELETE FROM curso
WHERE id_profesor = 5;

----------------------------------------------------------------------------------------

CREATE VIEW vista_global_academica AS
SELECT 
    a.id_alumno,
    a.rut,
    a.nombre AS alumno_nombre,
    a.apellido AS alumno_apellido,
    a.email AS alumno_email,
    c.id_curso,
    c.codigo_curso,
    c.nombre AS curso_nombre,
    p.id_profesor,
    p.nombre AS profesor_nombre,
    p.apellido AS profesor_apellido,
    h.dia,
    h.hora_inicio,
    h.hora_fin,
    s.id_sala,
    s.nombre AS sala_nombre,
    s.capacidad
FROM alumno a
JOIN alumno_curso ac ON a.id_alumno = ac.id_alumno
JOIN curso c ON ac.id_curso = c.id_curso
JOIN profesor p ON c.id_profesor = p.id_profesor
LEFT JOIN horario h ON c.id_curso = h.id_curso
LEFT JOIN sala s ON h.id_sala = s.id_sala;