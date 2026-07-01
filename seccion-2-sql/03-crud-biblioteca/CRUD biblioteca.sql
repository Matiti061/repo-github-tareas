SELECT u.id_usuario, u.nombre, COUNT(p.id_prestamo) AS total_retrasados
FROM usuario u
JOIN prestamo p ON u.id_usuario = p.id_usuario
WHERE p.estado = 'retrasado'
GROUP BY u.id_usuario, u.nombre
ORDER BY total_retrasados DESC;

SELECT l.id_libro, l.titulo, COUNT(al.id_autor) AS total_autores
FROM libro l
JOIN autor_libro al ON l.id_libro = al.id_libro
GROUP BY l.id_libro, l.titulo
HAVING COUNT(al.id_autor) > 1;

SELECT u.id_usuario, u.nombre, SUM(m.monto) AS total_multas
FROM usuario u
JOIN multa m ON u.id_usuario = m.id_usuario
GROUP BY u.id_usuario, u.nombre;

SELECT c.nombre AS categoria, l.anio_publicacion, COUNT(l.id_libro) AS cantidad_libros
FROM libro l
JOIN categoria c ON l.id_categoria = c.id_categoria
GROUP BY c.nombre, l.anio_publicacion
ORDER BY c.nombre, l.anio_publicacion;

SELECT DISTINCT l.id_libro, l.titulo
FROM libro l
JOIN prestamo p ON l.id_libro = p.id_libro
WHERE EXTRACT(YEAR FROM p.fecha_prestamo) = 2023;

---------------------------------------------------------------------------------------

UPDATE prestamo
SET estado = 'retrasado'
WHERE fecha_devolucion > fecha_prestamo + INTERVAL '15 days'
   OR (fecha_devolucion IS NULL AND CURRENT_DATE > fecha_prestamo + INTERVAL '15 days');

UPDATE prestamo
SET fecha_devolucion = CURRENT_DATE,
    estado = 'devuelto'
WHERE id_prestamo = 1;

UPDATE multa
SET estado = 'pagada'
WHERE id_multa = 1;

---------------------------------------------------------------------------------------

DELETE FROM prestamo
WHERE estado = 'devuelto' 
  AND fecha_devolucion < CURRENT_DATE - INTERVAL '1 year';

DELETE FROM libro
WHERE id_libro NOT IN (
    SELECT id_libro 
    FROM autor_libro
);

---------------------------------------------------------------------------------------

CREATE VIEW vista_global_biblioteca AS
SELECT 
    l.id_libro,
    l.titulo,
    l.anio_publicacion,
    c.nombre AS nombre_categoria,
    a.nombre AS nombre_autor,
    a.apellido AS apellido_autor,
    u.id_usuario,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    p.id_prestamo,
    p.fecha_prestamo,
    p.fecha_devolucion,
    p.estado AS estado_prestamo,
    m.id_multa,
    m.monto,
    m.estado AS estado_multa
FROM libro l
LEFT JOIN categoria c ON l.id_categoria = c.id_categoria
LEFT JOIN autor_libro al ON l.id_libro = al.id_libro
LEFT JOIN autor a ON al.id_autor = a.id_autor
LEFT JOIN prestamo p ON l.id_libro = p.id_libro
LEFT JOIN usuario u ON p.id_usuario = u.id_usuario
LEFT JOIN multa m ON p.id_prestamo = m.id_prestamo;