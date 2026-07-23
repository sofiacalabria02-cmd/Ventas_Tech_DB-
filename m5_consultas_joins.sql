--Se dejan comentarios en README.md
--============================================
-- Consulta 1
-- Vista base del proyecto (INNER JOIN)
-- ============================================

SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    NULL AS segmento,
    c.ciudad AS region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    NULL AS canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;

-- ============================================
-- Consulta 2
-- Clientes sin ventas
-- ============================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- ============================================
-- Consulta 3
-- Productos sin ventas
-- ============================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_producto IS NULL;

-- ============================================
-- Consulta 4
-- Consolidado por canal
-- ============================================

SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM
(
    SELECT
        'Ventas' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas

    UNION ALL

    SELECT
        'Ventas' AS canal,
        0 AS total_venta
    WHERE FALSE
) t
GROUP BY canal;
