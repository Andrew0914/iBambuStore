CREATE DATABASE bambu_store;
use bambu_store;
-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-09-2015 a las 04:19:50
-- Versión del servidor: 5.6.19
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bambu_store`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE IF NOT EXISTS `compras` (
  `id_compra` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_compra` date DEFAULT NULL,
  `subtotal_compra` float DEFAULT NULL,
  `iva_compra` float DEFAULT NULL,
  `total_compra` float DEFAULT NULL,
  `credito` int(1) DEFAULT NULL,
  `proveedor` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_compra`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `fecha_compra`, `subtotal_compra`, `iva_compra`, `total_compra`, `credito`, `proveedor`) VALUES
(1, '2015-07-04', 862.07, 137.93, 1000, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras_detalles`
--

CREATE TABLE IF NOT EXISTS `compras_detalles` (
  `id_compraDeta` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` varchar(20) DEFAULT NULL,
  `id_compra` int(3) DEFAULT NULL,
  `cantidad_productos` int(3) DEFAULT NULL,
  `subtotal_cdeta` float DEFAULT NULL,
  `iva_cdeta` float DEFAULT NULL,
  `total_cdeta` float DEFAULT NULL,
  PRIMARY KEY (`id_compraDeta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `compras_detalles`
--

INSERT INTO `compras_detalles` (`id_compraDeta`, `id_producto`, `id_compra`, `cantidad_productos`, `subtotal_cdeta`, `iva_cdeta`, `total_cdeta`) VALUES
(1, '7501037000009', 1, 100, 862.069, 137.931, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` varchar(20) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `medida` varchar(20) DEFAULT NULL,
  `unidad` varchar(10) NOT NULL,
  `precio` float DEFAULT NULL,
  `hasCode` int(2) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `medida`, `unidad`, `precio`, `hasCode`) VALUES
('75003173', 'Boing', '500', 'ml', 9, NULL),
('7501037000009', 'Corrector', '20', 'ml', 10, 1),
('azucar', 'Azucar', '2', 'Kg', 9, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_proveedor` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `empresa` varchar(40) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `nombre_distribuidor` varchar(20) DEFAULT NULL,
  `paterno_distribuidor` varchar(20) NOT NULL,
  `materno_distribuidor` varchar(20) NOT NULL,
  `correo` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `empresa`, `telefono`, `nombre_distribuidor`, `paterno_distribuidor`, `materno_distribuidor`, `correo`) VALUES
(3, 'Cooperativa Pascual S.A de C.V', 55314024, 'Andrew ', 'Gonzalez', 'Miranda', 'a_gonzalez@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE IF NOT EXISTS `ventas` (
  `idVenta` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_venta` date DEFAULT NULL,
  `subtotal_venta` float DEFAULT NULL,
  `iva_venta` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_detalles`
--

CREATE TABLE IF NOT EXISTS `ventas_detalles` (
  `id_ventaDeta` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `id_producto` varchar(20) DEFAULT NULL,
  `idVenta` int(3) DEFAULT NULL,
  `cantidad_productos` float DEFAULT NULL,
  `subtotal_vdeta` float DEFAULT NULL,
  `iva_dveta` float DEFAULT NULL,
  `total_vdeta` float DEFAULT NULL,
  PRIMARY KEY (`id_ventaDeta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
