-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-06-2021 a las 03:19:57
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `kaimanventasqvalen`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_usuario` (IN `_rut` VARCHAR(20), IN `_nombre` VARCHAR(50), IN `_apellido` VARCHAR(50), IN `_telefono` VARCHAR(20), IN `_correo` VARCHAR(70), IN `_contraseña` VARCHAR(20))  BEGIN
	INSERT INTO clientes (rut, nombre, apellido, telefono, correo, contraseña, fecha_registro_cliente) VALUES (_rut,_nombre,_apellido, _telefono, _correo, _contraseña,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_vendedor` (IN `_rut` VARCHAR(15), IN `_nombre` VARCHAR(50), IN `_apellido` VARCHAR(50), IN `_telefono` VARCHAR(20), IN `_correo` VARCHAR(150), IN `_clave` VARCHAR(15))  BEGIN
	INSERT INTO vendedores(rut,nombre,apellido,telefono,correo,clave) VALUES(_rut,_nombre,_apellido,_telefono,_correo,_clave);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_total_productos_pedido` (IN `_id_pedido` INT)  BEGIN
    SELECT
        detalle_pedido.id_producto,
        detalle_pedido.cantidad,
        detalle_pedido.precio_venta,
        detalle_pedido.cantidad * detalle_pedido.precio_venta AS total_por_producto,
        detalle_pedido.id_pedido
    FROM
        detalle_pedido
    WHERE
        id_pedido = _id_pedido ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_producto` (IN `_nombre` VARCHAR(60), IN `_tipo` VARCHAR(40), IN `_descripcion` VARCHAR(500), IN `_precio` INT, IN `_id_vendedor` INT)  BEGIN
	INSERT INTO productos (nombre,tipo,descripcion,precio,id_vendedor) VALUES (_nombre,_tipo,_descripcion,_precio,_id_vendedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_clientes` ()  BEGIN
    SELECT
        rut, nombre, apellido, telefono, correo
    FROM
        clientes ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_pedidos` (IN `_fecha_pedido` DATE)  BEGIN
    SELECT
        id_pedido,
        id_Cliente,
        id_tipo
    FROM
        pedidos
    WHERE
        fecha_pedido = _fecha_pedido ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_productos` ()  BEGIN
    SELECT
        nombre, precio
    FROM
        productos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_stock_productos` (IN `_id_stock` INT)  BEGIN
    SELECT
        id_producto,
        cantidad,
        id_tipo
    FROM
        detalle_stock_producto
    WHERE
        id_stock = _id_stock ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_cliente` (IN `_rut` VARCHAR(20), IN `nuevo_nombre` VARCHAR(50), IN `nuevo_apellido` VARCHAR(50), IN `nuevo_telefono` VARCHAR(20), IN `nuevo_correo` VARCHAR(70), IN `nuevo_contraseña` VARCHAR(20))  BEGIN
    UPDATE
        clientes
    SET
        nombre = nuevo_nombre,
        apellido = nuevo_apellido,
        telefono = nuevo_telefono,
        correo = nuevo_correo,
        contraseña = nuevo_contraseña
    WHERE
        rut = _rut ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cantidad_compras`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cantidad_compras` (
`COUNT(*)` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_Cliente` int(11) NOT NULL,
  `rut` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `contraseña` varchar(20) NOT NULL,
  `fecha_registro_cliente` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_Cliente`, `rut`, `nombre`, `apellido`, `telefono`, `correo`, `contraseña`, `fecha_registro_cliente`) VALUES
(1, '18275747-0', 'valentina', 'muñoz', '987654321', 'vale@gmail.com', '1234', '2021-06-27'),
(3, '19999999-9', 'antonio', 'toledo', '99999999', 'antonio@gmail.com', 'blabla', '2021-06-28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_stock_producto`
--

CREATE TABLE `detalle_stock_producto` (
  `id_stock` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

CREATE TABLE `direcciones` (
  `id_direccion` int(11) NOT NULL,
  `nombre_calle` varchar(100) NOT NULL,
  `numero_calle` int(11) NOT NULL,
  `adicional` varchar(100) NOT NULL,
  `comuna` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrega`
--

CREATE TABLE `entrega` (
  `id_entrega` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `idTipo_Entrega` int(11) NOT NULL,
  `id_direccion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `entrega_direcciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `entrega_direcciones` (
`id_entrega` int(11)
,`nombre_calle` varchar(100)
,`numero_calle` int(11)
,`adicional` varchar(100)
,`comuna` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `tipo_pago` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_Cliente` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `fecha_registro` date NOT NULL DEFAULT current_timestamp(),
  `fecha_pedido` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `pedidos_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `pedidos_clientes` (
`rut` varchar(20)
,`nombre` varchar(50)
,`apellido` varchar(50)
,`telefono` varchar(20)
,`id_tipo` int(11)
,`fecha_pedido` date
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_Producto` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `tipo` varchar(40) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `precio` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_Producto`, `nombre`, `tipo`, `descripcion`, `precio`, `id_vendedor`) VALUES
(1, 'pan pita', 'pan', 'pan libre de manteca', 200, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `reservas_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `reservas_clientes` (
`id_Cliente` int(11)
,`fecha_pedido` date
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `id_stock` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id_tipo`, `nombre`) VALUES
(1, 'Compra'),
(2, 'Reserva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_entrega`
--

CREATE TABLE `tipo_entrega` (
  `idTipo_Entrega` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_entrega`
--

INSERT INTO `tipo_entrega` (`idTipo_Entrega`, `nombre`) VALUES
(1, 'Retiro'),
(2, 'A_Domicilio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL,
  `rut` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `clave` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id_vendedor`, `rut`, `nombre`, `apellido`, `telefono`, `correo`, `clave`) VALUES
(1, '11.111.111-1', 'nombrevendedor', 'apellidovendedor', '987654321', 'vendedor@gmail.com', 'clavevendedor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_datos_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_datos_clientes` (
`nombre` varchar(50)
,`apellido` varchar(50)
,`telefono` varchar(20)
,`correo` varchar(70)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_precio_producto`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_precio_producto` (
`nombre` varchar(60)
,`precio` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `cantidad_compras`
--
DROP TABLE IF EXISTS `cantidad_compras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cantidad_compras`  AS SELECT count(0) AS `COUNT(*)` FROM `pedidos` WHERE `pedidos`.`id_tipo` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `entrega_direcciones`
--
DROP TABLE IF EXISTS `entrega_direcciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entrega_direcciones`  AS SELECT `entrega`.`id_entrega` AS `id_entrega`, `direcciones`.`nombre_calle` AS `nombre_calle`, `direcciones`.`numero_calle` AS `numero_calle`, `direcciones`.`adicional` AS `adicional`, `direcciones`.`comuna` AS `comuna` FROM (`entrega` join `direcciones` on(`entrega`.`id_direccion` = `direcciones`.`id_direccion`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `pedidos_clientes`
--
DROP TABLE IF EXISTS `pedidos_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pedidos_clientes`  AS SELECT `clientes`.`rut` AS `rut`, `clientes`.`nombre` AS `nombre`, `clientes`.`apellido` AS `apellido`, `clientes`.`telefono` AS `telefono`, `pedidos`.`id_tipo` AS `id_tipo`, `pedidos`.`fecha_pedido` AS `fecha_pedido` FROM (`clientes` join `pedidos` on(`clientes`.`id_Cliente` = `pedidos`.`id_Cliente`)) ORDER BY `clientes`.`rut` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `reservas_clientes`
--
DROP TABLE IF EXISTS `reservas_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reservas_clientes`  AS SELECT `pedidos`.`id_Cliente` AS `id_Cliente`, `pedidos`.`fecha_pedido` AS `fecha_pedido` FROM `pedidos` WHERE `pedidos`.`id_tipo` = 2 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_datos_clientes`
--
DROP TABLE IF EXISTS `vista_datos_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_datos_clientes`  AS SELECT `clientes`.`nombre` AS `nombre`, `clientes`.`apellido` AS `apellido`, `clientes`.`telefono` AS `telefono`, `clientes`.`correo` AS `correo` FROM `clientes` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_precio_producto`
--
DROP TABLE IF EXISTS `vista_precio_producto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_precio_producto`  AS SELECT `productos`.`nombre` AS `nombre`, `productos`.`precio` AS `precio` FROM `productos` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_Cliente`),
  ADD UNIQUE KEY `rut` (`rut`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_pedido`,`id_producto`),
  ADD KEY `fk_detalle_id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_stock_producto`
--
ALTER TABLE `detalle_stock_producto`
  ADD PRIMARY KEY (`id_stock`,`id_producto`,`id_tipo`),
  ADD KEY `fk_stock_id_producto` (`id_producto`),
  ADD KEY `fk_stock_id_tipo` (`id_tipo`);

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`id_direccion`);

--
-- Indices de la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD PRIMARY KEY (`id_entrega`),
  ADD KEY `fk_entrega_id_pedido` (`id_pedido`),
  ADD KEY `fk_entrega_idTipo_Entrega` (`idTipo_Entrega`),
  ADD KEY `fk_entrega_direccion` (`id_direccion`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_id_pedido` (`id_pedido`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `fk_id_Cliente` (`id_Cliente`),
  ADD KEY `fk_id_TIPO` (`id_tipo`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_Producto`),
  ADD KEY `id_vendedor` (`id_vendedor`);

--
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id_stock`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id_tipo`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `tipo_entrega`
--
ALTER TABLE `tipo_entrega`
  ADD PRIMARY KEY (`idTipo_Entrega`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_Cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `id_direccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrega`
--
ALTER TABLE `entrega`
  MODIFY `id_entrega` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_Producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_detalle_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  ADD CONSTRAINT `fk_detalle_id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_Producto`);

--
-- Filtros para la tabla `detalle_stock_producto`
--
ALTER TABLE `detalle_stock_producto`
  ADD CONSTRAINT `fk_detalle_id_stock` FOREIGN KEY (`id_stock`) REFERENCES `stock` (`id_stock`),
  ADD CONSTRAINT `fk_stock_id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_Producto`),
  ADD CONSTRAINT `fk_stock_id_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`);

--
-- Filtros para la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD CONSTRAINT `fk_entrega_direccion` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones` (`id_direccion`),
  ADD CONSTRAINT `fk_entrega_idTipo_Entrega` FOREIGN KEY (`idTipo_Entrega`) REFERENCES `tipo_entrega` (`idTipo_Entrega`),
  ADD CONSTRAINT `fk_entrega_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_id_Cliente` FOREIGN KEY (`id_Cliente`) REFERENCES `clientes` (`id_Cliente`),
  ADD CONSTRAINT `fk_id_TIPO` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
