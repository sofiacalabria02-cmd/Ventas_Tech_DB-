# Ventas_Tech_DB-
## Descripción del proyecto
Este proyecto fue realizado como parte del Módulo 4 del curso.
El objetivo es analizar la información de ventas de una empresa de tecnología mediante consultas SQL que permitan obtener indicadores de negocio, como la facturación mensual, el ranking de productos más vendidos, los clientes recurrentes y el desempeño de las ventas por mes.
La base de datos está compuesta por las tablas:
- Clientes
- Productos
- Categorías
- Ventas
-----------------------------------------------------------------

## Contenido del repositorio
- `m3_ddl_dml.sql`: creación de la base de datos, tablas e inserción de datos.
- `m4_consultas_negocio.sql`: consultas SQL orientadas al análisis de negocio.
- `README.md`: descripción del proyecto e instrucciones de uso.
-----------------------------------------------------------------

## Cómo ejecutar el proyecto
1. Crear la base de datos en PostgreSQL.
2. Ejecutar el archivo `m3_ddl_dml.sql` para crear las tablas e insertar los datos.
3. Ejecutar el archivo `m4_consultas_negocio.sql` para obtener los resultados de las consultas analíticas.
----------------------------------------------------------------

## Consultas implementadas
El proyecto incluye las siguientes consultas:
1. Resumen ejecutivo mensual:
   - Total facturado.
   - Cantidad de pedidos.
   - Ticket promedio.
2. Ranking de los cinco productos con mayor facturación.
3. Identificación de clientes recurrentes.
4. Comparación de la facturación mensual respecto del promedio general mediante el uso de `CASE WHEN` y subconsultas.

----------------------------------------------------------------
--Modulo 5
--Se utilizó la base de datos Ventas_Tech_DB, desarrollada en los módulos anteriores, compuesta por las siguientes tablas:
--ventas, clientes, productos y categorias.
--Aclaración sobre la consigna:
--La consigna hace referencia a una tabla territorios y a los campos segmento, región y canal (Online/Presencial).
--Sin embargo, dichos elementos no forman parte del modelo de datos construido en los módulos anteriores ni de la base de datos utilizada para este proyecto.
--Por este motivo, las consultas fueron adaptadas utilizando únicamente la información disponible.

