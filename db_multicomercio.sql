-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: db:3306
-- Tiempo de generación: 26-06-2026 a las 03:10:07
-- Versión del servidor: 10.4.28-MariaDB-1:10.4.28+maria~ubu2004
-- Versión de PHP: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_multicomercio`
--
CREATE DATABASE IF NOT EXISTS `db_multicomercio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_multicomercio`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-1b6453892473a467d07372d45eb05abc2031647a', 'i:1;', 1782404700),
('laravel-cache-1b6453892473a467d07372d45eb05abc2031647a:timer', 'i:1782404700;', 1782404700),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1782282603),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1782282603;', 1782282603),
('laravel-cache-77de68daecd823babbb58edb1c8e14d7106e83bb', 'i:1;', 1782404648),
('laravel-cache-77de68daecd823babbb58edb1c8e14d7106e83bb:timer', 'i:1782404648;', 1782404648),
('laravel-cache-da4b9237bacccdf19c0760cab7aec4a8359010b0', 'i:1;', 1782404542),
('laravel-cache-da4b9237bacccdf19c0760cab7aec4a8359010b0:timer', 'i:1782404542;', 1782404542),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:1;', 1782418302),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1782418302;', 1782418302),
('laravel-cache-livewire-rate-limiter:a31bbf16a9446b2e53785fb3a6de7129c3869e22', 'i:1;', 1782321868),
('laravel-cache-livewire-rate-limiter:a31bbf16a9446b2e53785fb3a6de7129c3869e22:timer', 'i:1782321868;', 1782321868);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
CREATE TABLE `calificaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `calificacion` tinyint(3) UNSIGNED NOT NULL,
  `comentario` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`id`, `user_id`, `producto_id`, `calificacion`, `comentario`, `created_at`, `updated_at`) VALUES
(1, 5, 17, 3, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(2, 5, 22, 1, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 6, 6, 3, 'Consectetur ut et magnam incidunt quod.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(4, 6, 7, 2, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 7, 9, 2, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(6, 7, 19, 3, 'Iusto repellat dicta necessitatibus voluptatum.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(7, 8, 18, 4, 'Eaque distinctio qui sunt odit dolorem optio ullam voluptate.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(8, 8, 27, 4, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(9, 9, 12, 1, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(10, 9, 21, 3, 'Quo qui nemo rerum dicta.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(11, 10, 3, 2, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(12, 10, 8, 5, NULL, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(13, 11, 17, 2, 'Eveniet officia doloribus adipisci ducimus harum vel.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(14, 11, 34, 3, 'Temporibus rem quis vel tempora.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(15, 12, 6, 4, 'Eum enim aperiam illo dolorem consequatur.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(16, 12, 21, 3, 'Iure quasi quo possimus et provident temporibus reprehenderit.', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(17, 13, 1, 5, 'Excelente producto, muy recomendado.', '2026-06-24 10:48:17', '2026-06-24 10:48:17'),
(18, 13, 2, 4, NULL, '2026-06-24 12:06:13', '2026-06-24 12:06:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `icono_url` varchar(500) DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `icono_url`, `activa`, `created_at`, `updated_at`) VALUES
(1, 'Restaurantes', 'Comida preparada y a domicilio', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(2, 'Farmacias', 'Medicamentos y productos de salud', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(3, 'Supermercados', 'Abarrotes y productos del hogar', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(4, 'Tiendas', 'Comercios y artículos varios', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(5, 'Cafeterías', 'Café, panadería y repostería', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(6, 'Ferreterías', 'Herramientas y materiales', NULL, 1, '2026-06-23 22:07:33', '2026-06-23 22:07:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

DROP TABLE IF EXISTS `detalle_pedidos`;
CREATE TABLE `detalle_pedidos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pedido_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 43.44, 43.44, '2026-06-24 06:38:38', '2026-06-24 06:38:38'),
(2, 1, 2, 2, 4.58, 9.16, '2026-06-24 06:38:38', '2026-06-24 06:38:38'),
(3, 1, 6, 2, 1.45, 2.90, '2026-06-24 06:38:38', '2026-06-24 06:38:38'),
(4, 5, 1, 1, 36.92, 36.92, '2026-06-24 17:22:01', '2026-06-24 17:22:01'),
(5, 6, 1, 2, 8.49, 16.98, '2026-06-25 03:20:13', '2026-06-25 03:20:13'),
(6, 7, 1, 1, 5.09, 5.09, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(7, 8, 13, 2, 3.50, 7.00, '2026-06-25 18:58:08', '2026-06-25 18:58:08'),
(8, 9, 34, 2, 3.25, 6.50, '2026-06-25 19:07:12', '2026-06-25 19:07:12'),
(9, 10, 1, 4, 5.09, 20.36, '2026-06-25 20:10:11', '2026-06-25 20:10:11'),
(10, 10, 3, 2, 11.04, 22.08, '2026-06-25 20:10:11', '2026-06-25 20:10:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE `direcciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `referencia` varchar(255) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `predeterminada` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`id`, `user_id`, `nombre`, `direccion`, `referencia`, `latitud`, `longitud`, `predeterminada`, `created_at`, `updated_at`) VALUES
(1, 5, 'Trabajo', '7328 Hipolito Meadow', NULL, 13.73714800, -89.13742500, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(2, 6, 'Oficina', '833 Mellie Club', NULL, 13.78709100, -89.27968500, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 7, 'Oficina', '545 Pouros Roads', NULL, 13.73680800, -89.13998000, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(4, 8, 'Casa', '141 Maurice Light', NULL, 13.79950200, -89.19445100, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 8, 'Oficina', '7434 Liana Courts Apt. 634', NULL, 13.64633500, -89.19055600, 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(6, 9, 'Oficina', '2672 Lolita Prairie Suite 746', 'Est labore sunt et.', 13.72952700, -89.27840500, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(7, 10, 'Oficina', '30687 Zemlak Neck Suite 828', 'Aut ipsam ex ea quo.', 13.68309600, -89.19095800, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(8, 10, 'Casa de mamá', '477 Kshlerin Dale', NULL, 13.67994100, -89.10673000, 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(9, 11, 'Casa', '85364 Everett Radial Apt. 539', NULL, 13.66890400, -89.17063500, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(10, 12, 'Oficina', '48819 Collins Camp Apt. 307', NULL, 13.74462800, -89.20447400, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(11, 12, 'Oficina', '216 Hilpert Unions', 'Necessitatibus suscipit sed eligendi eveniet sed.', 13.77436400, -89.27208700, 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(12, 13, 'prueba', 'Colonia Ciudad Real', NULL, NULL, NULL, 1, '2026-06-24 06:33:51', '2026-06-24 06:33:51'),
(13, 16, 'Casa', 'Ciudad Real', NULL, NULL, NULL, 1, '2026-06-24 17:15:50', '2026-06-24 17:15:50'),
(14, 15, 'ues', 'fmo ues', NULL, NULL, NULL, 1, '2026-06-25 18:55:51', '2026-06-25 18:55:51'),
(15, 18, 'Casa', 'Ues', NULL, NULL, NULL, 1, '2026-06-25 20:08:17', '2026-06-25 20:08:17'),
(16, 18, 'Trabajo', 'ues', NULL, NULL, NULL, 0, '2026-06-25 20:08:40', '2026-06-25 20:08:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad`
--

DROP TABLE IF EXISTS `disponibilidad`;
CREATE TABLE `disponibilidad` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sucursal_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `stock_minimo` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `disponibilidad`
--

INSERT INTO `disponibilidad` (`id`, `sucursal_id`, `producto_id`, `stock`, `stock_minimo`, `disponible`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 32, 5, 1, '2026-06-23 22:07:34', '2026-06-25 20:10:11'),
(2, 2, 1, 55, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 1, 2, 75, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(4, 2, 2, 77, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 1, 3, 57, 5, 1, '2026-06-23 22:07:34', '2026-06-25 20:10:11'),
(6, 2, 3, 15, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(7, 1, 4, 98, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(8, 2, 4, 88, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(9, 1, 5, 31, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(10, 2, 5, 58, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(11, 1, 6, 73, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(12, 2, 6, 73, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(13, 1, 7, 60, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(14, 2, 7, 65, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(15, 1, 8, 84, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(16, 2, 8, 76, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(17, 1, 9, 40, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(18, 2, 9, 83, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(21, 1, 11, 85, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(22, 2, 11, 81, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(23, 1, 12, 19, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(24, 2, 12, 42, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(25, 3, 13, 42, 5, 1, '2026-06-23 22:07:34', '2026-06-25 18:58:08'),
(26, 3, 14, 81, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(27, 3, 15, 46, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(28, 3, 16, 89, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(29, 3, 17, 23, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(30, 3, 18, 77, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(31, 3, 19, 100, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(32, 3, 20, 56, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(33, 3, 21, 86, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(34, 3, 22, 51, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(35, 3, 23, 41, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(36, 3, 24, 16, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(37, 4, 25, 93, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(38, 5, 25, 22, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(39, 4, 26, 60, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(40, 5, 26, 77, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(41, 4, 27, 23, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(42, 5, 27, 97, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(43, 4, 28, 19, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(44, 5, 28, 11, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(45, 4, 29, 95, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(46, 5, 29, 87, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(47, 4, 30, 91, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(48, 5, 30, 43, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(49, 4, 31, 45, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(50, 5, 31, 95, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(51, 4, 32, 68, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(52, 5, 32, 11, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(53, 4, 33, 73, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(54, 5, 33, 86, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(55, 4, 34, 8, 5, 1, '2026-06-23 22:07:34', '2026-06-25 19:07:12'),
(56, 5, 34, 37, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(57, 4, 35, 21, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(58, 5, 35, 95, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(59, 4, 36, 61, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(60, 5, 36, 73, 5, 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivos`
--

DROP TABLE IF EXISTS `dispositivos`;
CREATE TABLE `dispositivos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `fcm_token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `dispositivos`
--

INSERT INTO `dispositivos` (`id`, `user_id`, `fcm_token`, `created_at`, `updated_at`) VALUES
(1, 14, 'cVZ0GJe2QE6lEb4ya3djsx:APA91bG9Hs5_n7nwm04Ew8U_smptTbiH-ag_EqfUuTX9HQhX3OOfWTx_4Olmr6dVYP_WT4DQAp8TSSy5__s6pZYPTLJmRGWmIb3TEN2vKbm1JKMiMX57FxA', '2026-06-24 06:32:51', '2026-06-24 14:37:19'),
(2, 16, 'esN2fCHGQnSvY1E0igqtoI:APA91bGzmWeJGAJSl8RFlLQ2mdocptc2ESTcCgWlqiXHavZ_C86oQksNTwjszpE7v6nPh3DDYxkFC_jLy_sYyi2U-Y3CZt_cFdURC47OfT28H6-A-ET9IYU', '2026-06-24 17:08:05', '2026-06-24 17:08:35'),
(3, 18, 'dIY4qtLyTjyn8HfDwmt590:APA91bGQyWEUpNLGtrbQm8L5I9j7kQytNCnkxf00H0rdU3gdVxyeY6dMGsxXqAT1fJ2TssqlZ6u436tDB_ZiRfeRNdJK_0icKXxrdDg6-0KaUidGM_uGw0c', '2026-06-25 02:54:06', '2026-06-25 19:19:52'),
(4, 17, 'fyB3HP4fT2Sb-EM8YH2T0P:APA91bHZ0oEw6sjqCMUBklKRDsH6v4Zm1yZgrVmC8OBYERVjqmi9AkMStQSGkcBRmydNjMicDPDim0i_dsucX_1Im25kFofTa8fTDsHiZLrX0g-X6JKbxRE', '2026-06-25 19:01:51', '2026-06-25 19:01:51'),
(5, 18, 'cVyyRcI2RNCCoGiNdiWpkc:APA91bHPAzR5sw3kBdjGxj4qxw1RIDm-TVhgctDCD3fXtx1z-kG5owpev3i_2tzI6gHB3g9McuM7v6Uo3u8Z_Vm0iXOsVrZObO5WKcmdgkerANIKBv-0Xi0', '2026-06-25 20:04:11', '2026-06-25 20:04:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `categoria_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `user_id`, `categoria_id`, `nombre`, `descripcion`, `logo_url`, `activa`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Pizza Hut', 'Pizzas artesanales a la leña', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/empresas%2Fpizza_hut_logo.png?alt=media&token=21e8c8b0-227e-4a2d-a5e9-d0e17ffbd982', 1, '2026-06-23 22:07:34', '2026-06-25 16:21:25'),
(2, 3, 2, 'Farmacia Value', 'Medicamentos y cuidado personal', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/empresas%2Ffarmacia_value_logo.png?alt=media&token=ce450524-0283-4e2a-9119-bd5daca2baf5', 1, '2026-06-23 22:07:34', '2026-06-25 16:23:11'),
(3, 4, 3, 'Walmart', 'Alimentos y cosas para el hogar', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/empresas%2Fwalmart_logo.jpg?alt=media&token=c4804b59-efee-4539-a9fc-7caf17c6a58c', 1, '2026-06-23 22:07:34', '2026-06-25 16:24:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
CREATE TABLE `favoritos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id`, `user_id`, `producto_id`, `created_at`) VALUES
(1, 5, 7, '2026-06-23 22:07:34'),
(2, 5, 14, '2026-06-23 22:07:34'),
(3, 5, 28, '2026-06-23 22:07:34'),
(4, 6, 20, '2026-06-23 22:07:34'),
(5, 6, 29, '2026-06-23 22:07:34'),
(6, 6, 30, '2026-06-23 22:07:34'),
(7, 7, 13, '2026-06-23 22:07:34'),
(8, 7, 15, '2026-06-23 22:07:34'),
(9, 7, 25, '2026-06-23 22:07:34'),
(10, 8, 14, '2026-06-23 22:07:34'),
(11, 8, 30, '2026-06-23 22:07:34'),
(12, 8, 33, '2026-06-23 22:07:34'),
(13, 9, 15, '2026-06-23 22:07:34'),
(14, 9, 20, '2026-06-23 22:07:34'),
(15, 9, 29, '2026-06-23 22:07:34'),
(16, 10, 19, '2026-06-23 22:07:34'),
(17, 10, 22, '2026-06-23 22:07:34'),
(18, 10, 31, '2026-06-23 22:07:34'),
(19, 11, 1, '2026-06-23 22:07:34'),
(20, 11, 13, '2026-06-23 22:07:34'),
(21, 11, 23, '2026-06-23 22:07:34'),
(22, 12, 1, '2026-06-23 22:07:34'),
(23, 12, 13, '2026-06-23 22:07:34'),
(24, 12, 20, '2026-06-23 22:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estados_pedido`
--

DROP TABLE IF EXISTS `historial_estados_pedido`;
CREATE TABLE `historial_estados_pedido` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pedido_id` bigint(20) UNSIGNED NOT NULL,
  `estado` varchar(40) NOT NULL,
  `observacion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_estados_pedido`
--

INSERT INTO `historial_estados_pedido` (`id`, `pedido_id`, `estado`, `observacion`, `created_at`) VALUES
(1, 1, 'en_camino', 'ya casi', '2026-06-24 06:41:28'),
(2, 1, 'en_preparacion', NULL, '2026-06-24 06:41:56'),
(3, 1, 'en_camino', NULL, '2026-06-24 06:42:19'),
(4, 5, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-24 17:22:02'),
(5, 5, 'en_camino', NULL, '2026-06-24 17:24:02'),
(6, 6, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-25 03:20:13'),
(7, 7, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-25 17:03:47'),
(8, 7, 'en_preparacion', NULL, '2026-06-25 17:05:08'),
(9, 7, 'en_camino', NULL, '2026-06-25 17:05:27'),
(10, 7, 'entregado', NULL, '2026-06-25 17:05:44'),
(11, 8, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-25 18:58:08'),
(12, 8, 'en_preparacion', NULL, '2026-06-25 18:59:59'),
(13, 9, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-25 19:07:12'),
(14, 10, 'nuevo', 'Pedido creado y pagado con tarjeta (Stripe).', '2026-06-25 20:10:11'),
(15, 10, 'en_preparacion', NULL, '2026-06-25 20:11:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_06_21_201712_create_categorias_table', 1),
(5, '2026_06_21_201743_create_empresas_table', 1),
(6, '2026_06_21_204113_create_subcategorias_table', 1),
(7, '2026_06_21_204138_create_sucursales_table', 1),
(8, '2026_06_21_204153_create_promociones_table', 1),
(9, '2026_06_21_204200_create_productos_table', 1),
(10, '2026_06_21_204209_create_disponibilidad_table', 1),
(11, '2026_06_21_204226_create_promocion_productos_table', 1),
(12, '2026_06_21_204248_create_direcciones_table', 1),
(13, '2026_06_21_204258_create_pedidos_table', 1),
(14, '2026_06_21_204308_create_detalle_pedidos_table', 1),
(15, '2026_06_21_204337_create_historial_estados_pedido_table', 1),
(16, '2026_06_21_204404_create_calificaciones_table', 1),
(17, '2026_06_21_204418_create_favoritos_table', 1),
(18, '2026_06_21_204429_create_notificaciones_table', 1),
(19, '2026_06_21_204440_create_dispositivos_table', 1),
(20, '2026_06_21_211713_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
CREATE TABLE `notificaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `pedido_id` bigint(20) UNSIGNED DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `mensaje` varchar(500) NOT NULL,
  `tipo` varchar(40) DEFAULT NULL,
  `leida` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `user_id`, `pedido_id`, `titulo`, `mensaje`, `tipo`, `leida`, `created_at`) VALUES
(1, 13, 1, 'En camino', 'Tu pedido PED-2026-0001 va en camino', 'estado_entrega', 0, '2026-06-24 06:41:28'),
(2, 13, 1, 'En preparación', 'Tu pedido PED-2026-0001 se está preparando', 'estado_entrega', 0, '2026-06-24 06:41:56'),
(3, 13, 1, 'En camino', 'Tu pedido PED-2026-0001 va en camino', 'estado_entrega', 0, '2026-06-24 06:42:19'),
(4, 16, 5, 'En camino', 'Tu pedido PED-2EAHR5T0 va en camino', 'estado_entrega', 0, '2026-06-24 17:24:02'),
(5, 13, 7, 'En preparación', 'Tu pedido PED-GCFAOUSA se está preparando', 'estado_entrega', 0, '2026-06-25 17:05:08'),
(6, 13, 7, 'En camino', 'Tu pedido PED-GCFAOUSA va en camino', 'estado_entrega', 0, '2026-06-25 17:05:27'),
(7, 13, 7, 'Entregado', 'Tu pedido PED-GCFAOUSA fue entregado, ¡buen provecho!', 'estado_entrega', 0, '2026-06-25 17:05:44'),
(8, 15, 8, 'En preparación', 'Tu pedido PED-FHGDT58U se está preparando', 'estado_entrega', 0, '2026-06-25 18:59:59'),
(9, 18, 10, 'En preparación', 'Tu pedido PED-NUUDQHGJ se está preparando', 'estado_entrega', 0, '2026-06-25 20:11:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero` varchar(30) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `sucursal_id` bigint(20) UNSIGNED NOT NULL,
  `modalidad_entrega` enum('domicilio','retiro') NOT NULL,
  `metodo_pago` enum('tarjeta','contra_entrega') NOT NULL,
  `estado_entrega` enum('nuevo','en_preparacion','en_camino','listo_para_retiro','entregado') NOT NULL DEFAULT 'nuevo',
  `estado_pago` enum('pendiente','pagado') NOT NULL DEFAULT 'pendiente',
  `total` decimal(10,2) NOT NULL,
  `direccion_entrega` varchar(255) DEFAULT NULL,
  `latitud_entrega` decimal(10,8) DEFAULT NULL,
  `longitud_entrega` decimal(11,8) DEFAULT NULL,
  `stripe_payment_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `numero`, `user_id`, `empresa_id`, `sucursal_id`, `modalidad_entrega`, `metodo_pago`, `estado_entrega`, `estado_pago`, `total`, `direccion_entrega`, `latitud_entrega`, `longitud_entrega`, `stripe_payment_id`, `created_at`, `updated_at`) VALUES
(1, 'PED-2026-0001', 13, 1, 1, 'domicilio', 'contra_entrega', 'en_camino', 'pendiente', 61.84, 'Colonia Ciudad Real', NULL, NULL, NULL, '2026-06-24 06:38:38', '2026-06-24 06:42:19'),
(5, 'PED-2EAHR5T0', 16, 1, 1, 'domicilio', 'tarjeta', 'en_camino', 'pagado', 36.92, 'Ciudad Real', NULL, NULL, 'pi_3TluT5DrcKfXUjGO2N9kXZtX', '2026-06-24 17:22:01', '2026-06-24 17:24:02'),
(6, 'PED-7CRKJEKC', 13, 1, 1, 'domicilio', 'tarjeta', 'nuevo', 'pagado', 16.98, 'Colonia Ciudad Real', NULL, NULL, 'pi_3Tm3pODrcKfXUjGO13DIqcsd', '2026-06-25 03:20:13', '2026-06-25 03:20:13'),
(7, 'PED-GCFAOUSA', 13, 1, 1, 'domicilio', 'tarjeta', 'entregado', 'pagado', 5.09, 'Colonia Ciudad Real', NULL, NULL, 'pi_3TmGgLDrcKfXUjGO05gp1U2v', '2026-06-25 17:03:47', '2026-06-25 17:05:44'),
(8, 'PED-FHGDT58U', 15, 2, 3, 'domicilio', 'tarjeta', 'en_preparacion', 'pagado', 7.00, 'fmo ues', NULL, NULL, 'pi_3TmIT6DrcKfXUjGO2Yp70xzb', '2026-06-25 18:58:08', '2026-06-25 18:59:59'),
(9, 'PED-ZPIWQNQX', 15, 3, 4, 'domicilio', 'tarjeta', 'nuevo', 'pagado', 6.50, 'fmo ues', NULL, NULL, 'pi_3TmIZLDrcKfXUjGO0KcrX2ot', '2026-06-25 19:07:12', '2026-06-25 19:07:12'),
(10, 'PED-NUUDQHGJ', 18, 1, 1, 'domicilio', 'tarjeta', 'en_preparacion', 'pagado', 42.44, 'Ues', NULL, NULL, 'pi_3TmJaBDrcKfXUjGO1uqAIvZ5', '2026-06-25 20:10:11', '2026-06-25 20:11:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 13, 'mobile', '07214b69eaee6a8ddd7721a82a40298c6bd96b69c2f3992c6be035213d20184e', '[\"*\"]', '2026-06-24 12:12:13', NULL, '2026-06-24 06:32:51', '2026-06-24 12:12:13'),
(2, 'App\\Models\\User', 14, 'mobile', '50cea22195681781c678e323a24f2aec1445eec0e2ff0b66021343cb00ef5f3a', '[\"*\"]', '2026-06-24 14:37:19', NULL, '2026-06-24 14:37:16', '2026-06-24 14:37:19'),
(3, 'App\\Models\\User', 14, 'mobile', '6c525a3a636845ae385833864e3126956fbec63049351b65acf4ed342a11ebac', '[\"*\"]', NULL, NULL, '2026-06-24 14:37:17', '2026-06-24 14:37:17'),
(4, 'App\\Models\\User', 13, 'mobile', '418b7d5b0803cd1a84191c7f338aea12d17f2b58bc1324fd99e746316340864d', '[\"*\"]', '2026-06-24 17:08:06', NULL, '2026-06-24 17:08:04', '2026-06-24 17:08:06'),
(5, 'App\\Models\\User', 15, 'mobile', 'ace179885ef8be712dcc5dc58c4ac2cebdb990b4bbc32a5ad4e73eb6749fbbf0', '[\"*\"]', '2026-06-24 17:08:26', NULL, '2026-06-24 17:08:25', '2026-06-24 17:08:26'),
(6, 'App\\Models\\User', 16, 'mobile', '21ca591fc5d38bd469a497caa80b5a8e2ca7b26f6aa0d875b9f11990e77d067d', '[\"*\"]', '2026-06-24 17:28:20', NULL, '2026-06-24 17:08:34', '2026-06-24 17:28:20'),
(7, 'App\\Models\\User', 13, 'mobile', 'fdd96676f3236f8c4967bd22206e51df7ba1b57a78a412ab3b9a32b2ece9f936', '[\"*\"]', '2026-06-25 17:07:02', NULL, '2026-06-25 02:54:04', '2026-06-25 17:07:02'),
(8, 'App\\Models\\User', 15, 'mobile', '18f00206be001d61ff7ac0cda4dccb8eb4d7c56f4a188db27cadf70ebdb99dac', '[\"*\"]', '2026-06-25 19:00:48', NULL, '2026-06-25 17:07:41', '2026-06-25 19:00:48'),
(9, 'App\\Models\\User', 17, 'mobile', 'be7ca200471213f5df5f49b5a8b1e38365dfb4effe5f53a953108c1f2333afce', '[\"*\"]', '2026-06-25 19:10:17', NULL, '2026-06-25 19:01:51', '2026-06-25 19:10:17'),
(10, 'App\\Models\\User', 15, 'mobile', 'ac5a7893afc1108064b15a2efca5bd8613a9852e9b8301d894b9bb5dd30d16a8', '[\"*\"]', '2026-06-25 19:07:27', NULL, '2026-06-25 19:03:23', '2026-06-25 19:07:27'),
(11, 'App\\Models\\User', 18, 'mobile', '3b58fae49da27b2612d7293fa9ee899bae1a4be582c041d65b39d36e6c1b5132', '[\"*\"]', '2026-06-25 20:00:17', NULL, '2026-06-25 19:19:51', '2026-06-25 20:00:17'),
(12, 'App\\Models\\User', 18, 'mobile', 'f450ee7cea635dd733d881dc1c3744ce2ce55ac7438f269cb4e325b652ad9dc0', '[\"*\"]', '2026-06-25 20:18:50', NULL, '2026-06-25 20:04:10', '2026-06-25 20:18:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `subcategoria_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen_url` varchar(500) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `empresa_id`, `subcategoria_id`, `nombre`, `descripcion`, `imagen_url`, `precio`, `activo`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'Pizza Pepperoni Personal', 'Pizza individual con abundante pepperoni, salsa de tomate y queso mozzarella fundido sobre masa clásica.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fpizza.jpg?alt=media&token=76d82dd9-ec5d-4d17-996a-60436fbf11e0', 5.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:43:08', NULL),
(2, 1, 1, 'Pizza Hawaiana Mediana', 'Pizza mediana con jamón, piña natural, salsa de tomate y queso mozzarella. Dulce y salado en cada bocado.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fhawai.jpg?alt=media&token=a2d557e9-f6af-4d70-9921-a15c658320fe', 8.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:45:00', NULL),
(3, 1, 1, 'Pizza BBQ Pollo Grande', 'Pizza familiar con pollo a la BBQ, cebolla morada caramelizada, pimiento rojo y doble queso sobre masa pan.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fpollo_bbq.jpeg?alt=media&token=1335c5a5-437f-4814-8607-f759a5f046a7', 12.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:45:29', NULL),
(4, 1, 1, 'Pizza Suprema Familiar', 'Pizza grande con pepperoni, chorizo, champiñones, aceitunas negras, pimiento verde y queso doble.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fsuprema.jpg?alt=media&token=62fabbd1-cc03-4d08-a9cb-e2d2202d111d', 14.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:46:58', NULL),
(5, 1, 2, 'Alitas de Pollo x8', 'Ocho alitas de pollo horneadas y bañadas en salsa búfalo picante. Incluye aderezo ranch para dip.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Falitas.jpg?alt=media&token=44d34b87-c17d-4bb7-a3df-a62d65ce3112', 6.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:48:34', NULL),
(6, 1, 2, 'Pan de Ajo con Queso', 'Pan artesanal horneado con mantequilla de ajo, perejil fresco y queso mozzarella gratinado. Porción de 4 piezas.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fpan_ajo.jpg?alt=media&token=7f614d3f-aa1c-43fe-8964-d4cb5ea0f77c', 3.49, 1, '2026-06-23 22:07:34', '2026-06-25 03:54:04', NULL),
(7, 1, 2, 'Palitos de Queso x6', 'Palitos de queso mozzarella empanizados, fritos hasta quedar dorados. Acompañados de salsa marinara.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Falitas.jpg?alt=media&token=44d34b87-c17d-4bb7-a3df-a62d65ce3112', 4.25, 1, '2026-06-23 22:07:34', '2026-06-25 03:54:29', NULL),
(8, 1, 2, 'Ensalada César Individual', 'Lechuga romana fresca con aderezo César, crutones tostados y queso parmesano rallado.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fcesar-salad.png?alt=media&token=aabe33c4-1dca-4aeb-92d9-d8d63b17100c', 4.50, 1, '2026-06-23 22:07:34', '2026-06-25 03:55:24', NULL),
(9, 1, 3, 'Coca-Cola 600ml', 'Bebida gaseosa Coca-Cola clásica en botella de 600 ml, bien fría para acompañar tu pizza.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fcoca.jpg?alt=media&token=ae0b90ec-f0bc-4fa2-85cb-9beae35faad4', 1.25, 1, '2026-06-23 22:07:34', '2026-06-25 03:55:51', NULL),
(11, 1, 3, 'Agua Purificada 500ml', 'Agua purificada sin gas en botella de 500 ml, opción ligera para acompañar cualquier comida.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fagua.jpg?alt=media&token=9eba9b93-5b75-4184-908f-150fbdc4425f', 0.75, 1, '2026-06-23 22:07:34', '2026-06-25 03:56:15', NULL),
(12, 1, 3, 'Limonada Natural 500ml', 'Limonada preparada con limón fresco, agua mineral y un toque de menta. Refrescante y natural.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Flimonada.jpg?alt=media&token=fc760ec9-9088-49a7-81d2-fe3bf816bb59', 1.99, 1, '2026-06-23 22:07:34', '2026-06-25 03:56:49', NULL),
(13, 2, 4, 'Acetaminofén 500mg x100', 'Analgésico y antipirético para el alivio de dolor leve a moderado y reducción de fiebre. Uso adulto.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Facetaminofen.png?alt=media&token=c4ed579f-00d8-417a-b0ca-2de0edc71f90', 3.50, 1, '2026-06-23 22:07:34', '2026-06-25 04:01:16', NULL),
(14, 2, 4, 'Ibuprofeno 400mg x30', 'Antiinflamatorio no esteroideo indicado para dolor muscular, de cabeza y dental. Uso adulto.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fibuprofeno.jpg?alt=media&token=f3a51314-281f-4236-80c3-48bcf7f5ef5e', 4.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:01:56', NULL),
(15, 2, 4, 'Loratadina 10mg x30', 'Antihistamínico para alivio de síntomas alérgicos: estornudos, picazón ocular y congestión nasal.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Floratadina.jpg?alt=media&token=e9ccfdbd-6f26-45a3-8e51-58dffc43281a', 5.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:02:23', NULL),
(16, 2, 4, 'Omeprazol 20mg x28 cáps', 'Inhibidor de bomba de protones para tratamiento de acidez, reflujo gastroesofágico y úlceras.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fomeprazol.png?alt=media&token=efe0474f-de0e-40e9-bb4e-0fb45a55b62b', 6.75, 1, '2026-06-23 22:07:34', '2026-06-25 04:02:50', NULL),
(17, 2, 5, 'Shampoo Head & Shoulders 400ml', 'Shampoo anticaspa con zinc pyrithione, control clínico desde la primera lavada. Para uso diario.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fheadyshoulders.png?alt=media&token=7c7b3ecc-6024-403e-bc72-2f309e82ec9f', 5.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:03:24', NULL),
(18, 2, 5, 'Crema Hidratante Nivea 400ml', 'Crema corporal con extracto de almendras y vitamina E. Hidratación profunda y duradera por 48 horas.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fnivea.png?alt=media&token=c038603e-76e4-4db0-84f8-49a7884794bf', 7.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:03:52', NULL),
(19, 2, 5, 'Desodorante Degree Men 76g', 'Antitranspirante en barra Degree para hombre. Protección efectiva por 48 horas con fragancia fresca.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fdegree.png?alt=media&token=f20fa0e6-c79a-402b-898d-cf1c63eb716d', 4.50, 1, '2026-06-23 22:07:34', '2026-06-25 04:04:20', NULL),
(20, 2, 5, 'Bloqueador Solar SPF 50+ 90ml', 'Protector solar resistente al agua con SPF 50+, protege contra rayos UVA y UVB. Ideal para uso diario.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2FbloqueadorSolar.jpg?alt=media&token=f25a691e-e0d9-4ef8-ba70-4a71ee52036c', 9.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:05:30', NULL),
(21, 2, 6, 'Vitamina C 1000mg x60', 'Suplemento de vitamina C de alta potencia para fortalecer el sistema inmunológico. Presentación efervescente.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2FvitaminaC.png?alt=media&token=f85322f6-d286-40e9-9f0b-cb516fa34ca8', 8.50, 1, '2026-06-23 22:07:34', '2026-06-25 04:06:00', NULL),
(22, 2, 6, 'Complejo B x50 cáps', 'Suplemento con todas las vitaminas del grupo B para apoyar el metabolismo energético y el sistema nervioso.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2FcomplejoB.webp?alt=media&token=b882a918-3498-44c4-8407-e4ee183910b2', 6.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:06:27', NULL),
(23, 2, 6, 'Omega 3 1000mg x60 cáps', 'Ácidos grasos omega-3 de aceite de pescado purificado. Apoya la salud cardiovascular y la función cerebral.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fomega3.png?alt=media&token=37ed92f6-d88b-4dfa-aea0-d531d0778c1a', 10.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:06:54', NULL),
(24, 2, 6, 'Multivitamínico Adultos x30', 'Fórmula completa de vitaminas y minerales esenciales para adultos. Cubre las necesidades nutricionales diarias.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fmultivitaminicoadultos.png?alt=media&token=7f837a31-2cd0-4762-9ccf-9fa3791c7078', 7.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:07:25', NULL),
(25, 3, 7, 'Leche Entera Lala 1L', 'Leche entera pasteurizada Lala, fuente de calcio y vitaminas A y D. Presentación individual de 1 litro.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fleche.png?alt=media&token=01163104-126e-4184-8ff9-ff9eac78fb72', 1.49, 1, '2026-06-23 22:07:34', '2026-06-25 04:17:00', NULL),
(26, 3, 7, 'Queso Cheddar Rebanado 200g', 'Queso cheddar americano en rebanadas listas para usar. Ideal para sándwiches, hamburguesas y gratinados.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fqueso.png?alt=media&token=63efa481-5aff-4503-8fe7-aaf37ced50c3', 3.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:17:30', NULL),
(27, 3, 7, 'Jamón de Pavo 250g', 'Jamón de pavo bajo en grasa, listo para consumo. Excelente fuente de proteína para el desayuno o almuerzo.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2FjamoPavo.jpg?alt=media&token=d19b6103-70e1-4efa-8bfd-50e75d90b606', 3.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:18:03', NULL),
(28, 3, 7, 'Yogur Natural Great Value 900g', 'Yogur natural sin azúcar añadida, con cultivos activos. Rico en proteína y probióticos para la digestión.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fyogurt.png?alt=media&token=1a9e46b4-4149-4491-9eb8-756731c1bd8a', 5.49, 1, '2026-06-23 22:07:34', '2026-06-25 04:18:50', NULL),
(29, 3, 8, 'Arroz Diana Extra Largo 2kg', 'Arroz blanco extra largo Diana de alta calidad. Grano entero firme con cocción perfecta, no se pega.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2FarrozDiana.png?alt=media&token=dba667a0-4b38-458d-b1ca-4c24fe107fd9', 2.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:19:18', NULL),
(30, 3, 8, 'Frijoles Rojos Great Value 800g', 'Frijoles rojos cocidos enlatados Great Value. Sin conservantes artificiales, ricos en proteína y fibra.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Ffrijoles.png?alt=media&token=3fd90221-7874-4bdf-b940-2eb7a101977d', 1.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:19:47', NULL),
(31, 3, 8, 'Aceite Girasol Great Value 1L', 'Aceite de girasol refinado Great Value, alto en vitamina E. Ideal para freír, hornear y aderezar.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Faceite.png?alt=media&token=c312fa87-2afc-4f4e-950d-c279cfdc1800', 2.49, 1, '2026-06-23 22:07:34', '2026-06-25 04:20:25', NULL),
(32, 3, 8, 'Pasta Barilla Spaghetti 500g', 'Pasta spaghetti Barilla de sémola de trigo duro. Cocción al dente perfecta en 9 minutos.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fspagetti.png?alt=media&token=0dab3f4d-cfe4-4551-9cc3-b34222ed2cd3', 1.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:21:20', NULL),
(33, 3, 9, 'Detergente Ariel Líquido 2L', 'Detergente líquido Ariel con fórmula anti-manchas. Protege los colores y cuida la tela en cada lavado.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fariel.png?alt=media&token=2a5f2234-bd2a-4d52-84ce-85ed8f833039', 6.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:21:52', NULL),
(34, 3, 9, 'Fabuloso Lavanda 2L', 'Limpiador multiusos Fabuloso con fragancia a lavanda. Limpia, desinfecta y deja buen olor en pisos y superficies.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Ffabuloso.jpg?alt=media&token=840aaaa6-f94c-41a7-b8b5-e7f04036d37f', 3.25, 1, '2026-06-23 22:07:34', '2026-06-25 04:22:21', NULL),
(35, 3, 9, 'Papel Higiénico Scott 12 rollos', 'Papel higiénico Scott doble hoja, suave y resistente. Presentación económica familiar de 12 rollos.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fpapelhigienico.jpg?alt=media&token=d7ebd197-3add-48d3-965f-eb19d5ccaa24', 7.50, 1, '2026-06-23 22:07:34', '2026-06-25 04:22:49', NULL),
(36, 3, 9, 'Esponja Scotch-Brite x3', 'Pack de 3 esponjas de cocina Scotch-Brite con fibra verde. Remueve la grasa difícil sin rayar las superficies.', 'https://firebasestorage.googleapis.com/v0/b/app-pedidos-multicomercio.firebasestorage.app/o/productos%2Fesponjas.png?alt=media&token=712c79b7-e4c0-456b-bd93-711ddf251615', 2.99, 1, '2026-06-23 22:07:34', '2026-06-25 04:23:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

DROP TABLE IF EXISTS `promociones`;
CREATE TABLE `promociones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('porcentaje','monto_fijo') NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO `promociones` (`id`, `empresa_id`, `nombre`, `descripcion`, `tipo`, `valor`, `fecha_inicio`, `fecha_fin`, `activa`, `created_at`, `updated_at`) VALUES
(1, 1, 'Promoción Pizza Express', '15% de descuento en productos seleccionados', 'porcentaje', 15.00, '2026-06-22 22:07:34', '2026-07-23 22:07:34', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(2, 2, 'Promoción Farmacia Vida', '15% de descuento en productos seleccionados', 'porcentaje', 15.00, '2026-06-22 22:07:34', '2026-07-23 22:07:34', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 3, 'Promoción Super La Despensa', '15% de descuento en productos seleccionados', 'porcentaje', 15.00, '2026-06-22 22:07:34', '2026-07-23 22:07:34', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_producto`
--

DROP TABLE IF EXISTS `promocion_producto`;
CREATE TABLE `promocion_producto` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `promocion_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `promocion_producto`
--

INSERT INTO `promocion_producto` (`id`, `promocion_id`, `producto_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(4, 2, 15),
(5, 2, 20),
(6, 2, 22),
(7, 3, 25),
(8, 3, 26),
(9, 3, 35);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('S2Di7RuwoQBCiXflLDP731jJzZSqORW5FAyczS6k', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiWEdWWmxtY21yTHpMcEJUTGpYMXVYNmZCcjRLWFlUck92QVVXdEw0TSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9wZWRpZG9zLzEwIjtzOjU6InJvdXRlIjtzOjM3OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMucGVkaWRvcy52aWV3Ijt9czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6Ijc5NmY3NmQ5MjEzOGFhNGRlNWE5NDZjMTkyNjY2ODU2ZTQ1NGJhMjg4ODMzMmI0ZmRmYjNkYjJmNzc2YzVkZGUiO3M6NjoidGFibGVzIjthOjE6e3M6NDA6IjFiZGYyZGMxY2JlYzUyN2ZjYzJmYzUxZDFkMmNiZWVhX2NvbHVtbnMiO2E6OTp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6Im51bWVybyI7czo1OiJsYWJlbCI7czozOiJOwrAiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjk6InVzZXIubmFtZSI7czo1OiJsYWJlbCI7czo3OiJDbGllbnRlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxNDoiZW1wcmVzYS5ub21icmUiO3M6NToibGFiZWwiO3M6NzoiRW1wcmVzYSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTU6InN1Y3Vyc2FsLm5vbWJyZSI7czo1OiJsYWJlbCI7czo4OiJTdWN1cnNhbCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTc6Im1vZGFsaWRhZF9lbnRyZWdhIjtzOjU6ImxhYmVsIjtzOjk6Ik1vZGFsaWRhZCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTQ6ImVzdGFkb19lbnRyZWdhIjtzOjU6ImxhYmVsIjtzOjc6IkVudHJlZ2EiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjExOiJlc3RhZG9fcGFnbyI7czo1OiJsYWJlbCI7czo0OiJQYWdvIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJ0b3RhbCI7czo1OiJsYWJlbCI7czo1OiJUb3RhbCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjg7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6NToiRmVjaGEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fX19', 1782418269),
('TDU5k7nEEkE0JR6UL7R4mrNLMcM7WgnVymvz33ih', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ05IaHdyWkt5OHdPSEN5cENZSDJTTnd3Z01ZZUFhZDRDV0F1dmcwZSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9sb2dpbiI7czo1OiJyb3V0ZSI7czoyNToiZmlsYW1lbnQuYWRtaW4uYXV0aC5sb2dpbiI7fX0=', 1782415013);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategorias`
--

DROP TABLE IF EXISTS `subcategorias`;
CREATE TABLE `subcategorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `subcategorias`
--

INSERT INTO `subcategorias` (`id`, `empresa_id`, `nombre`, `orden`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pizzas', 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(2, 1, 'Entradas y Complementos', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 1, 'Bebidas', 2, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(4, 2, 'Medicamentos', 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 2, 'Cuidado Personal', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(6, 2, 'Vitaminas y Suplementos', 2, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(7, 3, 'Lácteos y Embutidos', 0, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(8, 3, 'Abarrotes', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(9, 3, 'Limpieza del Hogar', 2, '2026-06-23 22:07:34', '2026-06-23 22:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
CREATE TABLE `sucursales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sucursales`
--

INSERT INTO `sucursales` (`id`, `empresa_id`, `nombre`, `direccion`, `latitud`, `longitud`, `telefono`, `activa`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pizza Express Centro', 'Av. España #123, San Salvador', 13.69810000, -89.19140000, '2222-1111', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(2, 1, 'Pizza Express Escalón', 'Col. Escalón, San Salvador', 13.70260000, -89.24350000, '2222-2222', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(3, 2, 'Farmacia Vida Soyapango', 'Blvd. del Ejército, Soyapango', 13.71000000, -89.13900000, '2233-3333', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(4, 3, 'La Despensa Metrocentro', 'Metrocentro, San Salvador', 13.70500000, -89.21800000, '2244-4444', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 3, 'La Despensa Santa Tecla', 'Paseo El Carmen, Santa Tecla', 13.67400000, -89.28900000, '2244-5555', 1, '2026-06-23 22:07:34', '2026-06-23 22:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firebase_uid` varchar(200) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `foto_url` varchar(500) DEFAULT NULL,
  `rol` enum('cliente','empresa','admin') NOT NULL DEFAULT 'cliente',
  `fecha_nacimiento` date DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `firebase_uid`, `name`, `email`, `password`, `telefono`, `foto_url`, `rol`, `fecha_nacimiento`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Administrador', 'admin@multicomercio.com', '$2y$12$5lcmFLvtAcXOzq7g/Jg4fOM/phSUcTzTa0lghaeqE85Vy50t2/Z1a', NULL, NULL, 'admin', NULL, NULL, 'w7T1XcuxdSpIuYDkJtRZm7beYkLkGitBifg5VADFiz8NXBoqzO0hgbkfzfKC', '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(2, NULL, 'Pizza Hut', 'pizza@multicomercio.com', '$2y$12$88SYV7V8ioADioGoMF4ha.fWvdDxFKm3P.ZZ8iggkMAyA0.c.I5m.', NULL, NULL, 'empresa', NULL, NULL, 'xbIeeZCYY4Er05J658lhquV80FMtun0nIrWBWwI8l1UXcFljuaFXYGtcMPJo', '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(3, NULL, 'Farmacia Value', 'farmacia@multicomercio.com', '$2y$12$YdhWF.FoHPqFOTXFPhRcl.m.J/FD6.Fk8K9wAhhMJHE/0w9cra3Zi', NULL, NULL, 'empresa', NULL, NULL, '8XmCpEbw7yrUOt6jWw0WaHKgVnuuMkYTByEMpHuiWlr69XTErIf4ydeEVftu', '2026-06-23 22:07:33', '2026-06-23 22:07:33'),
(4, NULL, 'Walmart', 'walmart@multicomercio.com', '$2y$12$7t9p3hqYdPZ01DVMGQaLI.bmkwlkZpsS7FD.EjWoldTAxNXeFCzKK', NULL, NULL, 'empresa', NULL, NULL, '9Bl5dI4Qi6Cn1FUvA0j11fGu0rpLj1UQnFQN0TW30LOlnPJ2ncUKHkdRqde7', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(5, 'firebase_5964ec36-f808-318b-88ad-2a0644682863', 'Dewayne Mante', 'hester29@example.org', NULL, '7632-4617', NULL, 'cliente', '2006-12-15', '2026-06-23 22:07:34', '69JqpYMKCK', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(6, 'firebase_9f4ca892-76fb-3bf7-88e9-c453bb483778', 'Reggie Bednar', 'leta01@example.com', NULL, '7936-4059', NULL, 'cliente', '2005-07-07', '2026-06-23 22:07:34', 'dF8BV3AtcX', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(7, 'firebase_14e3ef82-2d7f-3f7b-8d08-19b6d8642ed9', 'Lavon Blick', 'malika.reichel@example.com', NULL, '7839-6222', NULL, 'cliente', '1997-09-20', '2026-06-23 22:07:34', 'JfOzKBlXau', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(8, 'firebase_acc91474-87f2-3dcb-a1fd-8a93bb338c5f', 'Dr. Dejuan Berge MD', 'schuster.kira@example.org', NULL, '7148-7654', NULL, 'cliente', '1987-01-24', '2026-06-23 22:07:34', 'sWZ0zC97Yv', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(9, 'firebase_43cae525-9e60-31f9-8d07-952139a858e1', 'Gabriella Gerlach', 'dayne.quigley@example.com', NULL, '7835-0569', NULL, 'cliente', '1967-12-23', '2026-06-23 22:07:34', '5mN1D6R0ba', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(10, 'firebase_959c7f0a-80b2-32ab-875d-6b4967e1e879', 'Blaze Runolfsdottir', 'predovic.dewayne@example.com', NULL, '7890-7679', NULL, 'cliente', '1971-03-24', '2026-06-23 22:07:34', '7BD54onOza', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(11, 'firebase_e104def1-0438-3367-877b-6f646144bba8', 'Maiya Jacobi IV', 'lcrist@example.net', NULL, '7204-0573', NULL, 'cliente', '1979-08-21', '2026-06-23 22:07:34', '1dATMh7AmU', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(12, 'firebase_b55e447c-0320-38a3-8de3-b7b2cc44770f', 'Mrs. Bernita Hills DVM', 'alexanne90@example.com', NULL, '7068-8093', NULL, 'cliente', '2001-11-17', '2026-06-23 22:07:34', 'NtPZx5hJdU', '2026-06-23 22:07:34', '2026-06-23 22:07:34'),
(13, 'fLVDmYECJ1NX6zExFjTJNcjP9LC3', 'Jairo Alexander Argueta Alvarenga', 'arguetajairo93@gmail.com', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIE3r3v9k97SJNSik7K0bjGSeK0j44-LfhymgXM4XIMTxzrxlBu=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-24 06:32:51', '2026-06-24 06:32:51'),
(14, 'y9XmRoXIjQUd1n9wXnDOQ4fEkSs2', 'Jairo Alexander Argueta Alvarenga', 'aa23027@ues.edu.sv', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIvy2IU_X_cUocnZKMVnyPFrEv9S9uV4utqyIg85WXgwW4VrQ=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-24 14:37:16', '2026-06-24 14:37:16'),
(15, 'HM4TeTBjb0WWYgyY4eAt9gEXiGS2', 'Jairo Argueta', 'srdrago.7@gmail.com', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocK4iqb6CeMH3VnqPfWgqiTUlFOYOEIggWFC2o1gOzjPDpLJubM=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-24 17:08:25', '2026-06-24 17:08:25'),
(16, 'wXbg7xEbuNd1m4Tb0KfiKVWHs7k1', 'Jailex', 'jailex56@gmail.com', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKjUYQ-ZdaAkmIk08t1PrjO-Wd4xzGnkrBvxtSbMonsFC94ILA=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-24 17:08:34', '2026-06-24 17:08:34'),
(17, '4kF7kLHnaORqNfEXFb2VMPXlN3A2', 'J c', 'jcolocho2003@gmail.com', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKs551Mc3akQND5ZhpdQY86rrv8LYeAmWkbqTEPRDJFAeGnHB4=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-25 19:01:51', '2026-06-25 19:01:51'),
(18, 'FWiiVICYc3OuyQFsPMVMiiLrZ5s1', 'vilma maria gutierrez juarez', 'gj20005@ues.edu.sv', NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL_BiGdozEUR4C6Z3BSlI7HCg67llky219C44QmotM6kJ5wZZE=s96-c', 'cliente', NULL, NULL, NULL, '2026-06-25 19:19:51', '2026-06-25 19:19:51');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `calificaciones_user_id_producto_id_unique` (`user_id`,`producto_id`),
  ADD KEY `calificaciones_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categorias_nombre_unique` (`nombre`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_pedidos_pedido_id_foreign` (`pedido_id`),
  ADD KEY `detalle_pedidos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `direcciones_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `disponibilidad_sucursal_id_producto_id_unique` (`sucursal_id`,`producto_id`),
  ADD KEY `disponibilidad_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dispositivos_fcm_token_unique` (`fcm_token`),
  ADD KEY `dispositivos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empresas_user_id_foreign` (`user_id`),
  ADD KEY `empresas_categoria_id_foreign` (`categoria_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `favoritos_user_id_producto_id_unique` (`user_id`,`producto_id`),
  ADD KEY `favoritos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `historial_estados_pedido`
--
ALTER TABLE `historial_estados_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_estados_pedido_pedido_id_foreign` (`pedido_id`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificaciones_user_id_foreign` (`user_id`),
  ADD KEY `notificaciones_pedido_id_foreign` (`pedido_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pedidos_numero_unique` (`numero`),
  ADD KEY `pedidos_user_id_foreign` (`user_id`),
  ADD KEY `pedidos_empresa_id_foreign` (`empresa_id`),
  ADD KEY `pedidos_sucursal_id_foreign` (`sucursal_id`),
  ADD KEY `pedidos_estado_entrega_estado_pago_index` (`estado_entrega`,`estado_pago`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_empresa_id_foreign` (`empresa_id`),
  ADD KEY `productos_subcategoria_id_foreign` (`subcategoria_id`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `promociones_empresa_id_foreign` (`empresa_id`),
  ADD KEY `promociones_fecha_inicio_fecha_fin_index` (`fecha_inicio`,`fecha_fin`);

--
-- Indices de la tabla `promocion_producto`
--
ALTER TABLE `promocion_producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `promocion_producto_promocion_id_producto_id_unique` (`promocion_id`,`producto_id`),
  ADD KEY `promocion_producto_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategorias_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sucursales_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_firebase_uid_unique` (`firebase_uid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `historial_estados_pedido`
--
ALTER TABLE `historial_estados_pedido`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `promocion_producto`
--
ALTER TABLE `promocion_producto`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `calificaciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_pedido_id_foreign` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_pedidos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD CONSTRAINT `direcciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD CONSTRAINT `disponibilidad_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `disponibilidad_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD CONSTRAINT `dispositivos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `empresas_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `empresas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_estados_pedido`
--
ALTER TABLE `historial_estados_pedido`
  ADD CONSTRAINT `historial_estados_pedido_pedido_id_foreign` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_pedido_id_foreign` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `notificaciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `pedidos_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`),
  ADD CONSTRAINT `pedidos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `productos_subcategoria_id_foreign` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`);

--
-- Filtros para la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD CONSTRAINT `promociones_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `promocion_producto`
--
ALTER TABLE `promocion_producto`
  ADD CONSTRAINT `promocion_producto_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `promocion_producto_promocion_id_foreign` FOREIGN KEY (`promocion_id`) REFERENCES `promociones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD CONSTRAINT `subcategorias_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD CONSTRAINT `sucursales_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
