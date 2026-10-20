
-- ==========================================
-- MiniStore - Soluciones con Outer JOINs
-- Autor: Celeste Keipert
-- Fecha: 19/10/2026
-- ==========================================

-- CONSULTA 1: LEFT JOIN
-- Pregunta: ¿Qué productos del catálogo nunca fueron vendidos?
-- Se muestran todos los productos, tengan ventas o no.

SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY p.producto_id;

-- Filtro opcional para mostrar solo los productos
-- que nunca fueron vendidos:
-- WHERE v.venta_id IS NULL


-- CONSULTA 2: RIGHT JOIN
-- Pregunta: ¿Hay ventas de productos que no existen
-- en el catálogo?

SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    v.venta_id,
    v.producto_id AS producto_id_venta,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL
ORDER BY v.venta_id;


-- CONSULTA 3: FULL OUTER JOIN
-- Pregunta: ¿Cuál es la situación completa del catálogo
-- y de las ventas, incluyendo registros sin coincidencia?

SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_id_venta,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY
    COALESCE(p.producto_id, v.producto_id),
    v.venta_id;
