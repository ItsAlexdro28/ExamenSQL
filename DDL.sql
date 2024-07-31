DROP DATABASE IF EXISTS miscompras;
CREATE DATABASE miscompras;

USE miscompras;

CREATE TABLE categorias (
    id_categoria INT,
    descripcion VARCHAR(45),
    estado TINYINT,
    CONSTRAINT pk_categorias_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(45),
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16,2),
    cantidad_stock INT,
    estado TINYINT,
    CONSTRAINT pk_productos_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_productos_categorias_id_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes (
    id VARCHAR(20),
    nombre VARCHAR(40),
    apellidos VARCHAR(100),
    celular DECIMAL(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),
    CONSTRAINT pk_clientes_id PRIMARY KEY (id)
);

CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATETIME,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    CONSTRAINT pk_compras_id_compra PRIMARY KEY (id_compra),
    CONSTRAINT fk_compras_clientes_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE compras_productos (
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total DECIMAL(16,2),
    estado TINYINT,
    CONSTRAINT pk_compras_productos_id_compra_id_producto PRIMARY KEY (id_compra, id_producto),
    CONSTRAINT fk_compras_productos_compras_id_compra FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    CONSTRAINT fk_compras_productos_producto_id_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);