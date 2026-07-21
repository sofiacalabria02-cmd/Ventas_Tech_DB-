--TP Modulo 3
--Creamos la DATABASE.
CREATE DATABASE Ventas_Tech_DB;

--Se eliminan las tablas en caso de que ya existan.
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

--Definición del esquema DDL.
-- Creamos tabla de categorias.
CREATE TABLE categorias (
  id_categoria	INT	PRIMARY KEY,
  nombre_categoria	VARCHAR(50)	NOT NULL,
  descripcion	VARCHAR(200)
);

--Creamos tabla de Clientes.
CREATE TABLE clientes (
   id_cliente INT PRIMARY KEY,
   nombre VARCHAR(100) NOT NULL,
   email VARCHAR(100) UNIQUE,
   ciudad VARCHAR(50),	
   fecha_registro DATE NOT NULL
);

--Creamos tabla de productos.
CREATE TABLE productos (
   id_producto INT PRIMARY KEY,
   nombre_producto VARCHAR(100) NOT NULL,
   id_categoria INT, FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
   precio DECIMAL(10,2) NOT NULL,
   stock INT DEFAULT 0,
   aactivo SMALLINT DEFAULT 1
);

--Creamos tabla de ventas.
CREATE TABLE ventas (
   id_venta INT PRIMARY KEY,
   id_cliente INT,FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), 
   id_producto INT, FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
   cantidad INT NOT NULL,
   precio_unitario DECIMAL(10,2) NOT NULL,
   fecha_venta DATE NOT NULL
);

--------------------------------------------------------------------------
--Definicion del esquema DML
--Insertamos al menos 3 categorias diferentes
INSERT INTO categorias 
VALUES 
    (1, 'Computación', 'Laptops, PCs y monitores'),
	(2, 'Accesorios', 'Periféricos y complementos'),
	(3, 'Audio', 'Auriculares y parlantes'),
	(4, 'Almacenamiento', 'Discos y memorias');

--Insertamos al menos 3 clientes.
INSERT INTO clientes 
VALUES 
    (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05'),
	(2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10'),
	(3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01'),
	(4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15'),
	(5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

--Insertamos al menos 5 productos distribuidos en esas categorías.
INSERT INTO productos 
VALUES 
    (1, 'Laptop Pro 15',       1, 1200.00, 15, 1),
	(2, 'Mouse Inalámbrico',   2,   28.00, 80, 1),
	(3, 'Monitor 4K 27"',      1,  450.00, 12, 1),
	(4, 'Auriculares BT Pro',  3,  120.00, 35, 1),
	(5, 'SSD Externo 1TB',     4,  130.00, 18, 1),
	(6, 'Teclado Mecánico',    2,   95.00, 40, 1);

--Instertamos al menos 10 transacciones de venta para que tengamos datos que analizar después.
INSERT INTO ventas 
VALUES 
    (1,  1, 1, 2, 1200.00, '2024-03-05'),
	(2,  2, 2, 5,   28.00, '2024-03-06'),
	(3,  3, 3, 1,  450.00, '2024-03-07'),
	(4,  1, 4, 2,  120.00, '2024-03-08'),
	(5,  4, 5, 3,  130.00, '2024-03-10'),
	(6,  2, 6, 4,   95.00, '2024-03-11'),
	(7,  5, 1, 1, 1200.00, '2024-03-12'),
	(8,  3, 2, 8,   28.00, '2024-03-13'),
	(9,  4, 4, 1,  120.00, '2024-03-14'),
	(10, 5, 3, 2,  450.00, '2024-03-15');

-- Confirmo que cada tabla se cargó correctamente
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

---------------------------------------------------------------
--TP Modulo 4
--Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    ROUND(SUM(cantidad * precio_unitario) / COUNT(id_venta), 2) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

--Consulta 2 — Ranking de productos Top 5 productos por facturación.
SELECT
id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

--Consulta 3 — Clientes recurrentes.
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

--Consulta 4 — Meses por encima/por debajo del promedio.
SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
        (SELECT AVG(total_mes)
         FROM(
          SELECT SUM(cantidad * precio_unitario) AS total_mes
          FROM ventas
          GROUP BY EXTRACT(MONTH FROM fecha_venta)) promedio_mensual)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

-- El ranking permite identificar los cinco productos que generan mayor facturación. Estos productos representan los principales generadores de ingresos del negocio, por lo que conviene asegurar su disponibilidad de stock y considerar acciones comerciales para potenciar aún más sus ventas.

-- Los clientes recurrentes constituyen una base importante para el negocio, ya que presentan mayor fidelización y generan ingresos repetidos. Este grupo es un buen candidato para implementar programas de beneficios o promociones exclusivas.

-- El análisis mensual permite identificar la evolución de la facturación y del ticket promedio. Los meses con mayor facturación representan oportunidades para analizar qué factores impulsaron las ventas (promociones, estacionalidad o mayor demanda), mientras que los meses con menor desempeño requieren estrategias comerciales para incrementar los ingresos.

-- Comparar cada mes con el promedio general permite detectar períodos de alto y bajo rendimiento. Esta información facilita la toma de decisiones comerciales y ayuda a investigar las causas de las variaciones observadas.
