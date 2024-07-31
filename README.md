# Mis Compras

- [Basicas](#consultas-básicas)
- [Funciones-Agregadas](#consultas-usando-funciones-agregadas)
- [Join](#consultas-usando-join)
- [SubConsultas](#subconsultas)

## Consultas Básicas
#### Consultar todos los productos y sus categorías
```sql
SELECT p.nombre, ca.descripcion, ca.estado
FROM productos p
INNER JOIN categorias ca ON p.id_categoria = ca.id_categoria;
```
#### Consultar todas las compras y los clientes que las realizaron
```sql
SELECT cl.nombre, cl.apellido, co.fecha, co.medio_pago, co.comentario, co.estado
FROM compras co
INNER JOIN clientes cl ON co.id_cliente = cl.id;
```
#### Consultar los productos comprados en una compra específica
```sql
SELECT p.nombre, p.precio_venta, cp.cantidad, cp.total
FROM compras c
INNER JOIN compras_produtos cp ON c.id_compra = cp.id_compra
INNER JOIN productos p ON cp.id_producto = p.id_producto
WHERE c.id_compra = 1;
```
#### Agregar un nuevo producto
```sql
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ('Monitor Compumax', 1, '4864534053', 499.99, 30, 4);
```
#### Actualizar el stock de un producto
```sql
UPDATE productos
SET cantidad_stock = 9
WHERE id_producto = 1;
```
#### Consultar todas las compras de un cliente específico
```sql
SELECT co.id, co.id_cliente, co.fecha, co.medio_pago, co.comentario, co.estado
FROM compras co
WHERE id_cliente = 1009486253;
```
#### Consultar todos los clientes y sus correos electrónicos
```sql
SELECT c.nombre, c.apellido, c.correo_electronico
FROM clientes c;
```
#### Consultar la cantidad total de productos comprados en cada compra
```sql
SELECT cp.id_compra, SUM(cp.cantidad)
FROM compras_productos cp
GROUP BY cp.id_compra;
```
#### Consultar las compras realizadas en un rango de fechas
```sql
SELECT c.id_compra, c.id_cliente, c.fecha, c.medio_pago, c.comentario, c.estado
FROM compras c
WHERE c.fecha BETWEEN '2024-07-01 12:00:00' AND '2024-07-31 12:00:00';
```
## Consultas usando funciones agregadas
#### Contar la cantidad de productos por categoría
```sql
SELECT p.id_categoria, SUM(p.cantidad_stock) AS cantidadProductos
FROM productos p
GROUP BY p.id_categoria;
```
#### Calcular el precio total de ventas por cada cliente
```sql
SELECT c.id_cliente, SUM(cp.total) AS total
FROM compras c
INNER JOIN compras_productos cp ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;
```
#### Calcular el precio promedio de los productos por categoría
```sql
SELECT p.id_categoria, AVG(p.precio_venta) as Promedio
FROM productos p
GROUP BY p.id_categoria;
```
#### Encontrar la fecha de la primera y última compra registrada
```sql
SELECT MAX(c.fecha) AS Ultima, MIN(c.fecha) as Primera
FROM compras c;
```
#### Calcular el total de ingresos por ventas
```sql
SELECT cp.id_compra, SUM(cp.total) as total
FROM compras_productos cp
GROUP BY cp.id_compra;
```
#### Contar la cantidad de compras realizadas por cada medio de pago
```sql
SELECT c.medio_pago, COUNT(c.id_compra) as medioPago
FROM compras c
GROUP BY c.medio_pago; 
```
#### Calcular el total de productos vendidos por cada producto
```sql
SELECT cp.id_producto, SUM(cp.cantidad) AS total
FROM compras_productos cp
GROUP BY cp.id_producto;
```
#### Obtener el promedio de cantidad de productos comprados por compra
```sql
SELECT cp.id_compra, AVG(cp.total) as Promedio
FROM compras_productos cp
GROUP BY cp.id_compra;
```
#### Encontrar los productos con el stock más bajo
```sql
SELECT p.nombre, p.cantidad_stock
FROM productos p
ORDER BY p.cantidad_stock DESC;
```
#### Calcular el total de productos comprados y el total gastado por cliente
```sql
SELECT co.id_cliente, SUM(cp.cantidad) as totalProductos, SUM(cp.total) as totalGasto
from compras_productos cp
INNER JOIN compras co ON cp.id_compra = co.id_compra
GROUP BY co.id_cliente; 
```

## Consultas usando join
#### Consultar todos los productos con sus categorías 
```sql
SELECT p.nombre, p.codigo_barras, p.precio_venta, p.cantidad_stock, p.estado, ca.id_categoria, ca.descripcion, ca.estado
FROM productos p
INNER JOIN categorias ca ON p.id_categoria = ca.id_categoria
```
#### Consultar todas las compras y los clientes que las realizaron
```sql
SELECT co.id_compra, co.fecha, co.medio_pago, co.comentario, co.estado, cl.id, cl.nombre, cl.apellidos, cl.celular, cl.direccion, cl.correo_electronico
FROM compras co
INNER JOIN clientes cl ON co.id_cliente = cl.id;
```
#### Consultar los productos comprados en cada compra
```sql
SELECT co.id_compra, co.fecha, co.medio_pago, co.comentario, p.nombre, p.precio_venta, p.cantidad_stock
FROM compras co
INNER JOIN compras_productos cp ON co.id_compra = cp.id_compra
INNER JOIN productos p ON cp.id_producto = p.id_producto;
```
#### Consultar las compras realizadas por un cliente específico
```sql
SELECT co.fecha, co.medio_pago, co.comentario, co.estado
FROM comrpas co
INNER JOIN clientes cl ON co.id_cliente = cl.id
WHERE cl.id = 1009486253;
```
#### Consultar el total gastado por cada cliente
```sql
SELECT co.id_cliente, SUM(cp.total)
FROM compras_productos cp
INNER JOIN compras co ON cp.id_compra = co.id_compra
GROUP BY co.id_cliente;
```
#### Consultar el stock disponible de productos y su categoría
```sql
SELECT p.nombre, p.cantidad_stock, ca.descripcion, ca.estado
FROM productos p
INNER JOIN categorias ca ON p.id_categoria = ca.id_categoria;
```
#### Consultar los detalles de compras junto con la información del cliente y el producto
```sql
SELECT cp.cantidad, cp.total, cp.estado, cl.nombre, cl.apellidos, cl.celular, cl.direccion, cl.correo_electronico, co.fecha, co.medio_pago, co.comentario, co.estado
FROM compras_productos cp
INNER JOIN compras co ON cp.id_compra = co.id_compra
INNER JOIN clientes cl ON co.id_cliente = cl.id;
```
#### Consultar los productos que han sido comprados por más de una cantidad específica
```sql
SELECT p.nombre, p.precio_venta, cp.cantidad
FROM productos p
INNER JOIN compras_productos cp ON p.id_producto = cp.id_producto
WHERE cp.cantidad > 3;
```
#### Consultar la cantidad total de productos vendidos por categoría
```sql
SELECT ca.id_categoria, ca.descripcion, COUNT(p.id_producto)
FROM productos p
INNER JOIN categorias ca ON p.id_categoria = ca.id_categoria
GROUP BY ca.id_categoria;
```
#### Consultar los clientes que han realizado compras en un rango de fechas específico
```sql
SELECT c.id_compra, cl.nombre, cl.apellidos
FROM compras c
INNER JOIN clientes cl ON c.id_cliente = cl.id
WHERE c.fecha BETWEEN '2024-07-01 12:00:00' AND '2024-07-31 12:00:00';
```
#### Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados
```sql
SELECT cl.id, cl.nombre, cl.apellidos, SUM(cp.cantidad), SUM(cp.total)
FROM clientes cl
INNER JOIN compras co ON cl.id = co.id_cliente
INNER JOIN compras_productos cp ON co.id_compra = cp.id_compra
GROUP BY cl.id;
```
#### Consultar los productos que nunca han sido comprados
```sql
SELECT p.id_producto, p.nombre
FROM productos p
LEFT JOIN compras_productos cp ON p.id_producto = cp.id_producto
WHERE cp.id_producto IS NULL;
```
#### Consultar los clientes que han realizado más de una compra y el total gastado por ellos
```sql
SELECT co.id_cliente, COUNT(co.id_cliente), SUM(cp.total)
FROM compras co
INNER JOIN compras_productos cp ON co.id_compra = cp.id_compra
GROUP BY co.id_compra
HAVING COUNT(co.id_cliente) > 1;
```
#### Consultar los productos más vendidos por categoría
```sql
SELECT SUM(cp.cantidad), p.id_categoria
FROM compras_productos cp
INNER JOIN productos p ON cp.id_producto = p.id_producto
GROUP BY p.id_categoria;
```
#### Consultar las compras realizadas por clientes de una ciudad específica y el total gastado
```sql
-- ??? nose
```
#### Consultar los proveedores que han suministrado productos y la cantidad total suministrada 
```sql
-- no se puede, no hay tabla de proveedores ni ningun campo para poder consultar los mismos
```

## Subconsultas
#### Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos
```sql
SELECT p.id_producto, p.nombre, p.precio_venta 
FROM productos p
WHERE p.precio_venta > (
    SELECT AVG(sp.precio_venta)
    FROM productos sp
);
```
#### Consultar los clientes que han gastado más del promedio general en sus compras
```sql
SELECT cl.id, SUM(cp.total)
FROM compras_productos cp
INNER JOIN compras co ON cp.id_compra = co.id_compra
INNER JOIN clientes cl ON co.id_cliente = cl.id
GROUP BY cl.id
HAVING SUM(cp.total) > (
    SELECT AVG(scp.total)
    FROM compras_productos scp
);
```
#### Consultar las categorías que tienen más de 5 productos
```sql
SELECT categorias, NroProductos
FROM (
    SELECT sp.id_categoria AS categorias, COUNT(sp.id_producto) AS NroProductos
    FROM productos sp
    GROUP BY sp.id_categoria
    ORDER BY COUNT(sp.id_producto) ASC
) AS sub
WHERE categorias > 5;
```
#### Consultar los productos más vendidos (top 5) por categoría
```sql
-- nose
```
#### Consultar los clientes que han realizado compras en los últimos 30 días
```sql
SELECT cl.id, cl.nombre, cl.apellidos
FROM clientes cl
WHERE cl.id IN (
    SELECT sco.id_cliente
    FROM compras sco
    WHERE sco.fecha >= NOW() - INTERVAL 30 DAY
);
```
#### Consultar las compras y sus productos para un cliente específico, mostrando solo las compras más recientes
```sql

```
#### Consultar las categorías que tienen productos con un stock por debajo del promedio general
```sql

```
#### Consultar los productos que han sido comprados por todos los clientes
```sql

```
#### Consultar las compras que tienen más productos que el promedio de productos por compra
```sql

```
#### Consultar los productos que se han vendido menos de la cantidad promedio de productos vendidos
```sql

```