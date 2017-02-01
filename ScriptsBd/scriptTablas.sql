CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(45) NOT NULL,
  `apellidos` varchar(90) NOT NULL,
  `dni` varchar(90) NOT NULL,
  `email` varchar(90) NOT NULL,
  `pass` varchar(90) DEFAULT NULL,
  `claveCompra` varchar(90) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_nacimiento` varchar(90) NOT NULL,
  `rol` varchar(10) NOT NULL DEFAULT 'user',
  `nick` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `poblacion` varchar(45) DEFAULT NULL,
  `cpostal` int(5) DEFAULT NULL,
  `provincia` varchar(10) DEFAULT NULL,
  `telefono` int(9) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`,`dni`,`email`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `nick_UNIQUE` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8$$


CREATE TABLE `comentario` (
  `id_reloj` decimal(10,0) DEFAULT NULL,
  `titulo` varchar(45) NOT NULL,
  `descripcion` varchar(90) NOT NULL,
  `valoracion` decimal(10,0) NOT NULL,
  `loguin` varchar(90) NOT NULL,
  `fecha_publicacion` datetime DEFAULT NULL,
  `puntuacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$

delimiter $$

CREATE TABLE `reloj` (
  `id_cod__inversion` decimal(10,0) NOT NULL DEFAULT '2',
  `desc_cod_inversion` varchar(45) NOT NULL DEFAULT 'RELOJ',
  `id_reloj` decimal(10,0) NOT NULL,
  `desc_reloj` varchar(45) NOT NULL,
  `prec_compra` double NOT NULL,
  `aduanas` double DEFAULT NULL,
  `prec_venta` double NOT NULL,
  `comisiones_pm` double DEFAULT NULL,
  `gastos_correos` double NOT NULL,
  `imagen_reloj` varchar(45) DEFAULT NULL,
  `fecha_venta` datetime NOT NULL,
  `unidades` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_reloj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$
