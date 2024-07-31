INSERT INTO categorias (id_categoria, descripcion, estado) VALUES 
(1, 'Electrónicos', 1),
(2, 'Perifericos', 1),
(3, 'Celulares', 1),
(4, 'Computadores', 1),
(5, 'Ropa', 1),
(6, 'Frutas', 1),
(7, 'Otros', 1);
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES 
('Televisor', 1, '1234567890123', 299.99, 50, 1),
('Pantalla', 2, '68453241323', 99.99, 40, 1),
('Xiaomi Note9', 3, '546511', 399.99, 90, 1),
('Laptop RTX 3060', 4, '78535345', 9.99, 60, 1),
('falda', 5, '65462132', 49.99, 48, 1),
('manzana', 6, '86456242', 98.99, 13, 1),
('cuaderno', 7, '6542301', 20.99, 15, 1),
('Roku', 1, '54321354', 29.99, 78, 1);
INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) VALUES 
('1009486253', 'Juan', 'Pérez', 9876543210, 'Calle 489#654-45', 'juan.perez@gmail.com'),
('78954654', 'Jholver', 'Pardo', 6874564, 'Carrera 654#654-45', 'Jholver@gmail.com');
INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado) VALUES 
('1009486253', NOW(), 'E', 'Compra de productos electrónicos', 'A');
INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado) VALUES 
(1, 1, 2, 599.98, 1);

