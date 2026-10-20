# outer-joins-ministore
Práctica de SQL sobre LEFT, RIGHT y FULL OUTER JOIN para auditar inventario y ventas


# MiniStore - Outer JOINs en SQL

## Objetivo

Analizar el catálogo de productos y el historial de ventas de MiniStore mediante LEFT JOIN, RIGHT JOIN y FULL OUTER JOIN, identificando productos sin ventas y registros de ventas que no tienen correspondencia en el catálogo.

## Estructura del repositorio

- `schema.sql`: crea las tablas productos y ventas y carga los datos de prueba.
- `soluciones.sql`: contiene las tres consultas SQL solicitadas.
- `README.md`: documenta el objetivo y las decisiones tomadas en las consultas.

## 1. ¿Por qué usar LEFT JOIN y no INNER JOIN?

Se utiliza LEFT JOIN porque la tabla productos debe conservar todos los registros del catálogo, incluso cuando un producto no tiene ventas asociadas.

Un INNER JOIN devuelve únicamente las filas que tienen coincidencias en ambas tablas. Por lo tanto, los productos 108 (Hub USB-C 7p) y 109 (Parlante Bluetooth) quedarían excluidos del resultado, ya que nunca fueron vendidos.

En cambio, LEFT JOIN conserva esos productos y devuelve NULL en las columnas de ventas, lo que permite identificar los productos sin movimientos comerciales.

## 2. ¿Por qué usar RIGHT JOIN en la Consulta 2?

Se utiliza RIGHT JOIN porque el objetivo es conservar todas las filas de la tabla ventas, incluso cuando el producto vendido no existe en el catálogo.

En la consulta, productos se encuentra a la izquierda del JOIN y ventas a la derecha. Por este motivo, todas las ventas se conservan en el resultado, aunque no exista una coincidencia en productos.

La venta 10 tiene producto_id = 999, un identificador que no existe en el catálogo. El RIGHT JOIN permite conservar ese registro y detectar la falta de correspondencia.

## 3. ¿Qué representan los valores NULL?

Los valores NULL indican que no existe un dato coincidente en la otra tabla para la unión realizada. No representan necesariamente un error del sistema: su significado depende del contexto.

En la Consulta 1, venta_id = NULL indica que un producto del catálogo no tiene ventas asociadas. Por ejemplo, el producto 108, Hub USB-C 7p, nunca fue vendido.

En la Consulta 2, producto_catalogo_id = NULL indica que una venta no encontró un producto correspondiente en el catálogo. En este caso, la venta 10 tiene producto_id = 999, que no existe en productos.

## 4. ¿Cuándo usar FULL OUTER JOIN en un caso real?

FULL OUTER JOIN resulta útil cuando se necesita comparar dos fuentes de datos y conservar tanto las coincidencias como los registros que aparecen únicamente en una de ellas.

Por ejemplo, una tienda puede comparar su catálogo de productos con el historial de ventas para identificar productos sin movimientos y ventas asociadas a identificadores inexistentes.

En MiniStore, esta consulta permite observar los productos sin ventas, las ventas sin producto correspondiente y los registros que sí coinciden. De esta manera, contribuye a la auditoría de la calidad de los datos y a la detección de inconsistencias antes de elaborar reportes de negocio.

## Conclusión

Las uniones externas permiten analizar información incompleta sin perder los registros relevantes. Su elección depende de qué tabla se necesita conservar y qué tipo de inconsistencias se busca detectar.
