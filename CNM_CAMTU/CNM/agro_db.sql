-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: db:3306
-- Thời gian đã tạo: Th5 29, 2026 lúc 07:25 AM
-- Phiên bản máy phục vụ: 8.0.45
-- Phiên bản PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `agro_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `target_id` int DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `target_id`, `ip_address`, `created_at`) VALUES
(1, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:17:24'),
(2, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:19:03'),
(3, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:24:46'),
(4, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:35:21'),
(5, 1, 'CREATE_USER', 8, NULL, '2026-04-29 17:42:16'),
(6, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:54:47'),
(7, 1, 'CREATE_USER', 9, NULL, '2026-04-29 17:56:37'),
(8, 1, 'CREATE_USER', 10, NULL, '2026-04-29 17:57:25'),
(9, 10, 'LOGIN_FAILED', NULL, '::ffff:172.19.0.1', '2026-04-29 17:58:21'),
(10, 10, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:58:56'),
(11, 10, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-29 17:59:02'),
(12, 10, 'LOGIN_FAILED', NULL, '::ffff:172.19.0.1', '2026-04-30 04:32:00'),
(13, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:32:23'),
(14, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:36:26'),
(15, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:36:31'),
(16, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:36:58'),
(17, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:37:12'),
(18, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:38:27'),
(19, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-04-30 04:47:27'),
(20, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 04:50:19'),
(21, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 04:50:23'),
(22, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 05:07:52'),
(23, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 05:07:57'),
(24, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 05:10:22'),
(25, 1, 'LOGIN', NULL, '::ffff:172.19.0.5', '2026-04-30 05:12:58'),
(26, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 07:38:56'),
(27, 10, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 07:50:58'),
(28, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 08:16:37'),
(29, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 08:16:54'),
(30, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 08:48:42'),
(31, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 08:57:34'),
(32, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 08:59:45'),
(33, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 09:18:24'),
(34, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-04 09:34:39'),
(35, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:25:13'),
(36, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:40:18'),
(37, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:40:35'),
(38, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:40:44'),
(39, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:43:07'),
(40, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:46:16'),
(41, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:52:12'),
(42, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 15:52:17'),
(43, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:03:50'),
(44, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:17:58'),
(45, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:24:29'),
(46, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:35:44'),
(47, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:43:33'),
(48, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 16:57:29'),
(49, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 17:06:03'),
(50, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 17:11:43'),
(51, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 17:11:51'),
(52, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 17:12:46'),
(53, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-05 17:17:23'),
(54, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:50:58'),
(55, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:00'),
(56, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:01'),
(57, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:01'),
(58, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:02'),
(59, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:03'),
(60, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:04'),
(61, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:04'),
(62, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:04'),
(63, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 04:51:05'),
(64, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 05:01:48'),
(65, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 05:09:52'),
(66, 3, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 05:26:19'),
(67, 1, 'LOGIN', NULL, '::ffff:172.19.0.1', '2026-05-08 09:56:35'),
(68, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:39:19'),
(69, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:40:35'),
(70, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:42:23'),
(71, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:42:30'),
(72, 1, 'ACCOUNT_LOCKED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:42:30'),
(73, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:44:07'),
(74, 1, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 04:44:35'),
(75, 1, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 04:46:42'),
(76, 1, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 05:41:49'),
(77, 6, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 07:35:53'),
(78, 6, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-09 07:36:02'),
(79, 6, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 07:39:59'),
(80, 6, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 07:56:46'),
(81, 1, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 07:57:26'),
(82, 6, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 08:05:09'),
(83, 6, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-09 10:19:11'),
(84, 2, 'LOGIN_FAILED', NULL, '::ffff:172.18.0.1', '2026-05-12 07:47:09'),
(85, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 07:47:17'),
(86, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 07:48:45'),
(87, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 08:20:38'),
(88, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 08:40:15'),
(89, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 09:10:12'),
(90, 2, 'LOGIN', NULL, '::ffff:172.18.0.1', '2026-05-12 09:10:32'),
(91, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 10:33:10'),
(92, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 10:33:36'),
(93, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 10:41:39'),
(94, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 10:51:55'),
(95, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 11:00:31'),
(96, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:23:44'),
(97, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:33:26'),
(98, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:39:45'),
(99, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:57:00'),
(100, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:57:11'),
(101, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 15:57:18'),
(102, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 16:00:26'),
(103, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 16:05:14'),
(104, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 16:22:01'),
(105, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-12 16:24:03'),
(106, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-13 05:28:44'),
(107, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 07:55:07'),
(108, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 08:37:10'),
(109, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 09:08:31'),
(110, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 09:58:05'),
(111, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:05:33'),
(112, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:09:30'),
(113, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:15:59'),
(114, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:16:43'),
(115, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:19:26'),
(116, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:22:46'),
(117, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:23:48'),
(118, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:25:26'),
(119, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:28:55'),
(120, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:29:44'),
(121, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 10:45:12'),
(122, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 11:30:16'),
(123, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 11:46:09'),
(124, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 16:20:35'),
(125, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 16:29:36'),
(126, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 16:37:18'),
(127, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 16:51:44'),
(128, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 16:52:38'),
(129, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 17:08:10'),
(130, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 17:27:07'),
(131, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 17:37:38'),
(132, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 17:37:54'),
(133, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 17:39:59'),
(134, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 23:09:30'),
(135, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 23:25:20'),
(136, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-14 23:26:13'),
(137, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 00:26:34'),
(138, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 00:32:02'),
(139, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 00:48:56'),
(140, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 12:27:59'),
(141, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 12:29:33'),
(142, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 12:31:13'),
(143, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 12:31:27'),
(144, 2, 'LOGIN_FAILED', NULL, '::ffff:172.20.0.1', '2026-05-15 12:50:59'),
(145, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 12:51:10'),
(146, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 13:06:48'),
(147, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 13:18:24'),
(148, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 14:04:09'),
(149, 2, 'LOGOUT', NULL, NULL, '2026-05-15 14:14:48'),
(150, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 14:15:04'),
(151, 2, 'LOGOUT', NULL, NULL, '2026-05-15 14:52:16'),
(152, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 14:54:15'),
(153, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 15:31:10'),
(154, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-15 15:39:28'),
(155, 2, 'LOGOUT', NULL, NULL, '2026-05-16 15:24:51'),
(156, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-16 15:27:30'),
(157, 2, 'LOGIN_FAILED', NULL, '::ffff:172.20.0.1', '2026-05-17 03:22:04'),
(158, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 03:22:08'),
(159, 2, 'LOGOUT', NULL, NULL, '2026-05-17 04:04:54'),
(160, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 04:20:48'),
(161, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 04:55:01'),
(162, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 05:10:34'),
(163, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 11:37:50'),
(164, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 13:21:01'),
(165, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 13:50:25'),
(166, 6, 'LOGOUT', NULL, NULL, '2026-05-17 14:35:35'),
(167, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 14:40:25'),
(168, 6, 'LOGOUT', NULL, NULL, '2026-05-17 15:20:49'),
(169, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:21:40'),
(170, 6, 'LOGOUT', NULL, NULL, '2026-05-17 15:21:52'),
(171, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:30:36'),
(172, 2, 'LOGOUT', NULL, NULL, '2026-05-17 15:30:43'),
(173, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:32:30'),
(174, 6, 'LOGOUT', NULL, NULL, '2026-05-17 15:32:35'),
(175, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:33:10'),
(176, 6, 'LOGOUT', NULL, NULL, '2026-05-17 15:47:40'),
(177, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:47:56'),
(178, 2, 'LOGOUT', NULL, NULL, '2026-05-17 15:51:31'),
(179, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:51:39'),
(180, 2, 'LOGOUT', NULL, NULL, '2026-05-17 15:52:09'),
(181, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 15:52:22'),
(182, 2, 'LOGOUT', NULL, NULL, '2026-05-17 16:36:38'),
(183, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 16:37:59'),
(184, 6, 'LOGOUT', NULL, NULL, '2026-05-17 16:41:16'),
(185, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 16:41:24'),
(186, 2, 'LOGOUT', NULL, NULL, '2026-05-17 17:15:53'),
(187, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 17:16:02'),
(188, 6, 'LOGOUT', NULL, NULL, '2026-05-17 17:18:38'),
(189, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-17 17:19:01'),
(190, 2, 'LOGIN_FAILED', NULL, '::ffff:172.20.0.1', '2026-05-18 01:08:15'),
(191, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 01:08:20'),
(192, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 04:07:12'),
(193, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 04:17:08'),
(194, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 04:52:49'),
(195, 2, 'LOGOUT', NULL, NULL, '2026-05-18 07:24:19'),
(196, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 07:24:38'),
(197, 2, 'LOGOUT', NULL, NULL, '2026-05-18 08:33:35'),
(198, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:33:52'),
(199, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:49:05'),
(200, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:50:23'),
(201, 6, 'LOGOUT', NULL, NULL, '2026-05-18 08:54:11'),
(202, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:54:24'),
(203, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:55:59'),
(204, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 08:59:32'),
(205, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 09:00:45'),
(206, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 09:05:09'),
(207, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 09:10:13'),
(208, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-18 09:19:02'),
(209, 1, 'LOGOUT', NULL, NULL, '2026-05-19 04:24:42'),
(210, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 04:25:20'),
(211, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 04:26:43'),
(212, 2, 'LOGOUT', NULL, NULL, '2026-05-19 04:27:42'),
(213, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 04:27:49'),
(214, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 05:03:18'),
(215, 1, 'LOGOUT', NULL, NULL, '2026-05-19 05:18:10'),
(216, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 05:18:36'),
(217, 1, 'LOGOUT', NULL, NULL, '2026-05-19 05:19:55'),
(218, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 14:36:19'),
(219, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 15:37:53'),
(220, 2, 'LOGOUT', NULL, NULL, '2026-05-19 15:58:32'),
(221, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 15:58:41'),
(222, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 16:58:27'),
(223, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 17:13:37'),
(224, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 17:34:18'),
(225, 6, 'LOGOUT', NULL, NULL, '2026-05-19 17:50:48'),
(226, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-19 17:50:59'),
(227, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 03:16:58'),
(228, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 05:46:55'),
(229, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 06:22:44'),
(230, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 06:51:47'),
(231, 21, 'LOGOUT', NULL, NULL, '2026-05-20 07:35:00'),
(232, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 07:35:09'),
(233, 6, 'LOGOUT', NULL, NULL, '2026-05-20 07:50:15'),
(234, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 07:50:27'),
(235, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 07:59:14'),
(236, 21, 'LOGOUT', NULL, NULL, '2026-05-20 08:16:33'),
(237, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 08:16:43'),
(238, 2, 'LOGOUT', NULL, NULL, '2026-05-20 08:45:32'),
(239, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 08:45:48'),
(240, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 09:04:56'),
(241, 6, 'LOGOUT', NULL, NULL, '2026-05-20 09:18:15'),
(242, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 09:18:24'),
(243, 2, 'LOGOUT', NULL, NULL, '2026-05-20 09:18:59'),
(244, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-20 09:23:18'),
(245, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 02:46:56'),
(246, 21, 'LOGOUT', NULL, NULL, '2026-05-21 03:31:05'),
(247, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 03:38:52'),
(248, 6, 'LOGOUT', NULL, NULL, '2026-05-21 03:40:17'),
(249, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 03:40:26'),
(250, 2, 'LOGOUT', NULL, NULL, '2026-05-21 03:43:21'),
(251, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 03:43:35'),
(252, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 04:08:25'),
(253, 2, 'LOGOUT', NULL, NULL, '2026-05-21 04:09:59'),
(254, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 04:10:14'),
(255, 1, 'LOGOUT', NULL, NULL, '2026-05-21 06:24:24'),
(256, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 06:24:33'),
(257, 2, 'LOGOUT', NULL, NULL, '2026-05-21 06:24:41'),
(258, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 06:24:54'),
(259, 1, 'LOGOUT', NULL, NULL, '2026-05-21 07:30:30'),
(260, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 07:30:49'),
(261, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-21 08:07:44'),
(262, 2, 'LOGOUT', NULL, NULL, '2026-05-21 08:35:27'),
(263, 2, 'LOGIN_FAILED', NULL, '::ffff:172.20.0.1', '2026-05-22 09:48:41'),
(264, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 09:48:50'),
(265, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 12:01:10'),
(266, 2, 'LOGOUT', NULL, NULL, '2026-05-22 12:13:29'),
(267, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 12:13:42'),
(268, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 15:46:42'),
(269, 21, 'LOGOUT', NULL, NULL, '2026-05-22 16:39:25'),
(270, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 16:54:56'),
(271, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-22 16:55:05'),
(272, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-23 04:28:56'),
(273, 6, 'LOGOUT', NULL, NULL, '2026-05-23 06:41:15'),
(274, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-23 06:42:07'),
(275, 21, 'LOGOUT', NULL, NULL, '2026-05-23 07:13:39'),
(276, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-23 07:13:48'),
(277, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-23 07:16:26'),
(278, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 04:11:55'),
(279, 2, 'LOGOUT', NULL, NULL, '2026-05-24 05:01:41'),
(280, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 05:56:09'),
(281, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 05:57:28'),
(282, 21, 'LOGOUT', NULL, NULL, '2026-05-24 08:35:04'),
(283, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 08:35:11'),
(284, 2, 'LOGOUT', NULL, NULL, '2026-05-24 08:37:16'),
(285, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 08:37:24'),
(286, 6, 'LOGOUT', NULL, NULL, '2026-05-24 08:37:35'),
(287, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-24 08:37:47'),
(288, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 06:00:20'),
(289, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 07:33:54'),
(290, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 08:35:43'),
(291, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 15:17:50'),
(292, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 15:47:08'),
(293, 2, 'LOGIN', NULL, '2402:800:637d:4c61:c5d3:784f:8a80:abf6', '2026-05-26 15:51:34'),
(294, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 16:16:45'),
(295, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 16:50:16'),
(296, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-26 17:28:07'),
(297, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 15:19:10'),
(298, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 15:49:47'),
(299, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 16:12:22'),
(300, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 16:26:54'),
(301, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 16:40:55'),
(302, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-27 17:16:32'),
(303, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 04:06:25'),
(304, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 11:05:16'),
(305, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 12:19:16'),
(306, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 12:56:40'),
(307, 21, 'LOGOUT', NULL, NULL, '2026-05-28 13:04:35'),
(308, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 13:04:48'),
(309, 2, 'LOGOUT', NULL, NULL, '2026-05-28 13:46:55'),
(310, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 13:48:24'),
(311, 2, 'LOGIN', NULL, '171.252.153.216', '2026-05-28 14:48:23'),
(312, 2, 'LOGOUT', NULL, NULL, '2026-05-28 15:10:29'),
(313, 2, 'LOGIN', NULL, '171.252.153.216', '2026-05-28 15:10:31'),
(314, 2, 'LOGOUT', NULL, NULL, '2026-05-28 15:40:49'),
(315, 21, 'LOGIN_FAILED', NULL, '::ffff:172.20.0.1', '2026-05-28 15:41:02'),
(316, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-28 15:41:09'),
(317, 1, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 02:36:19'),
(318, 1, 'LOGOUT', NULL, NULL, '2026-05-29 02:50:59'),
(319, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 02:51:23'),
(320, 21, 'LOGOUT', NULL, NULL, '2026-05-29 03:01:53'),
(321, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 03:04:23'),
(322, 2, 'LOGOUT', NULL, NULL, '2026-05-29 03:04:43'),
(323, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 03:04:52'),
(324, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 03:10:05'),
(325, 21, 'LOGOUT', NULL, NULL, '2026-05-29 04:40:46'),
(326, 21, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 04:41:40'),
(327, 21, 'LOGOUT', NULL, NULL, '2026-05-29 07:20:42'),
(328, 2, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 07:20:54'),
(329, 2, 'LOGOUT', NULL, NULL, '2026-05-29 07:21:12'),
(330, 6, 'LOGIN', NULL, '::ffff:172.20.0.1', '2026-05-29 07:21:34');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `CategoryID` int NOT NULL,
  `CategoryName` varchar(100) DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`CategoryID`, `CategoryName`, `Description`) VALUES
(1, 'Phân bón', 'Các loại phân bón cho cây trồng'),
(2, 'Thuốc BVTV', 'Thuốc bảo vệ thực vật'),
(3, 'Hạt giống', 'Hạt giống cây trồng'),
(4, 'Dụng cụ nông nghiệp', 'Dụng cụ phục vụ sản xuất nông nghiệp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `company_bank_accounts`
--

CREATE TABLE `company_bank_accounts` (
  `bank_account_id` int NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_bin` varchar(20) NOT NULL,
  `account_no` varchar(50) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `company_bank_accounts`
--

INSERT INTO `company_bank_accounts` (`bank_account_id`, `bank_name`, `bank_bin`, `account_no`, `account_name`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Viettinbank', '970415', '102876705963', 'VO THI CAM TU', 1, 1, '2026-05-26 05:58:59', '2026-05-26 15:29:55');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `crops`
--

CREATE TABLE `crops` (
  `CropID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `crops`
--

INSERT INTO `crops` (`CropID`, `Name`, `Description`) VALUES
(1, 'Lúa', 'Cây lương thực chính, thường bị ảnh hưởng bởi rầy nâu, đạo ôn, sâu cuốn lá.'),
(2, 'Ngô', 'Cây trồng lấy hạt, thường gặp sâu keo mùa thu, sâu đục thân.'),
(3, 'Cà chua', 'Cây rau ăn quả, dễ bị bọ trĩ, sâu xanh, bệnh sương mai.'),
(4, 'Ớt', 'Cây rau gia vị, thường bị rệp, bọ trĩ, thán thư.'),
(5, 'Dưa leo', 'Cây rau ăn quả, thường gặp bệnh phấn trắng, bọ trĩ, rệp mềm.'),
(6, 'Rau cải', 'Nhóm rau ăn lá, thường bị sâu tơ, sâu xanh, rệp.'),
(7, 'Khoai tây', 'Cây lấy củ, dễ bị bệnh mốc sương, sâu ăn lá.'),
(8, 'Đậu phộng', 'Cây họ đậu, thường gặp bệnh đốm lá, sâu khoang.'),
(9, 'Cam', 'Cây ăn quả có múi, thường bị sâu vẽ bùa, rệp sáp, bệnh vàng lá.'),
(10, 'Xoài', 'Cây ăn quả nhiệt đới, thường gặp rầy bông xoài, thán thư, ruồi đục quả.'),
(11, 'Thanh long', 'Cây ăn quả, thường gặp bệnh đốm nâu, thối cành.'),
(12, 'Cà phê', 'Cây công nghiệp lâu năm, thường gặp rệp sáp, mọt đục quả, bệnh gỉ sắt.'),
(13, 'Hồ tiêu', 'Cây công nghiệp, thường gặp bệnh chết nhanh, chết chậm, rệp sáp.'),
(14, 'Cao su', 'Cây công nghiệp lấy mủ, thường gặp bệnh phấn trắng, rụng lá.'),
(15, 'Hoa hồng', 'Cây hoa cảnh, thường bị bọ trĩ, nhện đỏ, bệnh phấn trắng.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `user_id` int NOT NULL,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `credit_limit` decimal(15,2) DEFAULT '10000000.00' COMMENT 'Tổng hạn mức nợ cho phép',
  `current_debt` decimal(15,2) DEFAULT '0.00' COMMENT 'Nợ hiện tại của khách',
  `remaining_limit` decimal(15,2) GENERATED ALWAYS AS ((`credit_limit` - `current_debt`)) VIRTUAL COMMENT 'Hạn mức còn lại',
  `tax_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`customer_id`, `user_id`, `company_name`, `address`, `credit_limit`, `current_debt`, `tax_code`) VALUES
(1, 3, 'Đại lý Vật tư Nông nghiệp Minh Phát', '152 Nguyễn Văn Nghi, Gò Vấp, TP.HCM', 20000000.00, 165000.00, '0310000003'),
(2, 4, 'Cửa hàng Phân bón Thanh Thanh', '22/4 Phan Huy Ích, Bình Thạnh, TP.HCM', 30000000.00, 0.00, '0310000004'),
(3, 5, 'Công ty TNHH Nông Nghiệp Huy Hoàng', '50 Quang Trung, Thủ Đức, TP.HCM', 50000000.00, 0.00, '0310000005'),
(4, 8, 'Đại lý Hạt giống Ngọc Anh', '12 Lê Đức Thọ, Quận 12, TP.HCM', 25000000.00, 0.00, '0310000008'),
(5, 9, 'Vật tư Nông nghiệp Khang Thịnh', '45 Trường Chinh, Tân Bình, TP.HCM', 35000000.00, 0.00, '0310000009'),
(14, 20, 'Chin chin Comany', 'Cần Thơ', 10000000.00, 0.00, '0404200422'),
(25, 33, 'CamTuCompany', '4418, Xã Thạnh An, Huyện Vĩnh Thạnh, Thành phố Cần Thơ', 10000000.00, 0.00, '0404200423'),
(26, 34, 'Bưởi Da Xanh Company', '156, Xã Tân An Luông, Huyện Vũng Liêm, Tỉnh Vĩnh Long', 10000000.00, 0.00, '0404200429');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dealer_commissions`
--

CREATE TABLE `dealer_commissions` (
  `dealer_commission_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_id` int NOT NULL,
  `commission_amount` decimal(15,2) NOT NULL,
  `commission_rate_per_day` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `early_payment_days` int NOT NULL DEFAULT '0',
  `base_amount` decimal(15,2) NOT NULL COMMENT 'Tổng tiền đơn dùng để tính hoa hồng',
  `source_type` enum('EARLY_PAYMENT','MANUAL','PROMOTION') NOT NULL DEFAULT 'EARLY_PAYMENT',
  `status` enum('PENDING','APPROVED','PAID','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `note` text,
  `created_by` int DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `dealer_commissions`
--

INSERT INTO `dealer_commissions` (`dealer_commission_id`, `customer_id`, `order_id`, `commission_amount`, `commission_rate_per_day`, `early_payment_days`, `base_amount`, `source_type`, `status`, `note`, `created_by`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(1, 1, 13, 1980.00, 0.000400, 30, 165000.00, 'EARLY_PAYMENT', 'PENDING', 'Hoa hồng trả sớm 30 ngày cho đơn hàng #13', NULL, NULL, NULL, '2026-05-26 06:19:27', '2026-05-26 06:19:27'),
(2, 1, 14, 924.00, 0.000400, 28, 82500.00, 'EARLY_PAYMENT', 'PENDING', 'Hoa hồng trả sớm 28 ngày cho đơn hàng #14', NULL, NULL, NULL, '2026-05-28 15:11:50', '2026-05-28 15:11:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dealer_commission_logs`
--

CREATE TABLE `dealer_commission_logs` (
  `dealer_commission_log_id` int NOT NULL,
  `dealer_commission_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `action` enum('CREATED','APPROVED','PAID','CANCELLED','ADJUSTED') NOT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `note` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `dealer_commission_logs`
--

INSERT INTO `dealer_commission_logs` (`dealer_commission_log_id`, `dealer_commission_id`, `customer_id`, `action`, `amount`, `old_status`, `new_status`, `note`, `created_by`, `created_at`) VALUES
(1, 1, 1, 'CREATED', 1980.00, NULL, 'PENDING', 'Tạo hoa hồng trả sớm cho đơn hàng #13', NULL, '2026-05-26 06:19:27'),
(2, 2, 1, 'CREATED', 924.00, NULL, 'PENDING', 'Tạo hoa hồng trả sớm cho đơn hàng #14', NULL, '2026-05-28 15:11:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `debt_logs`
--

CREATE TABLE `debt_logs` (
  `debt_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `type` enum('INCREASE','DECREASE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reason` enum('ORDER_CREATE','PAYMENT','EARLY_COMMISSION','LATE_INTEREST','CANCEL_ORDER','ADJUSTMENT') DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `balance_after` decimal(15,2) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `debt_logs`
--

INSERT INTO `debt_logs` (`debt_id`, `customer_id`, `order_id`, `payment_id`, `type`, `reason`, `amount`, `balance_after`, `description`, `created_at`) VALUES
(22, 1, 10, NULL, 'INCREASE', NULL, 960000.00, NULL, 'Phát sinh công nợ từ đơn hàng', '2026-05-15 12:58:52'),
(23, 1, 13, NULL, 'INCREASE', 'ORDER_CREATE', 165000.00, 165000.00, 'Nợ phát sinh từ đơn hàng #13', '2026-05-26 06:07:28'),
(24, 1, 13, 16, 'DECREASE', 'PAYMENT', 165000.00, 0.00, 'Thanh toán đơn hàng #13', '2026-05-26 06:19:27'),
(25, 1, 14, NULL, 'INCREASE', 'ORDER_CREATE', 82500.00, 82500.00, 'Nợ phát sinh từ đơn hàng #14', '2026-05-26 07:35:27'),
(26, 1, 15, NULL, 'INCREASE', 'ORDER_CREATE', 165000.00, 247500.00, 'Nợ phát sinh từ đơn hàng #15', '2026-05-26 15:25:38'),
(27, 1, 14, 17, 'DECREASE', 'PAYMENT', 20000.00, 227500.00, 'Thanh toán đơn hàng #14', '2026-05-26 17:04:13'),
(28, 1, 14, 18, 'DECREASE', 'PAYMENT', 2000.00, 225500.00, 'Thanh toán đơn hàng #14 qua SePay', '2026-05-27 16:51:43'),
(29, 1, 14, 19, 'DECREASE', 'PAYMENT', 2000.00, 223500.00, 'Thanh toán đơn hàng #14 qua SePay', '2026-05-28 14:21:14'),
(30, 1, 14, 20, 'DECREASE', 'PAYMENT', 58500.00, 165000.00, 'Thanh toán đơn hàng #14 qua SePay', '2026-05-28 15:11:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `goods_receipts`
--

CREATE TABLE `goods_receipts` (
  `receipt_id` int NOT NULL COMMENT 'Khóa chính của phiếu nhập kho thực tế',
  `receipt_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mã phiếu nhập kho thực tế, ví dụ GR001',
  `purchase_order_id` int DEFAULT NULL COMMENT 'Phiếu yêu cầu nhập hàng gốc liên quan đến phiếu nhập kho này',
  `supplier_id` int NOT NULL COMMENT 'Nhà cung cấp giao hàng',
  `received_by` int NOT NULL COMMENT 'Nhân viên kho thực hiện nhận hàng thực tế',
  `created_by` int NOT NULL COMMENT 'Người tạo phiếu nhập kho trên hệ thống',
  `updated_by` int DEFAULT NULL COMMENT 'Người cập nhật phiếu nhập kho gần nhất',
  `status` enum('DRAFT','COMPLETED','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'DRAFT' COMMENT 'Trạng thái phiếu nhập kho thực tế',
  `has_rejected_items` tinyint(1) NOT NULL DEFAULT '0',
  `issue_status` enum('NONE','WAITING_REVIEW','EMAIL_SENT','RESOLVED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `issue_email_sent_at` datetime DEFAULT NULL,
  `issue_email_sent_by` int DEFAULT NULL,
  `received_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm nhận hàng từ nhà cung cấp',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú thêm cho phiếu nhập kho',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm tạo phiếu nhập kho',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời điểm cập nhật phiếu nhập kho gần nhất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `goods_receipts`
--

INSERT INTO `goods_receipts` (`receipt_id`, `receipt_code`, `purchase_order_id`, `supplier_id`, `received_by`, `created_by`, `updated_by`, `status`, `has_rejected_items`, `issue_status`, `issue_email_sent_at`, `issue_email_sent_by`, `received_date`, `note`, `created_at`, `updated_at`) VALUES
(1, 'GR-2026-001', 3, 3, 2, 2, 2, 'COMPLETED', 0, 'NONE', NULL, NULL, '2026-05-18 09:30:00', 'Nhập kho lần 1 cho phiếu PO-2026-003, nhà cung cấp giao một phần hàng', '2026-05-18 08:26:03', '2026-05-18 08:26:03'),
(2, 'GR-2026-002', NULL, 1, 2, 2, 2, 'DRAFT', 0, 'NONE', NULL, NULL, '2026-05-18 14:00:00', 'Phiếu nhập kho trực tiếp, chưa hoàn tất kiểm hàng', '2026-05-18 08:26:16', '2026-05-18 08:26:16'),
(5, 'GR-20260523-2505', 5, 5, 6, 6, 6, 'COMPLETED', 0, 'NONE', NULL, NULL, '2026-05-23 06:29:01', NULL, '2026-05-23 06:29:01', '2026-05-23 06:29:01'),
(6, 'GR-20260523-4920', 4, 7, 6, 6, 6, 'COMPLETED', 1, 'NONE', NULL, NULL, '2026-05-23 06:40:57', NULL, '2026-05-23 06:40:57', '2026-05-23 06:40:57'),
(7, 'GR-20260523-3858', 7, 5, 6, 6, 6, 'COMPLETED', 1, 'NONE', NULL, NULL, '2026-05-23 07:20:02', NULL, '2026-05-23 07:20:02', '2026-05-23 07:20:02'),
(8, 'GR-20260523-4494', 8, 5, 6, 6, 6, 'COMPLETED', 1, 'NONE', NULL, NULL, '2026-05-23 08:08:33', NULL, '2026-05-23 08:08:33', '2026-05-23 08:08:33'),
(9, 'GR-20260524-8219', 6, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 05:56:58', NULL, '2026-05-24 05:56:58', '2026-05-24 05:56:58'),
(10, 'GR-20260524-9440', 9, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:15:59', NULL, '2026-05-24 06:15:59', '2026-05-24 06:15:59'),
(11, 'GR-20260524-5064', 10, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:27:53', NULL, '2026-05-24 06:27:53', '2026-05-24 06:27:53'),
(12, 'GR-20260524-4493', 11, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:31:57', NULL, '2026-05-24 06:31:57', '2026-05-24 06:31:57'),
(13, 'GR-20260524-5579', 13, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:34:54', NULL, '2026-05-24 06:34:54', '2026-05-24 06:34:54'),
(14, 'GR-20260524-7950', 12, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:38:03', NULL, '2026-05-24 06:38:03', '2026-05-24 06:38:03'),
(15, 'GR-20260524-2265', 15, 5, 6, 6, 6, 'COMPLETED', 1, 'WAITING_REVIEW', NULL, NULL, '2026-05-24 06:40:20', NULL, '2026-05-24 06:40:20', '2026-05-24 06:40:20'),
(16, 'GR-20260524-4504', 14, 5, 6, 6, 21, 'COMPLETED', 1, 'EMAIL_SENT', '2026-05-24 07:01:46', 21, '2026-05-24 06:44:52', NULL, '2026-05-24 06:44:52', '2026-05-24 07:01:46');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `goods_receipt_details`
--

CREATE TABLE `goods_receipt_details` (
  `receipt_detail_id` int NOT NULL COMMENT 'Khóa chính của chi tiết phiếu nhập kho',
  `receipt_id` int NOT NULL COMMENT 'Phiếu nhập kho mà dòng chi tiết này thuộc về',
  `purchase_order_detail_id` int DEFAULT NULL,
  `product_id` int NOT NULL COMMENT 'Sản phẩm thực tế được nhập kho',
  `received_quantity` int NOT NULL COMMENT 'Số lượng sản phẩm thực tế nhận được',
  `faulty_quantity` int DEFAULT '0' COMMENT 'Số lượng sản phẩm bị lỗi khi nhận hàng',
  `missing_quantity` int DEFAULT '0' COMMENT 'Số lượng sản phẩm bị thiếu so với số lượng đặt',
  `unit_price` decimal(15,2) DEFAULT NULL COMMENT 'Đơn giá nhập thực tế của sản phẩm',
  `manufacture_date` date DEFAULT NULL COMMENT 'Ngày sản xuất của lô hàng',
  `expiry_date` date DEFAULT NULL COMMENT 'Hạn sử dụng của lô hàng',
  `batch_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Số lô hoặc mã batch của hàng nhập',
  `manufacturer_batch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_rack` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Vị trí kệ hoặc khu vực lưu trữ trong kho',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú thêm cho dòng hàng nhập kho',
  `fault_images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL COMMENT 'Người thêm dòng hàng vào phiếu nhập kho',
  `updated_by` int DEFAULT NULL COMMENT 'Người cập nhật dòng hàng nhập kho gần nhất',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm thêm dòng hàng vào phiếu nhập kho',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời điểm cập nhật dòng hàng nhập kho gần nhất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `goods_receipt_details`
--

INSERT INTO `goods_receipt_details` (`receipt_detail_id`, `receipt_id`, `purchase_order_detail_id`, `product_id`, `received_quantity`, `faulty_quantity`, `missing_quantity`, `unit_price`, `manufacture_date`, `expiry_date`, `batch_number`, `manufacturer_batch`, `location_rack`, `note`, `fault_images`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 5, 2, 73, 4, 0, 0, 50000.00, NULL, NULL, 'LOT-20260523-P73-6259', NULL, 'A1-02', NULL, NULL, 6, 6, '2026-05-23 06:29:01', '2026-05-23 06:29:01'),
(2, 6, 1, 72, 1, 1, 0, 50000.00, NULL, NULL, 'LOT-20260523-P72-3076', NULL, 'A12', 'Hư', NULL, 6, 6, '2026-05-23 06:40:57', '2026-05-23 06:40:57'),
(3, 7, 5, 76, 2000, 500, 0, 500000.00, NULL, NULL, 'LOT-20260523-P76-1409', NULL, 'V2-01', 'hư bao bì', NULL, 6, 6, '2026-05-23 07:20:02', '2026-05-23 07:20:02'),
(4, 7, 6, 51, 1000000, 0, 0, 2000.00, NULL, NULL, 'LOT-20260523-P51-7074', NULL, 'V2-03', NULL, NULL, 6, 6, '2026-05-23 07:20:02', '2026-05-23 07:20:02'),
(5, 8, 7, 6, 5000, 150, 0, 10000.00, NULL, NULL, 'LOT-20260523-P6-1263', NULL, 'A2-12', 'giao hàng hỏng', NULL, 6, 6, '2026-05-23 08:08:33', '2026-05-23 08:08:33'),
(6, 9, 3, 76, 2000, 48, 0, 500000.00, NULL, NULL, 'LOT-20260524-P76-9154', NULL, 'A8-09', 'sai mã hàng', '[\"/uploads/goods-receipts/1779602218190-764521856.png\",\"/uploads/goods-receipts/1779602218206-520100775.png\"]', 6, 6, '2026-05-24 05:56:58', '2026-05-24 05:56:58'),
(7, 9, 4, 51, 1000000, 0, 0, 2000.00, NULL, NULL, 'LOT-20260524-P51-4467', NULL, 'A8-10', NULL, '[]', 6, 6, '2026-05-24 05:56:58', '2026-05-24 05:56:58'),
(8, 10, 8, 76, 50, 2, 0, 0.00, NULL, NULL, 'LOT-20260524-P76-6367', NULL, 'A8-02', 'HƯ', '[\"/uploads/goods-receipts/1779603359052-618964363.png\",\"/uploads/goods-receipts/1779603359061-360149690.png\"]', 6, 6, '2026-05-24 06:15:59', '2026-05-24 06:15:59'),
(9, 11, 9, 76, 50, 40, 0, 20000.00, NULL, NULL, 'LOT-20260524-P76-4424', NULL, 'A01', 'HƯ', '[\"public/images/uploads/goods-receipts/1779604073254-514997258.png\",\"public/images/uploads/goods-receipts/1779604073265-29111902.png\"]', 6, 6, '2026-05-24 06:27:53', '2026-05-24 06:27:53'),
(10, 12, 10, 76, 50, 2, 0, 20000.00, NULL, NULL, 'LOT-20260524-P76-9938', NULL, 'A03r', 'hư', '[\"./public/images/uploads/goods-receipts/1779604317926-192929950.png\",\"./public/images/uploads/goods-receipts/1779604317940-656501712.png\"]', 6, 6, '2026-05-24 06:31:57', '2026-05-24 06:31:57'),
(11, 13, 12, 76, 50, 50, 0, 2000.00, NULL, NULL, 'LOT-20260524-P76-4775', NULL, 'A0123', 'hư', '[\"/images/uploads/goods-receipts/1779604494339-328389196.png\",\"/images/uploads/goods-receipts/1779604494355-216563183.png\"]', 6, 6, '2026-05-24 06:34:54', '2026-05-24 06:34:54'),
(12, 14, 11, 76, 50, 50, 0, 2000.00, NULL, NULL, 'LOT-20260524-P76-9653', NULL, 'A0123', 'Hư', '[\"/images/uploads/images/goods-receipts/1779604682978-678962314.png\",\"/images/uploads/images/goods-receipts/1779604683001-228684146.png\"]', 6, 6, '2026-05-24 06:38:03', '2026-05-24 06:38:03'),
(13, 15, 14, 76, 50, 50, 0, 20000.00, NULL, NULL, 'LOT-20260524-P76-7673', NULL, 'A0123', 'hư', '[\"/uploads/images/goods-receipts/1779604819953-149657925.png\",\"/uploads/images/goods-receipts/1779604819972-978717620.png\"]', 6, 6, '2026-05-24 06:40:20', '2026-05-24 06:40:20'),
(14, 16, 13, 76, 50, 50, 0, 20000.00, NULL, NULL, 'LOT-20260524-P76-7699', NULL, 'A1-03', 'HƯ', '[\"/images/uploads/good-receips/1779605092872-875993582.png\",\"/images/uploads/good-receips/1779605092896-324486494.png\"]', 6, 6, '2026-05-24 06:44:52', '2026-05-24 06:44:52');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `goods_receipt_supplier_emails`
--

CREATE TABLE `goods_receipt_supplier_emails` (
  `email_log_id` int NOT NULL,
  `receipt_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `sent_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('SENT','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'SENT',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sent_by` int DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `goods_receipt_supplier_emails`
--

INSERT INTO `goods_receipt_supplier_emails` (`email_log_id`, `receipt_id`, `supplier_id`, `sent_to`, `subject`, `content`, `status`, `error_message`, `sent_by`, `sent_at`) VALUES
(1, 16, 5, 'tuvo068@gmail.com', 'Thông báo hàng lỗi - Phiếu GR-20260524-4504', '\n            Phiếu nhận hàng GR-20260524-4504\n            thuộc PO PO-20260524-2300 có phát sinh hàng lỗi.\n        ', 'SENT', NULL, 21, '2026-05-24 07:01:46');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_banners`
--

CREATE TABLE `home_banners` (
  `BannerID` int NOT NULL,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ImageURL` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ButtonText` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ButtonLink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `home_banners`
--

INSERT INTO `home_banners` (`BannerID`, `Title`, `Subtitle`, `Description`, `ImageURL`, `ButtonText`, `ButtonLink`, `IsActive`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Khuyến mãi mùa vụ mới', 'Giảm đến 50% cho sản phẩm nông nghiệp', 'Mua phân bón, thuốc BVTV và hạt giống chất lượng cao với giá ưu đãi trong hôm nay.', '/images/banner/agro-banner.png', 'Mua ngay', '#productList', 1, '2026-05-20 09:38:09', '2026-05-20 09:38:09');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `import_requests`
--

CREATE TABLE `import_requests` (
  `id` int NOT NULL,
  `request_code` varchar(20) NOT NULL,
  `created_by` int NOT NULL,
  `approved_by` int DEFAULT NULL,
  `status` enum('PENDING','APPROVED','PARTIAL','COMPLETED','REJECTED') DEFAULT 'PENDING',
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `import_request_details`
--

CREATE TABLE `import_request_details` (
  `id` int NOT NULL,
  `import_request_id` int NOT NULL,
  `product_id` int NOT NULL,
  `expected_quantity` int NOT NULL,
  `received_quantity` int DEFAULT '0',
  `faulty_quantity` int DEFAULT '0',
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `inventory`
--

CREATE TABLE `inventory` (
  `InventoryID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int DEFAULT '0' COMMENT 'Số lượng thực tế trong kho',
  `AllocatedQuantity` int NOT NULL DEFAULT '0' COMMENT 'Số lượng treo',
  `MinStockLevel` int DEFAULT '10' COMMENT 'Mức tồn kho tối thiểu để cảnh báo',
  `LocationRack` varchar(50) DEFAULT NULL,
  `ExpiryDate` date DEFAULT NULL COMMENT 'Hạn sử dụng (Nếu có)',
  `BatchNumber` varchar(255) NOT NULL COMMENT 'Mã lô hàng',
  `ManufacturerBatch` varchar(100) DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Ngày cập nhật gần nhất',
  `AvailableQuantity` int GENERATED ALWAYS AS ((`Quantity` - `AllocatedQuantity`)) VIRTUAL COMMENT 'Số lượng mà bộ phận Sale có thể nhìn thấy để bán'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `inventory`
--

INSERT INTO `inventory` (`InventoryID`, `ProductID`, `Quantity`, `AllocatedQuantity`, `MinStockLevel`, `LocationRack`, `ExpiryDate`, `BatchNumber`, `LastUpdated`) VALUES
(1, 1, 87, 5, 10, 'A-02', '2028-12-31 00:00:00', 'LO-SP-001-000001', NULL),
(2, 2, 94, 0, 10, 'A-03', '2028-12-31 00:00:00', 'LO-SP-001-000002', NULL),
(3, 3, 101, 0, 10, 'A-04', '2028-12-31 00:00:00', 'LO-SP-001-000003', NULL),
(4, 4, 108, 0, 10, 'A-05', '2028-12-31 00:00:00', 'LO-SP-001-000004', NULL),
(5, 5, 115, 0, 10, 'A-06', '2028-12-31 00:00:00', 'LO-SP-001-000005', NULL),
(6, 6, 122, 0, 10, 'A-07', '2028-12-31 00:00:00', 'LO-SP-001-000006', NULL),
(7, 7, 129, 0, 10, 'A-08', '2028-12-31 00:00:00', 'LO-SP-001-000007', NULL),
(8, 8, 136, 0, 10, 'A-09', '2028-12-31 00:00:00', 'LO-SP-001-000008', NULL),
(9, 9, 143, 0, 10, 'A-10', '2028-12-31 00:00:00', 'LO-SP-001-000009', NULL),
(10, 10, 150, 0, 10, 'A-01', '2028-12-31 00:00:00', 'LO-SP-001-000010', NULL),
(11, 11, 157, 0, 10, 'A-02', '2028-12-31 00:00:00', 'LO-SP-001-000011', NULL),
(12, 12, 164, 0, 10, 'A-03', '2028-12-31 00:00:00', 'LO-SP-001-000012', NULL),
(13, 13, 171, 0, 10, 'A-04', '2028-12-31 00:00:00', 'LO-SP-001-000013', NULL),
(14, 14, 178, 0, 10, 'A-05', '2028-12-31 00:00:00', 'LO-SP-001-000014', NULL),
(15, 15, 185, 0, 10, 'A-06', '2028-12-31 00:00:00', 'LO-SP-001-000015', NULL),
(16, 16, 192, 0, 10, 'A-07', '2028-12-31 00:00:00', 'LO-SP-001-000016', NULL),
(17, 17, 199, 0, 10, 'A-08', '2028-12-31 00:00:00', 'LO-SP-001-000017', NULL),
(18, 18, 206, 0, 10, 'A-09', '2028-12-31 00:00:00', 'LO-SP-001-000018', NULL),
(19, 19, 213, 0, 10, 'A-10', '2028-12-31 00:00:00', 'LO-SP-001-000019', NULL),
(20, 20, 220, 0, 10, 'A-01', '2028-12-31 00:00:00', 'LO-SP-001-000020', NULL),
(21, 21, 227, 0, 5, 'B-02', '2028-12-31 00:00:00', 'LO-SP-002-000021', NULL),
(22, 22, 234, 0, 5, 'B-03', '2028-12-31 00:00:00', 'LO-SP-002-000022', NULL),
(23, 23, 241, 0, 5, 'B-04', '2028-12-31 00:00:00', 'LO-SP-002-000023', NULL),
(24, 24, 248, 0, 5, 'B-05', '2028-12-31 00:00:00', 'LO-SP-002-000024', NULL),
(25, 25, 85, 0, 5, 'B-06', '2028-12-31 00:00:00', 'LO-SP-002-000025', NULL),
(26, 26, 92, 0, 5, 'B-07', '2028-12-31 00:00:00', 'LO-SP-002-000026', NULL),
(27, 27, 99, 0, 5, 'B-08', '2028-12-31 00:00:00', 'LO-SP-002-000027', NULL),
(28, 28, 106, 0, 5, 'B-09', '2028-12-31 00:00:00', 'LO-SP-002-000028', NULL),
(29, 29, 113, 0, 5, 'B-10', '2028-12-31 00:00:00', 'LO-SP-002-000029', NULL),
(30, 30, 120, 0, 5, 'B-01', '2028-12-31 00:00:00', 'LO-SP-002-000030', NULL),
(31, 31, 127, 0, 5, 'B-02', '2028-12-31 00:00:00', 'LO-SP-002-000031', NULL),
(32, 32, 134, 0, 5, 'B-03', '2028-12-31 00:00:00', 'LO-SP-002-000032', NULL),
(33, 33, 141, 0, 5, 'B-04', '2028-12-31 00:00:00', 'LO-SP-002-000033', NULL),
(34, 34, 148, 0, 5, 'B-05', '2028-12-31 00:00:00', 'LO-SP-002-000034', NULL),
(35, 35, 155, 0, 5, 'B-06', '2028-12-31 00:00:00', 'LO-SP-002-000035', NULL),
(36, 36, 162, 0, 5, 'B-07', '2028-12-31 00:00:00', 'LO-SP-002-000036', NULL),
(37, 37, 169, 0, 5, 'B-08', '2028-12-31 00:00:00', 'LO-SP-002-000037', NULL),
(38, 38, 176, 0, 5, 'B-09', '2028-12-31 00:00:00', 'LO-SP-002-000038', NULL),
(39, 39, 183, 0, 5, 'B-10', '2028-12-31 00:00:00', 'LO-SP-002-000039', NULL),
(40, 40, 190, 0, 5, 'B-01', '2028-12-31 00:00:00', 'LO-SP-002-000040', NULL),
(41, 41, 197, 0, 5, 'B-02', '2028-12-31 00:00:00', 'LO-SP-002-000041', NULL),
(42, 42, 204, 0, 5, 'B-03', '2028-12-31 00:00:00', 'LO-SP-002-000042', NULL),
(43, 43, 211, 0, 5, 'B-04', '2028-12-31 00:00:00', 'LO-SP-002-000043', NULL),
(44, 44, 218, 0, 5, 'B-05', '2028-12-31 00:00:00', 'LO-SP-002-000044', NULL),
(45, 45, 225, 0, 5, 'B-06', '2028-12-31 00:00:00', 'LO-SP-002-000045', NULL),
(50, 50, 90, 0, 5, 'B-01', '2028-12-31 00:00:00', 'LO-SP-002-000050', NULL),
(51, 51, 97, 0, 10, 'C-02', '2028-12-31 00:00:00', 'LO-SP-003-000051', NULL),
(52, 52, 104, 0, 10, 'C-03', '2028-12-31 00:00:00', 'LO-SP-003-000052', NULL),
(53, 53, 111, 0, 10, 'C-04', '2028-12-31 00:00:00', 'LO-SP-003-000053', NULL),
(54, 54, 118, 0, 10, 'C-05', '2028-12-31 00:00:00', 'LO-SP-003-000054', NULL),
(55, 55, 125, 0, 10, 'C-06', '2028-12-31 00:00:00', 'LO-SP-003-000055', NULL),
(56, 56, 132, 0, 10, 'C-07', '2028-12-31 00:00:00', 'LO-SP-003-000056', NULL),
(57, 57, 139, 0, 10, 'C-08', '2028-12-31 00:00:00', 'LO-SP-003-000057', NULL),
(58, 58, 146, 0, 10, 'C-09', '2028-12-31 00:00:00', 'LO-SP-003-000058', NULL),
(61, 61, 167, 0, 10, 'C-02', '2028-12-31 00:00:00', 'LO-SP-003-000061', NULL),
(65, 65, 195, 0, 10, 'C-06', '2028-12-31 00:00:00', 'LO-SP-003-000065', NULL),
(66, 66, 202, 0, 10, 'C-07', '2028-12-31 00:00:00', 'LO-SP-003-000066', NULL),
(67, 67, 209, 0, 10, 'C-08', '2028-12-31 00:00:00', 'LO-SP-003-000067', NULL),
(68, 68, 216, 0, 10, 'C-09', '2028-12-31 00:00:00', 'LO-SP-003-000068', NULL),
(69, 69, 223, 0, 10, 'C-10', '2028-12-31 00:00:00', 'LO-SP-003-000069', NULL),
(70, 70, 230, 0, 10, 'C-01', '2028-12-31 00:00:00', 'LO-SP-003-000070', NULL),
(71, 71, 237, 0, 10, 'D-02', NULL, 'LO-SP-004-000071', NULL),
(73, 73, 81, 0, 10, 'D-04', NULL, 'LO-SP-004-000073', NULL),
(75, 75, 95, 0, 10, 'D-06', NULL, 'LO-SP-004-000075', NULL),
(76, 76, 102, 0, 10, 'D-07', NULL, 'LO-SP-004-000076', NULL),
(77, 77, 109, 0, 10, 'D-08', NULL, 'LO-SP-004-000077', NULL),
(81, 81, 137, 0, 10, 'D-02', NULL, 'LO-SP-004-000081', NULL),
(83, 83, 151, 0, 10, 'D-04', NULL, 'LO-SP-004-000083', NULL),
(84, 84, 158, 0, 10, 'D-05', NULL, 'LO-SP-004-000084', NULL),
(89, 89, 193, 0, 10, 'D-10', NULL, 'LO-SP-004-000089', NULL),
(90, 90, 200, 0, 10, 'D-01', NULL, 'LO-SP-004-000090', NULL);
-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `inventory_logs`
--

CREATE TABLE `inventory_logs` (
  `LogID` int NOT NULL,
  `InventoryID` int NOT NULL,
  `ChangeQuantity` int NOT NULL,
  `LogType` varchar(20) DEFAULT NULL,
  `ReferenceID` varchar(50) DEFAULT NULL,
  `PerformedBy` int DEFAULT NULL,
  `Note` text,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `inventory_logs`
--

INSERT INTO `inventory_logs` (`LogID`, `InventoryID`, `ChangeQuantity`, `LogType`, `ReferenceID`, `PerformedBy`, `Note`, `CreatedAt`) VALUES
(1, 91, 4, 'IMPORT', '5', 6, 'Nhập kho từ phiếu GR-20260523-2505', '2026-05-23 06:29:01'),
(2, 92, 1500, 'IMPORT', '7', 6, 'Nhập kho từ phiếu GR-20260523-3858', '2026-05-23 07:20:02'),
(3, 93, 1000000, 'IMPORT', '7', 6, 'Nhập kho từ phiếu GR-20260523-3858', '2026-05-23 07:20:02'),
(4, 94, 4850, 'IMPORT', '8', 6, 'Nhập kho từ phiếu GR-20260523-4494', '2026-05-23 08:08:33'),
(5, 95, 1952, 'IMPORT', '9', 6, 'Nhập kho từ phiếu GR-20260524-8219', '2026-05-24 05:56:58'),
(6, 96, 1000000, 'IMPORT', '9', 6, 'Nhập kho từ phiếu GR-20260524-8219', '2026-05-24 05:56:58'),
(7, 97, 48, 'IMPORT', '10', 6, 'Nhập kho từ phiếu GR-20260524-9440', '2026-05-24 06:15:59'),
(8, 98, 10, 'IMPORT', '11', 6, 'Nhập kho từ phiếu GR-20260524-5064', '2026-05-24 06:27:53'),
(9, 99, 48, 'IMPORT', '12', 6, 'Nhập kho từ phiếu GR-20260524-4493', '2026-05-24 06:31:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `inventory_stocktakes`
--

CREATE TABLE `inventory_stocktakes` (
  `stocktake_id` int NOT NULL,
  `stocktake_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `stocktake_date` date NOT NULL,
  `warehouse_area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_general_ci,
  `status` enum('draft','pending','approved','rejected') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'draft',
  `created_by` int DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `rejected_by` int DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `reject_reason` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `inventory_stocktake_details`
--

CREATE TABLE `inventory_stocktake_details` (
  `stocktake_detail_id` int NOT NULL,
  `stocktake_id` int NOT NULL,
  `inventory_id` int NOT NULL,
  `product_id` int NOT NULL,
  `system_quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `actual_quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `difference_quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_condition` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `loss_reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image_url` text COLLATE utf8mb4_general_ci,
  `note` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL,
  `order_id` int NOT NULL,
  `total` decimal(15,2) NOT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `staff_id` int NOT NULL COMMENT 'ID nhân viên bán hàng lập đơn',
  `create_by` varchar(255) DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remaining_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `shipping_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `status` enum('PENDING','PROCESSING','SHIPPED','COMPLETED','CANCELLED') DEFAULT 'PENDING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payment_status` varchar(20) DEFAULT 'UNPAID',
  `payment_due_date` date DEFAULT NULL,
  `fully_paid_at` datetime DEFAULT NULL,
  `early_payment_days` int NOT NULL DEFAULT '0',
  `late_payment_days` int NOT NULL DEFAULT '0',
  `early_commission_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `late_interest_total` decimal(15,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `staff_id`, `create_by`, `total_amount`, `paid_amount`, `remaining_amount`, `shipping_address`, `status`, `created_at`, `updated_at`, `payment_status`, `payment_due_date`, `fully_paid_at`, `early_payment_days`, `late_payment_days`, `early_commission_total`, `late_interest_total`) VALUES
(13, 1, 2, 'sale01@gmail.com', 165000.00, 165000.00, 0.00, 'Cần Thơ', 'PENDING', '2026-05-26 06:07:28', '2026-05-26 06:19:27', 'PAID', '2026-06-25', '2026-05-26 06:19:27', 30, 0, 1980.00, 0.00),
(14, 1, 2, 'sale01@gmail.com', 82500.00, 82500.00, 0.00, 'Cần Thơ', 'PENDING', '2026-05-26 07:35:26', '2026-05-28 15:11:50', 'PAID', '2026-06-25', '2026-05-28 15:11:50', 28, 0, 924.00, 0.00),
(15, 1, 2, 'sale01@gmail.com', 165000.00, 0.00, 165000.00, 'Tại cửa hàng', 'PENDING', '2026-05-26 15:25:38', '2026-05-26 15:25:38', 'UNPAID', '2026-05-26', NULL, 0, 0, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(2, 13, 1, 2, 82500.00),
(3, 14, 1, 1, 82500.00),
(4, 15, 1, 2, 82500.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_payment_terms`
--

CREATE TABLE `order_payment_terms` (
  `order_payment_term_id` int NOT NULL,
  `order_id` int NOT NULL,
  `payment_term_template_id` int DEFAULT NULL,
  `term_name` varchar(100) NOT NULL,
  `credit_days` int NOT NULL DEFAULT '0',
  `early_commission_rate_per_day` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `late_interest_rate_per_day` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `order_date` date NOT NULL,
  `due_date` date NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `order_payment_terms`
--

INSERT INTO `order_payment_terms` (`order_payment_term_id`, `order_id`, `payment_term_template_id`, `term_name`, `credit_days`, `early_commission_rate_per_day`, `late_interest_rate_per_day`, `order_date`, `due_date`, `created_at`) VALUES
(2, 13, 2, 'Công nợ 30 ngày', 30, 0.000400, 0.000400, '2026-05-26', '2026-06-25', '2026-05-26 06:07:28'),
(3, 14, 2, 'Công nợ 30 ngày', 30, 0.000400, 0.000400, '2026-05-26', '2026-06-25', '2026-05-26 07:35:27'),
(4, 15, 1, 'Thanh toán ngay', 0, 0.000000, 0.000000, '2026-05-26', '2026-05-26', '2026-05-26 15:25:38');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_status_log`
--

CREATE TABLE `order_status_log` (
  `LogID` int NOT NULL,
  `OrderID` int DEFAULT NULL,
  `ChangedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_installment_id` int DEFAULT NULL,
  `payment_qr_id` int DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `transaction_code` varchar(100) DEFAULT NULL,
  `transfer_content` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'completed',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `confirmed_by` int DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`payment_id`, `customer_id`, `order_id`, `payment_installment_id`, `payment_qr_id`, `amount`, `method`, `transaction_code`, `transfer_content`, `payment_date`, `status`, `note`, `confirmed_by`, `confirmed_at`) VALUES
(1, 1, NULL, NULL, NULL, 7000000.00, 'transfer', NULL, NULL, '2026-04-29 18:18:31', 'completed', NULL, NULL, NULL),
(2, 1, NULL, NULL, NULL, 7000000.00, 'transfer', NULL, NULL, '2026-04-29 18:18:47', 'completed', NULL, NULL, NULL),
(3, 2, NULL, NULL, NULL, 400000.00, 'transfer', NULL, NULL, '2026-04-29 18:41:00', 'completed', NULL, NULL, NULL),
(4, 2, NULL, NULL, NULL, 500000.00, 'cash', NULL, NULL, '2026-04-29 18:42:35', 'completed', NULL, NULL, NULL),
(7, 2, NULL, NULL, NULL, 500000.00, 'cash', NULL, NULL, '2026-04-29 18:52:10', 'completed', NULL, NULL, NULL),
(8, 2, NULL, NULL, NULL, 500000.00, 'cash', NULL, NULL, '2026-04-29 18:52:11', 'completed', NULL, NULL, NULL),
(9, 2, NULL, NULL, NULL, 500000.00, 'cash', NULL, NULL, '2026-04-29 18:52:12', 'completed', NULL, NULL, NULL),
(10, 2, NULL, NULL, NULL, 10000000.00, 'cash', NULL, NULL, '2026-04-29 18:54:34', 'completed', NULL, NULL, NULL),
(11, 2, NULL, NULL, NULL, 3600000.00, 'cash', NULL, NULL, '2026-04-29 18:54:47', 'completed', NULL, NULL, NULL),
(12, 2, NULL, NULL, NULL, 9920000.00, 'cash', NULL, NULL, '2026-04-29 18:59:36', 'completed', NULL, NULL, NULL),
(16, 1, 13, 1, 1, 165000.00, 'BANK_TRANSFER', 'BANK_TEST_ORD13_DOT1', 'AGRO ORD13 DOT1', '2026-05-26 06:19:27', 'COMPLETED', 'Thanh toán tự động qua webhook', NULL, '2026-05-26 06:19:27'),
(17, 1, 14, 10, 10, 20000.00, 'BANK_TRANSFER', 'FT24012345678', 'AGRO0001409 chuyen tien', '2026-05-26 17:04:13', 'COMPLETED', 'Thanh toán tự động qua webhook', NULL, '2026-05-26 17:04:13'),
(18, 1, 14, 19, 19, 2000.00, 'BANK_TRANSFER', '840T26519XFL286U', 'AGRO0001418', '2026-05-27 16:51:43', 'COMPLETED', 'Thanh toán tự động qua SePay. Match bằng TRANSFER_CONTENT. Nội dung NH: CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001418 840T26519XFL286U', NULL, '2026-05-27 16:51:43'),
(19, 1, 14, 20, 20, 2000.00, 'BANK_TRANSFER', '840T2651BDJG2XUZ', 'AGRO0001419', '2026-05-28 14:21:14', 'COMPLETED', 'Thanh toán tự động qua SePay. Match bằng TRANSFER_CONTENT. Nội dung NH: CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001419 840T2651BDJG2XUZ', NULL, '2026-05-28 14:21:14'),
(20, 1, 14, 24, 24, 58500.00, 'BANK_TRANSFER', '1JwxY-89RZ49pxj', 'AGRO0001423', '2026-05-28 15:11:50', 'COMPLETED', 'Thanh toán tự động qua SePay. Match bằng TRANSFER_CONTENT. Nội dung NH: SEVQR AGRO0001423 BankAPINotify SEVQR AGRO0001423 AGRO0001423 1JwxY-89RZ49pxj', NULL, '2026-05-28 15:11:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_installments`
--

CREATE TABLE `payment_installments` (
  `payment_installment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `installment_no` int NOT NULL,
  `input_amount` decimal(15,2) NOT NULL COMMENT 'Số tiền Sale nhập cho đợt thanh toán',
  `qr_amount` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Số tiền đưa vào mã QR',
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Số tiền thực tế đã nhận',
  `payment_date` datetime DEFAULT NULL,
  `status` enum('DRAFT','QR_CREATED','PAID','PARTIAL','CANCELLED','EXPIRED') NOT NULL DEFAULT 'DRAFT',
  `note` text,
  `created_by` int DEFAULT NULL,
  `confirmed_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_installments`
--

INSERT INTO `payment_installments` (`payment_installment_id`, `order_id`, `customer_id`, `installment_no`, `input_amount`, `qr_amount`, `paid_amount`, `payment_date`, `status`, `note`, `created_by`, `confirmed_by`, `created_at`, `updated_at`) VALUES
(1, 13, 1, 1, 165000.00, 165000.00, 165000.00, '2026-05-26 06:19:27', 'PAID', NULL, 2, NULL, '2026-05-26 06:10:41', '2026-05-26 06:19:27'),
(2, 14, 1, 1, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 07:35:59', '2026-05-26 07:35:59'),
(3, 14, 1, 2, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 07:37:36', '2026-05-26 07:37:36'),
(4, 14, 1, 3, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 08:35:58', '2026-05-26 08:35:58'),
(5, 14, 1, 4, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 15:26:19', '2026-05-26 15:26:19'),
(6, 14, 1, 5, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 15:30:10', '2026-05-26 15:30:10'),
(7, 14, 1, 6, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 15:47:24', '2026-05-26 15:47:24'),
(8, 14, 1, 7, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 16:17:02', '2026-05-26 16:17:02'),
(9, 14, 1, 8, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 16:19:02', '2026-05-26 16:19:02'),
(10, 14, 1, 9, 20000.00, 20000.00, 20000.00, '2026-05-26 17:04:13', 'PAID', NULL, 2, NULL, '2026-05-26 16:50:29', '2026-05-26 17:04:13'),
(11, 14, 1, 10, 20000.00, 20000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-26 17:28:15', '2026-05-26 17:28:15'),
(12, 14, 1, 11, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 15:19:28', '2026-05-27 15:19:28'),
(13, 14, 1, 12, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 15:50:02', '2026-05-27 15:50:02'),
(14, 14, 1, 13, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 16:12:34', '2026-05-27 16:12:34'),
(15, 14, 1, 14, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 16:27:06', '2026-05-27 16:27:06'),
(16, 14, 1, 15, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 16:33:34', '2026-05-27 16:33:34'),
(17, 14, 1, 16, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 16:41:05', '2026-05-27 16:41:05'),
(18, 14, 1, 17, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-27 16:46:10', '2026-05-27 16:46:10'),
(19, 14, 1, 18, 2000.00, 2000.00, 2000.00, '2026-05-27 16:51:43', 'PAID', NULL, 2, NULL, '2026-05-27 16:51:22', '2026-05-27 16:51:43'),
(20, 14, 1, 19, 2000.00, 2000.00, 2000.00, '2026-05-28 14:21:14', 'PAID', NULL, 2, NULL, '2026-05-28 14:20:42', '2026-05-28 14:21:14'),
(21, 14, 1, 20, 2000.00, 2000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-28 14:28:15', '2026-05-28 14:28:15'),
(22, 14, 1, 21, 58000.00, 58000.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-28 14:49:36', '2026-05-28 14:49:36'),
(23, 14, 1, 22, 58500.00, 58500.00, 0.00, NULL, 'QR_CREATED', NULL, 2, NULL, '2026-05-28 15:08:06', '2026-05-28 15:08:06'),
(24, 14, 1, 23, 58500.00, 58500.00, 58500.00, '2026-05-28 15:11:50', 'PAID', NULL, 2, NULL, '2026-05-28 15:11:15', '2026-05-28 15:11:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_qr_codes`
--

CREATE TABLE `payment_qr_codes` (
  `payment_qr_id` int NOT NULL,
  `payment_installment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `bank_account_id` int DEFAULT NULL,
  `provider` varchar(50) NOT NULL DEFAULT 'VIETQR',
  `qr_amount` decimal(15,2) NOT NULL,
  `transfer_content` varchar(255) NOT NULL,
  `qr_image_url` text,
  `qr_payload` text,
  `expired_at` datetime DEFAULT NULL,
  `status` enum('CREATED','PAID','EXPIRED','CANCELLED') NOT NULL DEFAULT 'CREATED',
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payment_code` varchar(30) DEFAULT NULL,
  `paid_transaction_code` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_qr_codes`
--

INSERT INTO `payment_qr_codes` (`payment_qr_id`, `payment_installment_id`, `order_id`, `customer_id`, `bank_account_id`, `provider`, `qr_amount`, `transfer_content`, `qr_image_url`, `qr_payload`, `expired_at`, `status`, `created_by`, `created_at`, `updated_at`, `payment_code`, `paid_transaction_code`) VALUES
(1, 1, 13, 1, 1, 'VIETQR', 165000.00, 'AGRO ORD13 DOT1', 'https://img.vietqr.io/image/970422-123456789-compact2.png?amount=165000&addInfo=AGRO+ORD13+DOT1&accountName=CONG+TY+TNHH+AGRO', '{\"bank_bin\":\"970422\",\"account_no\":\"123456789\",\"account_name\":\"CONG TY TNHH AGRO\",\"amount\":165000,\"transfer_content\":\"AGRO ORD13 DOT1\"}', '2026-05-26 06:40:41', 'PAID', 2, '2026-05-26 06:10:41', '2026-05-26 06:19:27', NULL, NULL),
(2, 2, 14, 1, 1, 'VIETQR', 20000.00, 'AGRO ORD14 DOT1', 'https://img.vietqr.io/image/547-9338839351-compact2.png?amount=20000&addInfo=AGRO+ORD14+DOT1&accountName=VO+THI+CAM+TU', '{\"bank_bin\":\"547\",\"account_no\":\"9338839351\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO ORD14 DOT1\"}', '2026-05-26 08:05:59', 'CREATED', 2, '2026-05-26 07:35:59', '2026-05-26 07:35:59', NULL, NULL),
(3, 3, 14, 1, 1, 'VIETQR', 20000.00, 'AGRO ORD14 DOT2', 'https://img.vietqr.io/image/970436-9338839351-compact2.png?amount=20000&addInfo=AGRO+ORD14+DOT2&accountName=VO+THI+CAM+TU', '{\"bank_bin\":\"970436\",\"account_no\":\"9338839351\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO ORD14 DOT2\"}', '2026-05-26 08:07:36', 'CREATED', 2, '2026-05-26 07:37:36', '2026-05-26 07:37:36', NULL, NULL),
(4, 4, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO ORD14 DOT3', 'https://img.vietqr.io/image/970436-9338839351-compact2.png?amount=20000&addInfo=AGRO+ORD14+DOT3&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970436\",\"account_no\":\"9338839351\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO ORD14 DOT3\"}', '2026-05-26 09:05:58', 'CREATED', 2, '2026-05-26 08:35:58', '2026-05-26 08:35:58', NULL, NULL),
(5, 5, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001404', 'https://img.vietqr.io/image/970436-9338839351-compact2.png?amount=20000&addInfo=AGRO0001404&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970436\",\"account_no\":\"9338839351\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001404\"}', '2026-05-26 15:56:19', 'CREATED', 2, '2026-05-26 15:26:19', '2026-05-26 15:26:19', NULL, NULL),
(6, 6, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001405', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001405&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001405\"}', '2026-05-26 16:00:10', 'CREATED', 2, '2026-05-26 15:30:10', '2026-05-26 15:30:10', NULL, NULL),
(7, 7, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001406', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001406&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001406\"}', '2026-05-26 16:17:24', 'CREATED', 2, '2026-05-26 15:47:24', '2026-05-26 15:47:24', NULL, NULL),
(8, 8, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001407', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001407&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001407\"}', '2026-05-26 16:47:02', 'CREATED', 2, '2026-05-26 16:17:02', '2026-05-26 16:17:02', NULL, NULL),
(9, 9, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001408', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001408&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001408\"}', '2026-05-26 16:49:02', 'CREATED', 2, '2026-05-26 16:19:02', '2026-05-26 16:19:02', NULL, NULL),
(10, 10, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001409', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001409&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001409\"}', '2026-05-26 17:20:29', 'PAID', 2, '2026-05-26 16:50:29', '2026-05-26 17:04:13', NULL, NULL),
(11, 11, 14, 1, 1, 'VIETQR_IMAGE', 20000.00, 'AGRO0001410', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=20000&addInfo=AGRO0001410&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":20000,\"transfer_content\":\"AGRO0001410\"}', '2026-05-26 17:58:15', 'EXPIRED', 2, '2026-05-26 17:28:15', '2026-05-27 15:18:56', NULL, NULL),
(12, 12, 14, 1, 1, 'VIETQR_IMAGE', 2000.00, 'AGRO0001411', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=2000&addInfo=AGRO0001411&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001411\"}', '2026-05-27 15:49:28', 'CREATED', 2, '2026-05-27 15:19:28', '2026-05-27 15:19:28', NULL, NULL),
(13, 13, 14, 1, 1, 'VIETQR_IMAGE', 2000.00, 'AGRO0001412', 'https://img.vietqr.io/image/970415-102876705963-compact2.png?amount=2000&addInfo=AGRO0001412&accountName=VO+THI+CAM+TU', '{\"provider\":\"VIETQR_IMAGE\",\"payment_confirm_provider\":\"SEPAY_OR_CASSO\",\"note\":\"VietQR chỉ sinh ảnh QR. SePay/Casso sẽ nhận biến động số dư và gọi webhook về backend.\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001412\"}', '2026-05-27 16:20:02', 'CREATED', 2, '2026-05-27 15:50:02', '2026-05-27 15:50:02', NULL, NULL),
(14, 14, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001413', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=AGRO0001413&template=compact', '{\"provider\":\"SEPAY_QR\",\"qr_provider\":\"qr.sepay.vn\",\"payment_confirm_provider\":\"SEPAY_WEBHOOK\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001413\",\"template\":\"compact\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=AGRO0001413&template=compact\"}', '2026-05-27 16:42:34', 'CREATED', 2, '2026-05-27 16:12:34', '2026-05-27 16:12:34', NULL, NULL),
(15, 15, 14, 1, 1, 'SEPAY_MANUAL_MATCH', 2000.00, 'AGRO0001414', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=AGRO0001414&template=compact', '{\"provider\":\"SEPAY_MANUAL_MATCH\",\"note\":\"QR tự build chỉ để tham khảo. Với tài khoản này nên dùng QR SePay thật, backend sẽ match webhook bằng accountNumber + amount hoặc mã AGRO nếu có.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001414\",\"reference_qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=AGRO0001414&template=compact\"}', '2026-05-27 16:57:06', 'CREATED', 2, '2026-05-27 16:27:06', '2026-05-27 16:27:06', NULL, NULL),
(16, 16, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001415', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001415&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001415\",\"sepay_description\":\"SEVQR AGRO0001415\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001415&template=compact\"}', '2026-05-27 17:03:34', 'CREATED', 2, '2026-05-27 16:33:34', '2026-05-27 16:33:34', NULL, NULL),
(17, 17, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001416', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001416&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001416\",\"sepay_description\":\"SEVQR AGRO0001416\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001416&template=compact\"}', '2026-05-27 17:11:05', 'CREATED', 2, '2026-05-27 16:41:05', '2026-05-27 16:41:05', NULL, NULL),
(18, 18, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001417', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001417&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001417\",\"sepay_description\":\"SEVQR AGRO0001417\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001417&template=compact\"}', '2026-05-27 17:16:10', 'CREATED', 2, '2026-05-27 16:46:10', '2026-05-27 16:46:10', NULL, NULL),
(19, 19, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001418', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001418&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001418\",\"sepay_description\":\"SEVQR AGRO0001418\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001418&template=compact\"}', '2026-05-27 17:21:22', 'PAID', 2, '2026-05-27 16:51:22', '2026-05-27 16:51:43', NULL, NULL),
(20, 20, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001419', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001419&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001419\",\"sepay_description\":\"SEVQR AGRO0001419\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001419&template=compact\"}', '2026-05-28 14:50:42', 'PAID', 2, '2026-05-28 14:20:42', '2026-05-28 14:21:14', NULL, NULL),
(21, 21, 14, 1, 1, 'SEPAY_QR', 2000.00, 'AGRO0001420', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001420&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":2000,\"transfer_content\":\"AGRO0001420\",\"sepay_description\":\"SEVQR AGRO0001420\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=2000&des=SEVQR+AGRO0001420&template=compact\"}', '2026-05-28 14:58:15', 'CREATED', 2, '2026-05-28 14:28:15', '2026-05-28 14:28:15', NULL, NULL),
(22, 22, 14, 1, 1, 'SEPAY_QR', 58000.00, 'AGRO0001421', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58000&des=SEVQR+AGRO0001421&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":58000,\"transfer_content\":\"AGRO0001421\",\"sepay_description\":\"SEVQR AGRO0001421\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58000&des=SEVQR+AGRO0001421&template=compact\"}', '2026-05-28 15:19:36', 'CREATED', 2, '2026-05-28 14:49:36', '2026-05-28 14:49:36', NULL, NULL),
(23, 23, 14, 1, 1, 'SEPAY_QR', 58500.00, 'AGRO0001422', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58500&des=SEVQR+AGRO0001422&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":58500,\"transfer_content\":\"AGRO0001422\",\"sepay_description\":\"SEVQR AGRO0001422\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58500&des=SEVQR+AGRO0001422&template=compact\"}', '2026-05-28 15:38:06', 'CREATED', 2, '2026-05-28 15:08:06', '2026-05-28 15:08:06', NULL, NULL),
(24, 24, 14, 1, 1, 'SEPAY_QR', 58500.00, 'AGRO0001423', 'https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58500&des=SEVQR+AGRO0001423&template=compact', '{\"provider\":\"SEPAY_QR\",\"note\":\"QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.\",\"bank_code\":\"970415\",\"bank_bin\":\"970415\",\"account_no\":\"102876705963\",\"account_name\":\"VO THI CAM TU\",\"amount\":58500,\"transfer_content\":\"AGRO0001423\",\"sepay_description\":\"SEVQR AGRO0001423\",\"qr_url\":\"https://qr.sepay.vn/img?acc=102876705963&bank=970415&amount=58500&des=SEVQR+AGRO0001423&template=compact\"}', '2026-05-28 15:41:15', 'PAID', 2, '2026-05-28 15:11:15', '2026-05-28 15:11:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_term_templates`
--

CREATE TABLE `payment_term_templates` (
  `payment_term_template_id` int NOT NULL,
  `term_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days` int NOT NULL DEFAULT '0',
  `early_commission_rate_per_day` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `late_interest_rate_per_day` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `display_on_home` tinyint(1) DEFAULT '0',
  `visible_to_sale` tinyint(1) DEFAULT '1',
  `display_order` int DEFAULT '0',
  `target_audience` enum('ALL','DEALER','CUSTOMER') COLLATE utf8mb4_unicode_ci DEFAULT 'DEALER',
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_term_templates`
--

INSERT INTO `payment_term_templates` (`payment_term_template_id`, `term_name`, `description`, `image_url`, `banner_url`, `credit_days`, `early_commission_rate_per_day`, `late_interest_rate_per_day`, `is_active`, `display_on_home`, `visible_to_sale`, `display_order`, `target_audience`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Thanh toán ngay', 'Khách thanh toán ngay khi tạo đơn', '/images/uploads/promotions/anh3.jpg', '/images/uploads/promotions/anh3.jpg', 0, 0.040000, 0.000000, 1, 0, 1, 0, 'DEALER', NULL, NULL, '2026-05-26 04:49:00', '2026-05-28 15:41:37'),
(2, 'Công nợ 30 ngày', 'Thanh toán sau 30 ngày, trả sớm hưởng hoa hồng, trả trễ tính lãi', '/images/uploads/promotions/anh1.jpg', '/images/uploads/promotions/anh1.jpg', 30, 0.000400, 0.000400, 1, 0, 1, 0, 'DEALER', NULL, NULL, '2026-05-26 04:49:00', '2026-05-28 05:05:43'),
(3, 'Công nợ 60 ngày', 'Thanh toán sau 60 ngày, trả sớm hưởng hoa hồng, trả trễ tính lãi', '/images/uploads/promotions/anh2.jpg', '/images/uploads/promotions/anh2.jpg', 60, 0.000400, 0.000400, 1, 1, 1, 0, 'DEALER', NULL, NULL, '2026-05-26 04:49:00', '2026-05-28 05:05:43'),
(4, 'Ưu đãi mùa vụ 45 ngày', 'Chương trình mùa vụ cho đại lý', '/images/uploads/promotions/1779973068193-image_Nero_AI_Image_Upscaler_Photo_Face.png', 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80', 45, 0.010000, 0.050000, 1, 0, 0, 0, 'DEALER', NULL, NULL, '2026-05-26 04:49:00', '2026-05-28 12:57:48');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_webhook_logs`
--

CREATE TABLE `payment_webhook_logs` (
  `webhook_log_id` int NOT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `raw_payload` json NOT NULL,
  `transfer_content` text,
  `transaction_code` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `matched_payment_qr_id` int DEFAULT NULL,
  `matched_payment_installment_id` int DEFAULT NULL,
  `matched_order_id` int DEFAULT NULL,
  `process_status` enum('RECEIVED','MATCHED','FAILED','DUPLICATED') NOT NULL DEFAULT 'RECEIVED',
  `error_message` text,
  `received_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `processed_at` datetime DEFAULT NULL,
  `response_status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_webhook_logs`
--

INSERT INTO `payment_webhook_logs` (`webhook_log_id`, `provider`, `raw_payload`, `transfer_content`, `transaction_code`, `amount`, `matched_payment_qr_id`, `matched_payment_installment_id`, `matched_order_id`, `process_status`, `error_message`, `received_at`, `processed_at`, `response_status`) VALUES
(4, 'BANK_API', '{\"amount\": 165000, \"transaction_code\": \"BANK_TEST_ORD13_DOT1\", \"transfer_content\": \"AGRO ORD13 DOT1\"}', 'AGRO ORD13 DOT1', 'BANK_TEST_ORD13_DOT1', 165000.00, 1, 1, 13, 'MATCHED', NULL, '2026-05-26 06:19:27', '2026-05-26 06:19:27', NULL),
(5, 'BANK_API', '{}', NULL, NULL, 0.00, NULL, NULL, NULL, 'FAILED', 'Webhook thiếu transfer_content, transaction_code hoặc amount', '2026-05-26 08:38:10', '2026-05-26 08:38:10', NULL),
(6, 'Vietcombank', '{\"id\": 92704, \"code\": \"AGRO0001301\", \"content\": \"AGRO0001301 chuyen tien\", \"gateway\": \"Vietcombank\", \"description\": \"AGRO0001301 chuyen tien\", \"transferType\": \"in\", \"accountNumber\": \"1017588888\", \"referenceCode\": \"FT24012345678\", \"transferAmount\": 500000, \"transactionDate\": \"2026-05-26 15:00:00\"}', 'AGRO0001301 chuyen tien', 'FT24012345678', 500000.00, NULL, NULL, NULL, 'FAILED', 'Không tìm thấy QR theo nội dung chuyển khoản', '2026-05-26 16:58:05', '2026-05-26 16:58:05', NULL),
(7, 'Vietcombank', '{\"id\": 92704, \"code\": \"AGRO0001409\", \"content\": \"AGRO0001409 chuyen tien\", \"gateway\": \"Vietcombank\", \"description\": \"AGRO0001409 chuyen tien\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"FT24012345678\", \"transferAmount\": 20000, \"transactionDate\": \"2026-05-26 15:00:00\"}', 'AGRO0001409 chuyen tien', 'FT24012345678', 20000.00, 10, 10, 14, 'MATCHED', NULL, '2026-05-26 17:04:13', '2026-05-26 17:04:13', NULL),
(8, 'Vietcombank', '{\"id\": 92704, \"code\": \"AGRO0001409\", \"content\": \"AGRO0001409 chuyen tien\", \"gateway\": \"Vietcombank\", \"description\": \"AGRO0001409 chuyen tien\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"FT24012345678\", \"transferAmount\": 20000, \"transactionDate\": \"2026-05-26 15:00:00\"}', 'AGRO0001409 chuyen tien', 'FT24012345678', 20000.00, NULL, NULL, NULL, 'DUPLICATED', NULL, '2026-05-26 17:20:52', '2026-05-26 17:20:52', NULL),
(9, 'SEPAY', '{}', NULL, NULL, 0.00, NULL, NULL, NULL, 'FAILED', 'Webhook thiếu transfer_content, transaction_code hoặc amount', '2026-05-26 17:21:00', '2026-05-26 17:21:00', NULL),
(10, 'SEPAY', '{}', NULL, NULL, 0.00, NULL, NULL, NULL, 'FAILED', 'Webhook thiếu transfer_content, transaction_code hoặc amount', '2026-05-26 17:25:07', '2026-05-26 17:25:08', NULL),
(11, 'SePay', '{\"id\": 0, \"code\": \"SEPAYTEST\", \"content\": \"SEPAY TEST WEBHOOK\", \"gateway\": \"SePay\", \"subAccount\": null, \"accumulated\": 10000, \"description\": \"SePay test webhook delivery\", \"transferType\": \"in\", \"accountNumber\": \"0000000000\", \"referenceCode\": \"TEST1779816407\", \"transferAmount\": 10000, \"transactionDate\": \"2026-05-27 00:26:47\"}', 'SEPAY TEST WEBHOOK', 'TEST1779816407', 10000.00, NULL, NULL, NULL, 'FAILED', 'Không tìm thấy QR theo nội dung chuyển khoản', '2026-05-26 17:26:47', '2026-05-26 17:26:47', NULL),
(12, 'VietinBank', '{\"id\": 60734961, \"code\": null, \"content\": \"CT DEN:840T26519T9D731J MBVCB.14411622607.343698.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 73238, \"description\": \"BankAPINotify CT DEN:840T26519T9D731J MBVCB.14411622607.343698.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T26519T9D731J\", \"transferAmount\": 1000, \"transactionDate\": \"2026-05-27 22:04:00\"}', 'CT DEN:840T26519T9D731J MBVCB.14411622607.343698.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK', '840T26519T9D731J', 1000.00, NULL, NULL, NULL, 'FAILED', 'Không tìm thấy QR theo nội dung chuyển khoản', '2026-05-27 15:12:31', '2026-05-27 15:12:31', NULL),
(13, 'SePay', '{\"id\": 0, \"code\": \"SEPAYTEST\", \"content\": \"SEPAY TEST WEBHOOK\", \"gateway\": \"SePay\", \"subAccount\": null, \"accumulated\": 10000, \"description\": \"SePay test webhook delivery\", \"transferType\": \"in\", \"accountNumber\": \"0000000000\", \"referenceCode\": \"TEST1779897192\", \"transferAmount\": 10000, \"transactionDate\": \"2026-05-27 22:53:12\"}', 'SEPAY TEST WEBHOOK', 'TEST1779897192', 10000.00, NULL, NULL, NULL, 'FAILED', 'Không tìm thấy QR theo nội dung chuyển khoản', '2026-05-27 15:53:13', '2026-05-27 15:53:13', NULL),
(14, 'VietinBank', '{\"id\": 60739968, \"code\": null, \"content\": \"CT DEN:840T26519VAPFBHA MBVCB.14412007309.601986.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 58238, \"description\": \"BankAPINotify CT DEN:840T26519VAPFBHA MBVCB.14412007309.601986.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T26519VAPFBHA\", \"transferAmount\": 1000, \"transactionDate\": \"2026-05-27 22:56:29\"}', 'CT DEN:840T26519VAPFBHA MBVCB.14412007309.601986.SEVQR chuyen khoan.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK', '840T26519VAPFBHA', 1000.00, NULL, NULL, NULL, 'FAILED', 'Không tìm thấy QR theo nội dung chuyển khoản', '2026-05-27 15:56:31', '2026-05-27 15:56:31', NULL),
(15, 'VietinBank', '{\"id\": 60743198, \"code\": \"AGRO0001417\", \"content\": \"CT DEN:840T26519X8QG1J9 MBVCB.14412224628.754485.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 68238, \"description\": \"BankAPINotify CT DEN:840T26519X8QG1J9 MBVCB.14412224628.754485.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T26519X8QG1J9\", \"transferAmount\": 2000, \"transactionDate\": \"2026-05-27 23:46:29\"}', 'CT DEN:840T26519X8QG1J9 MBVCB.14412224628.754485.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T26519X8QG1J9 MBVCB.14412224628.754485.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001417 840T26519X8QG1J9', '840T26519X8QG1J9', 2000.00, NULL, NULL, NULL, 'FAILED', 'Data too long for column \'transfer_content\' at row 1', '2026-05-27 16:46:31', '2026-05-27 16:46:31', NULL),
(16, 'VietinBank', '{\"id\": 60743250, \"code\": \"AGRO0001417\", \"content\": \"CT DEN:840T26519X9LAN1T MBVCB.14412219661.756137.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 70238, \"description\": \"BankAPINotify CT DEN:840T26519X9LAN1T MBVCB.14412219661.756137.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T26519X9LAN1T\", \"transferAmount\": 2000, \"transactionDate\": \"2026-05-27 23:47:09\"}', 'CT DEN:840T26519X9LAN1T MBVCB.14412219661.756137.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T26519X9LAN1T MBVCB.14412219661.756137.SEVQR AGRO0001417.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001417 840T26519X9LAN1T', '840T26519X9LAN1T', 2000.00, NULL, NULL, NULL, 'FAILED', 'Data too long for column \'transfer_content\' at row 1', '2026-05-27 16:47:10', '2026-05-27 16:47:10', NULL),
(17, 'VietinBank', '{\"id\": 60743509, \"code\": \"AGRO0001418\", \"content\": \"CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 72238, \"description\": \"BankAPINotify CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T26519XFL286U\", \"transferAmount\": 2000, \"transactionDate\": \"2026-05-27 23:51:41\"}', 'CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T26519XFL286U MBVCB.14412235566.766940.SEVQR AGRO0001418.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001418 840T26519XFL286U', '840T26519XFL286U', 2000.00, 19, 19, 14, 'MATCHED', NULL, '2026-05-27 16:51:43', '2026-05-27 16:51:43', NULL),
(18, 'VietinBank', '{\"id\": 60871768, \"code\": \"AGRO0001419\", \"content\": \"CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 74238, \"description\": \"BankAPINotify CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"840T2651BDJG2XUZ\", \"transferAmount\": 2000, \"transactionDate\": \"2026-05-28 21:21:12\"}', 'CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK BankAPINotify CT DEN:840T2651BDJG2XUZ MBVCB.14424989317.981904.SEVQR AGRO0001419.CT tu 9338839351 VO THI CAM TU toi 102876705963 VO THI CAM TU tai VIETINBANK AGRO0001419 840T2651BDJG2XUZ', '840T2651BDJG2XUZ', 2000.00, 20, 20, 14, 'MATCHED', NULL, '2026-05-28 14:21:14', '2026-05-28 14:21:14', NULL),
(19, 'VietinBank', '{\"id\": 60878320, \"code\": \"AGRO0001423\", \"content\": \"SEVQR AGRO0001423\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 132738, \"description\": \"BankAPINotify SEVQR AGRO0001423\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"1JwxY-89RZ49pxj\", \"transferAmount\": 58500, \"transactionDate\": \"2026-05-28 22:11:48\"}', 'SEVQR AGRO0001423 BankAPINotify SEVQR AGRO0001423 AGRO0001423 1JwxY-89RZ49pxj', '1JwxY-89RZ49pxj', 58500.00, 24, 24, 14, 'MATCHED', NULL, '2026-05-28 15:11:50', '2026-05-28 15:11:50', NULL),
(20, 'VietinBank', '{\"id\": 60879336, \"code\": \"AGRO0001422\", \"content\": \"ZP7CUBJJLKJE SEVQR AGRO0001422\", \"gateway\": \"VietinBank\", \"subAccount\": null, \"accumulated\": 191238, \"description\": \"BankAPINotify ZP7CUBJJLKJE SEVQR AGRO0001422\", \"transferType\": \"in\", \"accountNumber\": \"102876705963\", \"referenceCode\": \"1T1RY-89RZdJV5C\", \"transferAmount\": 58500, \"transactionDate\": \"2026-05-28 22:20:28\"}', 'ZP7CUBJJLKJE SEVQR AGRO0001422 BankAPINotify ZP7CUBJJLKJE SEVQR AGRO0001422 AGRO0001422 1T1RY-89RZdJV5C', '1T1RY-89RZdJV5C', 58500.00, 23, 23, 14, 'FAILED', 'Đơn hàng đã thanh toán đủ', '2026-05-28 15:20:30', '2026-05-28 15:20:30', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pesticide`
--

CREATE TABLE `pesticide` (
  `PID` int NOT NULL,
  `ProductID` int DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `pesticide`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pesticide_crops`
--

CREATE TABLE `pesticide_crops` (
  `ID` int NOT NULL,
  `PDetailID` int DEFAULT NULL,
  `CropID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `pesticide_crops`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pesticide_detail`
--

CREATE TABLE `pesticide_detail` (
  `PDetailID` int NOT NULL,
  `PID` int DEFAULT NULL,
  `Dosage` varchar(100) DEFAULT NULL,
  `Method` text,
  `Time` varchar(100) DEFAULT NULL,
  `Harvest_interval` varchar(100) DEFAULT NULL,
  `Safety_warning` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `pesticide_detail`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pesticide_pests`
--

CREATE TABLE `pesticide_pests` (
  `ID` int NOT NULL,
  `PDetailID` int NOT NULL,
  `PestID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `pesticide_pests`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pesticide_usage`
--

CREATE TABLE `pesticide_usage` (
  `UsageID` int NOT NULL,
  `PDetailID` int DEFAULT NULL,
  `ToxicID` int DEFAULT NULL,
  `Precaution` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `pesticide_usage`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pests`
--

CREATE TABLE `pests` (
  `PestID` int NOT NULL,
  `PestName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `pests`
--

INSERT INTO `pests` (`PestID`, `PestName`, `Description`) VALUES
(1, 'Sâu ăn lá', 'Nhóm sâu gây hại bằng cách cắn phá lá non và lá trưởng thành.'),
(2, 'Sâu cuốn lá', 'Sâu cuốn lá lại để trú ẩn và ăn phần biểu bì lá, thường gặp trên lúa.'),
(3, 'Sâu đục thân', 'Sâu gây hại bằng cách đục vào thân cây, làm cây héo hoặc gãy đổ.'),
(4, 'Sâu xanh', 'Sâu thường gây hại trên rau màu, cà chua, ớt và cây ăn quả.'),
(5, 'Sâu tơ', 'Đối tượng gây hại phổ biến trên rau họ cải, làm thủng lá và giảm năng suất.'),
(6, 'Sâu khoang', 'Sâu ăn tạp, gây hại trên nhiều loại rau màu và cây công nghiệp.'),
(7, 'Rầy nâu', 'Côn trùng chích hút gây hại chủ yếu trên cây lúa, có thể truyền bệnh virus.'),
(8, 'Rầy mềm', 'Côn trùng chích hút nhựa cây, thường xuất hiện trên rau màu và cây ăn quả.'),
(9, 'Rệp sáp', 'Côn trùng chích hút, thường gây hại trên cây ăn quả, cà phê, hồ tiêu.'),
(10, 'Bọ trĩ', 'Côn trùng nhỏ gây xoăn lá, bạc lá, rụng hoa và giảm năng suất.'),
(11, 'Nhện đỏ', 'Đối tượng gây hại bằng cách chích hút mặt dưới lá, làm lá vàng và rụng.'),
(12, 'Ruồi đục quả', 'Gây hại trên trái cây bằng cách đẻ trứng vào quả, làm quả thối và rụng.'),
(13, 'Mọt đục quả', 'Gây hại bằng cách đục vào quả hoặc hạt, thường gặp trên cà phê.'),
(14, 'Sâu vẽ bùa', 'Gây hại trên lá non cây có múi, tạo đường ngoằn ngoèo trên lá.'),
(15, 'Bệnh đạo ôn', 'Bệnh hại phổ biến trên lúa, gây cháy lá, cổ bông và giảm năng suất.'),
(16, 'Bệnh phấn trắng', 'Bệnh nấm tạo lớp phấn trắng trên lá, hoa hoặc thân non.'),
(17, 'Bệnh sương mai', 'Bệnh nấm thường gặp trên rau màu, làm lá vàng, cháy và rụng.'),
(18, 'Bệnh thán thư', 'Bệnh nấm gây đốm đen, thối quả, khô cành trên nhiều cây trồng.'),
(19, 'Bệnh mốc sương', 'Bệnh nguy hiểm trên khoai tây, cà chua, gây thối lá và thân.'),
(20, 'Bệnh gỉ sắt', 'Bệnh nấm thường gặp trên cà phê, làm lá vàng và rụng sớm.'),
(21, 'Bệnh vàng lá', 'Bệnh làm lá chuyển vàng, cây sinh trưởng kém, thường gặp trên cây có múi.'),
(22, 'Bệnh chết nhanh', 'Bệnh nguy hiểm trên hồ tiêu, làm cây héo nhanh và chết hàng loạt.'),
(23, 'Bệnh chết chậm', 'Bệnh gây suy yếu rễ, vàng lá và làm cây hồ tiêu chết từ từ.'),
(24, 'Bệnh đốm nâu', 'Bệnh gây đốm trên thân, cành hoặc quả, thường gặp trên thanh long.'),
(25, 'Bệnh thối cành', 'Bệnh làm mềm, thối và khô cành, ảnh hưởng đến sinh trưởng cây.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `ProductID` int NOT NULL,
  `ProductName` varchar(100) DEFAULT NULL,
  `SKU` varchar(50) DEFAULT NULL,
  `Slug` varchar(255) DEFAULT NULL,
  `Description` text COMMENT 'Mô tả chi tiết để AI tư vấn khách hàng',
  `Price` decimal(15,2) DEFAULT NULL COMMENT 'Giá bán niêm yết trên Website',
  `CategoryID` int DEFAULT NULL,
  `StatusID` int DEFAULT NULL COMMENT 'Liên kết bảng product_status (Trạng thái hiển thị)',
  `UnitID` int DEFAULT NULL,
  `ImageID` int DEFAULT NULL,
  `Brand` varchar(100) DEFAULT NULL,
  `OriginCountry` varchar(100) DEFAULT NULL,
  `Weight` decimal(10,2) DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TechnicalContent` text COMMENT 'Thành phần kỹ thuật / thông tin kỹ thuật của sản phẩm',
  `UsageInstructions` text COMMENT 'Hướng dẫn sử dụng sản phẩm'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`ProductID`, `ProductName`, `SKU`, `Slug`, `Description`, `Price`, `CategoryID`, `StatusID`, `UnitID`, `ImageID`, `Brand`, `OriginCountry`, `Weight`, `IsActive`, `CreatedAt`, `UpdatedAt`, `TechnicalContent`, `UsageInstructions`) VALUES
(1, '0-52-34 Kích Tạo Mầm Hoa - Xử Lý Hoa Nghịch Mùa', 'PB.1638', 'td-0-52-34-kich-tao-mam-hoa-xu-ly-hoa-nghich-mua', 'Công dụng: Kích thích tạo mầm hoa, xử lý ra hoa nghịch mùa - Ức chế đọt non, mau già lá, chống nghẹt bông - Nuôi trái, dưỡng trái, mỏng vỏ, chắc hạt - Ra rễ mạnh, hạ phèn, cứng cây, chống đỗ ngã - Tăng sức đề kháng, chống chịu thời tiết bất lợi.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Hũ 100g
Giá tham khảo: 35.000đ', '35000.00', 1, 1, 4, 1, 'THIDICO', 'CANADA', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Bo(B) 2100ppm, Độ ẩm 1% , Nguyên liệu bổ sung : Moro Kali Phosphate (MKP) theo tỷ lệ NPK : 0-52-34.
Loại sản phẩm: Phân bón kích hoa', 'Hướng dẫn sử dụng: TD-MKP được sử dụng với công nghệ hoà tan, hoà tan. Sử dụng đa dạng cho các hệ thống phun tưới, hệ thống phun tưới nhỏ giọt và thuỷ canh. ♦ Đối với các loại cây:. Cây có múi: cam, quýt, bưởi, chanh. Cây ăn trái: sầu riêng, xoài, thanh long, chôm, chôm, mít, mãng cầu, ổi, nho, mận, nhãn, vải, bơ chanh dây. Cây công nghiệp: Cao su, cà phê, tiêu, điều. Cách sử dụng: Dùng trước khi ra hoa, dùng lặp lại sua khi hoa trổ rộ. Dưỡng trái dùng định kì 10-15 ngày/lần cho đến trước khi thu hoạch 10 ngày. Liều dùng: 100gram pha loãng 20 lít nước. ♦ Đối với cây: lúa, rau màu, hoa kiểng, hoa lan. Cách sử dụng: Giai đoạn trước ra hoa, nuôi trái. Liều dùng: 40-50gram cho bình 20 lít nước. CHÚ Ý :. Đọc kỹ hướng dẫn trước khi dùng. Hạn chế dùng chung sản phẩm chứa gốc đồng. Ngừng sử dụng 5-7 ngày trước khi thu hoạch. Hạn dùng : 3 năm.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(2, '15 - 12 - 17 Phân Bón NPK Hỗn Hợp | Chuyên Dùng Cho Hoa và Cây Cảnh', '151217', '15-12-17-phan-bon-npk-hon-hop-chuyen-dung-cho-hoa-va-cay-canh', 'Công dụng: – Bổ sung cân đối dinh dưỡng cho cây trồng trong các thời kì sinh trưởng và phát triển. – Phát triển cành lá non, làm cho lá xanh, bóng mượt. – Dưỡng hoa, giúp hoa tươi lâu, màu sắc đẹp, lâu tàn. – Cứng cây, chống đổ ngã. Giúp cây tăng sức đề kháng, kháng lại sâu bệnh hại và thời tiết khắc nghiệt. – Rất thích hợp cho các loại hoa, cây kiểng, cỏ sân gôn và rau sạch.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Gói 200g
Giá tham khảo: 25.000đ', '25000.00', 1, 1, 4, 12, 'CTY TNHH SX DV TM TRUNG HIỆP LỢI', NULL, '0.20', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: – N:15%. – P2O5 : 12%. – K2O: 17%.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Cây ăn trái, cây công nghiệp: 350 - 400kg/ha/năm, chia làm 2-3 lần bón. Cây lương thực, rau màu và các loại hoa: 300-400 kg/ha/vụ. Cây trồng ngoài chậu: 15-20gr/1 gốc. Cây trồng trong chậu ( Đường kính từ 15-25cm): 5-15gr/chậu/1 lần bón. Cây trồng luống, cỏ sân gôn: 40-50gr/m2/01 lần bón. CÁCH DÙNG:. + Bón rải đều xung quanh gốc cây. Sau đó tưới nước ướt để phân thấm đều. + Dùng cách nhau 1 tháng, thời kì ra hoa, dưỡng hoa có thể sau 15 – 20 ngày bón 1 lần.
An toàn sử dụng: Bảo quản: – Để nơi khô ráo, thoáng mát, tránh ánh nắng trực tiếp. Buộc kính sau khi sử dụng. – Để xa tầm tay trẻ em, nguồn nước, nguồn thực phẩm đang dùng. – Nguyên liệu ngoại nhập. Công nghệ của CHLB Đức. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(3, 'AC S.UPER K-CA Phân Bón Kali Có Chất Điều Hòa Sinh Trưởng', 'ACS.K', 'ac-super-k-ca-phan-bon-kali-co-chat-dieu-hoa-sinh-truong', 'Công dụng: Nguồn Dinh Dưỡng Đặc Biệt Cho Cây Cảnh. Ngăn Ngừa Vàng Lá Thôi Thân Do Dư Đạm. Giúp Cây Kiến Tạo Hệ Tế Bào Mạnh Khỏe. AC S.uper K-Ca là nguồn dinh dưỡng đặc biệt cho các loại cây cảnh. Giúp cây tăng quang hợp và hấp thu dinh dưỡng ngay cả khi ánh sáng không đủ, ngăn ngừa vàng lá thồi thân do dư đạm vào mùa mưa hoặc phun tưới đạm quá liều. Giúp cây sản sinh và kiến tạo hệ tế bào mạnh khỏe từ rễ tới thân lá. Cho cây lá xanh tốt, thân thẳng, vòi hoa dài, nhiều bông, sắc hoa sặc sỡ, lâu tàn….
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Hũ 100g
Giá tham khảo: 75.000đ - 90.000đ', '82500.00', 1, 1, 4, 23, 'CTY TNHH Á Châu Hóa Sinh', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Kali hữu hiệu (K2Ohh): 20%. Canxi (Ca): 2,86%. Bo (B): 10.000ppm. GA₄: 0,1%. Phụ gia vitamin phù hợp.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Chú ý : Tưới hoặc phun vào sáng sớm, chiều mát.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(4, 'AC-ZINMAC Phân Bón Vi Lượng', 'PB.1547', 'ac-zinmac-phan-bon-vi-luong', 'Công dụng: Cung cấp Zn, B, Mg, Ca. ► Giúp làm dày lá cây. ► Thúc đẩy cây ra hoa, nuôi trái. ► Công nghệ Nano dễ hấp thu. AC-ZINMAC gồm hỗn hợp trung vi lượng cao cấp chuyên dùng cho hoa lan, hoa hồng và các loại cây cảnh khác. Giúp cây tăng trưởng mạnh, xanh đẹp, dày lá, khắc phục hiện tượng thiếu hụt vi lượng gây xoắn lá, vàng lá, chết ngọn, khô cành.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 100ml
Giá tham khảo: 40.000đ', '40000.00', 1, 1, 3, 35, 'CTY TNHH Á Châu Hóa Sinh', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Zn: 15.000ppm. B: 3000ppm. Mg: 3%. Ca: 3.5%. Tỷ trọng: 1.35. pH: 4. Phụ gia đặc biệt khác.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Cây ăn trái: Trái non, trái trưởng thành đến trước thu hoạch: 25ml/16 – 20 lít nước. (Phun 7 – 10 ngày 1 lần). • Rau ắn lá, ăn quả: Cây con, trái non đến trước thu hoạch: 25ml/16 – 20 lít nước. (Phun 5 ngày 1 lần). • Hoa cảnh: Cây con đến trước khi cây ra hoa: 10ml/8 Lít. (Phun 5 – 7 ngày/ 1 lần:.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(5, 'ACROOTS 10SL – Phân Bón Kích Siêu Ra Rễ', 'ACRDA', 'acroots-10sl', 'Công dụng: Kích Thích Ra Rễ Cực Mạnh. Giúp Cây Đâm Chồi, Đẻ Nhánh. Tăng Khả Năng Chống Chịu. THÔNG TIN THUỐC KÍCH RỄ ACROOTS. Thuốc Kích Rễ NAA. ACROOTS 10SL chứa Auxin a – NAA có công kích thích ra rễ cực mạnh, đẻ nhánh nhiều, mập mầm, xanh cây, xanh lá... • Thích hợp cho mọi giai đoạn phát triển của cây trồng, đặc biệt là khi cây trải qua giai đoạn tổn thương của bộ rễ như cây non, cây mới trồng, giai đoạn điều kiện thời tiết bất lợi (hạn hán, ngập úng, ngộ độc hữu cơ...) Liều dùng: • Cây non: 10ml/16 Lít (1 nắp = 25ml) • Cây trưởng thành: 15-20ml/16 Lít.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Chai 100ml / Chai 480ml / Chai 1Lít / Can 3Lít
Giá tham khảo: 25.000đ', '25000.00', 1, 1, 3, 48, 'Á Châu Hóa Sinh', 'Jichuan Guoguang Agrochemicals Co., Ltd, Trung Quốc', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: a- Naphthyl Acetic Acid 10g/1L. Phụ gia đặc biệt.
Loại sản phẩm: Kích Rễ', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(6, 'AGBASICS SEAWEEDPLUS – Phân Bón Hỗn Hợp NPK Úc', 'PB.5646', 'agbasics-seaweedplus', 'Công dụng: Kết Hợp Đạm Cá Hồi Và Tảo Bẹ Nâu. ► Mập Mầm - To Hoa - Dày Lá.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Cặp 300ml / Chai 100ml / Chai 250ml / Can 3Lít
Giá tham khảo: 30.000đ', '30000.00', 1, 1, 3, 66, 'CTY TNHH Á Châu Hóa Sinh', NULL, '0.30', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Nitrogen (N): 6,6%. Phosphorus (P): 5,5%. Potassium (K) 7,2%, Nguyên liệu nhập khẩu từ Australia. Với công nghệ chiết xuất từ cá hồi và tảo bẹ nâu nên rất giàu vitamin, axit amin và các chất tăng trưởng khác cũng các nguyên tố vi lượng như: Magnesium (Mg), Calcium (Ca), Molybdenum (Mo), Zinc (Zn), Iron (Fe), Boron (B), Cobalt (Co), Manganese (Mn).
Loại sản phẩm: Phân Bón Lá, Phân Hữu Cơ', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(7, 'Agri Fos 400SL Thuốc Đặc Trị Nấm Hồng', 'AGRI.P4', 'agri-fos-400si-thuoc-dac-tri-nam-hong', 'Công dụng: Kích Thích Hệ Miễn Dịch Của Cây Trồng. Ngăn Chặn Sự Hình Thành Bào Tử Của Nấm. Không Bị Kháng Thuốc, Giúp Cây Mạnh Khỏe. Không Để Lại Tồn Dư Độc Hại Nào Trong Cây Trồng. Thuốc Đặc Trị Nấm Hồng. Thuốc hoàn toàn không độc hại, có thể sử dụng thường xuyên để chống nấm. Agri-Fos 400sl diệt bệnh bằng cơ chế kích kháng chủ động (không diệt trực tiếp bằng chất độc, mà kích kháng cây tiết ra chất đề kháng đặc biệt như Phytoalexin, PR-proteins... tấn công tiêu diệt mầm bệnh, tạo tín hiệu báo động cho các tế bào còn lại hình thành hệ thống đề kháng chủ động cho cây). Thuốc giúp sản xuất các chất Polysacharides làm dày vách tế bào, phá vỡ lớp ngụy trang của nấm bệnh giúp hệ thống đề kháng phát hiện và tiêu diệt. Hệ thống này còn có hiệu lực phòng bệnh kéo dài đến 60 ngày và giúp cây chống lại một số tác nhân gậy hại khác. Dùng tốt trong mùa mưa.', '175000.00', 2, 1, 3, 79, 'C.TY DONA-TECHNO', 'Agrichem - Úc', '0.50', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: 400 g/l Phosphorous Acid: Mono-potasium Phosphonate và Di-potasium Phosphonate. Phụ gia 950 g/l.', 'Hướng dẫn sử dụng: Chỗ bị thối nhũn, cắt bỏ sau đó bôi Agri-Fos nguyên chất vào chỗ cắt, sẽ hiệu quả cao.
An toàn sử dụng: Bảo quản: Để xa Tầm tay trẻ em, Nguồn thực phẩm, Nguồn nước. ◊ Bảo quản nơi khô ráo, thoáng mát, Tránh ánh Nắng. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu:'),
(8, 'Aliette 800WG - Thuốc Trị Thối Gốc, Rễ', 'NND.1698', 'aliette-800wg-thuoc-tri-thoi-goc-re', 'Công dụng: Đặc Trị Cháy Lá Vi Khuẩn. Thuốc Lưu Dận 2 Chiều. Có thể trị nhiều bệnh thối. Thuốc diệt nấm khuẩn Aliette 800wg Chuyên trị:. Thối gốc gây chết nhanh cây tiêu. Phấn trắng hại dưa. Lở cổ rễ, thối rễ hại cam quýt. Sương mai trên vải. Đặc biệt: Trị thối thân (Black Rot), thối rễ trên lan cực kỳ hiệu quả.
Đối tượng cây trồng: THUỐC BẢO VỆ THỰC VẬT
Quy cách: Gói 100g
Giá tham khảo: 70.000đ', '70000.00', 2, 1, 4, 90, 'Cty TNHH Bayer S.A.S – Pháp', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Fosetyl Aluminium..........800g/kg • Phụ Gia: 200g/kg.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Tiêu: Chết nhanh (lờ cổ rễ) 20gr thuốc/ 8 lít nước, phun đêu lên lá. Phun 1 tháng 1 lần trong mùa mưa. Dưa: Phấn trắng 20g thuốc/8 lít nước, phun khi thấy bệnh xuất hiện. Cam quýt : Thối rễ 20g thuốc/8 lít nước, phun dều lên lá. Phun 3 tháng 1 lần. Vài: Sương mai 20g/ 12 lít nước. Phun đều lên lá. Phun giai đoạn ra bông và tạo trái non.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(9, 'Alpine 80WG', 'ALPINE', 'alpine-80wg', 'Công dụng: Thuốc Lưu Dẫn Hai Chiều Cực Mạnh. Phòng Và Trừ Nấm Bệnh, Vi Khuẩn. Bám Dính Tốt, Hiệu Lực Cao. ALPINE 80WG là thuốc dạng cốm, có kích thước hạt thuốc siêu mịn, có tác dụng lưu dẫn cả hai chiều bên trong cây. Ngoài tác dụng trừ nấm Phytophthora, ALPINE còn có tác dụng ức chế sự hình thành và phát triển của vi khuẩn gây bệnh trên cây trồng. Thuốc bám dính tốt và thấm vào cây rất nhanh.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Gói 100g
Giá tham khảo: 45.000đ', '45000.00', 2, 1, 4, 104, 'CÔNG TY CỔ PHẨN BVTV SÀI GÒN', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Fosetyl - Aluminium: 80% w/w; Chất mang, phụ gia: 20% w/w.
Loại sản phẩm: Thuốc trừ bệnh cây', 'Hướng dẫn sử dụng: 1.0 kg/ha. Pha 40-60 g/bình 16 - 25 lít nước. Pha 40 g/bình 16 lít nước Phun ướt điều khi cây mới xuất hiện bệnh. Chú ý:. Phun thuốc khi bệnh mới xuất hiện, nếu thời tiết thuận lợi cho bệnh phát triển nên phun lại lần 2 cách lần thứ nhất 5 - 7 ngày. • ALPINE có thể hỗn hợp với các loại thuốc trừ sâu, bệnh khác. • Đối với bệnh xì mủ cây, nên cao sạch vết bệnh và quét thuốc lên vết bệnh phối hợp với phun thuốc lên tán lá.
An toàn sử dụng: Bảo quản: Bảo quản nơi khô ráo thoáng mát, tránh ánh sáng trực tiếp. • Để xa tầm tay trẻ em. • Thời gian cách ly 7 ngày. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(10, 'Ami Green - Phân Bón Giải Độc Sinh Học', 'AMG', 'phan-bon-sinh-hoc-ami-green', 'Công dụng: Phân Bón Sinh Học Có Vitamin B1, B6, B12. Phát Triển Rễ, Bật Mầm, Canh Lá. Giải Độc Chống Sốc Cây Cảnh. Tăng Sức Sống Cho Cây Mới Trồng. Phân Bón Sinh Học Ami Green giúp phát triển bộ rễ mạnh, dưỡng mắt ngủ, bật mầm gốc và làm xanh lá. Giúp cây phục hồi sau khi ra hoa. Tăng sức sống cho cây mới trồng. Giải độc - chống sốc cây khi thay đổi môi trường, thời tiết.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 100ml / Chai 1Lít
Giá tham khảo: 60.000đ', '60000.00', 1, 1, 3, 117, 'Á Châu Hóa Sinh', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Amino Acid 1,7%. Acid Alginic 2000ppm. Vitamin B1 300ppm. Mo 200ppm. Zn 500ppm. Bo 500ppm. PH 8. Tỉ trọng 1:1. Phụ Gia: Vitamin B6. Vitamin B12.
Loại sản phẩm: Giải Độc - Kích Mầm Gốc', 'Hướng dẫn sử dụng: Pha 1ml/ Lít nước tưới cho cây vào buổi sáng sớm hoặc chiều tối. Phun đều thân và lá đối với cây kiểng và cây ăn trái. Phun vào gốc đối với hoa lan đa thân. Phun vào thân và gốc đối với Hoa Lan đơn thân.
An toàn sử dụng: Bảo quản: Bảo quản trong mát tránh ánh nắng trực tiếp. Để xa tầm tay trẻ em, nguồn nước và thực phẩm. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(11, 'AMICO 10EC - Thuốc Trừ Sâu, Ruồi Vàng, Bọ Trĩ', 'AMI', 'amico-10ec', 'Công dụng: Đặc Trị Rầy Nâu Và Bọ Trĩ. Có Tính Lưu Dẫn Mạnh, Hiệu Quả Kéo Dài. Dùng Được Trên Cây Kiểng Và Hoa Lan. Thuốc Trừ Sâu Sinh Học Ít Độc Cho Con Người Và Môi Trường. Với cơ chế lưu dẫn có tác dụng đặc trị các loài côn trùng hút chích. Trị rầy nâu trên lúa, bọ trĩ trên dưa hấu và ruồi vàng trên hoa kiểng.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Chai 100ml / Chai 500ml
Giá tham khảo: 45.000đ - 50.000đ', '47500.00', 2, 1, 3, 129, 'ALFA', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Imidacloprid 10% w/w.
Loại sản phẩm: Thuốc Diệt Côn Trùng', 'Hướng dẫn sử dụng: Thuốc Trị Rầy Nâu Hại Lúa. Pha 5-7ml thuốc/bình 8 lít*Phun 4-6 bình/công (1000m2); 1,5-2 bình/ sào (360m2). Trị Bọ Trĩ Ở Dưa Hấu. Chú Ý. Phun thuốc cho ướt đều lá và thân cây ngay khi sâu, bọ mới xuất hiện. Nên phun thuốc vào sáng sớm hay chiều mát. Thuốc có thể được pha trộn với thuốc trừ sâu bệnh và các loại phân bón lá khác, trừ thuốc có tính kiềm. Thời gian cách ly: 14 ngày.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(12, 'Amino Alexin - Phân Bón Đa Lượng', 'PB.0467', 'amino-alexin', 'Công dụng: Tạo Mầm Hoa. Tác Động Lưu Dẫn Hai Chiều Cực Mạnh. Kích Thích Tạo Kháng Thể Tự Nhiên Cho Cây.', '45000.00', 1, 1, 3, 142, 'Growmore Việt Nam', 'Cty Sản xuất Complejo in dustrial Bioiberica - Tây Ban Nha - Đóng gói tại cty TNHH Growmore.', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Amino Acids: 4%;. Phosphorous (P2O5): 30% (Phosphite: PO3);. Potasium (K2O): 20% (Potassium Oxite). AminoAlexin Optimus : kích thích tạo ra Phytoalexin, một kháng thể tự nhiên giúp cây trồng tăng sức đè kháng với tác dộng xấu của môi trường , thời tiết. AminoAlexin Optimus : kết hợp tạo mầm hoa, tăng số hạt , bông , cây ra nhiều nhánh , tán rộng, ra lá mới to hơn, lá dày hơn. Tác động lưu dẫn 2 chiều cực mạnh.', 'Hướng dẫn sử dụng: Cách sử dụng trên hồ tiêu :. Pha 20-30ml AminoAlexin Optimus/ 10 lít nước (500ml / phuy 200 lít nước). Phun tưới đều thân lá , phun định kỳ 10 ngày/ lần hoặc tưới đều quanh gốc tiêu. Tưới 3 lần/ năm ( vào đầu , giữa và cuối mùa mưa). Cách sử dụng trên sầu riêng :.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(13, 'Amino Bo | AminoQuelant - 05 | Phân Bón Chống Rụng Nụ, Rụng Trái', 'AMNB', 'amino-bo', 'Công dụng: Cung cấp Boron dạng L-a Amino Acid. Trị Bệnh Xoăn Lá Tăng Khả Năng Ra Hoa, Chống Rụng Bông. Hiệu lực, hiệu quả rất cao. Phân Vi Lượng Bo. Chống hiện tượng vàng lá, lá dị dạng, thối chồi non, chồi biến dạng, thối rễ. Kích thích hạt phấn phát triển, kéo dài thời gian sống của hạt phấn. Tăng khả năng thụ phấn, khắc phục hiện tượng rụng bông, rụng trái non. Kích thích cây ra bông đều, bông tập trung, bông lớn. Kích thích trái cây phát triển nhanh, trái to, chắc trái, trái cân đối. Chống Hiện Tượng Thối Trái, Nứt Trái, Trái Non Biến Dạng. Đặc Trị Các Triệu Chứng Thiếu Bo:. Lá đổi màu, vàng lá, quăn lá, lá biến dạng, thối trái non, chồi dị dạng, thối rễ, thối thân. Cây ít bông, bông rụng nhiều, bông nhỏ, bông dị dạng. Trái nhỏ, trái biến dạng, nứt trái, rỗng ruột, thối trái, rụng trái non. Lúa trổ không điều, bông nhỏ, hạt ít, nhiều hạt lem lép. AminoQuelant-05 đặc hiệu cho các loại hoa, cây cảnh và đặc biệt là phong lan và các cây trồng trên giá thể. Giúp cây con phát triển nhanh, kích thích ra bông sớm, cây nhiều bông, bông lớn, đẹp, màu sắc đặc trưng và lâu héo.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 100ml / Chai 500ml / Chai 1Lít / Can 3.8Lít
Giá tham khảo: 35.000đ', '35000.00', 1, 1, 3, 154, 'Grow More', 'Tây ban Nha', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Đạm: 3% • Amino Acid 5% • Vi Lượng BO: 50.000ppm PH:7.2 Tỉ trọng 1.37.
Loại sản phẩm: Phân Bón Vi Lượng', 'Hướng dẫn sử dụng: Rau ăn trái: Cà chua, dưa hấu, ớt, dưa leo, dâu tây, và đậu các loại. Giai đoạn cây con, trước trổ bông và trái nhỏ, nuôi trái. Phun định kỳ 7 ngày/lần, 3 – 4 lần/vụ. Rau ăn lá: Rau cải, bắp cải, xà lách, bông cải, cần tây, các loại rau gia vị. Phun định kỳ 7 ngày/ 1 lần sau khi gieo cấy từ 3-5 ngày. Phun 3 – 4 lần/vụ. Cây ăn trái: Xoài, nhãn, sapoche, sầu riêng, chôm chôm, mảng cầu, mận, nho, và cây có múi (chanh, cam, quất, quýt). Khi cây ra chồi mới, vươn đọt, tạo lá mới, phun 2 - 3 lần cách nhau 7 ngày. Trước khi ra bông 30 ngày, phun 2 – 3 lần cách nhau 7 ngày. Sau khi đậu trái, phun 3 - 4 lần cách nhau 15 - 20 ngày. Cây công nghiệp: Điều, hồ tiêu, cà phê và trà. Sau khi đậu trái, phun 3 – 4 lần cách nhau 15 - 20 ngày. Riêng trà, phun định kỳ theo tháng sau mỗi lần thu hái. Lúa: Phun vào 3 giai đoạn cơ bản (lúa đẻ nhánh, trước làm đồng và lúa chín sữa). Phun 3 – 4 lần/vụ. Hoa lan, cây cảnh và cây giống trong vườn ươm: Phun định kỳ 7 ngày/lần. Riêng cỏ sân golf: Phun định kỳ 15 ngày 1 lần. Liều lượng: 10 -15ml/bình 10 lít. (300ml/phuy 200 lít nước).
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(14, 'Amino Combi - Phân Bón Vi Lượng Tổng Hợp', 'AMNCB', 'amino-combi', 'Công dụng: Dùng Tưới Lá, Tưới Gốc, Tưới Nhỏ Giọt. Lá Xanh Dày - To Mập. Trái Lớn Nhanh. Chống Thối Trái. Kích thích sự sinh trưởng và phát triển của cây trồng. Giúp lá xanh dày, thân to mập, rễ khỏe, cây bung chồi và phát đọt. Chống thối trái, rụng trái giúp cây lớn nhanh, màu sắc đẹp. Tăng sức chống chịu đối với thời tiết bất lợi.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 150ml / Chai 250ml
Giá tham khảo: 29.000đ', '29000.00', 1, 1, 3, 169, 'CTy Nông Hóa Xanh', NULL, '0.15', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Amino axit: 6,5%. Canxi (Ca): 3%. Mangan (Mn): 0,85%. Magie (Mg): 2%. Kẽm (Zn): 0,6%. Đồng (Cu): 0,2%. Sắt (Fe): 1,1%. Phụ gia đặc biệt vừa đủ.
Loại sản phẩm: Phân Bón Vi Lượng', 'Hướng dẫn sử dụng: Pha 1 - 1,5 ml/ Lít nước tưới cho cây định kỳ 7-10 ngày 1 lần. Thích hợp phối với các loại NPK Tám ngọc để làm cây phát triển, lá to, xanh, dày, thân mập, to và phát triển mạnh. Liên hệ với nhân viên Nông Nghiệp Đẹp để được hướng dẫn phối.
An toàn sử dụng: Bảo quản: Để nơi thoáng mát, tránh ánh nắng trực tiếp. Tránh xa tầm tay trẻ em, nguồn nước và thực phẩm. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(15, 'Amino Minors - Phân Vi Lượng Tổng Hợp', 'AMIMGM', 'amino-minors-phan-vi-luong-tong-hop', 'Công dụng: Bổ Sung Vi Lượng Thiết Yếu Cho Cây. Kích Thích Cây Con Phát Triển. Tô Khả Năng Kháng Sâu Bệnh. Phân bón lá Amino Minor. Bổ sung một lượng lớn vì lượng thiếu hụt cho cây ở mọi giai đoạn giúp cây phát triển toàn diện nhất:. Kích thích cây con phát triển nhanh khoẻ. Tăng cường khả năng kháng sâu bệnh. Kích thích cây ra bông sớm. Giúp lúa đẻ nhánh khỏe, tăng khả năng kháng phèn, mặn, trổ bông sớm, trổ tập trung, hặt to chắc, chồng lép hạt. Nâng cao năng suất và chất lượng nông sản. Amino minor biệt hiệu quả khi sử dụng trên cây có múi như Sầu riêng, Bưởi, Cam, Quýt... giúp kích thích trái cây phát triển nhanh, trái to, chắc trái, trái cân đối, chống hiện tượng thối trái, nứt trái, trái non biển dạng. Sản phẩm đặc hiệu cho các loại hoa, cây cảnh và đặc biệt là phong lan, cây trồng trên giá thể. Giúp cây con phát triển nhanh, kích thích ra bông sớm, cây nhiều bông, bông lớn, đẹp, màu sắc đặc trưng và lâu héo.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Chai 100ml / Chai 500ml / Chai 1Lít / Can 3.8Lít
Giá tham khảo: 35.000đ', '35000.00', 1, 1, 3, 181, 'Grow More', 'Công Ty Sản Xuất Complejo Industrial Bioiberica - Tây Ban Nha', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Amino Acid: 1.9%. Iron (Fe) 3,0%. Total Nitrogen 2,8%. kẽm (Zn) 1,0%. mangan ( Mn) 1.0%. Magie (Mg) 0.5%. Boron (B) 0,02%. Đồng (Cu) 0.01%. Molybdenum ( Mo) 7ppm.
Loại sản phẩm: Phân Bón Vi Lượng', 'Hướng dẫn sử dụng: Rau ăn trái: Cà chua, dưa hấu, ớt, dưa leo, dâu tây, và đậu các loại. Giai đoạn cây con, trước trổ bông và trái nhỏ, nuôi trái. Phun định kỳ 7 – 15 ngày/lần. Phun 3 lần 1 vụ. Rau ăn lá: Rau cải, bắp cải, xà lách, bông cải, cần tây, các loại rau gia vị. Phun định kỳ 7 ngày/ 1 lần sau khi gieo cấy từ 3 - 5 ngày. Phun 3 – 4 lần/vụ. Cây ăn trái: Xoài, nhãn, sapoche, sầu riêng, chôm chôm, mảng cầu, mận, nho, và cây có múi (chanh, cam, quất, quýt). Khi cây ra chồi mới, vươn đọt, tạo lá mới, phun 2 - 3 lần cách nhau 15 - 20 ngày. Trước khi ra bông, phun 2 – 3 lần cách nhau 15 - 20 ngày. Nuôi trái, phun 3 - 4 lần cách nhau 15 - 20 ngày. Cây công nghiệp: Điều, hồ tiêu, cà phê và trà. Lúa: Phun vào 3 giai đoạn cơ bản (lúa đẻ nhánh, trước làm đồng và lúa chin sữa). Phun 2-3 lần/vụ. Hoa lan, cây cảnh và cây trong vườn ươm: Phun định kỳ 7 ngày/lần. Liều lượng: 10 - 15ml/ bình 10 lít. (300ml/ 200 lít nước).
An toàn sử dụng: Bảo quản: Để xa Tầm tay trẻ em, Nguồn thực phẩm, Nguồn nước. Bảo quản nơi khô ráo, thoáng mát, Tránh ánh Nâng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(16, 'Amistar Top 325sc - Thuốc Trừ Bệnh Cây', 'AMIS', 'amistar-top-325sc-thuoc-tru-benh-cay', 'Công dụng: Đặc Trị Thán Thư, Diệt Nấm Bệnh. Trừ Bệnh Nội Hấp, Lưu Dẫn Mạnh. Phòng và Trị Bệnh Đốm Vằn, Vàng Lá Chín Sớm và Lép Hạt. Hiệu Quả Sử Dụng Cao Và Kéo Dài. Amistar Top 325SC là thuốc trừ bệnh nội hấp và lưu dẫn mạnh rất thích hợp để làm chủ bệnh hại trên ruộng lúa, ngô cùng một số lượng km trồng tính chất khác. Đặc trị phấn trắng trên coffe và hoa Hồng. Lem lép hạt, đạo ôn cổ bông trên lúa. Khô nứt vỏ rụng lá trên cao su. Chết cây con trên hạt đậu phộng đốm lá rỉ sắt trên ngô. ​​​​​​​.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN  >  THUỐC TRỊ BỆNH THÁN THƯ
Quy cách: Chai 100ml / Chai 250ml
Giá tham khảo: 167.000đ', '167000.00', 2, 1, 3, 194, 'Syngenta', 'Cty TNHH Syngenta Việt Nam', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Azoxystrobin 200g/L. Difenoconazoie: 125g/L. Phụ Gia & dung môi: 785g/L.
Loại sản phẩm: Thuốc Trừ Bệnh Cây', 'Hướng dẫn sử dụng: Amítar Top SỬ DỤNG CHO HOA LAN. Diều trị bệnh thán thư cho Hoa Lan: phun 1ml/ Lít nước vào buổi chiều tối sáng hôm sau xả nước sớm. Amistar Top SỬ DỤNG CHO CÁC LOẠI CÂY KHÁC. Lượng Nước sử dụng: 600-800L/ ha đối với tiêu, 400-500L/ ha đối với Tiêu. Dùng Cho Lúa. Lem lép hạt: 0,35 Lít/ Ha - Đạo ôn: 0,3-0,5 Lít/ Ha - Khô Vằn, Đốm Vằn: 0,25-0,3 Lít/ Ha. Dùng Cho Bắp (Ngô). Đốm Lá Lớn: 0,25-0,5Lit/ ha - Rỉ sắt: 0,4-0,5 Lít/ ha - Khô Vằn: 0,5 Lít/ ha. Dùng Cho Hoa Hồng. Trị Bệnh Phấn Trắng ở Hoa Hồng: 0,35 Lít/ ha. Dùng Cho Tiêu. Trị Thán Thư trên cây tiêu: 0,1%. Dùng Cho Cây Cà Phê. Thán Thư: 0,1-0,2% - Rỉ Sắt: 0,2%. Dùng Cho Cây Cao Su. Vàng lá 0,1 – 0,2% - Khô Nứt Vỏ: 1,5-3%. Chú Ý Khi Sử Dụng:. Lắc đều trước khi dùng.
An toàn sử dụng: Bảo quản: Bảo quản nơi thoáng mát, tránh ánh nắng trực tiếp. Để xa tầm tay trẻ em, nguồn nước và thực phẩm. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(17, 'Anvil 5SC – Thuốc Trị Bệnh Rỉ Sắt', 'ANVIL', 'anvil-5sc', 'Công dụng: Thuốc Trừ Bệnh Phổ Rộng. ► Hiệu Quả Kéo Dài. ► Cơ Chế Vừa Phòng Vừa Trị. ► Phòng Trừ Nhiều Nấm Bệnh. Anvil 5sc có thể trừ các bệnh như. Khô Vằn, lem lép hạt hạI lua, ngô (bắp). Rỉ sắt, nấm hồng, đốm hồng hại cafe. Phấn trắng hại xoài, nhãn. Lỡ cổ rể hại thuốc lá. Đốm lá hại lạc ( đậu phộng ). Phấn trắng , đốm đen , rỉ sắt hại hoa đồng. Ghẻ sẹo hại cam.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Chai 100ml / Chai 1Lít
Giá tham khảo: 55.000đ', '55000.00', 2, 1, 3, 208, 'CTY TNHH Syngenta Việt Nam', 'Công Ty TNHH Syngenta Việt Nam', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Hexaconazol : 50g/L. CƠ CHẾ TÁC ĐỘNG CỦA ANVIL 5SC. Anvil 5sc là thuốc trừ bệnh phổ rộng, tiêu diệt nấm bệnh thông qua cơ chế ngăn cản sinh tổng hợp ergosterol ( chát cấu tạo nên màn nấm bệnh ), nấm bệnh sẽ bị cô lập và ngừng phát triển , do chúng không hình thành được tế bào mới. Anvil được cây hấp thu nhanh, chuyển vị và lưu dẫn mạnh nên kiểm soát nấm bệnh nhanh chóng, hiệu quả kéo dài bằng cơ chế vừa phòng vừa trị bệnh. Tác động nội hấp, thấm sâu qua lá và phân bối đều khắp trong các bộ phận của cây trồng, ức chế nhanh nguồn bệnh , giúp câu khỏe, xanh lá , tăng năng xuất và phẩm chất. Anvil 5sc phòng trị hiệu quả các bệnh hại hay bị trên lúa ( khô vằn, lem lép hạt...) và các loại cây trồng khác , giữ xbộ lá thông qua cách điều trị bệnh tuyệt hảo. Đóng góp tích cực tối ưu , tăng năng xuất và hiệu quả cây trồng.
Loại sản phẩm: Thuốc Trừ Bệnh', 'Hướng dẫn sử dụng: Lúa: Khô vằn, lem lép hạt: 1ml/l. Phun 320-600 lít/ha. Ngô (bắp): Khô vằn 1-1,5ml/l. Phun 320-600 lít/ha. Cà phê: rỉ sắt, nấm hồng 1-2ml/l. Phun 600-800 lít/ha. Cà phê: đốm vòng 0,25%. Pha 20ml/8 lít. Trừ rỉ sắt trên lan: 1ml/ lít nước.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(18, 'B1 Xanh Grow More - Kích Rễ, Điều Hòa Sinh Trưởng Cho Cây', 'B1GM', 'b1-xanh-grow-more-start-p2-dieu-hoa-sinh-truong', 'Công dụng: Làm Chất Dẫn Phân Bón. ► Giúp Kích Rễ - Đâm Chồi. ► Có Thể Tưới Mỗi Ngày Cho Lan. Vitamin B1 xanh Growmore với các hoạt chất hữu cơ thực vật, giúp cho hạt mọc mầm mạnh, giúp cho việc cấy ghép được dễ dàng. Tăng cường sự sinh trưởng của bộ rễ. Giảm bớt các yếu tố có hại cho cây trồng. Gia tăng sự sản xuất chất diệp lục, tạo sự quang hợp, trao đổi chất dinh dưỡng, làm cho cây khỏe mạnh. Gia tăng sức đề kháng của cây, chống hạn, bệnh, sự khủng hoảng lúc cây sinh sản và sau khi thu hoạch. Làm chắc hạt lúa, trổ đều, thân đứng không bị ngã rạp, tăng năng suất, thu hoạch sớm. Làm tăng vị ngọt, phẩm chất, màu sắc cho các loại cây ăn quả, các loại rau cải và cây công nghiệp. Thích hợp cho nhiều loại cây: rau cải, cây ăn trái. Giúp cây sinh trưởng tốt, tăng năng suất. Tăng cường sự trao đổi chất và sức đề kháng của cây. Phân bón lá Start p2 vitamin B1 Grow More được sử dụng cho các loại rau cải, cây ăn trái, cây công nghiệp, các loại bông hoa cây cảnh, cây lúa và xử lý hạt giống, tốt cho cây lan. Vitamin B1 dùng để dẫn phân, có thể pha chung với các loại phân NPK và phân hữu cơ khác.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 100ml / Chai 500ml / Chai 235ml / Chai 1Lít / Can 3.8Lít
Giá tham khảo: 25.000đ', '25000.00', 1, 1, 3, 219, 'Grow More', 'Hoa Kỳ', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Vitamin B1; P2O5 2%; Fe 1000ppm; PH 1; Tỉ trọng 1:1.
Loại sản phẩm: Điều Hòa Sinh Trưởng', 'Hướng dẫn sử dụng: Pha 1ml/ Lít nước phun đều lên trên và dưới mặt dưới lá, phun vào rễ và các giá thể. Phun định kỳ 5-7 ngày 1 lần. Riêng với các loại Hoa kiểng, pha 8-10ml cho 1 bình xịt 8 lít nước. Phun định kỳ 15 ngày/lần. B1 Tưới Cho Lan. B1 Grow More Sử dụng cho Hoa Lan Trồng Chậu Ta có thể pha với nước liều 1cc/ Lít nước Tưới Mỗi Ngày. Ngoài ra B1 xanh Grow More còn được dùng làm phụ gia trong các công thức phun tưới giúp cây hấp thụ phân bón nhanh hơn ( powerfeed, Fish Bio, Phú Hảo, bánh dầu vv.vv ). Kích Hoa Thân Thòng. Pha 1 gói Ga3 chung với 1 chai b1 xanh 100ml và lắc đều ta có 1 lọ dung dịch làm rụng lá cho lan thân thòng. và sử dụng 1ml dung dịch này pha với 2g 0-52-34 và 1 -2 lít nước tưới cho cây 3 ngày 1 lần để làm rụng lá và kích hoa.
An toàn sử dụng: Bảo quản: Để sản phẩm trong mát, tránh ánh nắng trực tiếp. Tránh xa tầm tay trẻ em, nguồn nước, thực phẩm. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. VIDEO HƯỚNG DẪN KÍCH HOA PHI ĐIỆP. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(19, 'Benkona – Thuốc Sát Khuẩn, Khử Trùng Giá Thể, Đất Trồng', 'BKN', 'benkona-thuoc-sat-khuan-khu-trung-gia-the-dat-trong', 'Công dụng: Tiêu Diệt Nấm Mốc, Bảo Vệ Giá Thể. Phòng Được Các Bệnh Thối Nhũn Và Thối Đen. Phun Định Kỳ Để Bảo Vệ Chuồng Trại. Dung dịch sát khuẩn benkona là sản phẩm dùng để khử trùng không những cho vườn lan. Ngoài ra còn dùng trong y tế, chăn nuôi khử trùng chuồng trại đặc biệt khi có dịch bệnh. Thuốc còn có tác dụng diệt bào tử nấm mốc, vi khuẩn và rong tảo trong cây cảnh, giá thể lan. Những loại này nếu không diệt tận gốc sẽ bám chặt trên cây có thể gây thối đen dẫn đến chết lan. Như vậy thuốc benkona còn phòng trị thối nhũn, thối đen trên cây lan hay trên một số cây cảnh khác. Đặc biệt benkona có hiệu quả trị các loại nấm mốc trắng trên giá thể hoa lan, rất công hiệu khi dùng để diệt rong rêu bám trên lan, dùng để ngâm giá thể lan, vệ sinh vườn trồng lan tránh các dịch bệnh phát sinh.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN  >  Thuốc Sát Khuẩn - Khử Trùng
Quy cách: Chai 100ml / Chai 1Lít
Giá tham khảo: 25.000đ', '25000.00', 2, 1, 3, 231, 'CTY MINH NGÂN', 'Trong Nước', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Benzalkolium chloride 10% ;. Amyl Acetate 0,1ml ; Dung Môi ;. Glutaraldehyde vừa đủ. CÁCH SỬ DỤNG BENKONA CHO LAN. Để vệ sinh vườn lan và ngâm giá thể lan có thể pha 5 – 10ml/1 lít nước phun tưới trên lan ngăn ngừa được nhiều bệnh cho lan. Phun định kỳ từ 10 – 15 ngày/ 1 lần. Nếu có nấm mảng trắng nhẹ có thể pha 3ml/1 lít nước để tưới. Nếu nấm bám giá thể quá dày và mịn, bạn có thể pha từ 5 – 10ml/1 lít nước phun hoặc ngâm trị các bệnh nấm mốc, vi khuẩn, rong rêu trên lan. Nếu sử dụng thuốc cho vệ sinh chuồng trại có thể pha 5ml/1 lít nước phun đều khắp. Do giàn lan nhà bạn quá gần nhà hoặc trên ao cá, gần chuồng trại thì dùng benkona là lựa chọn tốt nhất, phun đều từ 10 – 15 ngày/1 lần. Dùng luân phiên thay thế Nano bạc và Nano đồng là chất gây hại để việc phòng và trị bệnh trên lan hiệu quả hơn.
Loại sản phẩm: Thuốc Khử Trùng', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để xa Tầm tay trẻ em, Nguồn thực phẩm, Nguồn nước. Bảo quản nơi khô ráo, thoáng mát, Tránh ánh Nắng. Mã Sản Phẩm: BKN. Lưu ý khi sử dụng: Mặc trang phục kín da khi làm việc, mang nón vành, mắt kính và khẩu trang chuyên dụng. Chọn khi thời tiết mát mẻ để làm việc. Chọn đúng thời điểm côn trùng quay trở lại để hiệu quả hơn. Pha thuốc đúng tỷ lệ quy định. Không đổ dung dịch thừa xuống nguồn nước sinh hoạt. Sơ cứu: Chưa có thông tin.'),
(20, 'BIO ROOT 0-1-1 - Phân Kích Rễ, Chống Nghẹt Rễ', 'PB.11746', 'bio-root-011-phan-kich-re-chong-nghet-re', 'Công dụng: KÍCH RỄ, KÍCH CHỒI. CHỐNG NGHẸT RỄ, THUN RỄ. RA LÁ, BUNG ĐỌT NHANH. Kích rễ, chống nghẹt rễ do ngộ độc hữu cơ, do bị phèn, bị nước mặn, do khô hạn, hoặc do mất cân bằng pH. Kích bung chồi mạnh, đẻ nhánh, bung đọt nhanh, ra lá, phục hồi cây sau các đợt thu hoạch. Dùng trước và sau khi cây ra hoa ra trái. CÁCH SỬ DỤNG BIO ROOT. Pha 1ml Bio Root với 1 lít nước và tưới cho cây định kỳ 7-10 ngày 1 lần.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 100ml / Chai 946ml (USA)
Giá tham khảo: 90.000đ', '90000.00', 1, 1, 3, 246, 'Cty TNHH TMDV Thiên Di', 'Thổ Nhĩ Kỳ', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chất hữu co: 30%. Lân (P 2 O 5 ): 5%. Kẽm (Zn): 450ppm. Tỷ Lệ C/N: 12. pH: 5. Tỷ Trongj1,3.
Loại sản phẩm: Phân Kích Rễ', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Bảo quản chai trong kệ, tủ và để trong mát, tránh ánh nắng trực tiếp. Tránh xa tầm tay trẻ em, nguồn nước, lương thực, thực phẩm. Khi sản phẩm mất nhãn cần ghi chú để không bị nhầm lẫn. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(21, 'Bung Chèo Cực Mạnh (Siêu Đạm Mỹ USA)', '331111SBC', 'sieu-bung-cheo-cuc-manh-sieu-dam-my-usa', 'Công dụng: Đâm Chồi, Phát Đọt, Kéo Chèo. Mập Thân, Xanh Cây, Dày Lá. Ra Rễ Cực Mạnh, Hạn Chế Điếc Chèo. Giúp thân, lá, trái lớn nhanh và cây đâm chồi rất mạnh. Đâm chồi cực mạnh. Giúp trái lớn nhanh. Phục hồi cây sau thu hoạch.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 50g
Giá tham khảo: 20.000đ', '20000.00', 1, 1, 4, 257, 'DANG NGUYEN INVESTMENT CONSTRUCTION TRADING AND SERVICE COMPANY LIMITED', 'Mỹ', '0.05', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Đạm tổng số (Nts): 33%. Lân hữu hiệu (P2O5hh): 11%. Kali hữu hiệu (K2Ohh): 11%. Sắt (Fe): 50ppm. Đồng (Cu): 50ppm. Kẽm (Zn): 80ppm. Mangan (Mn): 60ppm. Molipđen (Mo): 50ppm. Độ ẩm: 5%.', 'Hướng dẫn sử dụng: Cây hoa kiểng (hoa hồng, hoa lan, hoa vạn thọ, hoa giấy, hoa cúc,...): Sử dụng gói 50g pha cho 50 lít nước. Cây ăn trái: Sử dụng gói 50g pha cho 50 lít nước phun ướt đều cả lá và thân cây, định kỳ 7 ngày/lần. Cây rau màu: Sử dụng gói 50g pha cho 50 lít nước, bón định kì 7 ngày/lần, ngưng sử dụng trước khi thu hoạch 7 ngày.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(22, 'Béc Nhựa Thân Xoay 360° Ren Trong, Ren Ngoài', 'BECNRN', 'bec-nhua-than-xoay-360', 'Công dụng: Đặc biệt với dòng bét tưới cây mới bb 966 plus cải tiến từ béc bb966 cũ có thêm móc treo và dễ dàng tháo lắp, vệ sinh béc chống tắc nghẽn béc. Béc tưới cây, vòi tưới cây phun mưa 2 tia có bọc inox giúp béc xoay mượt mà, nhanh, bền hơn các loại béc không bọc inox, bán kính tưới 4.5 mét đến 6 mét phù hợp tưới rau, hoa màu, cây ăn quả. Vòi tưới làm từ nhựa cao cấp chịu được nắng mưa. ​​​​​​.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Cái
Giá tham khảo: 10.000đ', '10000.00', 4, 1, 4, 267, 'Bảo Bình', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(23, 'Béc Đồng Phun Sương Cao Áp - Vòi Phun Sương Cao Áp', 'BĐ.PXCA', 'voi-phun-suong-cao-ap-bec-dong-phun-suong-ap-luc', 'Công dụng: Béc Đồng Phun Sương Cao Áp. Nhiều Chế Độ Phun. Lực Nước Mạnh, Phun Tỏa Đều. Đầu tưới nông nghiệp gió lốc đen, béc bằng đồng chống ăn mòn và không gỉ, dễ lắp đặt. Vật liệu có độ bền cao và tuổi thọ lâu dài. Có thể điều chỉnh nguyên tử hóa vòi phun, nhiều chế độ phun.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Béc Đồng
Giá tham khảo: 55.000đ', '55000.00', 4, 1, 4, 284, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chỉ cần lắp vào cần vòi và sử dụng.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(24, 'Béc Đồng Phun Sương Áp Lực Cao - Vòi Phun Nguyên Tử', 'BĐ.NT', 'bec-dong-phun-suong-ap-luc-cao-voi-phun-nguyen-tu', 'Công dụng: Chất Liệu Bằng Đồng Thau Cao Cấp. Lực Phun Mạnh, Có Thể Điều Chỉnh, Khoảng Cách Phun. Có Thể Tháo Rời Và Điều Chỉnh, Dễ Dàng Vệ Sinh. Được làm bằng chất liệu đồng thau cao cấp, bền bỉ và ổn định trong quá trình sử dụng. Có thể tháo rời và điều chỉnh, dễ dàng vệ sinh và thuận tiện khi sử dụng. Cũng thích hợp để làm mát và tạo ẩm vòi phun trong các nhà máy dệt và trang trại. Chất liệu cao cấp, chống ăn mòn, không rỉ sét, sử dụng được lâu dài. Nó có thể được kết nối với PE hoặc thép không gỉ, dễ dàng lắp đặt và không bị rò rỉ.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: 1 Cái
Giá tham khảo: 55.000đ', '55000.00', 4, 1, 4, 300, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Dùng phun thuốc trừ sâu. Dùng phun hóa chất. Dùng phun xịt rửa áp lực. Phun thuốc diệt mối. Sử dụng trong nông nghiệp. Sử dụng hệ thống phun làm mát. Sử dụng phun hệ thống công nghiệp. Dùng tưới cây. Dùng tưới Lan, v.v.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(25, 'Béo Mập - Siêu Tăng Trưởng - Phân Bón Magnesium Nitrate', 'BEOMAP', 'beo-map-sieu-tang-truong-phan-bon-magnesium-nitrate', 'Công dụng: Cứng Cây, Mập Thân, Dày Lá. Đâm Chồi, Phát Đọt, Mập Cây. Xanh Lá, Mướt Lá, To Lá. Biến Lá Vàng Thành Xanh. Giúp cây xanh lá, mượt là, to là. Cứng cây, mập thân, dày lá. Đâm chồi, phát đọt, mập cây. Biến lá vàng thành xanh. Nhờ có hàm lượng Mg cao đã góp phần làm tăng quá trình quang hợp và hô hấp, đây là hai quá trình cốt lõi của cây trồng giúp cây trồng cho năng suất cao nhất, lại có thêm N giúp cây đâm chồi mạnh, xanh lá.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 50g
Giá tham khảo: 20.000đ', '20000.00', 1, 1, 4, 315, 'CTY TNHH Đầu Tư Xây Dựng Thương Mại và Dịch Vụ Đặng Nguyễn', 'Poland', '0.05', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: MgO: 15%, Nts: 11%, Độ ẩm: 1%.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Cây hoa kiếng (hoa hồng, hoa lan, hoa vạn thọ, hoa giấy, hoa cúc,...). Sử dụng gói 50g pha cho 25-50 lít nước. Cây ăn trái: Sử dụng gói 50g pha cho 25-50 lít nước phun ướt đều cả là và thân cây, định kỳ 7 ngày/ lần. Cây rau màu. Sử dụng gói 50g pha cho 50 lít nước, bón định kì 7 ngày/lần, ngưng sử dụng trước khi thu hoạch ngày.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Tránh xa tầm tay trẻ em, hạn chế sử dụng chung với sản phẩm chứa gốc đồng. Ngừng sử dụng từ 5-7 ngày trước khi thu hoạch. Sơ cứu: Chưa có thông tin.'),
(26, 'Bình Phun Tích Điện - Bình Tưới Cây - Làm Vườn', 'BINDIEN.5L', 'binh-phun-tich-dien', 'Công dụng: Bình Phun Tự Động. Bình Dạng Balo Mang Vai. Tiện Lợi, Dễ Sử Dụng. HÀNG ĐẶT TRƯỚC - SHOP SẼ GIAO MÀU NGẪU NHIÊN, TÙY MỖI ĐỢT HÀNG MÀU SẮC SẼ KHÁC NHAU. THÔNG SỐ KỸ THUẬT:. Dung lượng pin: 2500mAh. Dung tích chai: 5L / 8 L. Chất liệu: tay cầm ABS, thanh thép không gỉ, ống PVC. Công suất: 4.8W. Thời gian làm việc: hơn 2 giờ. Thời gian sạc: khoảng 2 giờ. Bơm: bơm nước tự mồi. Ống nước: Chiều dài kính thiên văn đến 60cm. Vòi điều chỉnh được: Phun sương đều/phun cột nước. Kích thước: Như trong hình. ĐẶC ĐIỂM VÀ CÔNG DỤNG. Vòi quay 360 độ, sản phẩm có 3 bộ vòi khác nhau, có thể thay thế dùng các chế độ phun khác nhau. Có thể tưới cây theo nhiều hướng, nhiều chế độ phun, giúp tiết kiệm năng lượng và tưới nước dễ dàng hơn. Cần phun kéo dài là thiết kế dạng kính thiên văn, dài đến 0,6m, mở rộng phạm vi phun của bạn. Tay cầm mở rộng được thiết kế công thái học, tạo cảm giác thoải mái sau khi vận hành lâu dài. Pin mạnh mẽ 2500mAh tích hợp đảm bảo hoạt động lên đến 3h, với thời gian sử dụng lâu dài và sạc lại nhanh chóng. Được trang bị bình chứa 5L / 8L, thiết kế nhỏ gọn tiện lợi, có dây đeo vai. Sản phẩm thích hợp để tưới cây, rửa xe, phun thuốc, .
Đối tượng cây trồng: Bình Xịt - Bình Tưới
Quy cách: Bình 8 Lít / Bình 5 Lít
Giá tham khảo: 550.000đ', '550000.00', 4, 1, 3, 325, 'None', NULL, '8.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Bảo quản nơi thoáng mát, tránh ánh sáng trực tiếp. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(27, 'Bình Tưới Cây Vòi Sen Nhựa - Nhiều Dung Tích', 'BT.VOISEN', 'binh-tuoi-cay-voi-sen-nhua-nhieu-dung-tich', 'Công dụng: Thiết Kế Tối Giản, Dễ Sử Dụng. Nhựa Cứng Bền Bỉ Theo Thời Gian. Bình Có Nhiều Quy Cách Dung Tích Để Lựa Chọn. SHOP SẼ GIAO MÀU NGẪU NHIÊN TÙY MỖI ĐỢT HÀNG VỀ Ạ. Bình tưới vòi sen dùng để tưới các loại hoa như Hoa lan, Hoa hồng, Hoa cúc,.. và các loại rau trong giai đoạn cây con. Khi tháo rời miệng bình có thể dùng để tưới cho những cây to.
Đối tượng cây trồng: Bình Xịt - Bình Tưới
Quy cách: Bình 7 Lít / Bình 10 Lít / Bình 3 Lít / Bình 5 Lít
Giá tham khảo: 45.000đ', '45000.00', 4, 1, 3, 347, 'None', 'Việt Nam', '7.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chỉ cần bỏ nước vào bình và dùng tưới cây thôi.
An toàn sử dụng: Bảo quản: Bền, không bể vỡ. Màu sắc tươi tắn, kiểu dáng dễ thương. Bình tưới đẹp, có thể xem như vật trang trí sân vườn. Đầu vòi hoa sen, thiết kế chắc chắn và đơn giản, dễ dàng tháo ráp vệ sinh bình. Chất liệu nhựa với tính năng chống bám bẩn, giúp bạn dễ dàng vệ sinh. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(28, 'Bình Tưới Cây Đa Năng 2in1 - Vừa Tưới Cây Vừa Phun Sương', 'B2IN1', 'binh-tuoi-cay-da-nang-2in1-vua-tuoi-cay-vua-phun-suong', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Bình Xịt - Bình Tưới
Quy cách: Bình dung tích 1L
Giá tham khảo: 35.000đ - 45.000đ', '40000.00', 4, 1, 4, 359, 'None', NULL, '1.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(29, 'Bình Xịt DUDACO Nhiều Dung Tích | Bình Xịt Nước 1-2-4-8 Lít', 'B0201', 'binh-xit-dudaco-dung-tich-1-2-4-8-lit', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Bình Xịt - Bình Tưới
Quy cách: Bình 1Lít / Bình 2Lít / Bình 4Lít / Bình 8Lít
Giá tham khảo: 65.000đ', '65000.00', 4, 1, 3, 375, 'DUDACO', 'Trong Nước', '1.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(30, 'Bút Đo Độ pH Trong Nước - Đo pH Nước Trong Bể Cá', 'pH-N', 'but-do-do-ph-trong-nuoc', 'Công dụng: Giúp Xác Đinh Độ Ph Nước. Nhỏ Gọn Tiện Mang Theo Bên Người. Bút đo nồng độ pH có tác dụng đo độ kiềm – chua trong dung dịch thủy canh, đo độ pH trong nước. Độ pH từ 6 - 8 phù hợp để nuôi cá cảnh. Kết quả độ pH từ 5.8 đến 6.5 nghĩa là cây đang phát triển tốt. Nếu độ pH dưới 5.5 và trên 6.8 thì cây bị còi cọc, vàng lá. Cây sẽ sinh trưởng và phát triển mạnh nhất nếu độ pH ở ngưỡng 6.2.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Bộ sản phẩm gồm
Giá tham khảo: 100.000đ', '100000.00', 4, 1, 4, 398, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Muốn sử dụng bút đo độ pH tốt nhất thì bạn chỉ cần thực hiện theo những bước dưới đây:. Đầu tiên bạn cần tháo nắp bảo vệ bút ra (hầu hết sản phẩm nào cũng có đầu bút bảo vệ). Rửa sạch điện cực với nước sạch rồi tiến hành làm khô bằng giấy lọc. Tiếp đó bạn bật đồng hồ “ON” ở trên bút bằng cách nhấn 1 lần vào phím ON / OFF. Sau đó nhúng bút đo độ pH này trực tiếp vào dung dịch cần đo sao cho chìm hết phần đầu cực vào nước để có kết quả chính xác. Không được nhúng nửa vời bởi như vậy sẽ làm giảm đi độ chính xác khi đo. Sau khi nhúng bút vào nước thì bạn khuấy nhẹ và chờ cho việc đọc kết quả ổn định. Khi đã có kết quả thì bạn tiếp túc làm sạch điện cực bằng dung dịch nước cất, tiến hành tắt máy bằng cách nhấn một lần nữa vào phím “ON / OFF”. Nhớ phải đậy lại nắp bảo vệ đầu bút sau khi đã sử dụng.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(31, 'Băng Keo Ghép Cành, Ghép Cây Tự Hủy', 'KEO.TUHUY', 'bang-keo-ghep-canh-ghep-cay-tu-huy', 'Công dụng: Keo Có Tính Mỏng,dai Và Có Thể Tự Dính Khi Sử Dụng. Dễ Dàng Truyền Tải Ánh Sáng Đến Cây. Khả Năng Tự Hủy Sau 1 Thời Gian. Băng nilon ghép cây tự hủy có khả năng đàn hồi, co giãn, tạo nên lực thắt vừa đủ để mạch nhựa cây lưu thông. Khi mắt ghép phát triển, băng nilon ghép cây tự hủy sẽ giãn nở, tránh tạo ra vết thương, vết cắt, xước trên mắt ghép. Nhờ có độ đàn hồi và khả năng kết dính, nên sau khi quấn xong mắt ghép, chúng ta chỉ cần miết nhẹ là băng nilon ghép cây tự hủy sẽ bám dính, không cần cột thắt. Băng ghép cây cuộn cành hoạt động theo nguyên lý tĩnh điện nên không cần phải buộc thắt nút. Băng quấn được làm từ nhựa PE nguyên sinh có khả năng tự hủy sau 2 năm, giúp bạn tiết kiệm được thời gian trong công việc tháo rỡ mối ghép.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Cuộn 2cm / Cuộn 4cm
Giá tham khảo: 15.000đ', '15000.00', 4, 1, 4, 409, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Làm sạch phần mắt ghép và gốc ghép. Sau khi ghép ép cành, mắt ghép và gốc ghép xong tiến hàng dùng băng keo quấn quanh mối ghé, quấn theo vòng tròng từ dưới lên trên. Đầu tiên đặt băng keo phía dưới cách mối ghép 20-30 cm sau đó quấn chặt băng keo vòng quanh thân cây sao cho lớp sau chồng lên 2/3 lớp trước. Quấn băng keo lên cao hơn tầm 20-30 cm để hạn ngăn nước thấm vào mối ghép.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(32, 'Bả Trừ Kiến Tận Tổ BTK', 'BTK', 'ba-tru-kien-tan-to-btk', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Gói 5g
Giá tham khảo: 10.000đ', '10000.00', 2, 1, 4, 425, 'CTY TNHH SX TM RVAC', 'Việt Nam', '0.01', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Phenylpyrazole 4.5 ‰ (phần nghìn). Phụ gia vừa đủ.
Loại sản phẩm: Thuốc diệt côn trùng', 'Hướng dẫn sử dụng: Để sử dụng sản phẩm Bả diệt kiến BTK , bạn chỉ cần thực hiện các bước sau đây:. Dùng 1 – 2 gam bả (1/3 muổng cà phê) rắc nơi có kiến đi qua, trên bếp, trong phòng, trước tổ, mép ngoài chậu lan, gốc cây, xung quanh vườn. Kiến sẽ làm việc còn lại đó là tha về tổ, cả tổ kiến gây rối loạn sinh lý tự cắn nhau rồi chết hết. Xử lý hạt giống: hạt giống sau khi gieo xuống đất rắc một ít lên trên kiến sẽ tha bả kiến đi không tha hạt giống.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Lưu ý khi sử dụng: Hiệu Quả Cao: Sản phẩm không chỉ diệt kiến mà còn có thể loại bỏ gián một cách nhanh chóng và hiệu quả. Hiệu Quả Kéo Dài: Sử dụng Bả diệt kiến BTK giúp duy trì sự cân bằng tự nhiên trong môi trường, ngăn ngừa sự phát triển quá mức của kiến. Dễ Sử Dụng: Sản phẩm được thiết kế để đơn giản hóa quá trình kiểm soát kiến, với hướng dẫn chi tiết để bạn có thể tự mình áp dụng. ​​​​​​​. Sơ cứu: Chưa có thông tin.'),
(33, 'Bả trừ ốc MOI OC 6GR', 'NND.6646', 'ba-tru-oc-moi-oc-6gr', 'Công dụng: Dẫn dụ diệt ốc hiệu quả. Ít gây độc với môi trường và con người. Đặc trị ốc bươu hại lúa.
Đối tượng cây trồng: THUỐC BẢO VỆ THỰC VẬT
Quy cách: Gói 400g
Giá tham khảo: 35.000đ', '35000.00', 2, 1, 4, 437, 'CTY Cổ Phần Đồng Xanh', 'WANGS LTD', '0.40', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Metaldehyde: 0,6% w/w. Phụ Gia: 94% w/w. ĐẶC TÍNH CỦA BẢ MỒI DIỆT ỐC. Mồi ốc 6Gr Là thuốc đặc trị ốc bươu hại lúa. Thuốc có tác dụng làm cho ốc tiết ra nhiều nhớt ( khô nhớt ) sau khi ăn phải và chết. - Bả mồi diệt ốc 6gr được sản xuất ở dạng bả mồi có chưa chất dẫn dụ để ốc đến ăn và tiêu diệt. - Bả mồi diệt ốc 6gr không độc với cá, giun đất, tôm, cua. Ít ảnh hưởng đến môi trường và con người. - Bả mồi diệt ốc 6gr có thể sử dụng trước khi sạ, trộn giống và sau khi sạ.
Loại sản phẩm: Thuốc Diệt Ốc', 'Hướng dẫn sử dụng: Dùng 4-6kg/ ha. Xử lý thuốc sau khi gieo 5 ngày. Rải thuốc nơi ốc tập trung. Giữ nước trong ruộng từ 2,5cm - 3,5cm. Tùy mức độ ốc mà dùng thuốc nhiều hay ít. Nên rải dọc theo các rãnh xả nước trên mặt ruộng và nơi ốc sống tập trung. CHÚ Ý:. Nên rải lúc trời mát. - Mùa mưa nên tăng lượng thuốc nhiều hơn mùa nắng. - Có thể rải lại lần 2 sau 14-21 ngày khi thấy ốc xuất hiện lại. ĐỀ PHÒNG NGỘ ĐỘC.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: LƯU Ý KHI SỬ DỤNG. Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(34, 'Bầu Nhựa Tròn Hỗ Trợ Chiết Cành', 'B.CHIETCANH', 'bau-nhua-tron-ho-tro-chiet-canh', 'Công dụng: Màu Sắc Đa Dạng, Giao Màu Ngẫu Nhiên. Chất Liệu Nhựa Dẻo Có Thể Tái Sử Dụng. Giúp Việc Chiết Cành, Nhân Giống Cây Dễ Dàng Hơn.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Size 3 / Size 2 / Size 1
Giá tham khảo: 8.000đ', '8000.00', 4, 1, 4, 449, 'None', 'Trung Quốc', NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Bước 1: Bỏ phân hoặc trấu, xơ dừa,... vào đầy bầu chiết cành. Bước 2: Tách phần da cây ( vỏ cây) bạn cần chiết cành. Bước 3: Lấy bầu ươm đưa vào cành vừa tách da cây ở bước 2, để cành chiết nằm ở giữa bầu ươm, khép bầu ươm, siết chặt lại thành vòng tròn như 1 quả bóng. Bước 4: Tưới nước lên phần bầu ươm đều đặn mỗi ngày và chờ 25 ngày sau hoặc đến khi cành chiết ra nhiều rễ thành.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: ĐẶC ĐIỂM KHÁC BIỆT:. Thiết kế độc đáo, đây là lần đầu tiên công cụ đóng bó cành chiết được thiết kế và sản xuất chuyên dụng GIÚP việc chiết cành sẽ đơn giàn hơn bao giờ hết tạo điều kiện thuận lợi cho việc nhân rộng và cải thiện giống cây chiết, làm tăng tỉ lệ sống sót và phát triển của cây trồng. Bảo vệ môi trường và tiết kiệm nguồn tài nguyên: Bầu Nhựa Chiết Cành là sản phẩm được làm từ nhựa tái chế, nên nó được sản xuất bằng cách tận dụng các nguồn rác thải nhựa mà con người thải ra và tái sử dụng lại được nhiều lần. Tạo nên môi trường sống tuyệt vời cho rễ chiết phát triển: Với thiết kế cách mạng cải tiến trong việc đóng bó bầu chiết, những điểm hạn chế trước đây của việc đóng bó bầu bằng túi nilon được khắc phục hoàn toàn, người làm vườn có thể kiếm soát, điều chỉnh được môi trường hỗn hợp giá thể bên trong bó bầu, từ đó chủ động đảm bảo độ ẩm, độ kín, tránh sáng cho nhành chiết, tạo nên một môi trường hoàn hảo bên trong bó bầu, giúp rễ chiết sinh trưởng và phát triển khỏe mạnh. Sơ cứu: Chưa có thông tin.'),
(35, 'Bầu Ươm V6 - Bầu Uơm Cây Thông Minh', 'BAU.UOM', 'bau-uom-v6-bau-uom-cay-thong-minh', 'Công dụng: Khách Muốn Mua Sỉ Cứ Liên Hệ Trực Tiếp Qua Shop. Liên Hệ: 0947 399 439 - 0835 294 953 - 0826 709 750. Là dụng cụ dùng để ươm cây con, giúp cho việc thoát khí, nước một cách dễ dàng hơn. Đồng thời giúp đất trồng luôn luôn tươi xốp, thoáng khí, hạn chế đến mức thấp nhất tình trạng ngập úng trên cây trồng. Giúp cây phát triển bộ rễ cám, rễ ăn vào sâu trong lòng đất. Từ đó, giúp giảm phân bón (hóa học, hữu cơ), lượng nước tưới. Giúp cây chống chọi với nhiều điều kiện thời tiết bất lợi như hạn hán, mưa nhiều. ƯU ĐIỂM CỦA BẦU ƯƠM V6 SO VỚI BẦU ƯƠM TRUYỀN THỐNG. Chủ động tăng cường phát triển cho cây bằng cách tăng số lượng rễ cám khoẻ mạnh. Điều này tối ưu hoá khả năng hấp thụ chất dinh dưỡng và nước, làm cho cây trồng khoẻ mạnh, phát triển nhanh. Đồng thời giúp định hình bộ rễ, giúp rễ không bị xoắn như chậu và bầu ươm truyền thống. Cây trồng sử dụng chậu V6 được phát triển rất khoẻ, cây mau lớn và bán nhanh và có giá trị cao hơn. Cây trồng chậu V6 phát triển nhanh dẫn đến doanh thu quay vòng nhanh tạo ra lợi nhuận lớn hơn. Cây trồng bầu ươm v6 có khả năng kháng bệnh cao do đó ít tổn thất hơn và ít tốn kém chi phí thuốc diệt nấm và trừ sâu bọ. Cây trồng chậu V6 sẽ không thay đất thường xuyên nữa, tức chi phí lao động ít hơn, bạn sẽ tiết kiệm được chi phí và thời gian.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Cuộn 50 mét 5 tấc / Cuộn 50 mét 4 tấc / Cuộn 50 mét 3 tấc / Cuộn 50 mét 2 tấc / Mét 4 tấc / Mét 3 tấc / Mét 5 tấc / Mét 2 tấc
Giá tham khảo: 10.000đ', '10000.00', 4, 1, 4, 465, 'None', 'Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Bước 1: Tính chiều dài bầu ươm thông minh cần dùng. Chiều cao bầu ươm: Tùy chọn loại cao từ 20cm – 90cm phù hợp bộ rễ cây. Đế nhựa lót đáy bầu: tùy chọn đường kính 20cm (ươm cây to công trình có thể không cần đế). Bước 2: Cắt tấm bầu ươm theo kích thước đã tính. Bước 3: Quấn tròn tấm bầu ươm thông minh. Nếu dùng đế lót: Đặt tấm đế nhựa lót vào tấm bầu ươm, sau đó cuộn tròn tấm bầu theo kích thước đế. Nếu không dùng đế nhựa lót đáy: Chỉ cần bầu tròn tấm bầu ươm theo đường kính bộ rễ cây. Bước 4: Vặn đinh ốc để cố định bầu ươm.
An toàn sử dụng: Bảo quản: Bảo quản nơi thoáng mát, khô ráo, tránh nhiệt độ cao. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(36, 'Bộ 5 Dụng Cụ Cắt Tỉa Cây Cảnh', '5DUNGCU', 'bo-5-dung-cu-cat-tia-cay-canh', 'Công dụng: Bộ Sản Phẩm Gồm 5 Món:. - 3 Kéo: 1 Kéo Mũi Nhọn, 2 Kéo Cộng Lực. - 2 Cưa: 1 Cưa Gấp, 1 Cưa Mini. Đáp Ứng Mọi Nhu Cầu Cắt Tỉa Cây Cảnh. Kéo Mũi Nhọn: Kéo mũi nhọn có thể luồn lách các cành cây dễ dàng, kích thước vừa tay có thể dùng cắt tỉa cành lá hay trái cây. Cưa Gấp: Cưa có thể gấp lại và mang đi bất cứ đâu, tiện lợi. Có thể cưa các cành to đủ loại. Chất liệu thép bền không gỉ. Kéo Cộng Lực Size Vừa: Kéo dạng kéo lưỡi cong, chất liệu thép không gỉ, sắc bén, kích thước vừa tay, có lò xo trợ lực giúp cắt cành dễ dàng không đau tay. Kéo Cộng Lực Size Lớn: Kéo dạng kéo lưỡi cong, kích thước to hơn size vừa một tí, có lò xo trợ lực giúp cắt cành dễ dàng đặc biệt các cành có đường kính to cở 20mm. Cưa Mini: Chất liệu thép mangan SK5 không gỉ, kích thước nhỏ mini cưa được các cành nhỏ đến vừa, dễ dàng mang theo khi đi du lịch, thám hiểm.
Đối tượng cây trồng: Kéo Cắt Tỉa Cây
Quy cách: 1 Bộ sản phẩm gồm 5 món:
Giá tham khảo: 230.000đ', '230000.00', 4, 1, 4, 478, 'None', 'Nhật Bản', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Kéo mũi nhọn: chỉ cần lấy cao su ra ở tay cầm ra và dùng.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Cưa gấp: mở khóa an toàn ở tay cầm và dùng. Cưa mini: tháo vỏ bọc giấy ra và dùng binh thường thôi. Sơ cứu: Chưa có thông tin.'),
(37, 'Bộ Dao Cắt Tỉa Cây Cảnh, Hoa Quả 14 Món RDEER', 'BDCT14', 'bo-dao-cat-tia', 'Công dụng: Nhiều Kiểu Dáng. Chất Liệu Thép Không Gỉ Vô Cùng Sắc Bén. Bộ dao tỉa đa năng dùng trong điêu khắc âm thực với nhiều mũi dao với các hình thù, kiểu dáng khác nhau giúp cho người dùng đạt được mục đích trong công việc của mình. Mũi tỉa sắc bén. Bộ sản phẩm là hàng nhập khẩu Đài Loan chính hãng RDEER, lưỡi tỉa là thép cacbon trong quá trình sử dụng rất sắc mà không sợ han gỉ, đặc biệt rất dễ vệ sinh sau khi sử dụng. Cán cầm bằng nhôm được bọc nhựa rẻo.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Giá tham khảo: 265.000đ', '265000.00', 4, 1, 4, 496, 'RDEER', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Dao Cắt Tỉa', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(38, 'Bộ Dụng Cụ Làm Vườn 4 Món - Nhiều Size Kích Thước', 'B4V-1', 'bo-dung-cu-lam-vuon-4-mon', 'Công dụng: Bộ 4 Dụng Cụ - Giúp Làm Vườn Dễ Dàng. Bộ Có 2 Size Kích Thước Để Lựa Chọn. Được Sơn Tĩnh Điện - Không Gỉ Theo Thời Gian. Bộ 4 dụng cụ làm vườn thép được dùng trong các công việc như xới đất, trồng rau, trồng hoa, trồng cây. Đây là bộ dụng cụ là không thể thiếu, nó rất phù hợp để trồng rau trong các hốc trồng xinh xắn. Đối với các gia đình có con nhỏ thì dụng cụ này là phụ kiện không thể thiếu cho các con để các con tiếp cận với tự nhiên. Với việc trồng rau trên hệ thống Aquaponic với dung dịch thủy canh thì xẻng mini này rất tiện lợi khi bạn làm việc với sỏi nhẹ.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Size 2 / Size 1
Giá tham khảo: 145.000đ', '145000.00', 4, 1, 4, 500, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(39, 'Bộ Vòi Tưới Cây Đa Năng LIONKING 8 Chế Độ', 'SY05', 'bo-voi-tuoi-cay-da-nang-lionking-8-che-do', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Bộ 6 chế độ / Bộ 8 Chế Độ
Giá tham khảo: 310.000đ - 400.000đ', '355000.00', 4, 1, 4, 520, 'LIONKING', 'Đài Loan', NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Sau khi lắp với nguồn nước thì vòi sẽ có 8 kiểu phun. xoay đầu vòi phun để chọn kiểu phun theo ý muốn.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(40, 'Bột Phấn Kiến VIPESCO - Gói 50g', 'BPKVIP', 'bot-phan-kien-vipesco', 'Công dụng: Diệt Trừ Tận Gốc. Dễ Làm, Giá Rẻ, An Toàn. Diệt trừ các côn trùng có hại như kiến, gián trong nhà ở, khách sạn, nhà hàng, nhà xưởng, kho bãi, vườn cây, chậu cây cảnh. Rắc bột phấn kiến nơi côn trùng thường qua lại hoặc trú ẩn, xung quanh chân tủ để thức ăn, thùng rác (tương ứng liều lượng khoảng 20g/m2).
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Gói 50g
Giá tham khảo: 15.000đ - 20.000đ', '17500.00', 2, 1, 4, 530, 'VIPESCO', NULL, '0.05', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Deltamethrin: 0,5% w/w. Phụ Gia: kaolin, Talc, Sio2...99,55.
Loại sản phẩm: Thuốc DIệt Côn Trùng', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chế phẩm dính vào mắt phải rửa mắt bằng nước sạch, Chế phẩm dính vào da phải tắm sạch với nước ấm và xà phòng. Nếu ngộ độc do nuốt/ hít phải chế phẩm hãy đưa nạn nhân đến nới thoáng khí sau đó đưa đến cơ sở y tế gần nhất và nhớ mang theo nhãn chế phẩm gây độc. Xử lý chế phẩm còn dư, tránh gây ảnh hưởng đến môi trường. Thu gom và không sử dụng lại bao bì, thải bỏ chế phẩm theo quy định về xử lý chất thải nguy hại. Lưu ý khi sử dụng: Trang bị dụng cụ bảo hộ cá nhân ( khẩu trang, găng tay, kính...) khi sử dụng chế phẩm,. Cần rửa tay với xà phòng sau khi sử dụng chế phẩm. Sơ cứu: Chưa có thông tin.'),
(41, 'Bột Trừ Kiến - Gián Green Killer Powder', 'GRE.KILER', 'bot-tru-kien-gian-green-killer-powder', 'Công dụng: Diệt Kiến Và Gián An Toàn. Bột Dạng Hạt Dễ Dàng Sử Dụng. Một Con Ăn Cả Đàn Chết. Tác dụng hiệu quả nhanh chóng nhờ hợp chất Fipronil. Diệt gián hiệu quả dù gián đã kháng các sản phẩm diệt gián thông thường. Những con gián ăn lại xác gián đã nhiễm đều bị bệnh và chết. Thiết kế đơn giản, dễ dàng, tiện lợi, nhỏ gọn. Mùi hương dễ chịu kích thích gián đến gần viên đen để kiếm ăn.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Gói 5g
Giá tham khảo: 5.000đ', '5000.00', 2, 1, 4, 542, 'Zhejiang Dier Chemical Co., Ltd', 'Zhejiang Dier Chemical Co., Ltd', '0.01', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Thuốc diệt côn trùng', 'Hướng dẫn sử dụng: Dùng 1 – 2 gam bả (1/3 muổng cà phê) rắc nơi có kiến, gián đi qua, trên bếp, trong phòng, trước tổ, mép ngoài chậu lan, gốc cây, xung quanh vườn. Kiến sẽ làm việc còn lại đó là tha về tổ, cả tổ kiến gây rối loạn sinh lý tự cắn nhau rồi chết hết. Xử lý hạt giống: hạt giống sau khi gieo xuống đất rắc một ít lên trên kiến sẽ tha bả kiến đi không tha hạt giống.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(42, 'CAM BI NHẬT - Phân Bón Lá Trung Vi Lượng', 'PB.3014', 'cam-bi-nhat', 'Công dụng: Bổ Sung Vi Lượng Cho Cây Dễ Hấp Thu. Phòng Chống Cây Trồng Còi Cọc. Khắc Phục Hiện Tượng Rụng Hoa. Gia Tăng Năng Suất Và Chất Lượng Cây Trồng. Cam bi nhật chứa đầy đủ các yếu tố trung vi lượng ở dưới dạng chelating hóa tinh khiết giúp cây trồng dễ dàng hấp thu 100% dưỡng chất , đồng thòi giúp cây phát triển, hấp thụ nhanh các dưỡng chất khác ở trong đất. Giúp chống lại bệnh thiếu dinh dưỡng ở cây như : cây còi cọc ( si cây ), rụng bông, rụng trái, quăng lá, vàng lá, cháy lá,nám trái, đen trái,chết cành, khô cây. Giúp cây trồng tổng hợp và hấp thụ dinh dưỡng một cách nhanh chóng và đạt hiệu quả cao nhất, cây xanh mượt, cây phát triển tột bật, chống đổ ngã, tăng sức đề kháng với sâu bệnh. Tăng tỷ lệ đậu trái, trái lớn nhanh, màu sắc bóng đẹp, tăng hương vị đặc trưng của nông sản. Trên lúa giúp kích thích bông ra nhiều, đồng loạt, chống nghẹn bông, dưỡng đòng, dưỡng hạt. Tăng năng suất rõ rệt, đạt tiêu chuẩn xuất khẩu.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 40g
Giá tham khảo: 25.000đ - 30.000đ', '27500.00', 1, 1, 4, 557, 'C.Ty TNHH TM Ngân Gia Nhật', 'C.Ty TNHH TM Ngân Gia Nhật', '0.04', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Thuốc dạng bột chứa các trung bi lượng dạng chelating hóa tinh khiết. Boron (B): 2000ppm. Mangan (Mn): 700ppm. Magie (MgO): 1.020ppm. Kẽm (Zn): 700ppm. Sắt ( Fe) 700ppm. Đồng (Cu): 1.700ppm. Canxi (CaO): 350ppm. Lưu Huỳnh (S): 17000ppm. Phụ Gia tinh khiết quý hiếm vừa đủ 100%.
Loại sản phẩm: p', 'Hướng dẫn sử dụng: CAM BI NHẬT sử dụng cho tất cả các loại cây trồng. Phun vào buổi sáng hoặc chiều mát, tránh trời mưa. Phun đều vào thân rễ lá đối với các cây ăn trái và phong lan đơn thân. Phun vào rễ đối với phong lan đa thân.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(43, 'CANON 100SL – Thuốc Đặc Trị Bọ Trĩ', 'NN.2953', 'canon-100sl-thuoc-dac-tri-bo-tri', 'Công dụng: Thuốc Trừ Sâu Phổ Rộng. Có Tác Dụng Tiếp Xúc và Lưu Dẫn. Diệt Trừ Nhiều Loại Sâu Rầy. Hiệu Lực Mạnh, Bảo Vệ Tốt. Canon 100sl là Thuốc Trừ Sâu Phổ Rộng Có tác dụng tiếp xúc và lưu dẫn diệt trừ nhiều loại sâu rầy. Đặc biệt thuốc đặc trị bọ trĩ mà không hại đến bông.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng  >  Thuốc trị Bọ Trĩ
Quy cách: Chai 250ml
Giá tham khảo: 155.000đ - 55.000đ', '105000.00', 2, 1, 3, 569, 'CTY CP Sát Trùng Cần Thơ', 'Changzhou Pecticides Factory, Longhutan, New district of Changzhou, jiangsu, China PO Box 213031, Ch', '0.25', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Imidacloprid…100/l.
Loại sản phẩm: Thuốc Trừ Sâu', 'Hướng dẫn sử dụng: Liều dùng: 5-7ml / 8 lít nước. Phun khi thấy bọ trĩ hay sâu non vừa xuất hiện, có thể phun lại 7-10 ngày tùy theo mật độ sâu phá hại. Phun ướt đều trên tán lá.
An toàn sử dụng: Bảo quản: Bảo quản nơi thoáng mát, tránh ánh nắng trực tiếp. Để xa tầm tay trẻ em, nguồn nước và thực phẩm. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Chú ý mặt dưới lá và nhưng phần non của cây. Có thể pha chung với các thuốc trừ sâu bệnh khác, ngoại trừ các thuốc có tính kiềm. Thời gian cách ly: 14 ngày trước khi thu hoạch . Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(44, 'CANXI NITRAT | Ca(NO3)2 15-0-0+26 CaO', 'CA.NITRAT', 'canxi-nitrat-cano32-15-0-0-26-cao', 'Công dụng: Tăng cường chất đạm và Canxi dạng dễ tiêu. ► Giúp cây khoẻ, thân to, cứng chắc. ► Khắc phục các hiện tượng thiếu Canxi. ► Giúp lúa đứng cây, giảm đổ ngã. Canxi Nitrat tăng cường chất đạm và Canxi dạng dễ tiêu giúp cây trồng hấp thu nhanh. Giúp cây khoẻ, thân to, cứng chắc, tăng khả năng chống chịu sâu bệnh. Canxi Nitrate giúp khắc phục các hiện tượng thiếu Canxi như nứt trái và thối đít trái đặc biệt vào mùa mưa. Giúp lùa đứng cây, giảm đổ ngã, hạt lúa to chắc, vàng sáng, bỏng đẹp. Ngoài ra, Phân bón canxi nitrat giúp tăng năng suất và kéo dài thời gian tồn trữ nông sản.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 1Kg
Giá tham khảo: 60.000đ', '60000.00', 1, 1, 4, 580, 'Haifa Chemicals - Do Thái', NULL, '1.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Đạm (N 15%); Canxi (CaO) 26%.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Cà Phê:. 100-150g/16 lít nước, dùng cách nhau 15 - 20 ngày. Giai đoạn khi có trái non, áp dụng từ 2 – 3 lần, cách nhau 15 - 20 ngày, giúp trái chín đồng loạt.
An toàn sử dụng: Bảo quản: Bảo quản nơi khô ráo thoáng mát. - Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(45, 'Champion 77WP - Thuốc Trừ Bệnh Nấm Hồng Và Thán Thư', 'CHA.PION', 'champion-77wp-thuoc-tru-benh-nam-hong-va-than-thu', 'Công dụng: Diệt nhanh nấm bệnh và vi khuẩn. Trừ bệnh dạng tiếp xúc phổ rộng. Đặc trị nấm hồng trên hoa mai cực kỳ tốt. Thuốc trừ nấm bệnh Champion 77WP đặc trị bệnh nấm hồng cho cây mai vàng hiệu lực cao, kéo dài. Champion 77WP là dòng thuốc trừ nấm bệnh phổ rộng, tác động tiếp xúc có khả năng phòng trừ nấm bệnh và vi khuẩn gây bệnh trên cây trồng. Sản phẩm có khả năng loang trải rộng, chống rửa trôi, bám dính tốt, hiệu lực cao.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Gói 100g
Giá tham khảo: 50.000đ', '50000.00', 2, 1, 4, 591, 'CTY TNHH ADC', 'Nufarm Malaysia Sdn.Bhd. No 35-2, Janan Setia Prima, Malaysia', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Copper Hydroxide 77% (w/w). Phụ gia vừa đủ.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Pha 03 gram thuốc trừ nấm bệnh champion 77WP vào 1 lít nước sạch, lắc đều rồi phun lên cây trồng. Nên phun đẫm ở những nơi nấm hồng xuất hiện nhiều. Phun lại sau 7 - 14 ngày. Nên phun vào sáng sớm hoặc chiều mát để đạt hiệu quả cao nhất. ​​​​​​​ ​​​​​​​.
An toàn sử dụng: Bảo quản: Bảo quản nơi thoáng mát, tránh ánh nắng trực tiếp. Để xa tầm tay trẻ em, nguồn nước và thực phẩm. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(50, 'Chậu Mèo Dễ Thương - Chậu Trồng Thủy Sinh', 'C.MEO', 'chau-meo-de-thuong-chau-trong-thuy-sinh', 'Công dụng: Chậu Kích Thước Nhỏ, Thủy Tinh Trồng Cây Thủy Sinh. Kiểu Dáng Dễ Thương, Ngộ Nghĩnh. Thích Hợp Decor Bàn Làm Việc, Phòng Khách,v.v. Các Tín Đồ Thích Mèo Không Thể Bỏ Qua. Với thiết kế nhỏ gọn, đẹp mắt, ngộ nghĩnh, cùng nhiều kiểu dáng để lựa chọn. Chật liệu thủy tinh và gốm, bền tốt. Giúp decor bàn làm việc, bàn khách, phòng ngủ, v.v đều được. Ngoài trồng thủy sinh, còn có thể nui cá trong chậu cực tiện lợi.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: Mẫu 6 / Mẫu 5 / Mẫu 4 / Mẫu 3 / Mẫu 2 / Mẫu 1
Giá tham khảo: 85.000đ', '85000.00', 4, 1, 4, 654, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây vào chậu và dùng thôi.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(51, 'Chậu Nhựa Treo Tròn Trơn - Chậu Treo Trồng Cây', 'CN.TRONTR', 'chau-nhua-treo-tron-tron', 'Công dụng: Chậu Trơn Thiết Kế Đơn Giản Dễ Phối Cây. Chậu Nhiều Màu Sắc, Lựa Chọn. SHOP SẼ GIAO MÀU NGẪU NHIÊN TÙY ĐỢT HÀNG. KHÁCH MUỐN CHỌN MÀU CỨ LIÊN HỆ TRỰC TIẾP QUA SHOP, HOẶC CHỌN MÀU KHI SHOP GỌI CHỐT ĐƠN. Chậu nhựa bao gồm móc treo cùng màu kèm theo chậu. Chậu được thiết kế dạng chậu trơn láng bóng, thiết kế đơn giản, dễ phối vs cây trồng. Màu sắc chậu đa dạng, tươi sáng và bắt mắt mang đến nét đẹp trẻ trung và hiện đại trong trang trí. Sợi nhựa chất lượng cao, có độ bền và độ đàn hồi tốt khó đứt gãy và phai màu trong quá trình sử dụng. Chậu nhựa dễ lau chùi và ít bám bụi.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: Size 2 / Size 1
Giá tham khảo: 10.000đ', '10000.00', 4, 1, 4, 672, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây vào chậu và treo lên theo ý thích. ​​​​​​​.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(52, 'Chậu Nhựa Treo Tổ Ong', 'C.TOONG', 'chau-nhua-treo-to-ong', 'Công dụng: Chậu Treo Nhiều Màu. Chậu Nhựa Treo Họa Tiết Tổ Ong. Giúp Trang Trí Khu Vườn Nhỏ Của Bạn. TÙY ĐỢT HÀNG SHOP SẼ GIAO MÀU NGẪU NHIÊN Ạ. Chậu nhựa bao gồm móc treo cùng màu kèm theo chậu. Chậu được thiết kế hoa văn giả tổ ong rất tinh tế, dễ thương, thiết kế trang nhã vẫn giữ được nét đẹp mộc mạc. Màu sắc chậu đa dạng, tươi sáng và bắt mắt mang đến nét đẹp trẻ trung và hiện đại trong trang trí. Sợi nhựa chất lượng cao, có độ bền và độ đàn hồi tốt khó đứt gãy và phai màu trong quá trình sử dụng. Chậu nhựa dễ lau chùi và ít bám bụi.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: F12
Giá tham khảo: 10.000đ', '10000.00', 4, 1, 4, 682, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây vào chậu và treo lên theo ý thích.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(53, 'Chậu Nhựa Treo Đan Mây - Chậu Nhựa Treo Ban Công', 'C.ĐANMAY', 'chau-nhua-treo-dan-may-chau-nhua-treo-ban-cong', 'Công dụng: Chậu Nhựa Treo Nhiều Kích Thước. Chậu Dạng Treo Nhiều Màu Sắc. Treo Ban Công, Hàng Rào, V.v. SHOP SẼ GIAO MÀU NGẪU NHIÊN TÙY MỖI ĐỢT HÀNG Ạ. Chậu nhựa bao gồm móc treo cùng màu kèm theo chậu. Chậu được thiết kế hoa văn giả mây đan rất dễ thương, thiết kế trang nhã vẫn giữ được nét đẹp mộc mạc. Màu sắc chậu đa dạng, tươi sáng và bắt mắt mang đến nét đẹp trẻ trung và hiện đại trong trang trí. Sợi nhựa chất lượng cao, có độ bền và độ đàn hồi tốt khó đứt gãy và phai màu trong quá trình sử dụng. Chậu nhựa dễ lau chùi và ít bám bụi. ỨNG DỤNG. Chậu nhựa đan mây treo ban công được ứng dụng trồng các loại cây hoa bụi mà bạn yêu thích. các loại hoa dây leo hay những cây thân rủ,…. Với móc treo chắc chắn có thể treo móc trên bất cứ lan can, ban công, hàng rào quanh nhà. Đồng thời, đặt chậu đã trồng cây vào giá móc, thế là bạn đã sở hữu được một không gian xanh ở ban công nhà mà vẫn tiết kiệm được diện tích đáng kể. Đặc điểm chung của chậu đan mây treo ban công là thích hợp trồng các loại cây thân mềm, thân rủ, hoa dây leo mềm mại như các loại dạ yến thảo. dừa cạn rủ. mười giờ. chuỗi ngọc ….
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: F20 / F16
Giá tham khảo: 15.000đ', '15000.00', 4, 1, 4, 692, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây vào chậu và treo lên theo ý thích.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(54, 'Chậu Nhựa Trồng Cây Đủ Màu - Size 7x7x8', 'CNTCM', 'chau-nhua-trong-cay-mini', 'Công dụng: Sản phẩm thường được sử dụng trong trang trí tiểu cảnh, trồng cây, terrarium, đồ trang trí, lưu niệm, quà tặng, trang trí hồ cá…. Shop sẽ giao hàng ngẫu nhiên đảm bảo tối đa khách hàng nhận được nhiều màu nhất có thể.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: Màu Ngẫu Nhiên
Giá tham khảo: 3.000đ', '3000.00', 4, 1, 4, 710, 'No Brand', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu Nhựa Trồng Cây', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(55, 'Chậu Nhựa Trồng Lan - Chậu Nhựa Nan Giả Gỗ', 'C.NAN', 'chau-nhua-trong-lan-chau-nhua-nan-den', 'Công dụng: Chậu Nhựa Nan Giả Gỗ. Giá Thành Rẻ, Chất Lượng. SHOP SẼ GIAO MÀU NGẪU NHIÊN TÙY ĐỢT HÀNG. KHÁCH MUỐN CHỌN MÀU CỨ LIÊN HỆ TRỰC TIẾP QUA SHOP, HOẶC CHỌN MÀU KHI SHOP GỌI CHỐT ĐƠN.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: F35 / F26 / F20 / F16
Giá tham khảo: 8.000đ', '8000.00', 4, 1, 4, 712, 'None', 'Chậu được sản xuất tại Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây vào chậu và treo lên.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Thiết kế phù hợp cho lan phát triển tốt. Dễ dàng vận chuyển đi xa với số lượng từ nhỏ đến lớn. Chậu bền đẹp, sang trọng, không nặng nề, dễ vỡ như chậu đất và giá rẻ hơn nhiều. Chậu nhựa có nan phụ giúp cho giá thể không bị rơi ra ngoài. Chậu nhựa giả chậu gỗ được thiết kế gọn nhẹ đẹp mắt, treo lên dàn không nặng dàn lan so với chậu đất nung. Giá thành rẻ hợp lý cho người chơi tài tử và nhà vườn trồng hoa. Đặt biệt là nhà vườn trồng hoa từ cây con và lớn lên rồi xuất vườn thì đưa vào (san chậu) nhựa giả gỗ này sẽ đẹp hơn và tăng giá trị cây lên, rất dể bán hơn so với chậu nhựa đen thông thường. Chậu treo được ngoài trời và chịu được nắng mưa. Chậu nhựa trồng lan sở hữu kiểu dáng dáng tròn đơn giản kết hợp tông nâu đỏ giả gỗ cổ điển, góp phần mang đến vẻ trang nhã cho khu vườn nhà bạn. Sơ cứu: Chưa có thông tin.'),
(56, 'Chậu Nhựa Vuông Mini Kèm Đĩa - Chậu Nhựa Nhiều Màu', 'CKD.MINI', 'chau-nhua-vuong-mini-kem-dia-chau-nhua-nhieu-mau', 'Công dụng: Chậu Nhựa Mini Nhiều Màu. Chậu Kèm Đĩa, Màu Pastel, Dễ Phối Trồng Cây. Kích Thước Nhỏ, Thích Hợp Trồng Sen Đá, Xương Rồng.
Đối tượng cây trồng: Chậu Trồng Cây
Quy cách: Màu Ngẫu Nhiên
Giá tham khảo: 4.000đ', '4000.00', 4, 1, 4, 726, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chỉ cần trồng cây và để nơi cần trang trí.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: – Hạn chế phai màu theo thời gian. – Màu sắc pastel nhẹ nhàng, màu được phối theo những tông màu hiện đại của năm. – Thân thiện môi trường, chậu kèm đĩa tránh bẩn khi tưới cây. Sơ cứu: Chưa có thông tin.'),
(57, 'Chậu Nhựa Đen Trồng Lan size F10 - F28', 'CTDF10', 'chau-nhua-den-trong-lan', 'Công dụng: Nhựa BP Cứng Màu Đen. Thường dùng để trồng Lan. Mua Sỉ LH: 0835 29 4953.
Đối tượng cây trồng: Chậu Trồng Cây  >  Chậu Nhựa Trồng Cây
Quy cách: F10 / F12 / F14 / F16 / F18 / F21 / F23 / F25 / F28
Giá tham khảo: 2.000đ', '2000.00', 4, 1, 4, 738, 'None', 'Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Chậu trồng cây', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(58, 'Chế Phẩm Diệt Côn Trùng CHLOXAM 350SC Hiệu PET ONE', 'PETONE', 'che-pham-diet-con-trung-chloxam-hieu-pet-one', 'Công dụng: Chế Phẩm Dạng Sữa Mát Cây. Diệt Côn Trùng Lẫn Sâu Hại Như: Ruồi, Muỗi, Kiến, Nhện Đỏ, Rệp Sáp, v.v. An Toàn Dùng Trong Gia Dụng Và Y Tế. Lưu Dẫn Mạnh, Hiệu Quả Kéo Dài. Hiệu quả vượt trội trong việc phòng và diệt bọ trĩ , sâu rầy , và nhện đỏ trên các loại cây trồng như mai vàng , hoa hồng , và cây ăn trái . Sản phẩm còn có khả năng tiêu diệt hiệu quả các loại côn trùng gây hại trong vườn, đồng thời giữ cho môi trường xung quanh sạch sẽ, không còn sự xuất hiện của muỗi và kiến trong vòng 30 ngày sau khi phun.
Đối tượng cây trồng: THUỐC BẢO VỆ THỰC VẬT
Quy cách: Chai 100ml
Giá tham khảo: 85.000đ', '85000.00', 2, 1, 3, 758, 'Nông Phố Xanh', 'Việt Nam', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chlorfenapy.........20%w/v. Thiamethoxam..... 15%w/v. Phụ gia..............65%w/v. ĐẶC ĐIỂM NỔI BẬT. Hai hoạt chất mạnh : Kết hợp giữa Chlorfenapyr và Thiamethoxam , sản phẩm có tác dụng vị độc, xông hơi, tiếp xúc và thẩm thấu vào cây trồng, tiêu diệt côn trùng từ bên trong. Lưu dẫn mạnh : Sản phẩm dạng sữa mát, dễ dàng bám dính và thẩm thấu vào cây trồng, cho hiệu quả nhanh chóng. Hiệu quả kéo dài : Với khả năng tồn lưu cao, Chloxam 350SC giúp bảo vệ cây trồng trong thời gian dài, tiết kiệm thời gian và công sức.', 'Hướng dẫn sử dụng: Đặc trị:. Sâu cuốn lá, bọ trĩ, nhẹn gié, rầy nâu, sâu đục bẹ, sâu năn (muỗi hành), sâu đục thân/lúa. Sâu xanh, nhện đỏ/hoa hồng. Bọ trĩ/hoa mai, bọ trĩ/điều. Dòi đục lá, sâu xanh da láng/đậu tương. Mối/cà phê. Liều lượng: 20-25ml/ bình 20 lít trừ các loại côn trùng TRONG VƯỜN. Thời gian cách ly : Đưa người và vật nuôi ra khỏi khu vực phun. Sau 30 phút, có thể trở lại khu vực phun. Nhắc lại : Nếu cần, có thể nhắc lại việc phun sau 30 ngày. Pha chế : Pha 50ml sản phẩm với 8 lít nước để phun trên diện tích 200m² nhằm diệt muỗi và kiến. Hiệu lực diệt tồn lưu : 30 ngày kể từ khi phun.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: HƯỚNG DẪN AN TOÀN:. Không hút thuốc, ăn uống khi đang phun thuốc. BIỆN PHÁP SƠ CỨU:. Khi thuốc dính vào mắt phải rửa bằng dòng nước sạch ít nhất 15 phút. Nếu bị thuốc dính vào da thì phải rửa sạch bằng xà phòng. Trong trường hợp bị ngộ độc thuốc phải đưa nạn nhân đi cấp cứu tại bệnh viện gần nhất, nhớ mang theo nhãn thuốc đã gây ngộ độc. LƯU Ý KHI SỬ DỤNG. Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(61, 'Chế Phẩm Sinh Học BIO-B _ Phòng Trừ Bọ Trĩ, Nhện Đỏ, Sâu Rầy', 'TMP-SYNC-61', 'che-pham-sinh-hoc-bio-b', 'Công dụng: Thuốc Trừ Sâu Rầy Sinh Học. Bacillus Thuringiensis: 10 8 Cfu/ml. An Toàn Tuyệt Đối Cho Người Và Cây Trồng. Hiệu Quả Cao, Tiết Kiệm Chi Phí. Phòng và trừ hiệu quả các loại rầy, bọ trĩ, nhện đỏ, rệp sáp, rầy nầu, bọ cánh cứng, cào cào, ve sầu, mối... trên hoa hồng và trên nhiều loại cây trồng khác, có thể sử dụng định kỳ chế phẩm sinh học Bio - B để phát huy hiệu quả cao nhất mà không cần sự can thiệp của các loại chế phẩm bảo vệ thực vật có nguồn gốc hóa học. Bên cạnh đó, chế phẩm sinh học Bio - B còn có khả năng phòng và trừ nhiều loại sâu hại như sâu tơ, sâu xanh, sâu xám, sâu khoang, sâu keo da láng, sâu róm thông, sâu cuốn lá.', '52000.00', 2, 1, 4, 798, 'CTY TNHH Phân Bón Lực Điền', NULL, '0.03', 1, '2026-05-31 00:00:00', '2026-05-31 17:24:14', 'Thành phần: Bacillus thuringiensis: 108 CFU/ml.', 'Hướng dẫn sử dụng: HƯỚNG DẪN SỬ DỤNG:. Pha hết 1 gói gồm hai ngăn cho 100 - 200 lít nước, phun trên tán lá hoặc tưới gốc tùy đổi tượng phòng trừ.
An toàn sử dụng: Bảo quản: Bảo quản nơi khô ráo thoán mát. • Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Lưu ý khi sử dụng: Nên phun vào thời điểm sáng sớm hoặc chiều mát. - Nên trộn thêm bám dính sinh học. - Phun khi sâu, rầy hại mới xuất hiện để được hiệu quả tốt nhất. Sơ cứu:'),
(65, 'Chế Phẩm Vi Sinh Xua Đuổi Ruồi Vàng Siêu Đậm Đặc', 'CP.RUOIV', 'che-pham-vi-sinh-xua-duoi-ruoi-vang-sieu-dam-dac', 'Công dụng: Công Nghệ Vi Sinh Khống Chế, Xua Đuổi Ruồi Vàng. Thành Phần Là Hợp Chất Thảo Mộc Giúp Tiêu Trùng Ruồi Nhanh. Bảo Vệ Hoa Qủa Khỏi Ruồi Vàng, Đặc Biệt Các Qủa Có Muối.
Đối tượng cây trồng: THUỐC BẢO VỆ THỰC VẬT
Quy cách: Chai 240ml
Giá tham khảo: 40.000đ', '40000.00', 2, 1, 3, 851, 'CTY TNHH TMDV HƯNG ĐIỀN', NULL, '0.24', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Vi sinh Bacillus spp. : 1.10^6 CFU/g. Chất thảo mộc. Enzyme. Tinh dầu quế. Hợp chất protein lên men. Dịch tỏi lên men. + Bảo vệ trái tránh sự xâm hại của ruồi vàng, gây thối trái, xù mủ trên trái. + Giúp trái sáng bóng, trái hư hỏng do ruồi vàng đục trái, tránh teo quả, sượng quả.
Loại sản phẩm: Chế phẩm vi sinh', 'Hướng dẫn sử dụng: + Pha 40 - 50 ml chế phẩm cho bình 16 - 18 Lít nước. Chai 240ml chế phẩm pha cho 80 - 100 lít nước. Phun khi ruồi vàng xuất hiện. Các lần phun cách nhau 10 - 15 ngày.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(66, 'CITIZEN 777 - Thuốc đặc trị nấm bệnh, khuẩn cho lan, cây cảnh', 'CITIZ.7', 'citizen-777-thuoc-dac-tri-nam-benh-khuan-cho-lan-cay-canh', 'Công dụng: Citizen 777 là dòng thuốc nội hấp có hiệu lực kéo dài, độ bám dính cao. Hạt cực mịn nên cây trồng hấp thụ nhanh. Phòng trị các loại bệnh do nấm, vi khuẩn gây ra. Trị đốm vàng, đốm nâu, đốm đen, vàng lá, thối nhũn, thối rễ, héo rũ và gỉ sắt.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Gói 7g
Giá tham khảo: 20.000đ', '20000.00', 2, 1, 4, 862, 'Công Ty TNHH Hóa Nông Việt Á', NULL, '0.01', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Validamycin: 50g/kg. Tricyclazole: 692g/kg. Kasugamycin: 35g/kg. Phụ gia:... 223g/kg.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Pha 7gr/ bình 16 lít nước. Phun khi vết bệnh mới xuất hiện. Phun vào sáng sớm hoặc chiều mát. Phun ướt lên toàn bộ thân, cành và 2 bề mặt của lá. Kết hợp thêm chất bám dính để đạt hiệu quả cao nhất.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(67, 'COC 85WP – Thuốc Trừ Nấm, Vi Khuẩn', 'NND.3012', 'coc-85wp-thuoc-tru-nam-vi-khuan', 'Công dụng: Thuốc Gốc Đồng Trị Bệnh Phổ Rộng. Cung Cấp Vi Lượng Đồng Cho Cây. An Toàn Cho Vật Nuôi, Cây Trồng Và Con Người. COC 85WP là thuốc trị nấm bệnh và vi khuẩn từ gốc đồng. dạng bột mịn, loan trải đều, bám dính tốt, không rửa trôi nên phòng và trừ bệnh thán thư trên 1 số cây ăn trái rất hiệu quả.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: g / Gói 20g
Giá tham khảo: 20.000đ', '20000.00', 2, 1, 4, 875, 'Công Ty TNHH Ngân Anh', 'Tây Ban Nha', '0.02', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Copper Oxychloride 85% w/W (1kg đồng Oxy clorua chưa 500g Đồng – 50% Cu ). • Phụ Gia 15% w/W Coc 85wp dạng hạt mịn, tan ngay, không nghẹt Béc, bám dính tốt, hiệu quả cao.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Đối với bệnh chết nhanh ở Hồ Tiêu: pha 40g/ 16 lít nước (500g/ phuy 200 lít nước). Phun ướt đều thân lá và tưới gốc lúc sáng sớm hoặc chiều mát. • Lượng nước phun tùy theo cây trồng và thời gian sinh trưởng. • Phun phòng ngừa và trị khi bệnh mới xuất hiện. • Nếu bệnh nặng nên phun 2 lần trong 7 ngày. • Không phun trực tiếp lên hoa khi hoa đang nở. Curenox COC 85wp ít độc với động vật máu nóng, không ảnh hưởng đến môi trường sinh thái và không tích lũy trong đất.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(68, 'Confidor 200SL - Thuốc Trị Bọ Trĩ', 'NN.1542', 'confidor-200sl', 'Công dụng: Đặc Trị Các Loại Côn Trùng Hút Chích. Thuốc Lưu Dẫn Nhanh Và Mạnh. Không Mùi, Dễ Sử Dụng. Bảo Vệ Tuyệt Đối Cây Trồng Khỏi Côn Trùng. Thuốc trừ sâu CONFIDOR 100SL – thuốc trừ sâu đặc trị các loại côn trùng chích hút. Ít ảnh hưởng đến thiên địch và cây trồng, chỉ trừ sâu. Hiệu lực trừ sâu kéo dài. Lưu dẫn nhanh, mạnh nên ít bị rửa trôi do mưa. Rất tiện lợi, có thể phun, tưới hoặc quét vào thân cây (cam, quýt).
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Chai 50ml / Chai 100ml
Giá tham khảo: 85.000đ', '85000.00', 2, 1, 3, 888, 'Công ty TNHH Bayer Việt Nam', 'PT. Bayer Indonesia - Indonesia', '0.05', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Imidaclorid 200g/L. Phụ gia: 800g/L.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Thời gian cách ly: 7 ngày. Không sử dụng sản phẩm trong giai đoạn cây trồng chuẩn bị thu hoạch. Để sử dụng thuốc trừ rệp sáp Confidor 200SL- 20ml, bạn cần tuân thủ theo các bước sau:. Pha thuốc theo liều lượng khuyến cáo: 5 - 7 ml/ thuốc cho bình 8 lít nước. Phun thuốc khi cây trồng bắt đầu ra hoa hoặc khi phát hiện có sự xuất hiện của rầy rệp hoặc bọ trĩ. Phun thuốc đều lên lá và cành của cây trồng, đặc biệt là mặt dưới của lá. Phun thuốc vào buổi sáng hoặc chiều mát, tránh phun khi nắng gắt hoặc mưa. Lặp lại việc phun thuốc sau 7 - 10 ngày nếu cần. Liều lượng phun trên 1 ha: 240-500L. THÔNG TIN KHÁC:. Sản phẩm được dùng để phòng bệnh và trị bệnh do các loại rầy rệp và bọ trĩ gây ra cho nhiều loại cây như dưa leo, dưa hấu, xoài, nho, chè, cam, quýt, sầu riêng, cà phê, vải. + Dưa leo, dưa hấu: bọ trĩ (rầy lửa). + Xoài: rầy, bọ trĩ. + Nho: bọ trĩ. + Chè (trà): bọ cánh tơ. + Cam, quýt: sâu vẽ bùa, rệp sáp. + Sầu riêng: rầy chổng cánh. + Cà phê, tiêu: rệp sáp, rệp vảy. + Vải: rệp vảy. + Lúa: trừ rầy nâu, bọ trĩ. + Điều: bọ trĩ. + Các loại hoa kiểng (hoa hồng....). Sản phẩm có ưu điểm là ít ảnh hưởng đến thiên địch và cây trồng, hiệu lực trừ sâu kéo dài, lưu dẫn nhanh và mạnh.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(69, 'Cuộn Dây Buộc Lan - Có Lưỡi Cắt - Lõi Kẽm Bọc Nhựa', 'DBKX', 'cuon-day-buoc-lan-co-luoi-cat-loi-kem-boc-nhua', 'Công dụng: 1 Cuộn Dài: 50m. Lõi Kẽm Bọc Nhựa Xanh. Dây Có Thể Buộc Cành, Buộc Lan, Cố Định Thân Cây.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Giá tham khảo: 25.000đ - 35.000đ', '30000.00', 4, 1, 4, 902, 'Nông Nghiệp Đẹp', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Dây Buộc Lan', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(70, 'Cào Inox 15 Răng Cào Rác - Lá Cây', 'CAOINOX', 'cao-inox-15-rang-cao-rac-la-cay', 'Công dụng: Thiết Kế Thông Minh Có Thể Thu Ngắn Kéo Dài Nhiều Kích Cỡ. Nhẹ Người Lớn Trẻ Em Đều Có Thể Sử Dụng Dễ Dàng. Gom Lá Cây, Bọc Nilon, Rác Các Loại Trong Sân Vườn, Vườn Cây Rất Hiệu Quả. Chiếc cào thích hợp cho bãi cỏ, sân vườn, hàng rào và những nơi ngoài trời khác. Cào Cỏ 15 Răng có thể thu gom nhiều mảnh vụn hơn mỗi khi nó đi qua, rất thích hợp cho mọi công việc dọn dẹp trong vườn. Cào thép dùng làm sạch cỏ, rác, lá khô trong vườn nhà, khuôn viên, công viên, trường học, công ty. Ngoài ra cào còn dùng để sàng những đống lúa, ngô và ngũ cốc đều ra trên sân để phơi trong những ngày nắng. Cào vườn dễ dàng cào rác, lá cây và các mảnh vụn trong vườn và bãi cỏ mà không làm hỏng cây.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: 1 cây cào nặng 760g
Giá tham khảo: 180.000đ', '180000.00', 4, 1, 4, 916, 'None', NULL, '0.76', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(71, 'Cưa Cầm Tay Cán Gỗ - Cưa Gỗ, Cưa Cành Cây Các Loại', 'CCT-CG', 'cua-cam-tay-can-go-cua-go', 'Công dụng: Cưa Cán Gỗ Chắc Chắn, Dễ Cầm Nắm. Lưỡi Thép Xanh, Sắc Bén. Cưa Có 2 Kích Thước Để Lựa Chọn. Chất liệu: Thép hợp kim xanh sắc bén, không gỉ, độ đàn hồi cao. Chiều dài lưỡi cưa 330mm (vùng cắt hoạt động 240mm). Bước răng to cho đường cắt lớn, hiệu quả. Tay cầm bằng gỗ bền bỉ, không ăn mòn, tạo cảm giác cầm nắm thoải mái.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Size 2 / Size 1
Giá tham khảo: 50.000đ', '50000.00', 4, 1, 4, 930, 'Cơ sở sản xuất Thuận Hà', 'Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Để cắt được vật liệu, chỉ cần đặt lưỡi cưa lên bề mặt vật liệu rồi di chuyển lên xuống liên tục.
An toàn sử dụng: Bảo quản: Giúp cưa gỗ, tre, nứa, cành,.v.v ngoài ra còn có thể cưa ống nước các loại. Giúp hỗ trợ công việc trở nên dễ dàng hơn. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(73, 'Cưa Cầm Tay Cán Nhựa Mini - Cưa Lách, Cưa Cành Gỗ', 'CCN.MN', 'cua-cam-tay-can-nhua-mini-cua-lach-cua-canh-go', 'Công dụng: Cưa Kích Thước Nhỏ Dễ Mang Theo. Chất Liệu Thép SK5 Cứng Cáp. Lưỡi Cưa Sắc Bén, Dễ Sử Dụng. Lưỡi cưa được cố định với cán nhựa bằng ốc vít rất chắc chắn giúp bạn yên tâm khi sử dụng. Cán cầm bằng nhựa không những chống trơn trượt mà còn hạn chế tình trạng ăn mòn hoặc nấm mốc trong quá trình sử dụng. Nhờ vậy, sản phẩm là dụng cụ cầm tay hữu ích cho nhiều gia đình, nhà làm vườn, và trở thành vật dụng quen thuộc trong túi đồ sinh tồn, đồ cắm trại, đồ đi phượt. Cưa cắt cành mini nhỏ dọn tiện dụng chuyên sử dụng để cắt tỉa cành, hoa và cây ăn quả trong vườn. Với chất lượng lưỡi kéo mạnh mẽ, sắc bén và bền vững. Kéo cầm vừa tay, gọn nhẹ, thoải mái với phần tay cầm được bọc nhựa giúp việc chăm sóc hoa, cây cảnh trở nên dễ dàng, hiệu quả mà không bị tổn thương tay. Chiếc cưa có tổng chiều dài 35cm, khiến nó trở thành một thiết bị toàn diện dễ sử dụng cắt những cành dày hơn. Điều đó là lý tưởng cho tất cả các công việc cưa trong vườn, và ngoài trời. Nó rất nhẹ và hiệu quả. Lưỡi cưa mạ crôm cứng có răng chính xác, đảm bảo kết quả nhanh chóng với ít sử dụng lực, và cắt chính xác tuyệt vời. Công thái học xuất sắc, vật liệu chất lượng hàng đầu và tất nhiên là hiệu suất cưa tuyệt vời với ít sử dụng lực đảm bảo cưa dễ dàng.
Đối tượng cây trồng: THUỐC BẢO VỆ THỰC VẬT
Quy cách: Cái
Giá tham khảo: 35.000đ', '35000.00', 4, 1, 4, 960, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chỉ cần lấy cưa và dùng thôi.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(75, 'Cần Phun Inox | Cần Rút Có Thể Kéo Dài 1m5 - 3m', 'CANRUT', 'can-phun-inox-can-rut-co-the-keo-dai-1m5-3m', 'Công dụng: Cần Gồm 2 Quy Cách: Cần Có Thể Kéo Dài 1m - 2m / Cần Có Thể Kéo Dài 1m5 - 3m. Chất Liệu Inox Nhẹ, Dễ Dàng Sử Dụng. Giúp Tưới Cây, Phun Thuốc Dễ Dàng Hơn. Cần rút inox chịu áp lực dày 16 li, dài từ 1m4 đến 2m7 với ren 14mm là sản phẩm được gia công tinh vi, đảm bảo độ bền và chính xác cao. Chịu lực tốt: Với độ dày và chất lượng cao, cần rút inox có khả năng chịu được áp lực lớn, phù hợp cho các ứng dụng công nghiệp nặng.
Đối tượng cây trồng: VẬT TƯ NÔNG NGHIỆP
Quy cách: Loại Có Thể Kéo Dài 1m5 - 3m / Loại Có Thể Kéo Dài 1m - 2m
Giá tham khảo: 150.000đ', '150000.00', 4, 1, 3, 989, 'None', 'Đài Loan', NULL, 1, '2026-05-31 00:00:00', '2026-06-01 03:29:28', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Kết nối cần với máy bơm hoặc bình phun điện, đầu ren kết nối với béc phun và sử dụng.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Độ bền cao: Inox chống ăn mòn và oxy hóa, đảm bảo sản phẩm có tuổi thọ dài, ngay cả trong môi trường khắc nghiệt. Thẩm mỹ: Bề mặt được hoàn thiện tốt mang lại vẻ đẹp cho các sản phẩm, phù hợp với nhiều ứng dụng trong xây dựng và thiết kế nội thất. Dễ dàng lắp đặt: Thiết kế linh hoạt cho phép dễ dàng lắp đặt và thay thế, tiết kiệm thời gian và công sức cho người sử dụng. Giúp Tưới cây hiệu quả: Với khả năng kéo dài từ 1m5 đến 3m, cần rút inox giúp người dùng dễ dàng tưới cây ở những vị trí khó tiếp cận, tiết kiệm thời gian và công sức. Phun thuốc bảo vệ thực vật: Sản phẩm cho phép phun thuốc một cách chính xác, hiệu quả, giúp bảo vệ cây trồng khỏi sâu bệnh mà không gây lãng phí. Chất liệu bền bỉ: Được làm từ inox nhẹ nhưng chắc chắn, cần rút inox không chỉ dễ dàng nâng lên mà còn chống ăn mòn, đảm bảo độ bền lâu dài ngay cả khi sử dụng trong môi trường ẩm ướt. Tiết kiệm chi phí: Việc nâng cao năng suất làm việc nhờ vào cần rút inox giúp giảm thiểu thời gian lao động, từ đó tiết kiệm chi phí cho các nhà vườn. Dễ dàng sử dụng: Thiết kế thông minh giúp người dùng thao tác một cách dễ dàng, phù hợp cho cả những ai chưa có nhiều kinh nghiệm trong việc chăm sóc cây trồng. Sơ cứu: Chưa có thông tin.'),
(76, 'Cần Phun Tích Điện Tự Động', 'CPĐ.25', 'can-phun-dien-tu-dong', 'Công dụng: Cần Phun Cầm Tay Tích Điện. Hút Nước Trực Tiếp Từ Xô Hoặc Ao, Hồ Nước. Tiện Dụng Dễ Dàng Sử Dụng. Vòi quay 360 độ, sản phẩm có 3 bộ vòi khác nhau, có thể thay thế dùng các chế độ phun khác nhau. Có thể tưới cây theo nhiều hướng, nhiều chế độ phun, giúp tiết kiệm năng lượng và tưới nước dễ dàng hơn. Cần phun kéo dài là thiết kế dạng kính thiên văn, dài đến 0,5m, mở rộng phạm vi phun của bạn. Tay cầm mở rộng được thiết kế công thái học, tạo cảm giác thoải mái sau khi vận hành lâu dài. Pin mạnh mẽ 2400mAh tích hợp đảm bảo hoạt động lên đến 3h, với thời gian sử dụng lâu dài và sạc lại nhanh chóng. Sản phẩm thích hợp để tưới cây, rửa xe, phun thuốc, vệ sinh, khử trùng gia đình, .
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Mẫu Ống Nước Dài 5M Có Vạch Pin / Mẫu Ống Nước Dài 3M Có Vạch Pin / Mẫu Ống Nước Dài 3M / Mẫu Ống Nước Dài 2M
Giá tham khảo: 210.000đ - 350.000đ', '280000.00', 4, 1, 4, 1003, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chỉ cần bỏ ống dẫn kết nối với đầu lọc vào nguồn nước, sau đó nhấn nút và sử dụng vô cùng dễ dàng.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(77, 'Cần Phun Xịt Inox Dùng Cho Bình Phun Xịt Thuốc Dài 50/100cm', 'CANINOX', 'can-phun-xit-inox-dung-cho-binh-phun-xit-thuoc-dai50100cm', 'Công dụng: Sản Phẩm Có 2 Loại Để Khách Lựa Chọn:. Cần Không Rút Gọn 50cm. Cần Có Thể Rút Gọn 50 - 100cm. – Phụ kiện thiết yếu dùng để kết nối đầu xịt và tay cầm bình xịt, bình điện các loại. – Hỗ trợ phun thuốc, tưới cây, ruộng lúa,…. – Cần xịt có chức năng rút ngắn dài từ 50-100cm tuỳ theo nhu cầu sử dụng của người dùng. – Cần xịt làm bằng chất liệu inox 304 không lo bị rỉ sét. – Đầu nối được làm bằng đồng thau bền bỉ với thời gian. – 2 ống cần được kết nối bằng 1 khớp nối cho phép người dùng thu rút chiều dài khi cần. – 2 đầu ren 14mm phù hợp đa số bình xịt thị trường Việt Nam hiện nay.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Cần Inox Rút Gọn Từ 50 - 100cm / Cần Inox Không Rút Gọn 50cm
Giá tham khảo: 65.000đ', '65000.00', 4, 1, 6, 1019, 'None', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Ren trong 14 cm phù hợp với tay bóp của tất cả các loại bình bơm có động cơ trên thị trường. Đầu lắp béc phun ren ngoài 14cm phù hợp với tất cả các loại béc tưới cây trên thị trường.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(81, 'Cốc Điều Hòa Trồng Lan', 'CDH', 'coc-dieu-hoa-trong-lan', 'Công dụng: Điều Hoà Nhiệt Độ, Độ Ẩm Cho Giá Thể. Tiết Kiệm Thời Gian Chăm Sóc, Tưới Nước. Kích Thích Bộ Rễ Phát Triển Mạnh. Điều hoà nhiệt độ, độ ẩm cho giá thể. Tiết kiệm thời gian chăm sóc, tưới nước, giá thể. Tạo môi trường cho bộ rễ phát triển mạnh. Thuận tiện cho việc thay giá thể hay sang chậu sau này. Nhử rễ, mập thân. Kích thích bộ rễ phát triển mạnh.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Nhỏ / Lớn
Giá tham khảo: 15.000đ', '15000.00', 4, 1, 3, 1078, 'No Brand', 'Sản xuất tại Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Dụng Cụ Tiện Ích', 'Hướng dẫn sử dụng: ▶️ Cắm các que dùng để cố định kie lan vào các điểm đánh dấu ở chóp cốc sao cho khớp với lỗ chốt cố định ở khay trữ nước. ▶️ Đặt cốc vào trong chậu rồi phủ giá thể xung quanh cốc. ▶️ Cố định kie lan vào que bằng các kẹp, dây buộc chuyên dụng. ▶️ Tưới nước vào giá thể sao cho nước có thể chảy vào khay trữ nước của cốc.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(83, 'Daconil 500SC - Thuốc Trừ Bệnh Nhật Bản', 'TTB01', 'daconil-500sc-thuoc-tru-benh-nhat-ban', 'Công dụng: Thuốc Trừ Nấm Dạng Phổ Rộng. Độ Bám Dính Tốt, Chống Rửa Trôi. Sản Phẩm Của Nhật Bản. Thuốc Trừ Nấm Bệnh Daconil 500SC Nhật Bản với hoạt tính Chlorothalonil: 500g/lít giúp trừ nấm bệnh và phòng ngừa nhiều loại bệnh khác nhau. Hiệu lực trừ bệnh cao và kéo dài. Thuốc Trừ Nấm Bệnh Daconil 500SC có thể trừ và phòng ngừa các bệnh hại như:. Bệnh sương mai (thán thư, thối quả) trên cây cà chua. Bệnh giả sương mai trên cây dưa chuột. Bệnh thán thư (thối dưa) trên cây dưa hấu. Bệnh đốm lá trên cây lạc (cây đậu phộng). Bệnh thán thư (thối bông, thối quả) trên cây xoài, cây nhãn. Bệnh sẹo, melanos trên cây họ cam quýt. Bệnh phấn trắng trên cây vải, cây nho. Bệnh đạo ôn, khô vằn, lem lép hạt ở lúa. Và nhiều loại bệnh trên nhiều loại cây trồng khác nhau.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Chai 100ml / Chai 450ml
Giá tham khảo: 54.000đ', '54000.00', 2, 1, 3, 1096, 'VITHACO', 'SDS Biotech K.K Tokyo - Japan', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Hoạt chất: Chlorothalonil: 500g/lít.
Loại sản phẩm: Thuốc Trừ Nấm Bệnh', 'Hướng dẫn sử dụng: Pha 10 – 15ml cho vào bình 10 -12 lít nước hoặc 200ml cho phuy 200 lít nước. Phun ướt đều lá và thân cây trồng khi bệnh hại mới phát sinh. Trường hợp bệnh nặng phải theo dõi và phun nhắc lại sau đó 7-10 ngày. Hiệu quả phòng, trừ bệnh rất cao đối với cây trồng quan trọng như: cà chua, hành, dưa chuột. Dưa hấu dễ bị nhiễm bệnh nên phun định kỳ 10-15 ngày/lần là đủ. Không phun thuốc khi trời sắp mưa. Liều lượng: 0.4-0.6 lít/ha. Lượng nước pha: 400 – 600 lít/ha. Thời gian cách ly:. Trên cây cam: 5 ngày. Trên cây lúa: 14 ngày. Các cây trồng khác: 7 ngày.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em;. Sử dụng xong phải đậy nấp lại để tránh đỗ ra ngoài. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(84, 'Daconil 75WP - Thuốc Trừ Bệnh Nhật Bản Chính Hiệu', 'DACONIL', 'daconil-75wp-thuoc-tru-benh-nhat-ban-chinh-hieu', 'Công dụng: Chính Hiệu Của SDS NHẬT BẢN. Trừ Được Nhiều Loại Bệnh. Hiệu Lực Trừ Bệnh Cao, Kéo Dài. Bám Dính Tốt Trong Mùa Mưa. Thuốc trừ bệnh Daconil 75WP là thuốc ở dạng bột hoà nước, phố tác dụng rộng, trừ được nhiều loại bệnh trên nhiều loại cây trồng. Daconil 75WP có hiệu lực trừ bệnh cao, kéo dài.
Đối tượng cây trồng: THUỐC TRỪ NẤM BỆNH - VI KHUẨN
Quy cách: Gói 100g
Giá tham khảo: 55.000đ', '55000.00', 2, 1, 4, 1107, 'VITHACO', 'SDS Biotech K.K Tokyo - Japan', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chlorothalonil 75% w/w.
Loại sản phẩm: Thuốc trừ bệnh hại cây', 'Hướng dẫn sử dụng: Pha 30-35g thuốc với bình 25 lít nước hoặc 2 gói 100g cho 1 phuy 200 lít. Lương thuốc dùng: 1,2-2,5 kg/ha. Lượng nước dùng: 400 - 500 lít/ha. Phun ướt điều lá cây và thân cây hoặc bệnh thối rễ thì tưới gốc cây, giảm tối đa bệnh chết cây con. Nếu bệnh nặng phải theo dõi để phun hoặc tưới gốc nhắc lại sau 7- 10 ngày. Hiểu quả phòng trừ của thuốc rất cao đối với cây trồng quan trọng như: Cà chua, hành, dưa chuột, hoa lan. Nên phun định kỳ 10 – 15 ngày /1 lần là đủ. Thời gian cách ly: Ngưng phun thuốc trước khi thu hoạch 7 ngày.
An toàn sử dụng: Bảo quản: Bảo quản nơi khô ráo thoảng mát. Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(89, 'Dây Nhôm Mạ Đồng Uốn Cây Bon Sai Và Hoa Lan', 'TMP-SYNC-89', 'day-nhom-ma-dong-uon-cay-bon-sai-va-hoa-lan', 'Công dụng: Dùng để uốn cây cảnh, tiểu cảnh, Bonsai,. Buộc cành cây, hoa lan cho cây thẳng theo ý muốn. Một số ưu điểm :. Màu dây kẽm tương đồng với các loại vỏ cây nên đạt yêu cầu thẩm mỹ cao hơn loại dây kẽm nhôm trắng. Dây kẽm mềm rất dễ uốn. Có thể sử dụng lại nhiều lần. Chuyên sử dụng cho Bonsai mini, Bonsai nhỏ. Sảm phẩm được các Nghệ Nhân tín nhiệm sử dụng.
Đối tượng cây trồng: Dụng Cụ Làm Vườn
Quy cách: Cuộn 1 li - 500g / Cuộn 1 li - 200g / Cuộn 1.2 li - 200g / Cuộn 1.4 li - 200g / Cuộn 1.6 li - 200g / Cuộn 1.8 li - 200g / Cuộn 2 li - 200g / Cuộn 2.5 li - 200g
Giá tham khảo: 60.000đ - 70.000đ', '65000.00', 4, 1, 4, 1168, 'None', 'Việt Nam', '1.00', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(90, 'Dầu Khoáng SK EnSpray 99EC Đặc Trị Nhện Đỏ', 'SK.ENSPRAY', 'dau-khoang-sk-enspray-99ec-dac-tri-nhen-do', 'Công dụng: Trừ Nhện, Các Loại Sâu Hại (phổ Rộng). Chất Hổ Trợ Cho Thuốc Trừ Sâu, Trừ Cỏ. Ngăn Cản Sự Nẩy Mầm Của Bào Tử Nấm Bệnh. Dầu khoáng SK Enspray 99EC được dùng như thuốc trừ nhện, trừ các loại sâu hại (phổ rộng), đồng thời hạn chế một số bệnh hại và còn được dùng như chất hỗ trợ cho thuốc trừ sâu, trừ cỏ. Đối với sâu hại, dầu khoáng có tác dụng gây ngạt (do bịt lỗ thở), thối trứng và thay đổi tập tính (ăn, đẻ trứng). Đối với bệnh hại, dầu ngăn cản sự nảy mầm của bào tử, hạn chế sự phát tán và phá vỡ màng tế bào bào tử. Dầu khoáng SK Enspray 99EC là thuốc phổ rộng, hiệu quả cao trừ nhện, rệp sáp, các loại rầy, sâu vẽ bùa, ruồi trắng, rầy chổng cánh trên cây ăn trái, cây công nghiệp, rau, cây cảnh, cây trồng trong nhà lưới.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Chai 100ml / Chai 480ml / Chai 1Lít
Giá tham khảo: 25.000đ', '25000.00', 2, 1, 3, 1180, 'CTY CP BVTV Sài Gòn', NULL, '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Petroleum Spray Oil 99%;. Phụ gia khác vừa đủ. ĐẶC ĐIỂM:. Dầu khoáng SK Enspray 99EC là dầu khoáng được chiết xuất từ công nghệ chưng cất đầu thô theo qui trình và yêu cầu đặc biệt, dùng pha với nước để phun lên cây phòng trừ dịch hại. Thành phần chính của dầu khoáng là Hydrocarbon mạch thẳng no có nhánh (Iso Parafin), ngoài ra còn có hydro mạch vòng no (Naphthalenes) và Hydro mạch vòng không no (Aromatic) và có thêm chất nhũ hóa để tan được trong nước. Dầu khoảng SK Enspray 99EC được dùng như thuốc trừ nhện, trừ các loại sâu hại (phố rộng), đồng thời hạn chế một số bệnh hại và còn được dùng như chất hổ trợ cho thuốc trừ sâu, trừ cỏ. Đối với sâu hại, dầu khoáng có tác dụng gây ngạt (do bịt lố thở), thối trứng và thay đổi tập tỉnh (ân, đẻ trứng). Đối với bệnh hại, dầu ngăn cản sự nấy mầm của bào tử, hạn chế sự phát tán và phá vỡ màng tế bào bào tử. Dầu khoáng SK Enspray 99EC là thuốc phố rộng, hiệu quả cao trừ nhện, rệp sáp, các loại rầy, sâu vẽ bùa, ruồi trắng, rầy chống cánh trên cây ăn trái, cây công nghiệp, rau, cây cảnh, cây trồng trong nhà lưới.
Loại sản phẩm: Thuốc trừ sâu hại cây', 'Hướng dẫn sử dụng: Dầu khoảng SK Enspray 99EC pha nước với nồng độ 0,5 – 0,75% (80 120 ml cho 1 bình 16 lít nước). Phun ướt đều lên cây để phòng trừ nhện đỏ hại chè và cây có múi (Cam, quit, bưởi, chanh) pha 160320 ml/16 lít. Đối với cây nhỏ, phun bình tay cần 600 - 800 lít nước, với cây lớn, phun máy cần 1.000 - 2.000 lít nước. Để trừ nhện lông nhung hại nhãn, liều khuyến cáo: 1% (pha 1 lít dầu SK Enspray 99EC cho 100 lít nước), phun ướt đều cây khi nhãn ra lá non.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Thời gian cách ly: 2 ngày. Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(91, 'Dầu Trừ Muỗi Vipesco | Thuốc Diệt Trừ Muỗi Và Côn Trùng', 'TM.VIPESCO', 'dau-tru-muoi-vipesco-thuoc-diet-tru-muoi-va-con-trung', 'Công dụng: Diệt trừ hữu hiệu các loại côn trùng như: muỗi, ruồi, kiến, gián trong nhà ở, nhà xưởng, trường học, khách sạn và những nơi côn trùng tập trung trú ẩn.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Chai 480ml
Giá tham khảo: 55.000đ', '55000.00', 2, 1, 3, 1193, 'VIPESCO', 'Việt Nam', '0.48', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Alpha Cypermethrin 0.1% w/v. Propoxur 0,1% w/v. Phụ gia vừa đủ 100% w/v.
Loại sản phẩm: Thuốc diệt côn trùng', 'Hướng dẫn sử dụng: Đóng kín các cửa, phun Bình xịt muỗi Vipesco trong không khí với lượng trung bình 1.2ml cho 1m3 không khí, đặc biệt phun tập trung nơi thấp tối như gầm giường, khe tủ, góc kẹt, kẽ nứt trên tường… là nơi côn trùng thường hay trú ẩn. Sau khi phun thuốc nên đóng cửa 30 phút mới mở các cửa để vào phòng. Đối với kiến phun trực tiếp vào tổ kiến. Thuốc có hiệu lực tồn lưu với muỗi là 1 tháng phun lên tường gỗ là 72%, trên tường gạch là 56% và tồn lưu 10 ngày đối với ruồi, kiến, gián. Chú ý: Không phun thuốc gần ngọn lửa. Đảm bảo không có người và vật nuôi trong khu vực phun thuốc khi đang tiến hành phun. Thời gian cách ly sau phun thuốc là 30 phút.
An toàn sử dụng: Bảo quản: Thời gian tồn lưu lâu so với các dòng sản phẩm pha sẵn khác, hiệu quả tồn lưu kéo dài lên đến 1 tháng đối với muỗi và 10 ngày đối với ruồi, kiến, gián. Dầu trừ muỗi Vipesco có mùi hương hoa dễ chịu không quá nồng. Sản xuất và phân phối bởi công ty thuốc sát trùng Việt Nam. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(92, 'Dầu Trừ Mối M-4 1.2SL', 'M41.2SL', 'dau-tru-moi-m-4-12sl', 'Công dụng: Xử lí mối gỗ khô hoặc gỗ phát hiện có phá hoại. Dễ sử dụng, không cần pha chế dung dịch, không mùi nặng như các thuốc diệt mối khác. Sử dụng dễ dàng bằng cách quét thuốc lên khu vực gỗ để phòng mối, mọt trước khi đưa vào công trình xây dựng. Giá thành rẻ, phù hợp với nhiều đối tượng. Dầu trừ mối M4 được dùng để phòng trừ mối, mọt, bảo vệ nhà cửa, kho tàng, đền chùa, chuồng trại, nội thất…làm bằng gỗ, tre, nứa, lá … trong nhiều năm.
Đối tượng cây trồng: Thuốc Trừ Sâu - Côn Trùng
Quy cách: Chai 480ml
Giá tham khảo: 55.000đ', '55000.00', 2, 1, 3, 1204, 'CTY CP Thuốc Sát Trùng Việt Nam', 'Việt Nam', '0.48', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: 1.0% Beta-naphthol. 0.2% Fenvalerate. Phụ gia đủ 100%.
Loại sản phẩm: Thuốc diệt côn trùng', 'Hướng dẫn sử dụng: Dùng 1 lít thuốc quét hoặc phun cho 4-6m2 đồ gỗ, cấu trúc gỗ… trong nhà. Dầu M-4 có thể dùng bằng cách phun trực tiếp lên đồ gỗ như: tủ, kệ, cánh cửa, cột, kèo nhà, giường, bàn, ghế,…. Sau khi xử lý thuốc 3-4 ngày mới đánh vec-ni hoặc sơn. Phun vào chân tường nhà phòng trừ mối cánh xâm nhập, hoặc dùng phòng chống mối nền móng thay cho các sản phẩm phòng chông mối độc hại cùng loại. Không dùng để diệt mối đất ẩm, mối nhà.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(114, 'Hạt Giống Bí Siêu Nụ Lai F1 Rạng Đông - GITA 33', 'GITA 33', 'hat-giong-bi-sieu-nu', 'Công dụng: Thuộc phân khúc cao cấp. Cây sinh trưởng phát triển mạnh. Mức độ bò vừa phải thích hợp trồng dày. Bông và nụ rất nhiều. Ngắn ngày. Thu hoạch nụ 31 ngày sau khi gieo. Nếu để trái lớn, trái khoảng 700gr -1kg, hình dạng đẹp với chất lượng ăn ngon. Thích hợp cho các farm rau sạch và nông dân trồng số lượng lớn.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: Gói / gói 8 hạt / Gói 100 hạt
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1476, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:. Ngâm hạt giống bí nụ vào nước sạch từ 2 – 4 giờ sau đó vớt ra rửa sạch nhẹ nhàng rồi đem ủ hạt vào khăn bông ẩm, tránh ánh sáng, nhiệt độ thích hợp để ủ từ 25 – 32 độ C. Ở nhiệt độ này thì sau 2 – 3 ngày hạt bắt đầu nảy mầm, nếu ngoài nhiệt độ này thời gian nảy mầm sẽ kéo dài hơn hoặc có thể không nảy mầm. Khi mầm dài 0.5cm thì bắt đầu đem hạt đi gieo. Gieo bầu ươm ở nơi có đầu đủ ánh sáng, khi cây đạt 3 – 4 lá thật thì đem ra trồng, loại bỏ những cây yếu, lá dị tật. Cách trồng hạt giống bí nụ:. Nếu trồng giàn: Trồng theo giàn hình chữ U, khoảng cách hàng đơn từ 1.2 – 1.5m, cây cách cây 50cm, mật độ từ 2000 cây – 27000 cây/1000m 2 , lượng hạt giống cần 150 – 200gam/1000m 2 . Nếu trồng bò đất: Khoảng cách hàng đôi từ 4.5 – 5m, khoảng cách cây cách câu 0.5m, mật độ 800 – 900 cây/1000m 2 , lượng hạt giống cần 70 – 80gam/1000m 2 . Chú ý:. Tránh phủ đất lên hạt. Giữ ẩm hạt. Cây cho hoa sau 12 tuần tính từ lúc gieo, thích hợp nhất là vào mùa hè. Sau 10 – 15 ngày trồng thì kiểm tra tỷ lệ nảy mầm. Trồng dặm những cây đã chết hoặc hạt không nảy mầm bằng những cây con có 5 – 6 lá. Sau đó, làm sạch cỏ và xới nhẹ cho đất tơi xốp. Chú ý không chạm mạnh, tránh bị động rễ cây. Sau 30 – 35 ngày trồng, làm sạch cỏ. Và bón, phân urê hoặc phân chuồng loãng. Sau mỗi lứa thu hoạch lại tiến hành làm sạch cỏ dại. Bón thúc theo tỷ lệ được liệt kê như sau. Phân hữu cơ hoại mục: 10 – 15 tấn/ha/năm. Sulphát kali 100kg/ha/năm. Phân đạm urê : 400kg/ha/năm. Chia đều làm 7 – 8 lứa sau thu hoạch.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: THÔNG TIN:. Độ sạch của hạt giống > 99%. Độ ẩm < 10%. Tỷ lệ nãy mầm > 85%. Khối lượng: 0.5Gr. Sơ cứu: Chưa có thông tin.'),
(115, 'Hạt Giống Bắp Ngọt Rạng Đông - RADO 236', 'RADO236', 'hat-giong-bap-ngot', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1484, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(116, 'Hạt Giống Bắp Nếp Dẻo Rạng Đông - Cẩm Nông', 'RDCN01', 'hat-giong-bap-nep-deo', 'Công dụng: Cây sinh trưởng phát triển mạnh. Trồng quanh năm. Trái nhỏ, dài, có nhiều màu sắc, dẻo, ăn ngon, cây có nhiều trái. Thời gian thu hoạch: 65-68 ngày. Hàng x hàng 70-75cm, cây x cây 25cm, lượng giống/1000m2: 1.1 -1.2kg. Bắp Nếp Cẩm Hồng có hàm lượng chất xơ khá cao, nhiều tinh bột, cùng với đó là vitamin, vi chất dinh dưỡng và các khoáng chất khác. Có thể nói, những tác dụng sức khỏe tuyệt vời của Bắp nếp đều nhờ vào hàm lượng dưỡng chất dồi dào có chứa trong nó. Bắp có 2 màu trắng và điểm tím hồng, ngọt. HƯỚNG DẪN TRỒNG BẮP NẾP CẨM HỒNG BẰNG HẠT. ♦ Chuẩn bị hạt giống: Ngâm hạt giống 12 đến 14 giờ trong nước ấm 40°C (2 sôi, 3 lạnh) sau đó vớt ra ủ trong khăn ẩm đến khi hạt nứt nanh thì bạn có thể lấy ra gieo. ♦ Bón lót: Sử dụng vôi bột nông nghiệp rải đều mặt đất để diệt trừ các nấm bệnh. Bón phân bò ủ hoai hoặc phân trùng quế, phân hữu cơ vi sinh để bón lót tăng độ mùn và tơi xốp. Rải đều phân lên mặt luống, lấy cuốc hoặc cày trộn đều và trộn sâu vào lòng luống, san phẳng mặt luống. ♦ Gieo hạt: Gieo hạt theo từng hốc, mỗi hốc gieo 2-3 hạt để phòng khi có hạt không lên. Chỉ nên để tối đa 2 cây/hốc. Nếu số cây /hốc nhiều sẽ cạnh tranh ánh sáng và dinh dưỡng làm cây phát triển không đồng đều. - Khoảng cách giữa hàng với hàng 60-100 cm và khoảng cách cây với cây trên hàng là 20-40 cm tùy theo đặc tính giống. ♦ Tỉa cây: Tỉa thưa cây để cây lớn nhanh cho trái lớn. mỗi hốc chỉ để 1-2 cây. Nhổ bỏ những cây tật, yếu ớt. Dặm những cây chết. ♦ Tưới nước: Giai đoạn đầu cần nhiều nước thì 5-7 ngày tưới 1 lần. Khi cây đã phát triển ổn định 2-3 tuần tưới 1 lần. Giai đoạn cây con cần làm cỏ sạch sẽ để tránh bị sâu bệnh. Mỗi lần làm cỏ kết hợp với vun gốc bón phân để cây tránh đổ ngã, phát triển khoẻ mạnh. ♦ Bón phân: Với những đất nghèo dinh dưỡng thì nên bón nhiều phân hơn cho đất. Chia lượng phân ra làm 3 lần bón, 2/3phân lân dùng để bón lót. Bón thúc lần đầu 15 ngày sau gieo 1/3 lượng phân urê, 1/3 lượng phân lân. - 30 ngày sau gieo bón 1/3 lượng phân urê, 1/2 lượng phân kali. - Lần cuối bón lúc 45 ngày sau gieo bón hết số phân còn lại. ♦ Thu hoạch: Tuỳ vào mục đích sử dụng mà bạn thu hoạch non hay già, thu hoạch trái xong bạn có thể tận dụng thân bắp để làm phân bón hay thức ăn cho gia súc. Xác định thời điểm thu hoạch bắp bằng việc quan sát hạt bắp ở đầu trái và cuối trái. Khi thấy lá bắt đầu héo lại, hạt chắc. - Bạn sẽ nhận ra cây chín hoàn toàn khi thấy lá của bắp chuyển vàng từ dưới lên.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1492, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(117, 'Hạt Giống Cà Tím Rạng Đông - RADO 205', 'RADO 205', 'hat-giong-ca-tim', 'Công dụng: Về mặt sức khỏe: Cà tím cung cấp vitamin đáng kể, chứa hàm lượng sắt và canxi cao rất cần thiết cho cơ thể. Về mặt kinh tế: Trồng được quanh năm, trái dài khoảng 25 cm, đường kính 5cm, trọng lượng 180-300gr/trái, cây cao > 80cm, cho trái sau 55-60 ngày trồng.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1500, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:. Chọn hạt giống cà tím từ nhà cung cấp giống uy tín. Ngâm khoảng vài tiếng cho phần thịt quả nở ra và phần hạt nặng hơn sẽ chìm xuống đáy. - Hạt cà tím có vỏ khá cứng và dày nên trước khi gieo bạn phải ngâm nước từ 24-30 giờ. Tiếp theo vớt ra ngâm nước ấm 50 độ C khoảng 1 tiếng, bước này vừa giúp làm mềm vỏ hạt để kích thích nảy mầm vừa giúp diệt trừ nấm bệnh. Cách trồng:. Bước 1: Xử lý đất nếu đất đã qua sử dụng bằng cách tiến hành cày xới đất cho đất tơi xốp. dọn dẹp cỏ rác nếu có. Rải vôi bột lên bề mặt, phơi ải từ 5-7 ngày để cân bằng độ pH trong suốt mùa vụ và khử trùng, tiêu diệt những ấu trùng sâu bệnh. Sau đó trộn đất theo tỉ lệ (7 phần đất + 3 phần phân trùn quế hoặc phân gà, xơ dừa…) để tăng độ dinh dưỡng cho đất. Cuối cùng tưới nước tạo độ ẩm cho đất. Bước 2: Chuẩn bị hạt giống đã ngâm. Bước 3: Tiến hành gieo: Đem hạt đã ủ gieo từ 2-3 hạt vào một ô ở giá gieo hạt hoặc bầu. Kế tiếp, phủ lớp rươm rạ hoặc lớp đất mỏng lên hạt. Sau đó tưới phun nước cho hạt để giữ ẩm. Khi cây con trồng trong bầu có từ 5 đến 6 lá thật và cao khoảng 6-8cm thì chọn ra những cây khoẻ mạnh nhất rồi đem trồng ra chậu hoặc thùng xốp. Sau khi cấy xong tưới nước cho cây và che phủ trong vòng 1 tuần. Cách chăm sóc:. Ủ hạt giống trong vải ẩm cho nứt ra rồi mới đem đi gieo. - Giá gieo hạt giống chia thành các ô nhỏ, xan đất cho phằng đều, tưới nước cho ẩm đất rồi gieo từ 2,3 hạt vào một ô. Khi cây con trồng trong giá có từ 5 đến 6 lá thật và cao 6-8cm, bạn chọn ra khoảng 1, 2 cây khoẻ mạnh nhất rồi đem trồng ra chậu. Cà tím là loại cây ưa nước, do đó trong thời gian đầu bạn cần phải tưới nước hàng ngày. Khi cây bắt đầu ra hoa bạn nên cắt tỉa các cành nhánh phía dưới chùm hoa thứ nhất để cho gốc cây được thông thoáng. Khi cây cà ra đợt hoa thứ 2 thì bạn nên bấm ngọn để hạn chế chiều cao và để cho cây ra thêm nhiều nhánh quả, chú ý chỉ nên cắt tỉa vào những ngày nắng ráo và vào khoảng cuối chiều bạn nhé. Cách thu hoạch:. Khi trái cà tím lớn đẫy, vỏ bắt đầu chuyển từ màu tím sang tím nhạt, da quả bóng, căng đều là bạn có thể thu hoạch được. Chú ý không để quả cà quá già vì chất lượng sẽ bị giảm sút. Cà tím là loại rau phổ biến được nhiều bà nội trợ lựa chọn cho bữa cơm gia đình. Có thể chế biến thành các món ăn khác nhau như cà tím nhồi thịt, cà tím nấu đậu, cà tím kẹp thịt rán…. ​​​​​​​.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(118, 'Hạt Giống Cải Bẹ Xanh Mỡ Rạng Đông - RADO 57', 'RADO 57', 'hat-giong-cai-be-xanh-mo', 'Công dụng: TRỒNG ĐƯỢC QUANH NĂM. LÀ LOẠI CẢI RẤT DỄ TRỒNG. Chữa ho hen, đờm suyễn ở người già: Hạt cải bẹ xanh, hạt củ cải, hạt tía tô, mỗi vị 8-12g, sắc uống hay tán bột uống mỗi lần 4-5gel, ngày uống 2-3 lần. Viêm khí quản : Hạt cải bẹ xanh (sao) 10g, hạt cải củ (sao) 10g, nước 600ml, sắc còn 300ml, chia ba lần uống trong ngày. Đơn độc sưng tấy : Hạt cải bẹ xanh tán nhỏ, trộn giấm, làm cao dán, đắp ngoài…. Trị viêm họng : Dùng hạt cải bẹ xanh giã nát, nhuyễn sau đó cho vào một ít nước, khuấy thấy sền sệt, dùng đắp vào phần hầu, băng lại. Thanh nhiệt: Trong đông y, tất cả các loại cây màu xanh nào cũng đều có tác dụng thanh nhiệt, riêng cải bẹ xanh có tác dụng thanh nhiệt gấp đôi, nhất là vào mùa nóng, có thể nấu lên lấy nước để uống có tác dụng thanh nhiệt. Chữa mụn nhọt : Mùa hè trẻ dễ bị mụn nhọt, bạn có thể dùng cải bẹ xanh nấu lấy nước thay trà uống trong ngày, vừa có tác dụng tiêu và phòng ngừa mụn nhọt. Tốt nhất, đầu mùa nóng nên cho trẻ uống nước rau cải bẹ xanh thì trẻ sẽ không bị mụn nhọt. Tốt cho tim mạch : Trong cải bẹ xanh có hoạt chất có tác dụng kiềm chế cholesterol, hấp thu bài tiết ra phân. Do vậy, nếu ăn rau cải thường xuyên sẽ gián tiếp hỗ trợ tim, tốt cho mạch máu của cơ thể bạn. Hỗ trợ bệnh nhân tiểu đường : Trong rau cải xanh có nhiều chất xơ, ăn nhiều rau có thể chống đói, không sợ sinh ra calo. Hỗ trợ bướu cổ : Bướu cổ thường xảy ra nhiều ở phụ nữ do thiếu lượng i-ốt. Trong rau cải bẹ xanh có chứa chất ngăn ngừa bướu cổ ở người cường tuyến giáp, đối với người suy tuyến giáp lại không nên sử dụng cải bẹ xanh. Tăng sức đề kháng: Trong rau cải bẹ xanh có chứa nhiều vitamin C, giúp tăng sức đề kháng của cơ thể. Chữa viêm ruột : Trong rau cải bẹ xanh chứa chất có tác dụng giảm nhu động ruột, ức chế chất gây viêm màng ruột. Do đó, nó giúp ngăn ngừa viêm ruột. Chống lão hóa da: Đối với những thực phẩm rau có màu xanh đậm như cải bẹ xanh thì hàm lượng vitamin càng cao, cung cấp nhiều axit folic cần thiết cho tế bào máu, giúp da dẻ hồng hào, tươi tắn.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1508, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(119, 'Hạt Giống Cải Ngọt Rạng Đông - RADO 54', 'RADO 54', 'hat-giong-cai-ngot-rang-dong', 'Công dụng: CÂY SINH TRƯỞNG KHỎE. KHÁNG BỆNH TỐT. Theo Đông y, cải ngọt tính ôn, có công dụng thông lợi trường vị, làm đỡ tức ngực, tiêu thực hạ khí,...có thể dùng để chữa các chứng ho, táo bón. Ngoài ra, ăn nhiều cải còn giúp cho việc phòng ngừa bệnh trĩ, ung thư ruột kết, ung thư gan và kết hợp điều trị bệnh ung thư và xơ cứng gan.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1516, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(120, 'Hạt Giống Cải Thìa - RADO 77 Rạng Đông', 'RADO 77', 'hat-giong-cai-thia', 'Công dụng: SINH TRƯỞNG PHÁT TRIỂN MẠNH. THÍCH NGHI RỘNG. TRỒNG ĐƯỢC QUANH NĂM. Làm thuốc thanh nhiệt: Người bị bệnh nội nhiệt nặng thiếu tân dịch, môi khô ráo hay lưỡi sinh cam, chân răng sưng thũng, kẽ răng chảy máu, họng khô cứng... dùng rau cải thìa nấu canh ăn sẽ có tác dụng thanh hỏa rất tốt. Chữa nhiệt miệng: Rễ cải thìa gọt bỏ vỏ già ở ngoài, thái lát, sao nhỏ lửa vàng cháy, tán thành bột mịn, cho vào lọ nút kín dùng dần. Mỗi ngày lấy bột thuốc bôi vào chỗ bị bệnh 2 - 3 lần. Dùng liền 3 - 5 ngày. Chữa cảm gió. Chữa đầy bụng, khó tiêu: Cải thìa (cả cây) rửa sạch giã vắt lấy nước, hâm cho âm ấm, ngày uống 2 lần trước bữa ăn, mỗi lần 30ml. Dùng liền 3 - 5 ngày.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1525, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Hướng dẫn sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(121, 'Hạt Giống Dền Đỏ Rạng Đông - RADO 15', 'RADO 15', 'hat-giong-den-do', 'Công dụng: Sinh Trưởng Phát Triển Mạnh. Tỉ Lệ Nảy Mầm Cao. Lợi ích:. Hạt giống có tỷ lệ nảy mầm cao giúp tiết kiệm được chi phí hạt giống, dễ dàng phân bố mật độ giữa cây với cây, hàng với hàng. Hạt giống chất lượng tốt, nảy mầm nhanh, sinh trưởng và phát triển mạnh giúp tiết kiệm thời gian gieo trồng và chi phí phân bón. Hạt giống của giống cây trồng tốt có thể kháng được nhiều sâu bệnh nên năng suất cao hơn, chăm bón dễ dàng hơn. Công dụng:. Theo y học cổ truyền, rau dền đỏ có vị ngọt, tính mát, tác dụng thanh nhiệt, làm mát máu, lợi tiểu, làm mát máu, sát trùng, trị nhiệt lỵ, huyết nhiệt sinh mụn nhọt. Rau dền đỏ có thể luộc, xào hoặc nấu canh ăn rất ngon và ngọt. Rau dền là loại rau mùa hè, có tác dụng mát gan, thanh nhiệt.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: đóng gói: 20g/gói
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1536, 'Rạng Đông', NULL, '0.02', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Hướng dẫn sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(122, 'Hạt Giống Hành Hương Chịu Nhiệt Rạng Đông - RADO 215', 'RADO 215', 'hat-giong-hanh-huong-chiu-nhiet', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1547, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(123, 'Hạt Giống Khổ Qua Lai F1', 'RADO 316', 'hat-giong-kho-qua', 'Công dụng: Phòng và trị rôm sảy;. Phòng chống cảm nắng;. Tẩy sẹo;. Thượng hỏa nhức răng;. Côn trùng cắn;. Trị ho và cảm cúm;. Giảm cân dưỡng da sau khi sinh. Kích thích bài tiết sữa.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1555, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(124, 'Hạt Giống Măng Tây Xanh Rạng Đông - RADO 636', 'RADO 636', 'hat-giong-mang-tay-xanh', 'Công dụng: Về dinh dưỡng, măng tây có hàm lượng dinh dưỡng cao, chất xơ, đạm, glucid, các vitammin K, C, A, pyridoxine (B6), riboflavin (B2), thiamin (B1), acid folid, các chất khoáng cần thiết cho cơ thể con người như: kali, magnê, canxi, sắt, kẽm…Rất tốt cho bà mẹ mang thai và còn là liều thuốc thiên nhiên rất hữu ích cho đời sống tình dục…. Về mặt kinh tế: trồng quanh năm (miền Nam ). Thu hoạch 7 – 8 tháng sau khi gieo , năng suất ổn định 1 năm (sau gieo) và có thể kéo dài từ 2-3 năm.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1563, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:53', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dùng:. Do vỏ hạt măng tây rất cứng, vì thế trước khi gieo phải ngâm trong nước nóng khoảng 50 độ C (Bà con cũng có thể canh nước theo tỷ lệ 2 sôi 3 lạnh) trong 24 giờ. Cách 4 giờ thay nước và chà hạt 1 lần. Sau đó, ủ hạt trong khăn ẩm. Sau 24h, lấy hạt ra, rửa sạch hạt và lập lại công đoạn ủ như trên. Sau 2 ngày thì hạt có thể nảy mầm. Đối với những hạt chưa nảy mầm, cứ cách 24 giờ, bà con sẽ rửa sạch hạt và tiến hành ủ lại trên khăn ẩm. Cho đến khi toàn bộ số hạt đã nứt nanh hết. Sau khi hạt đã nứt nanh, bà con tiến hành gieo hạt. Đất gieo hạt được trộn theo tỷ lệ: 2 phần đất, 1 phần phân hữu cơ, 1 phần xơ dừa hoặc tro trấu. Cách gieo hạt:. Chuẩn bị dụng cụ. Đất trồng sau khi trộn đều, chúng ta cho vào chậu hoặc khay uơm. Tưới đẫm đất trồng. Ngâm hạt: đối với các loại hạt có vỏ mỏng có thể ngâm bằng nước ấm khoảng 5-8 tiếng. Đối với các loại hạt có vỏ dày thì nên ngâm bằng nước ấm (nguyên tắc pha nước 7 lạnh 3 nóng) ngâm 1 đêm cho vỏ hạt nở ra rồi hãy tiến hành gieo. Ủ hạt: sau khi ngâm hạt, tiến hành ủ hạt (tùy loại hạt, có loại cần ủ vài tiếng, 1 hoặc nhiều ngày), cũng có loại hạt không cần ngâm ủ. Gieo hạt: nguyên tắc gieo hạt là phủ hạt với độ sâu bằng 1-2 lần đường kính của hạt (chú ý ko nén chặt đất sau khi phủ hạt). Đối với các loại hạt rất nhỏ, thì chúng ta gieo trực tiếp trên mặt đất ẩm, sau đó phun suơng cho hạt bám vào đất trồng là được. Sau khi gieo hạt xong dùng bình xịt dạng phun suơng lên bề mặt vài lần để đất và hạt tiếp xúc với nhau. Đặc biết đối với các hạt xứ lạnh, sau khi gieo hạt nên xử dụng màng thực phẩm bọc chậu hoặc khay uơm để tăng độ ẩm (đặt chậu nơi ít nắng), giúp hạt nảy mầm nhanh hơn. Các loại hạt xứ nóng không cần thực hiện bước này.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(125, 'Hạt Giống Mướp Xanh Lai F1 Rạng Đông - RADO 39', 'RADO 39', 'hat-giong-muop-xanh', 'Công dụng: SINH TRƯỞNG KHỎE. TRỒNG ĐƯỢC QUANH NĂM. KHÁNG BỆNH TỐT. Quả mướp hương: giải nhiệt, lương huyết, tiêu độc, làm tan đờm. Xơ mướp hương: chỉ huyết, giải nhiệt, tiêu đọc, tan đờm nhầy. Lá mướp: giải nhiệt, bài trừ độc tố cho cơ thể, chỉ huyết, tiêu đờm. Hạt: nhuận táo, sát khuẩn, tiêu đờm, làm mát cơ thể, bổ gân xương.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1571, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:. Gieo hạt vào bầu 10 cm chứa đầy hỗn hợp đất trộn đã được làm ẩm trước. Gieo chúng sâu 1cm. Đậy khay bằng màng bọc thực phẩm hoặc mái vòm gieo hạt để tăng độ ẩm. Thời gian nảy mầm trung bình từ 4 đến 7 ngày. Khi hạt đã nảy mầm, hãy tháo màng bọc hoặc mái vòm nhựa để thúc đẩy luồng không khí tốt. Theo dõi độ ẩm của đất nhằm mục đích giữ cho đất ẩm nhẹ nhưng không ướt. Bắt đầu bón phân khi cây con đã mọc bộ lá thật đầu tiên. Có thể sử dụng phân hữu cơ dạng lỏng với tỷ lệ phân nửa khuyến nghị trên bao bì. Bạn cũng có thể bón phân ngay trước khi cấy cây con. Tìm địa điểm thích hợp để trồng mướp. Mướp có sức sống mạnh mẽ, có thể dài tới ba mươi mét. Điều quan trọng là phải cung cấp một điểm đầy nắng và khuyến khích sự phát triển nhanh, ổn định bằng cách duy trì độ ẩm của đất và bón phân cho cây thường xuyên. Cho cây khởi đầu tốt khi trồng bằng cách trộn phân hữu cơ trước khi trồng cây.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Trồng mướp trong chậu. Bạn có thể trồng mướp trong giá thể nhưng hãy chọn loại đủ lớn để chứa bộ rễ của loại cây khá lớn này. Chọn một chậu hoặc túi trồng có chiều ngang khoảng 40 đến 60cm. Đổ 2/3 bầu và 1/3 phân trộn hoặc phân chuồng ủ hoai mục. Bạn cũng có thể thêm một số phân hữu cơ tan chậm vào đất trồng. Một cây mướp trong chậu phát triển rất lớn, vì vậy hãy ghi nhớ điều đó khi bạn chọn vị trí đặt chậu của mình. Tốt nhất, nó sẽ ở gần giàn hoặc hàng rào, nhưng bạn có thể để dây leo qua các thành của chậu. Chỉ cần lưu ý rằng nó sẽ chiếm lĩnh sân của bạn!. Chăm sóc cây mướp mùa hè. Cho dù bạn đang trồng trong chậu hay luống vườn, bạn sẽ cần duy trì độ ẩm và bón phân thường xuyên. Kiểm tra đất vài lần một tuần vào mùa hè, tưới đẫm nước nếu nó khô. Bón phân hữu cơ dạng lỏng hai đến ba tuần một lần. Nếu bạn đang đáp ứng nhu cầu phân bón ngày càng tăng của cây mướp, khả năng chúng sẽ ra nhiều hoa và tạo ra những quả chất lượng tốt nhất. Thụ phấn hoa mướp hương bằng tay. Bên cạnh việc tưới nước và bón phân, có một nhiệm vụ mùa hè khác là đảm bảo có nhiều trái – thụ phấn bằng tay. Tại sao? Một số lý do: 1) Nếu bạn sống nơi có mùa sinh trưởng ngắn. Thụ phấn bằng tay giúp đảm bảo những bông hoa đầu tiên tạo ra được thụ phấn và có thể phát triển thành trái. 2) Những con ong địa phương và các loài thụ phấn yêu thích dưa chuột, bí và bí ngô, không quan tâm đến cây mướp, nếu không thụ phấn bằng tay, sẽ nhận được ít quả hơn. Thụ phấn bằng tay cho mướp rất nhanh chóng và dễ dàng. Tuy nhiên, bạn cần phải biết sự khác biệt giữa hoa đực và hoa cái. Một bông hoa mướp cái có một quả con bên dưới nở. Hoa mướp đực không có quả, chỉ có thân thẳng. Cách thụ phấn :. Dùng cọ hoặc tăm bông nhỏ sạch và khô để chuyển phấn hoa từ hoa đực sang hoa cái. Hoặc, bạn có thể hái một bông hoa đực, loại bỏ các cánh hoa và ép hạt phấn vào bông hoa cái. Cố gắng làm điều này khi hoa còn tươi và mới mở. Khi hoa ra nhiều, hãy thụ phấn bằng tay một vài lần một tuần. Vấn đề sâu bệnh hại mướp. Mặc dù bầu bí là loại cây ít tốn công chăm sóc, nhưng vẫn luôn để ý đến các vấn đề và thực hiện các biện pháp xử lý khi cần thiết. Dưới đây là ba vấn đề bạn có thể gặp phải khi trồng mướp:. Bệnh phấn trắng – Loại nấm phổ biến này xuất hiện dưới dạng một lớp bụi màu trắng trên ngọn và dưới cùng của lá. Nó hoàn toàn không giết chết cây, nhưng trông lộn xộn và làm giảm khả năng quang hợp của cây. Điều đó có thể làm giảm năng suất tổng thể. Để giảm sự xuất hiện của bệnh phấn trắng, khi tưới cần tưới ẩm cho đất, không tưới cho cây. Ngoài ra, hãy cố gắng tưới nước sớm vào ban ngày để nếu nước bắn vào lá cây sẽ có thời gian khô trước khi đêm xuống. Việc đặt cây đúng cách cũng rất quan trọng để không khí có thể lưu thông tốt. Trồng mướp lên giàn là một cách tuyệt vời để thúc đẩy không khí lưu thông tốt. Bệnh sương mai – Bệnh này ảnh hưởng đến các loại cây trồng như bầu, mướp, dưa chuột, bí đỏ và do một loại nấm gây ra. Nó chủ yếu ảnh hưởng đến tán lá của cây và xuất hiện đầu tiên là những đốm nhỏ màu vàng nhạt trên đầu lá. Bệnh phổ biến nhất trong thời tiết ẩm ướt và có thể lây lan nhanh chóng. Cuối cùng các lá bị bao phủ bởi các vết bệnh màu vàng, chuyển sang màu nâu và giòn. Sản xuất bị giảm sút. Cũng như đối với bệnh phấn trắng, tránh tưới vào tán lá của cây mà thay vào đó hãy tưới vào đất. Cây trồng trong không gian để đảm bảo không khí lưu thông tốt và phát triển thẳng đứng nếu có thể. Bọ dưa – Vì bầu bí có họ hàng gần với dưa chuột nên bọ dưa chuột cũng có thể là một vấn đề. Chúng không chỉ gây hại cho cây trồng mà còn có thể lây lan dịch bệnh. Đặt tấm phủ hàng hoặc lưới chắn côn trùng ngay trên cây con sau khi trồng. Loại bỏ khi dây leo sẵn sàng leo lên hoặc khi những bông hoa đầu tiên hé nở. Thu hoạch mướp. Có hai thời điểm chính để thu hoạch mướp: 1) như một loại rau non mềm dùng để xào 2) đối với những quả mướp già được sử dụng lấy xơ mướp. Có bạn có thể ăn mướp! Những quả chưa chín không chỉ ăn được mà còn thơm ngon với hương vị giống như bí. Chọn khi quả dài từ 15 đến 25cm để có độ mềm tối ưu. Nếu bạn muốn trồng bầu mướp để lấy xơ mướp, hãy để trái chín trên cây. Chúng sẵn sàng hái khi da đã chuyển từ xanh sang nâu hoặc nâu vàng và quả bầu có cảm giác nhẹ khi cầm trên tay bạn. Sơ cứu: Chưa có thông tin.'),
(126, 'Hạt Giống Mồng Tơi Rạng Đông - RADO 38', 'RADO 38', 'hat-giong-mong-toi-rang-dong', 'Công dụng: Tỉ Lệ Nảy Mầm Cao. Là Loại Cây Sinh Trưởng Tốt. Chống bệnh xương khớp: Đem rau mồng tơi hầm với chân giò cho nhừ rồi ăn. Món ăn này rất có lợi cho xương khớp, phòng chống các bệnh liên quan đến xương khớp. Chữa yếu sinh lý: Mồng tơi, rau ngót, rau má đem nấu với lòng gà hoặc lòng vịt giúp tăng cường sinh lý nam giới. Trị mụn nhọt: Lấy lá mồng tơi, rửa sạch, giã nhuyễn sau đó đắp lên mụn nhọt sẽ khiến mụn nhọt nhanh chóng nặn đi. Chữa bệnh trĩ: Lấy lá mồng tơi non kèm thêm chút muối đắp vào búi trĩ, cố định bằng gạc sạch sẽ giúp chống viêm và búi trĩ co lên đáng kể. Chữa say nắng: Giã lá mồng tơi rồi đắp vào trán sẽ giúp giảm nhiệt , bệnh nhân say nắng sẽ nhanh chóng phục hồi sức khỏe. Chữa nám, thâm da: Lấy lá mồng tơi rửa thật sạch, giã nhuyễn, sau đó đắp lên da sẽ giúp da giảm thâm, nám đáng kể.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1580, 'Rạng Đông', 'Việt Nam', NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(127, 'Hạt Giống Rau Dền Cơm - RADO 86', 'RADO86', 'hat-giong-rau-den-com-rado-86', 'Công dụng: Cải thiện chất lượng xương khớp. Cải thiện tình trạng viêm. Mang lại lợi ích cho bệnh nhân đái tháo đường. Cải thiện dấu hiệu thiếu máu do thiếu sắt. Cải thiện chất lượng hệ tiêu hoá. Ngăn ngừa bệnh ung thư.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1589, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(128, 'Hạt Giống Rau Muống Lá Tre Rạng Đông - RADO 12', 'RADO 12', 'hat-giong-rau-muong-la-tre', 'Công dụng: Bảo vệ tim. Rau muống chứa nhiều dinh dưỡng thiết yếu như vitamin A, C và beta-carotene. Có lợi cho mắt. Điều trị chứng khó tiêu và táo bón. Ngăn ngừa bệnh tiểu đường. Tăng cường miễn dịch. Điều trị thiếu máu. Giảm cholesterol. Điều trị vàng da và các vấn đề về gan.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: Gói 50g
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1594, 'Rạng Đông', NULL, '0.05', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Rau muống lá tre là loại cây sinh trưởng phát triển khỏe, kháng bệnh tốt, độ đồng đều cao, vị ngon ngọt, màu xanh trung bình. Cây trồng được quanh năm, thời gian sinh trưởng ngắn 25 ngày sau khi gieo trồng có thể thu hoạch. Tiểu chuẩn của hạt:. Độ thuần : >99%. Tỷ lệ nảy mầm: >80%. Sơ cứu: Chưa có thông tin.'),
(129, 'Hạt Giống Rau Má Lá Nhỏ Rạng Đông', 'RADO 05', 'hat-giong-rau-ma-la-nho', 'Công dụng: CÂY SINH TRƯỞNG PHÁT TRIỂN MẠNH. TRỒNG QUANH NĂM. Rau má có tác dụng tiêu nhiệt, dưỡng âm, giải độc,… thường dùng để điều trị nhiều bệnh như viêm họng, viêm amidan, ngộ độc thực phẩm. Ngoài ra, chúng còn được sử dụng với mục đích giảm nhanh các triệu chứng bệnh ngoài da và hỗ trợ cải thiện bệnh tim mạch và thần kinh. HƯỚNG DÃN SỬ DỤNG, CÁCH TRỒNG VÀ CHĂM SÓC HẠT GIỐNG RAU MÁ LÁ NHỎ RẠNG ĐÔNG. Cách sử dụng:. Hạt giống trước khi sử dụng cần đem phơi nắng nhẹ để ráo hạt;. Trước khi đem gieo trồng cần ngâm hạt giống vào trong nước ấm theo tỷ lệ (3 sôi + 2 lạnh) theo số giờ được ghi trên sản phẩm. Cách trồng: Gieo hạt. Bước 1 : Cây rau má có khả năng mọc trên nhiều loại đất khác nhau, tuy nhiên rau má sẽ phát triển tốt, cho năng suất cao và chất lượng hơn nếu trồng ở các loại đất thịt pha cát, đất tơi xốp và loại đất phèn. Làm đất lên luống thấp, đủ để đất thoát nước mà không bị ứ động khi tưới nước. Giữa các liếp làm các rãnh nhỏ để dẫn và thoát nước. Nếu trồng ở thùng xốp, xô chậu thì xới đất cho tơi xốp rồi san phẳng mặt đất. Thùng xốp phải thoát nước tốt, tốt nhất nên làm thùng cải tiến để trồng cây đạt hiệu quả cao. Bước 2: Hạt rau má ngâm nước đã nảy mầm thì tiến hành gieo trồng. Bước 3: Rạch từng hàng thẳng để gieo hạt cho thẳng hàng, hoặc rắc đều hạt giống xuống đất. Kế tiếp, phủ lớp rươm rạ hoặc lớp đất mỏng lên hạt. Sau đó tưới phun nước cho hạt để giữ ẩm. Có thể rải Basudin hạt phòng trừ kiến, dế, sâu đất ăn hạt. Bước 4: Trong 3 – 5 ngày đầu gieo hạt nên tránh nắng cho hạt nảy mầm nhanh, sau đó dở tấm đậy ra để hạt nảy mầm đón ánh sáng. Cách chăm sóc:. Sau 1 tuần thì những hạt rau má sẽ nảy mầm lên mặt đất. Tiến hành tưới nước 1 ngày 2 lần vào buổi sáng và chiều mát. Nếu trời mưa thì nên hạn chế tưới nước và nên kiểm tra tránh tình trạng đất bị ngập nước. Nên bón phân cho rau má bằng phân chuồng đã qua ủ hoại hoặc các loại phân vi sinh. Ngoài ra, nếu trồng rau má trên ruộng. Thì cần bón thúc cho ruộng rau má bằng phân Supe lân, đạm và kali mỗi đợt cách nhau 10 – 12 ngày để dinh dưỡng cho rau phát triển tốt.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1602, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(130, 'Hạt Giống Rau Ngót Rạng Đông - RADO 621', 'RADO 621', 'hat-giong-rau-ngot', 'Công dụng: CÂY PHÁT TRIỂN TỐT. TRỒNG QUANH NĂM. Theo Đông y, lá rau ngót tính mát lạnh, ngoài tác dụng thanh nhiệt, giải độc còn lợi tiểu, tăng tiết nước bọt, bổ huyết, cầm huyết, nhuận tràng, sát khuẩn, tiêu viêm, sinh cơ . Rễ vị hơi đắng. Cả lá và rễ cây rau ngót đều có tác dụng với sức khỏe. Lá rau ngót chữa ban sởi, ho, viêm phổi, sốt cao, đái rắt, tiêu độc.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1610, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(131, 'Hạt Giống Rau Thì Là Rạng Đông - RADO 06', 'RADO 06', 'hat-giong-rau-thi-la', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1619, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(132, 'Hạt Giống Rau Đay Đỏ-Rạng Đông-RADO 88', 'RADO 88', 'hat-giong-rau-day-do-rang-dong-rado-88', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: 5 Hạt/ Gói
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1627, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(133, 'Hạt Giống Sen mini Nhiều Màu - Rạng Đông - RD 846', 'RD846', 'hat-giong-sen-mini-nhieu-mau-rang-dong-rd-846', 'Công dụng: HƯỚNG DẪN CÁCH TRỒNG:. Cách trồng: Nên trồng hoa ở những nơi nắng ấm, vào mùa hè, vì hoa này rất ưa sống ở nơi mặt trời mọc. Chọn loại giống tốt, tỉ lệ nảy mầm cao. Chúng thích hợp với đất bùn nên mọi người nên trồng ở ruộng hoặc đầm lầy. Vỏ hạt sen hơi dày phải dùng dao cắt nhẹ ở đầu hạt để cho dễ nảy mầm. Ngâm vào nước ở nhiệt độ là 20 độ C, chú ý phải thay nước hàng ngày, nếu không sẽ ảnh hưởng đến việc nảy mầm. Cách Chăm Sóc: Sen là loại hoa ưa ánh sáng, phải đặt chúng ở nơi nơi nhiều ánh sáng. Nếu trồng trong chậu phải trồng với nước sạch, một ngày tưới nước 1-2 lần là được. Để cho cây ẩm ướt và phát triển tươi tốt, chỉ cần để ý tới nước. Chế độ dinh dưỡng của cây để bổ sung và chăm sóc cho cây. Khi nào cây chuyển sang màu vàng thì bón cho nó một ít phân để cho là xanh , thân cây cứng cáp. Chỉ cần chăm sóc đơn giản như vậy chúng ta đã có một chậu hoa đẹp, ý nghĩa.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: 5 Hạt/ Gói
Giá tham khảo: 30.000đ', '30000.00', 3, 1, 4, 1635, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(134, 'Hạt Giống Tía Tô Nhật Rạng Đông - SHISO 113', 'SHISO 113', 'hat-giong-tia-to-nhat', 'Công dụng: Chưa có thông tin.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1645, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(135, 'Hạt Giống Tần Ô Rạng Đông - RADO 123', 'Rado 123', 'hat-giong-tan-o', 'Công dụng: Sinh Trưởng Khỏe. Trồng Được Quanh Năm. Kháng Bệnh Tốt. Hỗ trợ giảm cân : Rau tần ô (cải cúc) chứa nhiều axit chlorogenic, một loại axit hydroxycinnamic cũng có nhiều trong hạt cà phê. Axit chlorogenic đã được chứng minh là có đặc tính làm chậm quá trình giải phóng glucose vào máu sau bữa ăn, điều này làm cho nó trở thành một chất dinh dưỡng giảm cân tuyệt vời. Chống oxy hóa : Ngoài lợi ích giảm cân tiềm năng, axit chlorogenic có trong rau tần ô còn có khả năng chống oxy hóa. Cung cấp nhiều kali : Một khẩu phần 100 gram rau tần tô sống có chứa tới 460 miligam kali. Lượng kali này nhiều hơn 30% so với một khẩu phần chuối tương tự dù từ lâu chuối được coi là "thực phẩm vàng" cho kali.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1653, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Hướng dẫn sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(136, 'Hạt Giống Xà Lách Búp Rạng Đông - RADO 45', 'RADO 45', 'hat-giong-xa-lach-bup-rang-dong-rado-45', 'Công dụng: Giảm cân. Xà lách chứa ít calo và chất béo khiến chúng trở thành loại thực phẩm hợp lý hỗ trợ quá trình giảm cân. Cải thiện sức khỏe. Xà lách búp mỹ giàu vitamin A, một chất giúp cải thiện các vấn đề về sức khỏe. Phòng ngừa dị tật bẩm sinh. Tốt cho máu. Tốt cho xương.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: Gói 5g
Giá tham khảo: 10.000đ', '10000.00', 3, 1, 4, 1664, 'Rạng Đông', NULL, '0.01', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:. Hạt giống khi mau về cần phơi nắng nhẹ để không bị móc. Trức khi đem gieo trồng cần ngâm nước để hạt nảy mầm, khi trồng sẽ được hiệu quả hơn. Cách trồng:. Bước 1: Xử lý đất nếu đất đã qua sử dụng bằng cách tiến hành cày xới đất cho đất tơi xốp. dọn dẹp cỏ rác nếu có. Rải vôi bột lên bề mặt, phơi ải từ 5-7 ngày để cân bằng độ pH trong suốt mùa vụ và khử trùng, tiêu diệt những ấu trùng sâu bệnh. Sau đó trộn đất theo tỉ lệ (7 phần đất + 3 phần phân trùn quế hoặc phân bò, phân chuồng…) để tăng độ dinh dưỡng cho đất. Cuối cùng tưới nước tạo độ ẩm cho đất. Bước 2: Hạt giống ngâm trong 2 tiếng, để ráo rồi đem gieo. Bước 3: Tiến hành gieo: Rắc đều hạt giống xuống đất. Kế tiếp, phủ lớp rươm rạ hoặc lớp đất mỏng lên hạt. Sau đó tưới phun nước cho hạt để giữ ẩm. Cách chăm sóc:. Bón phân: Bón lót toàn bộ phân chuồng + toàn bộ lượng phân bón trên khi làm đất lần cuối. Bón thúc: sau khi trồng tuỳ theo tình hình sinh trưởng của cây mà bón thúc thêm lượng phân thích hợp, song cần bón ít nhưng chia nhiều lần. Ngoài ra có thể sử dụng thêm phân bón qua lá hoặc Nitrophoska hoà tan lọc sạch rồi cho vào bể nước tưới trong hệ thống tưới tự động. Tưới nước: Mỗi ngày tưới 1 lần vào buổi sáng sớm hay chiều mát. Nếu trồng ngoài trời khi tưới thủ công nên tưới giọt nhỏ để hạn chế rau bị tổn thương. Nếu mưa nhiều liên tục cần chú ý hệ thống thoát nước để hạn chế sâu bệnh, ngập úng. Nguồn nước tưới phải là nước máy, nước giếng khoan không bị ô nhiễm kim loại nặng, nước sông suối phải là nước sạch, không nhiễm vi sinh vật gây bệnh . ​​​​​​​.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(138, 'Hạt Giống Đu Đủ Lùn lai F1 Rạng Đông', 'RDVL01', 'hat-giong-du-du-lun-lai-f1-rang-dong', 'Công dụng: Cây đu đủ lùn chỉ cao khoảng 1m - 1.2m, thích hợp trồng vào chậu chơi tết rất đẹp và ý nghĩa. Đu đủ rất tốt cho hệ tiêu hóa bởi có hàm lượng chất xơ cao. Việc ăn đu đủ cũng sẽ ngừa táo bón và giải độc hệ tiêu hóa. Trong đu đủ có chứa các loại enzyme giúp kháng viêm, giảm nguy cơ mắc bệnh mãn tính. Chống oxy hóa, hàm lượng vitamin tuyệt vời như vitamin A, E, C, kết hợp với các khoáng chất như kali, đồng và magiê. Ngoài ra, ăn đu đủ có tác dụng giảm cân, tăng cường thị lực và rất tốt cho làn da. Ăn đu đủ còn giúp bạn giảm căng thẳng, mệt mỏi, ngăn ngừa bệnh tim mạch và ngừa được ung thư tuyến tiền liệt.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Quy cách: Gói 5 hạt
Giá tham khảo: 20.000đ', '20000.00', 3, 1, 4, 1680, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Trước khi gieo nên ngâm hạt trong nước vài giờ sau đó vùi trong trấu hun cho hạt nảy mầm rồi đem gieo. Thời vụ trồng: Cây dễ trồng, dễ chăm sóc, có thể trồng quanh năm. Mật độ: cây x cây 1.2m - 1.5m, hàng x hàng 2m - 2.5m. Thời gian thu hoạch: 7 - 8 tháng sau khi gieo.
An toàn sử dụng: Bảo quản: Chất lượng hạt giống tốt nhất khi bao bì còn nguyên vẹn. Bảo quản nơi khô ráo, thoáng mát, không để trực tiếp dưới ánh nắng mặt trời hoặc nơi có nhiệt độ cao. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(139, 'Hạt Giống Đậu Bắp Rạng Đông - RADO 60', 'RADO 60', 'hat-giong-dau-bap-rang-dong', 'Công dụng: CÂY CÓ KHẢ NĂNG SINH TRƯỞNG MẠNH. KHÁNG BỆNH TỐT. Giúp xương chắc khỏe. Ngừa bệnh thiếu máu. Chữa ho và viêm họng. Loại bỏ lượng cholesterol xấu. Hỗ trợ hệ tiêu hóa. Giảm triệu chứng hen suyễn. Làm đẹp da.
Đối tượng cây trồng: Hạt Giống Rạng Đông
Giá tham khảo: 15.000đ', '15000.00', 3, 1, 4, 1688, 'Rạng Đông', NULL, NULL, 1, '2026-05-31 00:00:00', '2026-05-31 17:29:54', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Hạt Giống', 'Hướng dẫn sử dụng: Cách sử dụng:.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Nếu trồng vào mùa mưa, bạn cần lên luống vừa rộng, vừa cao và dốc để dễ thoát nước. Ngược lại, nếu trồng vào mùa nắng, bạn cần làm đất kỹ theo hàng và gieo vào các hốc. Bón lót: sử dụng phân dê, bò,. Bước 2:. Bước 4:. Chuyển nhà cho cây Khi cây đạt chiều cao khoảng 20cm trở lên, bạn nên chuyển cây ra vườn trồng. Cách chăm sóc:. Ngày tưới nước 2 lần vào lúc sáng sớm và chiều tối. Khi cây đậu bắp ra được 4-5 lá thì tiến hành bón phân đợt 1 bằng phân hữu cơ, phân bò, phân trùn quế, phân dê, phân gà…. Đợt 2 bón khi cây bắt đầu có nụ. Đợt 3 bón khi thu hoạch xong quả đợt 1. Đợt 4 và 5 bón sau 2 lần hái quả. Sơ cứu: Chưa có thông tin.'),
(418, 'Đá Trân Châu Perlite - Đá Trân Châu Trắng', 'SOI.PERLITE', 'da-tran-chau-perlite-da-tran-chau-trang', 'Công dụng: Tăng Độ Tơi Xốp. Giữ Ẩm Và Thoát Nước Tốt. Vô Trùng, Sạch Nấm Bệnh. Cấu tạo thể hang, nhiều lỗ thông khí có tác dụng thoáng khí rất tốt cho đất trồng. Ngoài ra, nhờ thể hang nên chúng còn có khả năng thoát nước cực tốt. Chống úng nước cho rễ cây trong mùa mưa ngập. Vì quá trình hình thành tạo sự trương nở thể tích của đá trân châu nên trọng lượng của chúng khá nhẹ. Khi trộn cùng đất sạch trồng cây trên tường hay các chậu treo khá nhẹ, tốt cho trọng lượng chậu. Giúp giữ chất dinh dưỡng cho cây trồng, giữ ẩm cho cây vừa đủ. Khi trộn đá vào đất trồng cây giúp đất có được khả năng tơi xốp, không bị nén chặt, chống tình trạng đất thịt gây rễ kém phát triển. Đá trân châu là vô trùng nên ngăn chặn được các loại bệnh, sâu hại không thể phát triển.
Đối tượng cây trồng: Giá Thể Trồng Cây
Quy cách: Gói 100g (tách chiết)
Giá tham khảo: 10.000đ', '10000.00', 4, 1, 4, 5303, 'CTY TNHH FINON', 'Việt Nam', '0.10', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:55', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Giá Thể Trồng Cây', 'Hướng dẫn sử dụng: Đá Perlite là một loại đá có tính chất giữ ẩm rất cao. Tuy khả nắng giữ nước kém hơn với đá Vermiculite nhưng ngược lại điều này cũng mang đến những hiệu quả nhất định với các loại cây cần tạo độ thoáng và giữ ẩm hơn là giữ nước. Trồng thủy canh: Hệ thống trồng thủy canh đang dần rất phổ biến hiện nay, giúp việc thoát nước rất tốt. Công thức trộn đá Perlite gợi ý: 50% đá Perlite + 50% đá Vermiculite. Có thể tùy trường hợp mà áp dụng. Trồng rau sạch: Vấn đề trồng rau sạch đang ngày càng rất bức thiết. Đặc biệt, tại các thành phố lớn. Bạn có thể tự trồng rau sạch tại nhà với công thức trộn như sau: 30% đá Perlite, 30 % đá Vermiculite + 38% đất sạch namix + 2% phân vi sinh. Trồng cây cảnh: Cây cảnh cũng rất cần sự thoáng khí và thoát nước giữ ẩm hợp lý để phát triển. Công thức gợi ý trồng cây cảnh như sau: 40% đá Perlite + 20% đá Vermiculite + 38% đất sạch + 2% phân vi sinh. Dùng chiết cành: Chiết cành, vậy cành om sẽ rất cần giữ ẩm tốt, nhưng cũng phải có độ thoát nước. Đồng thời đất không được nén chặt để rễ dễ dàng phát triển. Vì thế, công thức gợi ý như sau: 30% đá Perlite + 70% đá Vermiculite. ​​​​​​​.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(424, 'Đầu Kéo Cắt Cành Trên Cao RHB', 'DAUKEO.RHB', 'dau-keo-cat-canh-tren-cao-rhb', 'Công dụng: Chất Liệu Thép SK5 Không Gỉ. Thép Dày 6mm Chắc Chắn Bền Bỉ. Lưỡi Cưa Sắc Bén, Có Thể Tháo Rời.
Đối tượng cây trồng: Kéo Cắt Tỉa Cây
Quy cách: 1 Kéo nặng 1.4kg
Giá tham khảo: 190.000đ', '190000.00', 4, 1, 1, 5385, 'RHB', 'Đài Loan', '1.40', 1, '2026-05-31 00:00:00', '2026-05-31 17:29:55', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Vật Tư Nông Nghiệp', 'Hướng dẫn sử dụng: Chỉ cần lắp đầu kéo vào thanh gỗ và khoan vặn ốc cố định lại chắc chắn và dùng thôi. Khi cắt cành chỉ cần kéo dây nhẹ là có thể cắt cành.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Lưỡi kéo được làm từ chất liệu thép, bền và cứng. Thuận lợi cho nhà vườn tỉa bỏ, cắt cành hư, trái thối , tỉa đi các cành xa mà không dùng thang, ghế, với tay ra xa, có thể gây nguy hiểm khi làm việc trên cao, tránh được côn trùng chích đốt, thuận lợi cho ổi,cam, trụ sống, dây lươn, cây tiêu, cây bơ, hồng, mận, xoài, nhãn, quýt, …. Thuận lợi cho nghệ nhân tỉa cành với các loại kiểng cao như mai cổ thụ, đại đinh tùng, kiểng xanh, sung, me …. Ngoài ra còn có tính năng cưa để cưa cành trên cao. Sơ cứu: Chưa có thông tin.'),
(431, 'Chất Chống Rụng Bông Super Mai - Lan - Hoa', 'DHCTSP', 'chat-chong-rung-bong-super-mai-lan-hoa', 'Công dụng: Làm Giảm Thiểu Số Lượng Nụ Bị Rụng. Làm Hoa Tươi Lâu Và Không Bị Rụng. Làm giảm thiểu số lượng nụ bị rụng. Làm hoa tươi lâu và không bị rụng.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Chai 10ml
Giá tham khảo: 25.000đ - 30.000đ', '27500.00', 1, 1, 3, 5480, 'ĐẠI HỌC CẦN THƠ', NULL, '0.01', 1, '2026-06-01 03:29:28', '2026-06-01 03:29:29', 'Thành phần: Sử dụng nguồn nguyên liệu Ca-EDTA (12%) nguyên chất, Ca được chiết xuất từ thực vật có chứa CaO > 15% và nguồn Bo hữu cơ Solubor, Borac có hàm lượng nguyên chất >10% tăng cường nguồn hữu, amino với liều lượng tối đa, nên sau khi sử dụng thì tác dụng cực nhanh và hiệu quả kéo dài giúp chống chịu hạn mặn.
Loại sản phẩm: Dưỡng Hoa Lâu Tàn', 'Hướng dẫn sử dụng: Chống Rụng Nụ Mai. Pha một chai 10ml cho 1 lít nước phun ướt đều lên hoa và nụ vào khoảng thời gian cây có 10% hoa nở. Chống Rụng Hoa GIấy. Chống Rụng Hoa Lan. Pha một chai 10ml cho 10 lít nước phun ướt đều lên hoa và nụ vào khoảng thời gian cây có 10% hoa nở.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(432, 'Chất Chống Rụng Cánh Hoa ĐHCT - Phân Bón Giữ Hoa Lâu Tàn', 'RCH.DHCT', 'chat-chong-rung-canh-hoa-dhct-phan-bon-giu-hoa-lau-tan', 'Công dụng: Chống rung cánh hoa Mai, Lan, Hoa Giấy. Giúp hoa có màu sắc đẹp. Sản phẩm nghiên cứu của ĐHCT. Chống rụng nụ hoa, chống rụng cánh hoa. Dưỡng hoa lâu tàn, giữ màu sắc hoa tươi. Dùng được cho Hoa Mai, Hoa Giấy, Phong Lan. CÁCH SỬ DỤNG. Pha theo tỉ lệ 10ml/ 1lít. Phun lúc hoa nở 10%. Phun tốt nhất vào sáng sớm hoặc chiều mát.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Chai 20ml
Giá tham khảo: 30.000đ', '30000.00', 1, 1, 3, 5481, 'ĐH Cần Thơ', 'CTY TNHH SX-TM và DV VINO', '0.02', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Sản phẩm sử dụng tốt khi dưỡng hoa lâu tàn, hạn chế rụng nụ hoa và rụng cánh hoa trên hoa mai, hoa giấy và các loại phong lan nói chung. Triacontanol: 1ml/l; Acid Boric: 0.5g/l; Phụ gia vừa đủ. MÔ TẢ SẢN PHẨM:. Từ lâu, các loài hoa như hoa mai, hoa lan, hoa giấy,... đã đi vào đời sống tinh thần của người Việt Nam. Đặc biệt vào các ngày Tết, hoa mai thường là một thứ hoa không thể thiếu trong những ngày xuân, ai cũng muốn có một cành mai đẹp trong nhà, vừa để tô điểm sắc xuân, vừa để cầu mong những điều tốt đẹp. Tuy nhiên, cảnh hoa mai rất dễ rụng và mau tàn. Vì vậy, hiện nay nhiều nhà vườn trồng mai thường sử dụng hóa chất giữ hoa lâu tàn để bản trong dịp tết. Chế phẩm "Chất chống rụng cánh hoa - ĐHCT" do PGS. Ts. Lê Văn Bé, Bộ môn Sinh lý Sinh hóa, Khoa Nông nghiệp và Sinh học Ứng dụng, Trường Đại học Cần Thơ nghiên cứu và thử nghiệm thành công trên các loại hoa (mai vàng, phong lan, hoa giấy) với mục đích chống rụng cảnh hoa, giúp hoa lâu tàn. Chất chống rụng hoa ĐHCT gồm các thành phần chính như Triacontanol (0,11 g/lit). Acid boric (0,5 g/lit). Clorua Calcium (4 g/lít) và các chất phụ gia. Đối tượng được áp dụng: Mai Vàng, Phong Lan, Hoa Giấy.
Loại sản phẩm: Hoạt chất khác', 'Hướng dẫn sử dụng: Chưa có thông tin.
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(433, 'Chất Gây Rụng lá Mai RVAC FOFER X3', 'RVAC', 'chat-gay-rung-la-mai-rvac-fofer-x3', 'Công dụng: Rụng Lá Có Chọn Lọc. Ra Hoa Đồng Loạt, Hoa Lên Màu Đẹp. Không Ảnh Hưởng Đến Nụ Hoa, Không Suy Cây. Giúp cây mai rụng lá, không cần phải lặt lá. Ra hoa đồng loạt, hoa nở có màu sắc đẹp. Không ảnh hưởng đến nụ hoa, không suy cây.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Gói 200g
Giá tham khảo: 50.000đ - 55.000đ', '52500.00', 1, 1, 4, 5482, 'RVAC', NULL, '0.20', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Nts: 25%. B:1500ppm. Zn: 1000ppm. Độ Ẩm 25%.
Loại sản phẩm: Chất Gây Rụng Lá', 'Hướng dẫn sử dụng: ♦ Đối với Mai trồng trên chậu:. Pha gói 200g cho bình 14-16 lít nước, phun đều và ướt đẫm 2 mặt lá mai. ♦ Đối với Mai trồng dưới đất (vườn Mai trồng đại trà):. Pha gói 200gam cho 8-10 lít nước, phun đều và ướt đẫm như mưa trên 2 mặt lá. - Đối với vườn Mai lâu năm (>10 năm tuổi), cây sung sức: có thể thời gian xiết nước kéo dài hơn và trước khi phun sản phẩm rụng lá 01 ngày, nên tưới nước gốc thật đẫm. Phun lúc trời nắng gắt và khô nước. Tốt nhất tầm 9-10 giờ sáng. Tùy theo nụ hoa lớn nhỏ mà thời điểm phun khác nhau. Sau khi phun từ 2-3 ngày lá già sẽ rụng, khoảng 2-5 ngày sẽ rụng hết lá. Phun khi cây khỏe mạnh, lá đã già, cây đã thay lá trước tháng 9 âm lịch. Cần xiết nước, làm khô đất xung quanh gốc cây và không bón phân. Sau khi cây rụng hết lá, tưới nước và chăm sóc lại bình thường để cây trổ hoa. CHĂM SÓC VÀ ĐIỀU CHỈNH NỤ HOA SAU KHI RỤNG LÁ ĐỒNG LOẠT:. Đối với nụ hoa lớn (nụ sớm), thì tưới nước hạn chế, duy trì có độ ẩm tránh quá khô làm rụng nụ…. Đối với nụ hoa nhỏ (nụ trễ), thì nên tưới nước nhiều hơn, xen kẽ cần sử dụng sản phẩm RVAC FOFER-PT (nồng độ pha 10ml/8-10 lít nước) tưới xen từ 2-3 ngày/lần,.. đồng thời theo dõi sự phát triển của nụ hoa, để chăm sóc trở lại bình thường.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. CÁC CHẤT LÀM RỤNG LÁ KHÁC. [product_category category="chat-gay-rung-la" columns="4" orderby="date" order="desc"]. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(434, 'Chất Gây Rụng Lá Mai Đại Học Cần Thơ', 'DHCT01', 'chat-gay-rung-la-mai-dai-hoc-can-tho', 'Công dụng: Chất Gây Rụng Lá Mai Đại Học Cần Thơ. Sản phẩm này khi phun lên lá mai vàng, mai chiếu thủy, linh sam sẽ gây rụng lá sau đó 2 – 3 ngày. Đặc biệt là không làm hư nụ mai vàng, chết cành do thuốc nếu sử dụng đúng nồng độ đã ghi theo nhãn chai. Sau 2 – 3 ngày phun thuốc thì tiến hành lặt lá vì thuốc không gây rụng lá non, các lá còn lại thì cũng dễ dàng lặt bỏ vì tầng rời ở cuống lá đã hình thành. Sản phẩm này làm giảm công lao động hơn 60 – 70%.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 180g
Giá tham khảo: 55.000đ', '55000.00', 1, 1, 4, 5483, 'ĐẠI HỌC CẦN THƠ', NULL, '0.18', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Bo: 2000ppm. Phụ gia đặc biệt vừa đủ.
Loại sản phẩm: Phân Bón Vi Lượng', 'Hướng dẫn sử dụng: Pha tỉ lệ 18Gr/1 lít nước sạch. Phun ướt đều lên lá mai. Sau 2-3 ngày cây sẻ rụng lá, không ảnh hưởng tới nụ. Thời gian phun cho hoa mai vàng thường 12-20 tháng 12 âm lịch.
An toàn sử dụng: Bảo quản: Để nơi khô ráo, thoáng mát;. Tránh xa tầm tây trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(435, 'Chế Phẩm Hùng Nguyễn - Kích Rễ, Kích Kei', 'CPHN', 'che-pham-hung-nguyen-kich-re-kich-kei', 'Công dụng: Làm ra rễ, ra keiki. Bổ Sung NPK. Phòng Trị 1 Vài Loại nấm Bênh. Trị Bệnh Đốm lá – Rỉ Sắt. Sát Khuẩn. Chế Phẩm Hùng Nguyễn là chế phẩm có tác dụng 6 trong 1 giúp phong lan phát triển cân bằng đầy đủ dưỡng chất. Đặc biệt phát huy tác dụng rất tốt khi dùng kết hợp với Atonik và B1. Đây là chế phẩm không thể thiếu của anh chị em yêu lan, đặc biệt các nhà vườn thường xuyên sử dụng. THÔNG TIN CHẾ PHẨM HÙNG NGUYỄN. Cre: Thần Nông.
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Chai 20ml
Giá tham khảo: 30.000đ', '30000.00', 1, 1, 3, 5484, 'Hùng Nguyễn', 'Đà Lạt', '0.02', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Đang Cập Nhật.
Loại sản phẩm: Phân Bón Lá, Chất Điều Hòa Sinh Trưởng', 'Hướng dẫn sử dụng: Một chai chế phẩm Hùng Nguyễn 20ml, pha được 20 lít nước để phun (toàn bộ cây). Tỉ lệ: 1ml (khoảng 20 giọt) pha với 1 lít nước. 3 đến 5 ngày, phun 1 lần. Phun từ 3 đến 5 lần, hiệu quả sẽ thể hiện rõ rệt. Giữa các lần phun, vẫn tưới nước giữ ẩm bình thường. Khi phun chế phẩm: phun toàn bộ cây (rễ, thân, lá). Có thể phun xen kẽ với các dưỡng chất khác theo chu kỳ phát triển của cây. Chú ý: Đối với những cây con quá nhỏ (từ cấy mô): phải pha loãng liều lượng (1ml pha 3 lít nước) khi phun. TRƯỜNG HỢP LOẠI TRỪ. Khi cây đã ra nụ (hoạch cành bông), chứng tỏ cây đã đủ mạnh. Lúc này không cần phun chế phẩm nữa. Nếu muốn phun chỉ phun vào rễ thôi. (Không nên phun vào cành bông đã nở hoa).
An toàn sử dụng: Bảo quản: Chưa có thông tin. Lưu ý khi sử dụng: Bước 1: Già hành già cắt ra phải sát trùng vết cắt, chấm sơn liền da 2 đầu chống thối nhũn (Nếu không có loại chuyên dụng thì dùng xi măng, nhúng vào 2 đầu). Bước 2: lấy tăm bông thắm chế phẩm nguyên chất bôi trực tiếp vào các mắt ngủ. Bước 3: cách 5 ngày 1 lần tiến hành pha & phun như trên. Toàn bộ quá trình ươm keiki phải giữ giả hành ở điều kiện độ ẩm và ánh sáng thích hợp. CHÚ Ý KHI DÙNG. Trong điều kiện tắt nắng (khoảng 5h chiều). Tưới nước ướt đẫm toàn cây Lan để tạo đường dẫn cho cây hấp thu. 45 phút – 1 tiếng sau, mới tiến hành phun chế phẩm. Lưu ý: cây cần tối thiểu 5 tiếng để hấp thụ dưỡng chất của chế phẩm. Do đó, hạn chế tối đa việc phun vào buổi sáng. Nếu vừa phun xong trời mưa thì ngày kế tiếp nên phun lại. Sáng hôm sau tưới nước như bình thường. Không dùng cho thực phẩm: rau, củ, trái cây... (Lý do: chưa có phân tích ảnh hưởng tới thực phẩm). Đối với thân thòng, khi ngủ đông (hay xuống lá, chuẩn bị ra hoa), khi phun lúc này sẽ không thể hiện hiệu quả rõ rệt. Tuy nhiên, chế phẩm vẫn có dưỡng chất để dưỡng cây và xua đuổi một số loại côn trùng. Đối với cây mới tách và mới khai thác từ rừng. Với cây tách: Sau khi tách, vệ sinh và sát trùng vết cắt. Ngâm toàn bộ thân-lá-rễ vào nước đã pha chế phẩm tỷ lệ 1 ml/1 lít nước khoảng 30p, sau đó ghép hoặc trồng vào giá thể mới. Cuối cùng, nhúng lại cả giá thể ngập rễ vào nước pha chế phẩm khoảng 10 phút rồi treo lên giàn. Thực hiện tiếp quy trình phun chế phẩm 3-5 ngày một lần xen kẽ với các dưỡng chất khác theo chu kỳ phát triển của cây. Cây sẽ ra rễ nhanh nảy mầm mới nhanh và khỏe. Đối Với Cây Lan Mới Khai Thác. Cắt bỏ rễ hỏng, lá dập, vòi hoa cũ, làm sạch bộ rễ, ngâm vào nước đã pha chế phẩm theo tỷ lệ 1ml/1 lít nước khoảng 2 tiếng. Sau đó treo ngược 10-15 ngày hoặc có thể ghép ngay vào giá thể. Quy trình tiếp theo giống như phần tách ở trên. Cây mới khai thác kể cả dòng thân đốt thời gian này vẫn bắn rễ rất nhanh, cây phục hồi phát triển tốt. HƯỚNG DẪN TRỊ BỆNH ĐỐM LÁ GÌ SẮT. Vệ sinh, rửa sạch sẽ lá bệnh vào buổi chiều, sau đó lấy tăm bông (hoặc nhiều thì lấy bông gòn) thắm chế phẩm nguyên chất, bôi trực tiếp lên những vết gỉ sắt. Từ 3-5 ngày bôi 1 lần, hiệu quả sau 5 lần:. HƯỚNG DẪN PHUN PHÒNG – TRỊ NÁM. Cách phun giống kích rễ, nhưng phun dày hơn: Nên phun 3 ngày 1 lần. Nấm sau khi nhiễm chế phẩm, sẽ ngả màu nâu đỏ và dần tan mất. Lúc này không cần phải dọn dẹp giá thể, mà để nấm phân hủy trở thành nguồn dinh dưỡng ưa thích của lan. Nếu không có nấm, thì việc phun mang lại hiệu quả phòng ngừa. Chế phẩm có tác dụng trên khá nhiều loại nấm, đặc biệt là nấm trắng, xanh, đỏ, nâu trên giá thể, nấm gây thối nhũn ngọn, vv. HƯỚNG DẪN BẢO QUÂN. Trong điều kiện thoáng mát, không có nắng chiếu vào. Thời gian sử dụng: trong vòng 18 tháng, kể từ ngày sản xuất. NSX và HSD: Xem trên bao bì sản phẩm. Sơ cứu: Chưa có thông tin.'),
(436, 'Chế Phẩm Nấm Đối Kháng Trichoderma Plus Humic Sfarm', 'TRICHO.SF', 'che-pham-nam-doi-khang-trichoderma-plus-humic-sfarm', 'Công dụng: Bổ sung hệ vi sinh vật có lợi cho đất: giúp phòng ngừa hiệu quả nấm bệnh gây hại tồn tại trong đất, ngăn ngừa tuyến trùng hại rễ. Đồng thời, mang đến hiệu quả mạnh mẽ trong cải tạo đất bạc màu và thoái hoá. Phân giải các chất hữu cơ: Trichoderma được xem như nhà máy sản xuất enzym phân giải chất xơ cellulose. Do đó Trichoderma thường được trộn chung với chất thải hữu cơ, xác bã thực vật (cỏ, rơm, lá cây, xác rau củ quả,...), phân chuồng,... để đẩy nhanh quá trình phân hủy các chất hữu cơ thành các đơn chất dinh dưỡng giúp cây hấp thụ dễ dàng. Phân hữu cơ sinh học: khi nấm đối kháng Trichoderma Plus Sfarm được trộn chung với các loại phân hữu cơ (phân chuồng) và các chế phẩm sinh học...bón vào đất để hạn chế bệnh hại và cải tạo tính chất vật lý, hóa học của đất. Từ đó giúp đất tơi xốp, thoáng khí, nhiều chất mùn, tăng độ phì, tạo điều kiện thuận lợi cho vi sinh vật có ích và vi sinh vật đối kháng phát triển, hạn chế phân bón hóa học và thuốc BVTV, giúp tăng cường khả năng phát triển, phục hồi bộ rễ.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 500g / Gói 1Kg
Giá tham khảo: 55.000đ', '55000.00', 1, 1, 4, 5485, 'CÔNG TY TNHH SX-TM-DV ĐẶNG GIA TRANG', NULL, '0.50', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Hữu cơ: 15%. Độ ẩm: 30%. Trichoderma sp. (Trichoderma aureaviride, Trichoderma viride, Trichoderma koningii, Trichoderma harzianum): 10^9 cfu/g. Humic và các hoạt chất sinh học đặc hiệu. Nấm đối kháng Trichoderma được xác định có tới 33 loài. Trong đó, sản phẩm nấm đối kháng Trichoderma Plus Sfarm bao gồm 04 loài là Trichoderma aureaviride, Trichoderma viride, Trichoderma koningii và Trichoderma harzianum. Bốn loài nấm này được công nhận là sinh ra kháng sinh ức chế và tiêu diệt nấm bệnh, diệt tuyến trùng rất mạnh. Ưu điểm của chế phẩm nấm đối kháng Trichoderma Humic Plus Sfarm. Mật độ bào tử nấm cao nhất thị trường (10^9 CFU/g). Tan đều trong nước: thuận tiện sử dụng và ứng dụng phun trên lá, toàn bộ thân cây. Không gây hại cho người và vật nuôi. Có phổ đối kháng rộng trên các loài nấm gây bệnh với cây trồng. Sử dụng nhiều cơ chế để kháng lại các vi sinh vật gây bệnh. Tồn tại lâu dài trong đất nhờ khả năng tự sản sinh ra bào tử. Trichoderma phát triển nhanh trong đất. Hỗ trợ quá trình hấp thu chất dinh dưỡng và kích thích tăng trưởng cho cây trồng. Phân hủy rác thải hữu cơ rất mạnh.
Loại sản phẩm: Chế phẩm vi sinh', 'Hướng dẫn sử dụng: Bón gốc, tưới hoặc phun trực tiếp lên cây: kết hợp với các lần bón lót, bón thúc phân hữu cơ. Tưới hoặc phun trực tiếp lên cây với lượng dùng 100g pha với 10 lít nước. Tùy theo nhu cầu và đối tượng cây trồng, tần suất bón sẽ khác nhau. Trộn với đất hay giá thể trồng cây: lượng dùng: 1kg cho 1m 3 đất trồng/ giá thể. Cải tạo đất: 1kg/ 1000 m 2 . Ủ phân hữu cơ: 1kg - 2kg/ tấn nguyên liệu.
An toàn sử dụng: Bảo quản: Bảo quản nơi khô ráo, thoáng mát và tránh ánh nắng trực tiếp. Tránh xa tầm tay trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(437, 'Chế Phẩm Thân Nù Lá Mít', 'TNLM.01', 'che-pham-than-nu-la-mit', 'Công dụng: Cung Cấp Dinh Dưỡng Giúp Thân Cây Mập, Lá Dày, To, Xanh Mướt. Chống Thối Nhũn Lúc Lan Mới Ra Chai Mô, Khi Trời Mưa Nhiều. Chuyên Dùng Cho Lan Thân Thòng, Đặc Biệt Rất Tốt Cho Phi Điệp. Phân bón giúp xanh lá dưỡng lá siêu to, dày lá, giúp bộ lá xanh dày và cứng cáp hơn. Phân kích nù hoa lan dưỡng mập thân, ức chế tăng trưởng làm rụt thân, đứng ngọn. Dùng phân lá mít tưới tưới cho Ngọc Điểm làm lá mít to bản, thân rút lại, phình to. Tưới Dendro, Cat làm thân lá rút ngắn lại, to mập dày. Phân bón còn được dùng để chống thối lan khi lan mới ra chai mô, hạn chế tình trạng thối nhũn trên lan trong mùa mưa. Sản phẩm phù hợp cho nhiều loại cây hoa kiểng đặc biệt là Ngọc Điểm, Vũ Nữ, Hồ Điệp, Dendro….
Đối tượng cây trồng: CHUYÊN HOA LAN - CÂY KIỂNG
Quy cách: Hũ 100g
Giá tham khảo: 55.000đ', '55000.00', 1, 1, 3, 5486, 'None', 'Việt Nam', '0.10', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Chưa có thông tin.
Loại sản phẩm: Phân Bón Lá', 'Hướng dẫn sử dụng: Pha 2-3g kích nù hoa lan với 1 lít nước rồi phun tưới đều ướt 2 mặt lá và thân cây. Nên phun lúc sáng sớm hoặc chiều mát, tránh mưa, phun ướt đều 2 mặt lá, thân cây xung quanh gốc.
An toàn sử dụng: Bảo quản: Để xa tầm tay trẻ em, nguồn thực phẩm, nguồn nước. Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng. Sử dụng không hết Nhớ Đóng Nắp Kỹ Càng. Lưu ý khi sử dụng: Mặc đồ bảo hộ lao động khi phun hóa chất. Không ăn uống và hút thuốc khi pha chế và phun hóa chất. Tránh hít phải hơi hóa chất. Không để hóa chất dính vào da, mắt. Không đổ hóa chất thừa làm ô nhiễm nguồn nước, ao hồ. Sơ cứu: Nếu dính da: rửa với thật nhiều nước và xà phòng. Nếu dính mắt: rửa dưới vòi nước chảy trong 10 - 15 phút. Nếu nuốt: phải đưa nạn nhân đến cơ quan y tế gần nhất kèm theo nhãn sản phẩm.'),
(438, 'Chế phẩm vi sinh EMZEO - Xử Lý Chất Thải Hữu Cơ', 'EMZEO', 'che-pham-vi-sinh-emzeo-xu-ly-chat-thai-huu-co', 'Công dụng: Phân giải nhanh rác thải và phế thải nông nghiệp làm phân bón hữu cơ vi sinh. Ủ và khử mùi hôi: phân chuồng, rơm rạ, đậu nành, bánh dầu, phân cá, trùn quế, rác thải nhà bếp. Diệt mầm bệnh, trứng giun, hạn chế ruồi muỗi. Xử lý nước thải, làm sạch môi trường. Emzeo sử dụng như EM gốc, sản xuất ra các chế phẩm EM2, EM5, EM rượu, EM chuối, EM tỏi, EM trầu.
Đối tượng cây trồng: PHÂN BÓN
Quy cách: Gói 200g
Giá tham khảo: 35.000đ', '35000.00', 1, 1, 4, 5487, 'CTY TNHH Công Nghệ Sinh Học Đức Bình', 'Việt Nam', '0.20', 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Emzeo là chế phẩm vi sinh vật hữu hiệu dạng bột (Chế phẩm EM), là hỗn hợp các vi sinh vật thuộc các chi: Bacillus sp., Saccharomyces sp. (nấm men), Lactobacillus sp., Actinomyces ... có khả năng phân giải mạnh cellulose, tinh bột, kitin, protein, lipid... khủ mùi hôi thối, đồng thời sinh ra các hoạt chất có lợi cho môi trường. Vi sinh vật tổng số > 10 8 CFU/g. Chất mang: bột cám gạo, bột đậu. Có khả năng sinh chất kích thích sinh trưởng thực vật, sinh chất kháng sinh, chuyển hóa lân khó tiêu thành dễ tiêu và xử lý nước thải.
Loại sản phẩm: Chế phẩm vi sinh', 'Hướng dẫn sử dụng: Hòa 1 gói vào nước sạch, tưới đều cho 1 tấn nguyên liệu, đạt độ ẩm 45 - 50%. Ủ đống trong 20-30 ngày. Xử lý nước thải: sử dụng 3 - 5gr chế phẩm cho 1m 3 nước thải. Ủ đậu nành, dịch đạm cá, dịch chuối, dịch trùn quế.
An toàn sử dụng: Bảo quản: Để nơi khô mát trong 24 tháng kể từ ngày sản xuất. Tránh xa tầm tay trẻ em. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu: Chưa có thông tin.'),
(439, 'Dithane M45 80WP- Thuốc Trừ Nấm Bệnh', 'CAT2-9', 'dithane-m45-80wp-thuoc-tru-nam-benh', 'Công dụng: Trừ Bệnh Dạng Tiếp Xúc. Bồ Sung Kẽm Và Mangan. Cơ Chế Phổ Rộng. Công Nghệ NEO – TEC. Là thuốc trừ nấm dạng tiếp xúc, phổ rộng. Trừ được vài trăm loại nấm bệnh thông dụng. - Ngoài ra còn bổ sung Mn và Zn làm cho cây cứng cáp, thích hợp thay đổi môi trường, ngừa bệnh. - Thuốc trừ bệnh vàng lá, đạo ôn, thán thư, mốc sương, rỉ sắt,... trên nhiều loại cây trồng như Lúa, Cà phê, Điều, Xoài, Vải, Khoai tây, Cà chua... - Có thể sử dụng cho lan để trừ bệnh vàng lá, rụng lá, rỉ sắt, thán thư và phòng chống nhiều loại nấm bệnh khác nhau.', '0.00', 2, 1, 3, 5488, NULL, NULL, NULL, 1, '2026-06-01 03:29:29', '2026-06-01 03:29:29', 'Thành phần: Mancozeb 800g/kg • Vi lượng Kẽm và Mangan • Phụ Gia Vừa Đủ.', 'Hướng dẫn sử dụng: Liều dùng cho lan: 2g/1 lít nước.
An toàn sử dụng: Bảo quản: Để xa Tầm tay trẻ em, Nguồn thực phẩm, Nguồn nước. ◊ Bảo quản nơi khô ráo, thoáng mát, Tránh ánh Nắng. Lưu ý khi sử dụng: Chưa có thông tin. Sơ cứu:');
-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_embeddings`
--

CREATE TABLE `product_embeddings` (
  `id` int NOT NULL,
  `ProductID` int NOT NULL,
  `content` text NOT NULL,
  `embedding` json NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_image`
--

CREATE TABLE `product_image` (
  `ImageID` int NOT NULL,
  `ProductID` int DEFAULT NULL COMMENT 'Tú image: sản phẩm sở hữu ảnh, dùng cho upload ảnh tự động',
  `Name` varchar(100) DEFAULT NULL,
  `URL` varchar(500) DEFAULT NULL COMMENT 'Đường dẫn public của file ảnh, ví dụ /images/uploads/products/sp1.jpg',
  `AltText` varchar(255) DEFAULT NULL COMMENT 'Tú image: mô tả ảnh để SEO và hỗ trợ truy cập',
  `IsPrimary` tinyint(1) DEFAULT '1' COMMENT 'Tú image: 1 là ảnh đại diện chính của sản phẩm',
  `SortOrder` int DEFAULT '1' COMMENT 'Tú image: thứ tự hiển thị ảnh trong gallery',
  `ImageTypeID` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_image`
--

INSERT INTO `product_image` (`ImageID`, `ProductID`, `Name`, `URL`, `AltText`, `IsPrimary`, `SortOrder`, `ImageTypeID`, `CreatedAt`) VALUES
(1, 1, 'mau-td-mkp-05234-4379.png', '/images/uploads/products/td-0-52-34-kich-tao-mam-hoa-xu-ly-hoa-nghich-mua/mau-td-mkp-05234-4379.png', '0-52-34 Kích Tạo Mầm Hoa - Xử Lý Hoa Nghịch Mùa', 1, 1, 1, '2026-05-31 00:00:00'),
(12, 2, '151217-5803.png', '/images/uploads/products/15-12-17-phan-bon-npk-hon-hop-chuyen-dung-cho-hoa-va-cay-canh/151217-5803.png', '15 - 12 - 17 Phân Bón NPK Hỗn Hợp | Chuyên Dùng Cho Hoa và Cây Cảnh', 1, 1, 1, '2026-05-31 00:00:00'),
(23, 3, 'ac super k-ca,.png', '/images/uploads/products/ac-super-k-ca-phan-bon-kali-co-chat-dieu-hoa-sinh-truong/ac super k-ca,.png', 'AC S.UPER K-CA Phân Bón Kali Có Chất Điều Hòa Sinh Trưởng', 1, 1, 1, '2026-05-31 00:00:00'),
(35, 4, 'ac zinmac,,.png', '/images/uploads/products/ac-zinmac-phan-bon-vi-luong/ac zinmac,,.png', 'AC-ZINMAC Phân Bón Vi Lượng', 1, 1, 1, '2026-05-31 00:00:00'),
(48, 5, '2nn-4346.jpg', '/images/uploads/products/acroots-10sl/2nn-4346.jpg', 'ACROOTS 10SL – Phân Bón Kích Siêu Ra Rễ', 1, 1, 1, '2026-05-31 00:00:00'),
(66, 6, '1nn-9492_1.jpg', '/images/uploads/products/agbasics-seaweedplus/1nn-9492_1.jpg', 'AGBASICS SEAWEEDPLUS – Phân Bón Hỗn Hợp NPK Úc', 1, 1, 1, '2026-05-31 00:00:00'),
(79, 7, 'agri-fos-400-1361_1.png', '/images/uploads/products/agri-fos-400si-thuoc-dac-tri-nam-hong/agri-fos-400-1361_1.png', 'Agri Fos 400SL Thuốc Đặc Trị Nấm Hồng', 1, 1, 1, '2026-05-31 00:00:00'),
(90, 8, 'aliette-2456.png', '/images/uploads/products/aliette-800wg-thuoc-tri-thoi-goc-re/aliette-2456.png', 'Aliette 800WG - Thuốc Trị Thối Gốc, Rễ', 1, 1, 1, '2026-05-31 00:00:00'),
(104, 9, 'alpine-1-6176_1.png', '/images/uploads/products/alpine-80wg/alpine-1-6176_1.png', 'Alpine 80WG', 1, 1, 1, '2026-05-31 00:00:00'),
(117, 10, 'ami green 100ml,...png', '/images/uploads/products/phan-bon-sinh-hoc-ami-green/ami green 100ml,...png', 'Ami Green - Phân Bón Giải Độc Sinh Học', 1, 1, 1, '2026-05-31 00:00:00'),
(129, 11, 'amico-10ec-100ml-4156.jpg', '/images/uploads/products/amico-10ec/amico-10ec-100ml-4156.jpg', 'AMICO 10EC - Thuốc Trừ Sâu, Ruồi Vàng, Bọ Trĩ', 1, 1, 1, '2026-05-31 00:00:00'),
(142, 12, '1nn-1694_1.jpg', '/images/uploads/products/amino-alexin/1nn-1694_1.jpg', 'Amino Alexin - Phân Bón Đa Lượng', 1, 1, 1, '2026-05-31 00:00:00'),
(154, 13, 'amn-bo-05 (1).png', '/images/uploads/products/amino-bo/amn-bo-05 (1).png', 'Amino Bo | AminoQuelant - 05 | Phân Bón Chống Rụng Nụ, Rụng Trái', 1, 1, 1, '2026-05-31 00:00:00'),
(169, 14, 'amino-combi-3815_1.png', '/images/uploads/products/amino-combi/amino-combi-3815_1.png', 'Amino Combi - Phân Bón Vi Lượng Tổng Hợp', 1, 1, 1, '2026-05-31 00:00:00'),
(181, 15, 'amini minor.jpg', '/images/uploads/products/amino-minors-phan-vi-luong-tong-hop/amini minor.jpg', 'Amino Minors - Phân Vi Lượng Tổng Hợp', 1, 1, 1, '2026-05-31 00:00:00'),
(194, 16, 'amistar-top-1809.png', '/images/uploads/products/amistar-top-325sc-thuoc-tru-benh-cay/amistar-top-1809.png', 'Amistar Top 325sc - Thuốc Trừ Bệnh Cây', 1, 1, 1, '2026-05-31 00:00:00'),
(208, 17, '1nn-2587.jpg', '/images/uploads/products/anvil-5sc/1nn-2587.jpg', 'Anvil 5SC – Thuốc Trị Bệnh Rỉ Sắt', 1, 1, 1, '2026-05-31 00:00:00'),
(219, 18, 'b1-xanh-grow-more-2394_1.png', '/images/uploads/products/b1-xanh-grow-more-start-p2-dieu-hoa-sinh-truong/b1-xanh-grow-more-2394_1.png', 'B1 Xanh Grow More - Kích Rễ, Điều Hòa Sinh Trưởng Cho Cây', 1, 1, 1, '2026-05-31 00:00:00'),
(231, 19, '1nn-3843_1.jpg', '/images/uploads/products/benkona-thuoc-sat-khuan-khu-trung-gia-the-dat-trong/1nn-3843_1.jpg', 'Benkona – Thuốc Sát Khuẩn, Khử Trùng Giá Thể, Đất Trồng', 1, 1, 1, '2026-05-31 00:00:00'),
(246, 20, 'bio root 100m.png', '/images/uploads/products/bio-root-011-phan-kich-re-chong-nghet-re/bio root 100m.png', 'BIO ROOT 0-1-1 - Phân Kích Rễ, Chống Nghẹt Rễ', 1, 1, 1, '2026-05-31 00:00:00'),
(257, 21, 'bung chèo siêu đạm mỹ usa,.png', '/images/uploads/products/sieu-bung-cheo-cuc-manh-sieu-dam-my-usa/bung chèo siêu đạm mỹ usa,.png', 'Bung Chèo Cực Mạnh (Siêu Đạm Mỹ USA)', 1, 1, 1, '2026-05-31 00:00:00'),
(267, 22, 'bec-than-xoay (2).png', '/images/uploads/products/bec-nhua-than-xoay-360/bec-than-xoay (2).png', 'Béc Nhựa Thân Xoay 360° Ren Trong, Ren Ngoài', 1, 1, 1, '2026-05-31 00:00:00'),
(284, 23, 'bec-360-6179_1.png', '/images/uploads/products/voi-phun-suong-cao-ap-bec-dong-phun-suong-ap-luc/bec-360-6179_1.png', 'Béc Đồng Phun Sương Cao Áp - Vòi Phun Sương Cao Áp', 1, 1, 1, '2026-05-31 00:00:00'),
(300, 24, 'bec-dong (1).png', '/images/uploads/products/bec-dong-phun-suong-ap-luc-cao-voi-phun-nguyen-tu/bec-dong (1).png', 'Béc Đồng Phun Sương Áp Lực Cao - Vòi Phun Nguyên Tử', 1, 1, 1, '2026-05-31 00:00:00'),
(315, 25, 'beo-map-sieu-tangtruong-4962_1.png', '/images/uploads/products/beo-map-sieu-tang-truong-phan-bon-magnesium-nitrate/beo-map-sieu-tangtruong-4962_1.png', 'Béo Mập - Siêu Tăng Trưởng - Phân Bón Magnesium Nitrate', 1, 1, 1, '2026-05-31 00:00:00'),
(325, 26, '252578e3aa8d42ed9affaf697ff9c365-8713.jpg', '/images/uploads/products/binh-phun-tich-dien/252578e3aa8d42ed9affaf697ff9c365-8713.jpg', 'Bình Phun Tích Điện - Bình Tưới Cây - Làm Vườn', 1, 1, 1, '2026-05-31 00:00:00'),
(347, 27, 'bình tươi vòi sen (2).png', '/images/uploads/products/binh-tuoi-cay-voi-sen-nhua-nhieu-dung-tich/bình tươi vòi sen (2).png', 'Bình Tưới Cây Vòi Sen Nhựa - Nhiều Dung Tích', 1, 1, 1, '2026-05-31 00:00:00'),
(359, 28, 'bình 2in1,,,.png', '/images/uploads/products/binh-tuoi-cay-da-nang-2in1-vua-tuoi-cay-vua-phun-suong/bình 2in1,,,.png', 'Bình Tưới Cây Đa Năng 2in1 - Vừa Tưới Cây Vừa Phun Sương', 1, 1, 1, '2026-05-31 00:00:00'),
(375, 29, 'binh-xit-dudaco-5236.png', '/images/uploads/products/binh-xit-dudaco-dung-tich-1-2-4-8-lit/binh-xit-dudaco-5236.png', 'Bình Xịt DUDACO Nhiều Dung Tích | Bình Xịt Nước 1-2-4-8 Lít', 1, 1, 1, '2026-05-31 00:00:00'),
(398, 30, 'but-do-ph (1).png', '/images/uploads/products/but-do-do-ph-trong-nuoc/but-do-ph (1).png', 'Bút Đo Độ pH Trong Nước - Đo pH Nước Trong Bể Cá', 1, 1, 1, '2026-05-31 00:00:00'),
(409, 31, 'keo-tu-huy-3408.png', '/images/uploads/products/bang-keo-ghep-canh-ghep-cay-tu-huy/keo-tu-huy-3408.png', 'Băng Keo Ghép Cành, Ghép Cây Tự Hủy', 1, 1, 1, '2026-05-31 00:00:00'),
(425, 32, 'btk-2514.png', '/images/uploads/products/ba-tru-kien-tan-to-btk/btk-2514.png', 'Bả Trừ Kiến Tận Tổ BTK', 1, 1, 1, '2026-05-31 00:00:00'),
(437, 33, 'mau-moi-oc-6gr-8659.png', '/images/uploads/products/ba-tru-oc-moi-oc-6gr/mau-moi-oc-6gr-8659.png', 'Bả trừ ốc MOI OC 6GR', 1, 1, 1, '2026-05-31 00:00:00'),
(449, 34, 'bau-nhua-tron-1-9315_1.png', '/images/uploads/products/bau-nhua-tron-ho-tro-chiet-canh/bau-nhua-tron-1-9315_1.png', 'Bầu Nhựa Tròn Hỗ Trợ Chiết Cành', 1, 1, 1, '2026-05-31 00:00:00'),
(465, 35, 'bau-uom (1).png', '/images/uploads/products/bau-uom-v6-bau-uom-cay-thong-minh/bau-uom (1).png', 'Bầu Ươm V6 - Bầu Uơm Cây Thông Minh', 1, 1, 1, '2026-05-31 00:00:00'),
(478, 36, 'bo 5 dung-cu-cat-tia (1).png', '/images/uploads/products/bo-5-dung-cu-cat-tia-cay-canh/bo 5 dung-cu-cat-tia (1).png', 'Bộ 5 Dụng Cụ Cắt Tỉa Cây Cảnh', 1, 1, 1, '2026-05-31 00:00:00'),
(496, 37, 'bo-dao-cat-tia-8373.png', '/images/uploads/products/bo-dao-cat-tia/bo-dao-cat-tia-8373.png', 'Bộ Dao Cắt Tỉa Cây Cảnh, Hoa Quả 14 Món RDEER', 1, 1, 1, '2026-05-31 00:00:00'),
(500, 38, 'bo-lam-vuon-4-mon-s2 (1).png', '/images/uploads/products/bo-dung-cu-lam-vuon-4-mon/bo-lam-vuon-4-mon-s2 (1).png', 'Bộ Dụng Cụ Làm Vườn 4 Món - Nhiều Size Kích Thước', 1, 1, 1, '2026-05-31 00:00:00'),
(520, 39, 'bo-voi-tuoi-cay-lionking-1-4820_1.jpg', '/images/uploads/products/bo-voi-tuoi-cay-da-nang-lionking-8-che-do/bo-voi-tuoi-cay-lionking-1-4820_1.jpg', 'Bộ Vòi Tưới Cây Đa Năng LIONKING 8 Chế Độ', 1, 1, 1, '2026-05-31 00:00:00'),
(530, 40, 'bot-phan-kien-vipesco-1402.png', '/images/uploads/products/bot-phan-kien-vipesco/bot-phan-kien-vipesco-1402.png', 'Bột Phấn Kiến VIPESCO - Gói 50g', 1, 1, 1, '2026-05-31 00:00:00'),
(542, 41, 'green killer,.png', '/images/uploads/products/bot-tru-kien-gian-green-killer-powder/green killer,.png', 'Bột Trừ Kiến - Gián Green Killer Powder', 1, 1, 1, '2026-05-31 00:00:00'),
(557, 42, 'cam bi nhật,.png', '/images/uploads/products/cam-bi-nhat/cam bi nhật,.png', 'CAM BI NHẬT - Phân Bón Lá Trung Vi Lượng', 1, 1, 1, '2026-05-31 00:00:00'),
(569, 43, 'canon 100sl,,.png', '/images/uploads/products/canon-100sl-thuoc-dac-tri-bo-tri/canon 100sl,,.png', 'CANON 100SL – Thuốc Đặc Trị Bọ Trĩ', 1, 1, 1, '2026-05-31 00:00:00'),
(580, 44, 'canxi nitrat haifa,,.png', '/images/uploads/products/canxi-nitrat-cano32-15-0-0-26-cao/canxi nitrat haifa,,.png', 'CANXI NITRAT | Ca(NO3)2 15-0-0+26 CaO', 1, 1, 1, '2026-05-31 00:00:00'),
(591, 45, 'champion-1455.png', '/images/uploads/products/champion-77wp-thuoc-tru-benh-nam-hong-va-than-thu/champion-1455.png', 'Champion 77WP - Thuốc Trừ Bệnh Nấm Hồng Và Thán Thư', 1, 1, 1, '2026-05-31 00:00:00'),
(654, 50, 'chau-meo-1-5883.png', '/images/uploads/products/chau-meo-de-thuong-chau-trong-thuy-sinh/chau-meo-1-5883.png', 'Chậu Mèo Dễ Thương - Chậu Trồng Thủy Sinh', 1, 1, 1, '2026-05-31 00:00:00'),
(672, 51, 'chau-nhua-tron-tron-1-3726.png', '/images/uploads/products/chau-nhua-treo-tron-tron/chau-nhua-tron-tron-1-3726.png', 'Chậu Nhựa Treo Tròn Trơn - Chậu Treo Trồng Cây', 1, 1, 1, '2026-05-31 00:00:00'),
(682, 52, 'chau-to-ong-1-9648_1.png', '/images/uploads/products/chau-nhua-treo-to-ong/chau-to-ong-1-9648_1.png', 'Chậu Nhựa Treo Tổ Ong', 1, 1, 1, '2026-05-31 00:00:00'),
(692, 53, 'chau-dan-may-4111.png', '/images/uploads/products/chau-nhua-treo-dan-may-chau-nhua-treo-ban-cong/chau-dan-may-4111.png', 'Chậu Nhựa Treo Đan Mây - Chậu Nhựa Treo Ban Công', 1, 1, 1, '2026-05-31 00:00:00'),
(710, 54, 'chau-nhua-trong-cay-du-mau-5358_1.jpg', '/images/uploads/products/chau-nhua-trong-cay-mini/chau-nhua-trong-cay-du-mau-5358_1.jpg', 'Chậu Nhựa Trồng Cây Đủ Màu - Size 7x7x8', 1, 1, 1, '2026-05-31 00:00:00'),
(712, 55, 'chau-nan (1).png', '/images/uploads/products/chau-nhua-trong-lan-chau-nhua-nan-den/chau-nan (1).png', 'Chậu Nhựa Trồng Lan - Chậu Nhựa Nan Giả Gỗ', 1, 1, 1, '2026-05-31 00:00:00'),
(726, 56, 'chau-mini-kem-dia (1).png', '/images/uploads/products/chau-nhua-vuong-mini-kem-dia-chau-nhua-nhieu-mau/chau-mini-kem-dia (1).png', 'Chậu Nhựa Vuông Mini Kèm Đĩa - Chậu Nhựa Nhiều Màu', 1, 1, 1, '2026-05-31 00:00:00'),
(738, 57, 'chau-nhua-den-f10-8827.jpg', '/images/uploads/products/chau-nhua-den-trong-lan/chau-nhua-den-f10-8827.jpg', 'Chậu Nhựa Đen Trồng Lan size F10 - F28', 1, 1, 1, '2026-05-31 00:00:00'),
(758, 58, 'pet one (1).png', '/images/uploads/products/che-pham-diet-con-trung-chloxam-hieu-pet-one/pet one (1).png', 'Chế Phẩm Diệt Côn Trùng CHLOXAM 350SC Hiệu PET ONE', 1, 1, 1, '2026-05-31 00:00:00'),
(798, 61, 'bio-b (2).png', '/images/uploads/products/che-pham-sinh-hoc-bio-b/bio-b (2).png', 'Chế Phẩm Sinh Học BIO-B _ Phòng Trừ Bọ Trĩ, Nhện Đỏ, Sâu Rầy', 1, 1, 1, '2026-05-31 00:00:00'),
(851, 65, 'duoi-ruoi-vang-1493_1.png', '/images/uploads/products/che-pham-vi-sinh-xua-duoi-ruoi-vang-sieu-dam-dac/duoi-ruoi-vang-1493_1.png', 'Chế Phẩm Vi Sinh Xua Đuổi Ruồi Vàng Siêu Đậm Đặc', 1, 1, 1, '2026-05-31 00:00:00'),
(862, 66, 'citizen 777.png', '/images/uploads/products/citizen-777-thuoc-dac-tri-nam-benh-khuan-cho-lan-cay-canh/citizen 777.png', 'CITIZEN 777 - Thuốc đặc trị nấm bệnh, khuẩn cho lan, cây cảnh', 1, 1, 1, '2026-05-31 00:00:00'),
(875, 67, 'coc85-1297_1.png', '/images/uploads/products/coc-85wp-thuoc-tru-nam-vi-khuan/coc85-1297_1.png', 'COC 85WP – Thuốc Trừ Nấm, Vi Khuẩn', 1, 1, 1, '2026-05-31 00:00:00'),
(888, 68, '50mlnn-5187.jpg', '/images/uploads/products/confidor-200sl/50mlnn-5187.jpg', 'Confidor 200SL - Thuốc Trị Bọ Trĩ', 1, 1, 1, '2026-05-31 00:00:00'),
(902, 69, 'day-buoc-lan-2600.png', '/images/uploads/products/cuon-day-buoc-lan-co-luoi-cat-loi-kem-boc-nhua/day-buoc-lan-2600.png', 'Cuộn Dây Buộc Lan - Có Lưỡi Cắt - Lõi Kẽm Bọc Nhựa', 1, 1, 1, '2026-05-31 00:00:00'),
(916, 70, 'cào inox,,,.png', '/images/uploads/products/cao-inox-15-rang-cao-rac-la-cay/cào inox,,,.png', 'Cào Inox 15 Răng Cào Rác - Lá Cây', 1, 1, 1, '2026-05-31 00:00:00'),
(930, 71, 'cua-cam-tay-can-go (1).png', '/images/uploads/products/cua-cam-tay-can-go-cua-go/cua-cam-tay-can-go (1).png', 'Cưa Cầm Tay Cán Gỗ - Cưa Gỗ, Cưa Cành Cây Các Loại', 1, 1, 1, '2026-05-31 00:00:00'),
(960, 73, 'cua-cam-tay-8874.png', '/images/uploads/products/cua-cam-tay-can-nhua-mini-cua-lach-cua-canh-go/cua-cam-tay-8874.png', 'Cưa Cầm Tay Cán Nhựa Mini - Cưa Lách, Cưa Cành Gỗ', 1, 1, 1, '2026-05-31 00:00:00'),
(989, 75, 'can-rut (2).png', '/images/uploads/products/can-phun-inox-can-rut-co-the-keo-dai-1m5-3m/can-rut (2).png', 'Cần Phun Inox | Cần Rút Có Thể Kéo Dài 1m5 - 3m', 1, 1, 1, '2026-05-31 00:00:00'),
(1003, 76, '5a37e4220f3e418aa611d40501210d34-8385_1.jpg', '/images/uploads/products/can-phun-dien-tu-dong/5a37e4220f3e418aa611d40501210d34-8385_1.jpg', 'Cần Phun Tích Điện Tự Động', 1, 1, 1, '2026-05-31 00:00:00'),
(1019, 77, 'can-inox50-2402.png', '/images/uploads/products/can-phun-xit-inox-dung-cho-binh-phun-xit-thuoc-dai50100cm/can-inox50-2402.png', 'Cần Phun Xịt Inox Dùng Cho Bình Phun Xịt Thuốc Dài 50/100cm', 1, 1, 1, '2026-05-31 00:00:00'),
(1078, 81, 'coc-dieu-hoa-4039.jpg', '/images/uploads/products/coc-dieu-hoa-trong-lan/coc-dieu-hoa-4039.jpg', 'Cốc Điều Hòa Trồng Lan', 1, 1, 1, '2026-05-31 00:00:00'),
(1096, 83, 'daconil-500sc-100ml-3534_1.jpg', '/images/uploads/products/daconil-500sc-thuoc-tru-benh-nhat-ban/daconil-500sc-100ml-3534_1.jpg', 'Daconil 500SC - Thuốc Trừ Bệnh Nhật Bản', 1, 1, 1, '2026-05-31 00:00:00'),
(1107, 84, 'daconil 75wp,,...png', '/images/uploads/products/daconil-75wp-thuoc-tru-benh-nhat-ban-chinh-hieu/daconil 75wp,,...png', 'Daconil 75WP - Thuốc Trừ Bệnh Nhật Bản Chính Hiệu', 1, 1, 1, '2026-05-31 00:00:00'),
(1168, 89, 'day-nhom-ma-dong-1032.png', '/images/uploads/products/day-nhom-ma-dong-uon-cay-bon-sai-va-hoa-lan/day-nhom-ma-dong-1032.png', 'Dây Nhôm Mạ Đồng Uốn Cây Bon Sai Và Hoa Lan', 1, 1, 1, '2026-05-31 00:00:00'),
(1180, 90, 'sk enspray (1).png', '/images/uploads/products/dau-khoang-sk-enspray-99ec-dac-tri-nhen-do/sk enspray (1).png', 'Dầu Khoáng SK EnSpray 99EC Đặc Trị Nhện Đỏ', 1, 1, 1, '2026-05-31 00:00:00'),
(1193, 91, 'mau-tru-muoi-vipesco-1485.png', '/images/uploads/products/dau-tru-muoi-vipesco-thuoc-diet-tru-muoi-va-con-trung/mau-tru-muoi-vipesco-1485.png', 'Dầu Trừ Muỗi Vipesco | Thuốc Diệt Trừ Muỗi Và Côn Trùng', 1, 1, 1, '2026-05-31 00:00:00'),
(1204, 92, 'amino-combi-8941_1.png', '/images/uploads/products/dau-tru-moi-m-4-12sl/amino-combi-8941_1.png', 'Dầu Trừ Mối M-4 1.2SL', 1, 1, 1, '2026-05-31 00:00:00'),
(1476, 114, 'bí nụ..jpg', '/images/uploads/products/hat-giong-bi-sieu-nu/bí nụ..jpg', 'Hạt Giống Bí Siêu Nụ Lai F1 Rạng Đông - GITA 33', 1, 1, 1, '2026-05-31 00:00:00'),
(1484, 115, 'bap-ngot-4246.jpg', '/images/uploads/products/hat-giong-bap-ngot/bap-ngot-4246.jpg', 'Hạt Giống Bắp Ngọt Rạng Đông - RADO 236', 1, 1, 1, '2026-05-31 00:00:00'),
(1492, 116, 'bap-nep-cam-3423.jpg', '/images/uploads/products/hat-giong-bap-nep-deo/bap-nep-cam-3423.jpg', 'Hạt Giống Bắp Nếp Dẻo Rạng Đông - Cẩm Nông', 1, 1, 1, '2026-05-31 00:00:00'),
(1500, 117, 'cà tím..jpg', '/images/uploads/products/hat-giong-ca-tim/cà tím..jpg', 'Hạt Giống Cà Tím Rạng Đông - RADO 205', 1, 1, 1, '2026-05-31 00:00:00'),
(1508, 118, 'cải bẹ xanh..jpg', '/images/uploads/products/hat-giong-cai-be-xanh-mo/cải bẹ xanh..jpg', 'Hạt Giống Cải Bẹ Xanh Mỡ Rạng Đông - RADO 57', 1, 1, 1, '2026-05-31 00:00:00'),
(1516, 119, 'cay-cai-ngot-3188.jpg', '/images/uploads/products/hat-giong-cai-ngot-rang-dong/cay-cai-ngot-3188.jpg', 'Hạt Giống Cải Ngọt Rạng Đông - RADO 54', 1, 1, 1, '2026-05-31 00:00:00'),
(1525, 120, 'hạt cải thìa rado 77,,.png', '/images/uploads/products/hat-giong-cai-thia/hạt cải thìa rado 77,,.png', 'Hạt Giống Cải Thìa - RADO 77 Rạng Đông', 1, 1, 1, '2026-05-31 00:00:00'),
(1536, 121, 'mau-rau-den-do-2013.png', '/images/uploads/products/hat-giong-den-do/mau-rau-den-do-2013.png', 'Hạt Giống Dền Đỏ Rạng Đông - RADO 15', 1, 1, 1, '2026-05-31 00:00:00'),
(1547, 122, 'hành lá..jpg', '/images/uploads/products/hat-giong-hanh-huong-chiu-nhiet/hành lá..jpg', 'Hạt Giống Hành Hương Chịu Nhiệt Rạng Đông - RADO 215', 1, 1, 1, '2026-05-31 00:00:00'),
(1555, 123, 'cay-kho-qua-1415.jpg', '/images/uploads/products/hat-giong-kho-qua/cay-kho-qua-1415.jpg', 'Hạt Giống Khổ Qua Lai F1', 1, 1, 1, '2026-05-31 00:00:00'),
(1563, 124, 'mang-tay-2596.jpg', '/images/uploads/products/hat-giong-mang-tay-xanh/mang-tay-2596.jpg', 'Hạt Giống Măng Tây Xanh Rạng Đông - RADO 636', 1, 1, 1, '2026-05-31 00:00:00'),
(1571, 125, 'hat-giong-muop-huong-xanh-lai-f1-rang-dong-5217_1.jpg', '/images/uploads/products/hat-giong-muop-xanh/hat-giong-muop-huong-xanh-lai-f1-rang-dong-5217_1.jpg', 'Hạt Giống Mướp Xanh Lai F1 Rạng Đông - RADO 39', 1, 1, 1, '2026-05-31 00:00:00'),
(1580, 126, 'cay-mong-toi-5628.jpg', '/images/uploads/products/hat-giong-mong-toi-rang-dong/cay-mong-toi-5628.jpg', 'Hạt Giống Mồng Tơi Rạng Đông - RADO 38', 1, 1, 1, '2026-05-31 00:00:00'),
(1589, 127, 'den-com-10g-8175_1.jpg', '/images/uploads/products/hat-giong-rau-den-com-rado-86/den-com-10g-8175_1.jpg', 'Hạt Giống Rau Dền Cơm - RADO 86', 1, 1, 1, '2026-05-31 00:00:00'),
(1594, 128, 'mau-hat-rau-muong-la-tre-7784.jpg', '/images/uploads/products/hat-giong-rau-muong-la-tre/mau-hat-rau-muong-la-tre-7784.jpg', 'Hạt Giống Rau Muống Lá Tre Rạng Đông - RADO 12', 1, 1, 1, '2026-05-31 00:00:00'),
(1602, 129, 'hat-giong-rau-ma-la-nho-1g-9019_1.jpg', '/images/uploads/products/hat-giong-rau-ma-la-nho/hat-giong-rau-ma-la-nho-1g-9019_1.jpg', 'Hạt Giống Rau Má Lá Nhỏ Rạng Đông', 1, 1, 1, '2026-05-31 00:00:00'),
(1610, 130, 'cay-rau-ngot-1281.jpg', '/images/uploads/products/hat-giong-rau-ngot/cay-rau-ngot-1281.jpg', 'Hạt Giống Rau Ngót Rạng Đông - RADO 621', 1, 1, 1, '2026-05-31 00:00:00'),
(1619, 131, 'mau-hat-thi-la-1625.jpg', '/images/uploads/products/hat-giong-rau-thi-la/mau-hat-thi-la-1625.jpg', 'Hạt Giống Rau Thì Là Rạng Đông - RADO 06', 1, 1, 1, '2026-05-31 00:00:00'),
(1627, 132, 'cay-rau-day-4688.jpg', '/images/uploads/products/hat-giong-rau-day-do-rang-dong-rado-88/cay-rau-day-4688.jpg', 'Hạt Giống Rau Đay Đỏ-Rạng Đông-RADO 88', 1, 1, 1, '2026-05-31 00:00:00'),
(1635, 133, 'h-hoa-sen-mini-2560_1.jpg', '/images/uploads/products/hat-giong-sen-mini-nhieu-mau-rang-dong-rd-846/h-hoa-sen-mini-2560_1.jpg', 'Hạt Giống Sen mini Nhiều Màu - Rạng Đông - RD 846', 1, 1, 1, '2026-05-31 00:00:00'),
(1645, 134, 'cay-tia-to-4227.jpg', '/images/uploads/products/hat-giong-tia-to-nhat/cay-tia-to-4227.jpg', 'Hạt Giống Tía Tô Nhật Rạng Đông - SHISO 113', 1, 1, 1, '2026-05-31 00:00:00'),
(1653, 135, 'hạt tần ô rado123,,.png', '/images/uploads/products/hat-giong-tan-o/hạt tần ô rado123,,.png', 'Hạt Giống Tần Ô Rạng Đông - RADO 123', 1, 1, 1, '2026-05-31 00:00:00'),
(1664, 136, 'mau-hat-xa-lach-bup-2050.jpg', '/images/uploads/products/hat-giong-xa-lach-bup-rang-dong-rado-45/mau-hat-xa-lach-bup-2050.jpg', 'Hạt Giống Xà Lách Búp Rạng Đông - RADO 45', 1, 1, 1, '2026-05-31 00:00:00'),
(1680, 138, 'du-du-lun-3750.jpg', '/images/uploads/products/hat-giong-du-du-lun-lai-f1-rang-dong/du-du-lun-3750.jpg', 'Hạt Giống Đu Đủ Lùn lai F1 Rạng Đông', 1, 1, 1, '2026-05-31 00:00:00'),
(1688, 139, 'cay-dau-bap-6589.jpg', '/images/uploads/products/hat-giong-dau-bap-rang-dong/cay-dau-bap-6589.jpg', 'Hạt Giống Đậu Bắp Rạng Đông - RADO 60', 1, 1, 1, '2026-05-31 00:00:00'),
(5303, 418, 'da-tran-chau-perlite (2).png', '/images/uploads/products/da-tran-chau-perlite-da-tran-chau-trang/da-tran-chau-perlite (2).png', 'Đá Trân Châu Perlite - Đá Trân Châu Trắng', 1, 1, 1, '2026-05-31 00:00:00'),
(5385, 424, 'dau-keo-cat-canh-tren-cao-7485_1.png', '/images/uploads/products/dau-keo-cat-canh-tren-cao-rhb/dau-keo-cat-canh-tren-cao-7485_1.png', 'Đầu Kéo Cắt Cành Trên Cao RHB', 1, 1, 1, '2026-05-31 00:00:00'),
(5480, 431, 'chong-rung-hoa-mai-300x300.jpg', '/images/uploads/products/chat-chong-rung-bong-super-mai-lan-hoa/chong-rung-hoa-mai-300x300.jpg', 'Chất Chống Rụng Bông Super Mai - Lan - Hoa', 1, 1, 1, '2026-06-01 03:29:28'),
(5481, 432, 'chong-rung-hoa-dhct (1).png', '/images/uploads/products/chat-chong-rung-canh-hoa-dhct-phan-bon-giu-hoa-lau-tan/chong-rung-hoa-dhct (1).png', 'Chất Chống Rụng Cánh Hoa ĐHCT - Phân Bón Giữ Hoa Lâu Tàn', 1, 1, 1, '2026-06-01 03:29:29'),
(5482, 433, 'logo rvac.png', '/images/uploads/products/chat-gay-rung-la-mai-rvac-fofer-x3/logo rvac.png', 'Chất Gây Rụng lá Mai RVAC FOFER X3', 1, 1, 1, '2026-06-01 03:29:29'),
(5483, 434, 'chat-gay-rung-la-mai-dai-hoc-can-tho-6273_1.jpg', '/images/uploads/products/chat-gay-rung-la-mai-dai-hoc-can-tho/chat-gay-rung-la-mai-dai-hoc-can-tho-6273_1.jpg', 'Chất Gây Rụng Lá Mai Đại Học Cần Thơ', 1, 1, 1, '2026-06-01 03:29:29'),
(5484, 435, 'che-pham-hung-nguyen-2018.png', '/images/uploads/products/che-pham-hung-nguyen-kich-re-kich-kei/che-pham-hung-nguyen-2018.png', 'Chế Phẩm Hùng Nguyễn - Kích Rễ, Kích Kei', 1, 1, 1, '2026-06-01 03:29:29'),
(5485, 436, 'mau-trichoderma-sfarm-5694.png', '/images/uploads/products/che-pham-nam-doi-khang-trichoderma-plus-humic-sfarm/mau-trichoderma-sfarm-5694.png', 'Chế Phẩm Nấm Đối Kháng Trichoderma Plus Humic Sfarm', 1, 1, 1, '2026-06-01 03:29:29'),
(5486, 437, 'che-pham-than-nu-la-mit-3294.png', '/images/uploads/products/che-pham-than-nu-la-mit/che-pham-than-nu-la-mit-3294.png', 'Chế Phẩm Thân Nù Lá Mít', 1, 1, 1, '2026-06-01 03:29:29'),
(5487, 438, 'emzeo-5470.png', '/images/uploads/products/che-pham-vi-sinh-emzeo-xu-ly-chat-thai-huu-co/emzeo-5470.png', 'Chế phẩm vi sinh EMZEO - Xử Lý Chất Thải Hữu Cơ', 1, 1, 1, '2026-06-01 03:29:29'),
(5488, 439, 'dithane-3894.png', '/images/uploads/products/dithane-m45-80wp-thuoc-tru-nam-benh/dithane-3894.png', 'Dithane M45 80WP- Thuốc Trừ Nấm Bệnh', 1, 1, 1, '2026-06-01 03:29:29');
-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_image_type`
--

CREATE TABLE `product_image_type` (
  `ImageTypeID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_image_type`
--

INSERT INTO `product_image_type` (`ImageTypeID`, `Name`) VALUES
(1, 'Thumbnail'),
(2, 'Gallery');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_status`
--

CREATE TABLE `product_status` (
  `StatusID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL COMMENT 'Tên trạng thái: Còn hàng, Hết hàng, Ngừng kinh doanh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_status`
--

INSERT INTO `product_status` (`StatusID`, `Name`) VALUES
(1, 'Còn hàng'),
(2, 'Không có hàng'),
(3, 'Sắp hết hàng'),
(4, 'Ngừng kinh doanh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_unit`
--

CREATE TABLE `product_unit` (
  `PUnitID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL COMMENT 'Tên đơn vị tính: Kg, Bao, Lít...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_unit`
--

INSERT INTO `product_unit` (`PUnitID`, `Name`) VALUES
(1, 'Kg'),
(2, 'Bao'),
(3, 'Chai'),
(4, 'Gói'),
(5, 'Hộp'),
(6, 'Can');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `profiles`
--

CREATE TABLE `profiles` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `gender` enum('male','female','other','hidden') DEFAULT 'hidden',
  `avatar_url` varchar(255) DEFAULT 'default-avatar.png',
  `address` text,
  `date_of_birth` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `full_name`, `phone_number`, `gender`, `avatar_url`, `address`, `date_of_birth`, `created_at`, `updated_at`) VALUES
(1, 1, 'Quản trị hệ thống', '0901000001', 'other', 'default-avatar.png', 'Cần Thơ', '1995-01-01', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(2, 2, 'Nhân viên kinh doanh 01', '0901000002', 'male', 'default-avatar.png', 'TP. Hồ Chí Minh', '1998-03-12', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(3, 3, 'Nguyễn Văn Minh', '0901000003', 'male', 'default-avatar.png', 'Gò Vấp, TP.HCM', '1990-05-20', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(4, 4, 'Trần Thị Thanh', '0901000004', 'female', 'default-avatar.png', 'Bình Thạnh, TP.HCM', '1992-08-15', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(5, 5, 'Lê Quốc Huy', '0901000005', 'male', 'default-avatar.png', 'Thủ Đức, TP.HCM', '1988-11-03', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(6, 6, 'Nhân viên kho 01', '0901000006', 'male', 'default-avatar.png', 'Cần Thơ', '1997-02-22', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(7, 7, 'Nhân viên kho 02', '0901000007', 'female', 'default-avatar.png', 'Cần Thơ', '1999-07-09', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(8, 8, 'Phạm Thị Ngọc Anh', '0901000008', 'female', 'default-avatar.png', 'Quận 12, TP.HCM', '1993-04-18', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(9, 9, 'Hoàng Minh Khang', '0901000009', 'male', 'default-avatar.png', 'Tân Bình, TP.HCM', '1991-12-25', '2026-05-12 11:04:14', '2026-05-21 03:37:46'),
(15, 20, 'Đặng Thị Tuyết Trinh', '0398820296', 'female', 'default-avatar.png', 'Cần Thơ', '2004-04-04', '2026-05-18 07:21:20', '2026-05-18 07:21:20'),
(16, 21, 'Quản lý sản phẩm 01', '0901000021', 'other', 'default-avatar.png', 'Cần Thơ', '1996-06-06', '2026-05-21 03:37:46', '2026-05-21 03:37:46'),
(39, 33, 'Tú Võ', '0398820259', 'female', 'default-avatar.png', '4418, Xã Thạnh An, Huyện Vĩnh Thạnh, Thành phố Cần Thơ', '2026-05-21', '2026-05-21 07:59:38', '2026-05-24 04:45:50'),
(40, 34, 'Tú Như', '0353091877', 'female', 'default-avatar.png', '156, Xã Tân An Luông, Huyện Vũng Liêm, Tỉnh Vĩnh Long', '2004-11-18', '2026-05-24 04:49:20', '2026-05-24 04:49:20');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `purchase_order_id` int NOT NULL COMMENT 'Khóa chính của phiếu yêu cầu nhập hàng',
  `po_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mã phiếu yêu cầu nhập hàng, ví dụ PO001',
  `supplier_id` int NOT NULL COMMENT 'Nhà cung cấp được chọn cho phiếu yêu cầu nhập hàng',
  `created_by` int NOT NULL COMMENT 'Người tạo phiếu yêu cầu nhập hàng, thường là nhân viên kho',
  `approved_by` int DEFAULT NULL COMMENT 'Người duyệt phiếu yêu cầu nhập hàng, thường là ban giám đốc',
  `updated_by` int DEFAULT NULL COMMENT 'Người cập nhật phiếu yêu cầu nhập hàng gần nhất',
  `status_id` int NOT NULL COMMENT 'Trạng thái hiện tại của phiếu, liên kết với bảng purchase_order_statuses',
  `email_status` enum('NOT_SENT','SENT','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'NOT_SENT',
  `email_sent_at` datetime DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL COMMENT 'Ngày dự kiến nhà cung cấp giao hàng',
  `total_amount` decimal(15,2) DEFAULT '0.00' COMMENT 'Tổng giá trị dự kiến của phiếu yêu cầu nhập hàng',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú thêm cho phiếu yêu cầu nhập hàng',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm tạo phiếu yêu cầu nhập hàng',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời điểm cập nhật phiếu yêu cầu nhập hàng gần nhất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_orders`
--

INSERT INTO `purchase_orders` (`purchase_order_id`, `po_code`, `supplier_id`, `created_by`, `approved_by`, `updated_by`, `status_id`, `email_status`, `email_sent_at`, `expected_delivery_date`, `total_amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'PO-2026-001', 1, 2, NULL, 2, 1, 'NOT_SENT', NULL, '2026-06-01', 31000000.00, 'Nhân viên kho tạo phiếu yêu cầu nhập hàng do tồn kho sắp hết', '2026-05-18 08:25:07', '2026-05-18 08:25:50'),
(2, 'PO-2026-002', 2, 2, 1, 1, 2, 'NOT_SENT', NULL, '2026-06-05', 36000000.00, 'Phiếu nhập phân bón đã được ban giám đốc duyệt', '2026-05-18 08:25:18', '2026-05-18 08:25:50'),
(3, 'PO-2026-003', 3, 2, 1, 2, 4, 'NOT_SENT', NULL, '2026-06-10', 7600000.00, 'Nhà cung cấp mới giao một phần thuốc BVTV', '2026-05-18 08:25:27', '2026-05-18 08:25:50'),
(4, 'PO-20260522-2740', 7, 21, NULL, 21, 5, 'NOT_SENT', NULL, '2026-04-30', 50000.00, NULL, '2026-05-22 16:16:09', '2026-05-23 06:40:57'),
(5, 'PO-20260522-7576', 5, 21, NULL, 21, 5, 'SENT', '2026-05-22 16:29:47', '2026-05-24', 200000.00, NULL, '2026-05-22 16:29:42', '2026-05-23 06:29:01'),
(6, 'PO-20260523-5205', 5, 21, NULL, 21, 5, 'SENT', '2026-05-23 07:18:51', '2026-05-24', 3000000000.00, NULL, '2026-05-23 07:18:47', '2026-05-24 05:56:58'),
(7, 'PO-20260523-3286', 5, 21, NULL, 21, 5, 'SENT', '2026-05-23 07:18:53', '2026-05-24', 3000000000.00, NULL, '2026-05-23 07:18:49', '2026-05-23 07:20:02'),
(8, 'PO-20260523-3165', 5, 21, NULL, 21, 5, 'SENT', '2026-05-23 08:06:38', '2026-05-24', 50000000.00, NULL, '2026-05-23 08:06:34', '2026-05-23 08:08:33'),
(9, 'PO-20260524-3934', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:15:30', NULL, 0.00, NULL, '2026-05-24 06:15:25', '2026-05-24 06:15:59'),
(10, 'PO-20260524-8322', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:26:59', NULL, 1000000.00, NULL, '2026-05-24 06:26:54', '2026-05-24 06:27:53'),
(11, 'PO-20260524-1967', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:31:27', '2026-05-25', 1000000.00, NULL, '2026-05-24 06:31:23', '2026-05-24 06:31:57'),
(12, 'PO-20260524-7107', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:34:34', NULL, 100000.00, NULL, '2026-05-24 06:34:30', '2026-05-24 06:38:03'),
(13, 'PO-20260524-7957', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:34:35', NULL, 100000.00, NULL, '2026-05-24 06:34:31', '2026-05-24 06:34:54'),
(14, 'PO-20260524-2300', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:39:59', NULL, 1000000.00, NULL, '2026-05-24 06:39:55', '2026-05-24 06:44:52'),
(15, 'PO-20260524-6918', 5, 21, NULL, 21, 5, 'SENT', '2026-05-24 06:40:03', NULL, 1000000.00, NULL, '2026-05-24 06:39:58', '2026-05-24 06:40:20'),
(16, 'PO-20260529-1739', 5, 21, NULL, 21, 3, 'SENT', '2026-05-29 04:39:24', '2026-05-29', 10600000.00, NULL, '2026-05-29 04:39:14', '2026-05-29 04:39:24');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_order_details`
--

CREATE TABLE `purchase_order_details` (
  `purchase_order_detail_id` int NOT NULL COMMENT 'Khóa chính của chi tiết phiếu yêu cầu nhập hàng',
  `purchase_order_id` int NOT NULL COMMENT 'Phiếu yêu cầu nhập hàng mà dòng chi tiết này thuộc về',
  `product_id` int NOT NULL COMMENT 'Sản phẩm cần nhập trong phiếu yêu cầu nhập hàng',
  `ordered_quantity` int NOT NULL COMMENT 'Số lượng sản phẩm dự kiến đặt nhập từ nhà cung cấp',
  `received_quantity` int DEFAULT '0' COMMENT 'Số lượng sản phẩm đã thực nhận vào kho',
  `unit_price` decimal(15,2) NOT NULL COMMENT 'Đơn giá nhập dự kiến của sản phẩm',
  `total_price` decimal(15,2) GENERATED ALWAYS AS ((`ordered_quantity` * `unit_price`)) VIRTUAL COMMENT 'Thành tiền dự kiến, tự tính bằng số lượng đặt nhân đơn giá',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú thêm cho dòng sản phẩm cần nhập',
  `created_by` int DEFAULT NULL COMMENT 'Người thêm dòng sản phẩm vào phiếu yêu cầu nhập hàng',
  `updated_by` int DEFAULT NULL COMMENT 'Người cập nhật dòng sản phẩm gần nhất',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm thêm dòng sản phẩm vào phiếu',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời điểm cập nhật dòng sản phẩm gần nhất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_order_details`
--

INSERT INTO `purchase_order_details` (`purchase_order_detail_id`, `purchase_order_id`, `product_id`, `ordered_quantity`, `received_quantity`, `unit_price`, `note`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 4, 72, 1, 1, 50000.00, NULL, 21, 21, '2026-05-22 16:16:09', '2026-05-23 06:40:57'),
(2, 5, 73, 4, 4, 50000.00, NULL, 21, 21, '2026-05-22 16:29:42', '2026-05-23 06:29:01'),
(3, 6, 76, 2000, 2000, 500000.00, NULL, 21, 21, '2026-05-23 07:18:47', '2026-05-24 05:56:58'),
(4, 6, 51, 1000000, 1000000, 2000.00, NULL, 21, 21, '2026-05-23 07:18:47', '2026-05-24 05:56:58'),
(5, 7, 76, 2000, 2000, 500000.00, NULL, 21, 21, '2026-05-23 07:18:49', '2026-05-23 07:20:02'),
(6, 7, 51, 1000000, 1000000, 2000.00, NULL, 21, 21, '2026-05-23 07:18:49', '2026-05-23 07:20:02'),
(7, 8, 6, 5000, 5000, 10000.00, NULL, 21, 21, '2026-05-23 08:06:34', '2026-05-23 08:08:33'),
(8, 9, 76, 50, 50, 0.00, NULL, 21, 21, '2026-05-24 06:15:25', '2026-05-24 06:15:59'),
(9, 10, 76, 50, 50, 20000.00, NULL, 21, 21, '2026-05-24 06:26:54', '2026-05-24 06:27:53'),
(10, 11, 76, 50, 50, 20000.00, NULL, 21, 21, '2026-05-24 06:31:23', '2026-05-24 06:31:57'),
(11, 12, 76, 50, 50, 2000.00, NULL, 21, 21, '2026-05-24 06:34:30', '2026-05-24 06:38:03'),
(12, 13, 76, 50, 50, 2000.00, NULL, 21, 21, '2026-05-24 06:34:31', '2026-05-24 06:34:54'),
(13, 14, 76, 50, 50, 20000.00, NULL, 21, 21, '2026-05-24 06:39:55', '2026-05-24 06:44:52'),
(14, 15, 76, 50, 50, 20000.00, NULL, 21, 21, '2026-05-24 06:39:58', '2026-05-24 06:40:20'),
(15, 16, 95, 10, 0, 107500.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(16, 16, 97, 10, 0, 77500.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(17, 16, 98, 10, 0, 105000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(18, 16, 93, 10, 0, 82500.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(19, 16, 99, 10, 0, 115000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(20, 16, 91, 10, 0, 160000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(21, 16, 96, 10, 0, 62500.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(22, 16, 100, 10, 0, 155000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(23, 16, 94, 10, 0, 105000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14'),
(24, 16, 92, 10, 0, 90000.00, NULL, 21, 21, '2026-05-29 04:39:14', '2026-05-29 04:39:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_order_statuses`
--

CREATE TABLE `purchase_order_statuses` (
  `status_id` int NOT NULL COMMENT 'Khóa chính của bảng trạng thái phiếu yêu cầu nhập hàng',
  `status_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mã trạng thái dùng trong hệ thống, ví dụ PENDING, APPROVED, COMPLETED',
  `status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tên trạng thái hiển thị cho người dùng',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Mô tả ý nghĩa của trạng thái phiếu yêu cầu nhập hàng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_order_statuses`
--

INSERT INTO `purchase_order_statuses` (`status_id`, `status_code`, `status_name`, `description`) VALUES
(1, 'PENDING', 'Chờ duyệt', 'Phiếu yêu cầu nhập hàng đang chờ ban giám đốc duyệt'),
(2, 'APPROVED', 'Đã duyệt', 'Phiếu đã được duyệt và có thể tiến hành đặt hàng'),
(3, 'ORDERED', 'Đã đặt hàng', 'Đã gửi đơn đặt hàng đến nhà cung cấp'),
(4, 'PARTIAL_RECEIVED', 'Nhập một phần', 'Nhà cung cấp mới giao một phần hàng'),
(5, 'COMPLETED', 'Hoàn tất', 'Đã nhập đủ hàng theo phiếu yêu cầu'),
(6, 'REJECTED', 'Từ chối', 'Phiếu yêu cầu nhập hàng bị từ chối'),
(7, 'CANCELLED', 'Đã hủy', 'Phiếu yêu cầu nhập hàng đã bị hủy');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_order_status_logs`
--

CREATE TABLE `purchase_order_status_logs` (
  `log_id` int NOT NULL COMMENT 'Khóa chính của log thay đổi trạng thái phiếu yêu cầu nhập hàng',
  `purchase_order_id` int NOT NULL COMMENT 'Phiếu yêu cầu nhập hàng được thay đổi trạng thái',
  `old_status_id` int DEFAULT NULL COMMENT 'Trạng thái cũ trước khi thay đổi',
  `new_status_id` int NOT NULL COMMENT 'Trạng thái mới sau khi thay đổi',
  `changed_by` int DEFAULT NULL COMMENT 'Người thực hiện thay đổi trạng thái',
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm thay đổi trạng thái',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú lý do hoặc nội dung thay đổi trạng thái'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `purchase_order_status_logs`
--

INSERT INTO `purchase_order_status_logs` (`log_id`, `purchase_order_id`, `old_status_id`, `new_status_id`, `changed_by`, `changed_at`, `note`) VALUES
(1, 1, NULL, 1, 2, '2026-05-18 08:27:26', 'Nhân viên kho tạo phiếu yêu cầu nhập hàng'),
(2, 2, 1, 2, 1, '2026-05-18 08:27:26', 'Ban giám đốc đã duyệt phiếu yêu cầu nhập hàng'),
(3, 3, 1, 2, 1, '2026-05-18 08:27:26', 'Ban giám đốc đã duyệt phiếu'),
(4, 3, 2, 3, 2, '2026-05-18 08:27:26', 'Nhân viên kho đã gửi đơn đặt hàng cho nhà cung cấp'),
(5, 3, 3, 4, 2, '2026-05-18 08:27:26', 'Nhà cung cấp đã giao một phần hàng, kho đã lập phiếu nhập GR-2026-001'),
(6, 4, NULL, 3, 21, '2026-05-22 16:16:09', 'Product Manager tạo phiếu đặt hàng'),
(7, 5, NULL, 3, 21, '2026-05-22 16:29:42', 'Product Manager tạo phiếu đặt hàng'),
(8, 5, 3, 5, 6, '2026-05-23 06:29:01', 'Warehouse tạo phiếu nhận hàng GR-20260523-2505'),
(9, 4, 3, 5, 6, '2026-05-23 06:40:57', 'Warehouse tạo phiếu nhận hàng GR-20260523-4920'),
(10, 6, NULL, 3, 21, '2026-05-23 07:18:47', 'Product Manager tạo phiếu đặt hàng'),
(11, 7, NULL, 3, 21, '2026-05-23 07:18:49', 'Product Manager tạo phiếu đặt hàng'),
(12, 7, 3, 5, 6, '2026-05-23 07:20:02', 'Warehouse tạo phiếu nhận hàng GR-20260523-3858'),
(13, 8, NULL, 3, 21, '2026-05-23 08:06:34', 'Product Manager tạo phiếu đặt hàng'),
(14, 8, 3, 5, 6, '2026-05-23 08:08:33', 'Warehouse tạo phiếu nhận hàng GR-20260523-4494'),
(15, 6, 3, 5, 6, '2026-05-24 05:56:58', 'Warehouse tạo phiếu nhận hàng GR-20260524-8219'),
(16, 9, NULL, 3, 21, '2026-05-24 06:15:25', 'Product Manager tạo phiếu đặt hàng'),
(17, 9, 3, 5, 6, '2026-05-24 06:15:59', 'Warehouse tạo phiếu nhận hàng GR-20260524-9440'),
(18, 10, NULL, 3, 21, '2026-05-24 06:26:54', 'Product Manager tạo phiếu đặt hàng'),
(19, 10, 3, 5, 6, '2026-05-24 06:27:53', 'Warehouse tạo phiếu nhận hàng GR-20260524-5064'),
(20, 11, NULL, 3, 21, '2026-05-24 06:31:23', 'Product Manager tạo phiếu đặt hàng'),
(21, 11, 3, 5, 6, '2026-05-24 06:31:57', 'Warehouse tạo phiếu nhận hàng GR-20260524-4493'),
(22, 12, NULL, 3, 21, '2026-05-24 06:34:30', 'Product Manager tạo phiếu đặt hàng'),
(23, 13, NULL, 3, 21, '2026-05-24 06:34:31', 'Product Manager tạo phiếu đặt hàng'),
(24, 13, 3, 5, 6, '2026-05-24 06:34:54', 'Warehouse tạo phiếu nhận hàng GR-20260524-5579'),
(25, 12, 3, 5, 6, '2026-05-24 06:38:03', 'Warehouse tạo phiếu nhận hàng GR-20260524-7950'),
(26, 14, NULL, 3, 21, '2026-05-24 06:39:55', 'Product Manager tạo phiếu đặt hàng'),
(27, 15, NULL, 3, 21, '2026-05-24 06:39:58', 'Product Manager tạo phiếu đặt hàng'),
(28, 15, 3, 5, 6, '2026-05-24 06:40:20', 'Warehouse tạo phiếu nhận hàng GR-20260524-2265'),
(29, 14, 3, 5, 6, '2026-05-24 06:44:52', 'Warehouse tạo phiếu nhận hàng GR-20260524-4504'),
(30, 16, NULL, 3, 21, '2026-05-29 04:39:14', 'Product Manager tạo phiếu đặt hàng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchase_requests`
--

CREATE TABLE `purchase_requests` (
  `RequestID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  `RequestedBy` int NOT NULL,
  `Status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `Note` text,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `token_hash` text,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_revoked` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `user_id`, `token_hash`, `expires_at`, `created_at`, `is_revoked`) VALUES
(1, 6, '$2b$10$Vpw0H/nLMKlcKeI5lPSRdu59a6nxjYHeBlLSry1s/0jnpFuDUXkma', '2026-05-26 15:37:53', '2026-05-19 15:37:53', 0),
(2, 6, '$2b$10$/s2XKzEvXOJRLblhkP4t3ePiJ.IlcqrRL957eJUe6gc/aXBzZiXDG', '2026-05-26 15:58:42', '2026-05-19 15:58:41', 1),
(3, 6, '$2b$10$6TCC4TlvzAy1IS1.u9RoUuxE/jMakBmrzH1.fRA/UQ7hrhM0l6lMS', '2026-05-26 16:58:27', '2026-05-19 16:58:27', 0),
(4, 6, '$2b$10$kfGeBdgnfS5fGhGLp9RoYeeUonE1S7IPV5viPfUsNOy.1xHiTuP1u', '2026-05-26 17:13:38', '2026-05-19 17:13:37', 0),
(5, 6, '$2b$10$elwkhAs4DCoNNNk3QLVe1.2zw7yVBjXE4IeFacNBOSGIxCehYUocm', '2026-05-26 17:34:18', '2026-05-19 17:34:18', 0),
(6, 2, '$2b$10$aCozQrXhKvQuXoajLoS4MeexP2ywsmx/WnC.R0.NKPy913GzZk1cO', '2026-05-26 17:50:59', '2026-05-19 17:50:59', 0),
(7, 6, '$2b$10$a9VeXyzFfZ9s6cdozKexouIZSyMc5W552vMGRAn.uxDELkgdvHPLO', '2026-05-27 03:16:59', '2026-05-20 03:16:58', 0),
(8, 21, '$2b$10$0wdyoBstJEMiNE3uF1sBaeTm/iYAbJ.qKGUjrvcScS0yahiJ8BJ56', '2026-05-27 05:46:56', '2026-05-20 05:46:55', 1),
(9, 21, '$2b$10$h.9ifTQau1/aZRS3nZ5v/er8iguz7btUF19UrI7qeJJYQyO1l8EnK', '2026-05-27 06:22:45', '2026-05-20 06:22:44', 0),
(10, 21, '$2b$10$aZdrl0hlbtWEeQr/YCafQev/3z8VJMDa1EKBz.d/njfXrvjyRj.jq', '2026-05-27 06:51:48', '2026-05-20 06:51:47', 0),
(11, 6, '$2b$10$RJeGlYuFu8b5F4Q9boBanONL2de7fYyzmJBwJ32FW12gXl1kGb7Xm', '2026-05-27 07:35:09', '2026-05-20 07:35:09', 1),
(12, 21, '$2b$10$322KQrrHGVHOKu4bkM/WFO3439855JTYabHnN9hpDoEJ7LB1rgKQe', '2026-05-27 07:50:27', '2026-05-20 07:50:27', 1),
(13, 21, '$2b$10$ecD3FmMqeKGlmWIDv7GQ2enuSRJlkwM3VFUjwzdm7naw3AxBL1HCG', '2026-05-27 07:59:14', '2026-05-20 07:59:14', 0),
(14, 2, '$2b$10$3GidlZkc9fcgYvsO47JfMOd3V0.4OWtsVvSOrH3d6GJzBzCB3V.ki', '2026-05-27 08:16:44', '2026-05-20 08:16:43', 1),
(15, 21, '$2b$10$e50LnsohPQHcBebYcdlkvu1dB6LNqFMfHY9RwN2F0d9gyPdR27Uxm', '2026-05-27 08:45:49', '2026-05-20 08:45:48', 0),
(16, 6, '$2b$10$3zgHTpKPgwgc8jaXe86E5uMo1sri6JK9nmU3kf4myvEy7lcPhsP0u', '2026-05-27 09:04:57', '2026-05-20 09:04:56', 1),
(17, 2, '$2b$10$ZTaXaI4tcApR80mPhFoFzeUfQLnybYZIA2F/BySQa3NLjjWEnOrTa', '2026-05-27 09:18:25', '2026-05-20 09:18:24', 1),
(18, 21, '$2b$10$0cFOqr6ASPv2PFV8jLTgd..4MqSKssWOmdonhfmHLC3IN4kXTLmhm', '2026-05-27 09:23:18', '2026-05-20 09:23:18', 0),
(19, 21, '$2b$10$SIWFMoMUzwT699jy4W5yAOCDQuHMX289uZV94bmAk2xToPcvc740y', '2026-05-28 02:46:57', '2026-05-21 02:46:56', 1),
(20, 6, '$2b$10$gVLzLDMsrLpYJ45iufSazOo/oddEaAqloOKcWa8h8LY7G0woVsN2y', '2026-05-28 03:38:52', '2026-05-21 03:38:52', 1),
(21, 2, '$2b$10$muzQxJReCHS7qTGoiayxYOVZuc8LX9wF6CYrRSI47gdvcu.J1cM06', '2026-05-28 03:40:26', '2026-05-21 03:40:26', 1),
(22, 6, '$2b$10$uZSRESp9qipjFTjrBQA0fu5jFnJqublsCwfFK6zaDkYf3K7w.tGai', '2026-05-28 03:43:35', '2026-05-21 03:43:35', 0),
(23, 2, '$2b$10$8UIH5cOTLJ7wFDOvJ7.Xcu3o8CVIhJweoyB8.1y4npUoYGeHozLbq', '2026-05-28 04:08:26', '2026-05-21 04:08:25', 1),
(24, 1, '$2b$10$D1pOl7L/u4jfXno4xcagZOjOHywj8QBjjU4EyCFa94/9107inqTMi', '2026-05-28 04:10:14', '2026-05-21 04:10:14', 1),
(25, 2, '$2b$10$QccAhMlxsxVsEqQ1m53DIe2mVvau1cm3ZWE26oSAnly7sFzKUX6nW', '2026-05-28 06:24:33', '2026-05-21 06:24:33', 1),
(26, 1, '$2b$10$CGl/0vg4TJFxpeadKunhhuT.A1qdXxUKIMXyrBxLXDcArLISTjADq', '2026-05-28 06:24:55', '2026-05-21 06:24:54', 1),
(27, 2, '$2b$10$g7Eh0Yj5qqy.q5gZYQxstuBQw3QWPxOzaXkmQSQwZztFY1RsBY6rm', '2026-05-28 07:30:49', '2026-05-21 07:30:49', 1),
(28, 2, '$2b$10$SggbCyQiONJW9yDO8vG.YejJSvKNhS1armzeU1FfJau4UZULSHdX.', '2026-05-28 08:07:44', '2026-05-21 08:07:44', 0),
(29, 2, '$2b$10$2d2OCg6vJtErO8mAI.KTB.0kQfC/M/tDFF3rEIjW/RtyYBTkk7H8e', '2026-05-29 09:48:50', '2026-05-22 09:48:50', 0),
(30, 2, '$2b$10$V0WJftwkKgJjTdI5HGN9XeWYSNIJgSc/25PgVb11HQkAU/Gef7jQS', '2026-05-29 12:01:10', '2026-05-22 12:01:09', 1),
(31, 21, '$2b$10$uO57vj.rgnfAaKsleO5V..I7/P26mv/GOH5Tm03QcGsMZATWNcZ4.', '2026-05-29 12:13:42', '2026-05-22 12:13:42', 0),
(32, 21, '$2b$10$88Cd98hyLv0EL5NAyPmzvuPF6giYTiuKAmpsVr1Agiyy5OqPyBlyu', '2026-05-29 15:46:42', '2026-05-22 15:46:42', 1),
(33, 2, '$2b$10$mmoToGVjMqO6KfVadDJCm.CkjRpnOliL9dEcdIK21L7HhabrGgaDi', '2026-05-29 16:54:56', '2026-05-22 16:54:56', 0),
(34, 6, '$2b$10$0r2NNmThW3KRfzz1haUO..60/WLdCmmxSUkjuwOVSTI8Flcc1m3Hq', '2026-05-29 16:55:05', '2026-05-22 16:55:05', 0),
(35, 6, '$2b$10$HY1lhR8VH4T9T6lWsPwxzOwxWBR0OCtfRtZcP5ksTC2YPSZIdNxha', '2026-05-30 04:28:56', '2026-05-23 04:28:56', 1),
(36, 21, '$2b$10$r64juaqr8yqAJgBypj/Nr.vJ4Ug1Zg1.LDlcK.FBsxhjpCY2HnfVS', '2026-05-30 06:42:08', '2026-05-23 06:42:07', 1),
(37, 6, '$2b$10$JRmNim0Tt1T1mi5JKNAsu.m/BhYvabYXETwqq5KoyD655.FA9UtBO', '2026-05-30 07:13:48', '2026-05-23 07:13:48', 0),
(38, 21, '$2b$10$7SZOLJg47Oc6PV6KfrF6neUYhNQ/ODNFqxV7nKm6X6CTW3hIDLBAC', '2026-05-30 07:16:27', '2026-05-23 07:16:26', 0),
(39, 2, '$2b$10$XcHBZ86urJgSEOkjQcSU2eO4mITgIHbN.uoIwjLfzFBPcDde9yk32', '2026-05-31 04:11:56', '2026-05-24 04:11:55', 1),
(40, 6, '$2b$10$hz9TmhFduP5rYwLQB.oaI.awaTaSC/iO52kzhMXnjt4vwl7VNT6/.', '2026-05-31 05:56:09', '2026-05-24 05:56:09', 0),
(41, 21, '$2b$10$NlsRO7yiezWaWeiQWBnaIeIAuTYNGBWUV0pO7nfKJVJDYW4xxtQfC', '2026-05-31 05:57:29', '2026-05-24 05:57:28', 1),
(42, 2, '$2b$10$0Zk22lMOEOLssjdfF23d9eYZjURDQAQnJakMZeF.eYXgr431CEcYi', '2026-05-31 08:35:12', '2026-05-24 08:35:11', 1),
(43, 6, '$2b$10$pebFrtogtPfkA3wpeL5w/.gbMK6NOSkIWRg3hrdlvfzIHDdo2.UGC', '2026-05-31 08:37:24', '2026-05-24 08:37:24', 1),
(44, 21, '$2b$10$joS/G2HjYtCVp9hh5F1QKO2DvVQCA9rTgUKS3T1JEtnozdqs7PWL6', '2026-05-31 08:37:47', '2026-05-24 08:37:47', 0),
(45, 2, '$2b$10$wLzTQzshNBX.9vuhfkqkYOZFtEm.bhF29hMtOTgOppdz4hl/uRwNC', '2026-06-02 06:00:20', '2026-05-26 06:00:20', 0),
(46, 2, '$2b$10$XuvZg1UDzvBVl9AxDzTcmuprwuelq3MuXH6fwi5mThANJsQdW1FWa', '2026-06-02 07:33:55', '2026-05-26 07:33:54', 0),
(47, 2, '$2b$10$e48AlZXlKOGQI/eBPHj6G.NATMOJ0tCs4IpBRfIzAvnTzAyXJtclm', '2026-06-02 08:35:43', '2026-05-26 08:35:43', 0),
(48, 2, '$2b$10$UUcBZo2ZxBe/ae47wjufOuFx3Kbiwjs4WFX88hiJWPIIJJYXYEkGy', '2026-06-02 15:17:51', '2026-05-26 15:17:50', 0),
(49, 2, '$2b$10$6SpofaZp2GT.bm4SW5cnqOU5ASHm4G3nVPaUL.nJgWlALKLmjlWu.', '2026-06-02 15:47:08', '2026-05-26 15:47:08', 0),
(50, 2, '$2b$10$U.dEb9P/3YGf3kPoE.yH3eeoHvqXofzRpiZDZPl0RHV2K2jSky6.W', '2026-06-02 15:51:35', '2026-05-26 15:51:34', 0),
(51, 2, '$2b$10$4uesSqQEdAxBUPNmlF3TFu71HTOE41w5Ipe4lj5C1K1AbMHIA6Rda', '2026-06-02 16:16:45', '2026-05-26 16:16:45', 0),
(52, 2, '$2b$10$FIowae4H23.hIy6CWRLHAe1993w1DxWVL8H1rQOINqsIWLskCKCf6', '2026-06-02 16:50:16', '2026-05-26 16:50:16', 0),
(53, 2, '$2b$10$2s2sxA1r2Yxc8ZAKC1Lndu2Xzs8/o2uXQjV7tT/nlioJURzfHaFcm', '2026-06-02 17:28:07', '2026-05-26 17:28:07', 0),
(54, 2, '$2b$10$fgMH.7Sj.jgs7fyM5xjPd.CkkD0vQggQmQDGCzTXrOBkBsL/yhH2C', '2026-06-03 15:19:11', '2026-05-27 15:19:10', 0),
(55, 2, '$2b$10$qjlTS..0Tsk3hkS6vR1x..mscVWvH.2wvjosPh4KqnNyc07jT9BS.', '2026-06-03 15:49:48', '2026-05-27 15:49:47', 0),
(56, 2, '$2b$10$s9FnAJ4Yh30HiVQhW0dBfewhsIbvInZiTneUfjObH9ya1MoHfInH6', '2026-06-03 16:12:23', '2026-05-27 16:12:22', 0),
(57, 2, '$2b$10$O8UtwC/jHv5FNb8VzonvDeVnlGf2gklTgDuYuBb7n.SwkURBd9RHy', '2026-06-03 16:26:54', '2026-05-27 16:26:54', 0),
(58, 2, '$2b$10$/fL4ytWApf8dsH4M2IcHceO6MREQlAAPyQ0MSR45y.DGMdIB1Knoi', '2026-06-03 16:40:56', '2026-05-27 16:40:55', 0),
(59, 21, '$2b$10$N6wcNtCzD6Bc1Eo0WZFCTuOwlkCc/7YQUs6nAz.3UqIqBB2ZZrsla', '2026-06-03 17:16:32', '2026-05-27 17:16:32', 0),
(60, 21, '$2b$10$IwEwecIIhFf5CQXXabD5GuxjK3P0HIMiY5I4dvbsOjgpzkm0JKRJW', '2026-06-04 04:06:25', '2026-05-28 04:06:25', 0),
(61, 21, '$2b$10$0Ay7XdbVLlzskur744hNbu7gR59QKkbCkQihhccjMsaGvtDgnrmc2', '2026-06-04 11:05:17', '2026-05-28 11:05:16', 0),
(62, 21, '$2b$10$gHZUL5EO0wIz5qF7qE93YOwOZiP.g55gyv/a/f4HVwL2vgKTVHH3K', '2026-06-04 12:19:16', '2026-05-28 12:19:16', 0),
(63, 21, '$2b$10$0O4ZyBabU.b68e5m94LFeOXH/tZOfbw0kACVMlU6n6Q7QIIrp8kaq', '2026-06-04 12:56:40', '2026-05-28 12:56:40', 1),
(64, 2, '$2b$10$.5P5kxqHlm5kbXFUxQ7f.ugguRGbDKs//5vwqrqTi4bOg6Z8nodiC', '2026-06-04 13:04:48', '2026-05-28 13:04:48', 1),
(65, 2, '$2b$10$zFmn0e5bcw2xDWfUjAnw4uxzz5GNI6EdOPgjEH8eTHMu7A4.Xj7ca', '2026-06-04 13:48:25', '2026-05-28 13:48:24', 1),
(66, 2, '$2b$10$pmqtCeV9FXJ.MmuAytl6POBjvOD8mB0ORBnJKeQicgXykIr4XLtVi', '2026-06-04 14:48:23', '2026-05-28 14:48:23', 1),
(67, 2, '$2b$10$/XvCqBpJDBVQvjc0k8FWI.hBgTSJrAR6qXPY7lY.Y6C/vBP.xgx0.', '2026-06-04 15:10:32', '2026-05-28 15:10:31', 0),
(68, 21, '$2b$10$1RG.mj6KSicyTFpEur7G6uftM7dPBdyZ5fI1spEa/DLqf14RI9tp.', '2026-06-04 15:41:09', '2026-05-28 15:41:09', 0),
(69, 1, '$2b$10$FhzoRdgPWWyHyuBG8OmSbeWwxOxUB323XetQgXkxrKbe28wwR14hq', '2026-06-05 02:36:19', '2026-05-29 02:36:19', 1),
(70, 21, '$2b$10$TDD3Nr3GdM15E29Xc95jUeoTPYKaZ3sdpHLSZT2EwRsWplolPOg/.', '2026-06-05 02:51:24', '2026-05-29 02:51:23', 1),
(71, 2, '$2b$10$tK1MWVfOLqTl4ieZj9JvYeg7x.6BPpjEPS/xodrcvkY0Z6a.7skga', '2026-06-05 03:04:23', '2026-05-29 03:04:23', 1),
(72, 6, '$2b$10$bo.CEvCNyT3FRrdmXkLskOIibSsYfN4LzPOJdUsnpnIVeAKZNXvYC', '2026-06-05 03:04:53', '2026-05-29 03:04:52', 0),
(73, 21, '$2b$10$Ffpg/JkVZJA0wz1UtMfCHe.azwpeJ4GeLmAbU3EJxCrUZNgQFZZX2', '2026-06-05 03:10:05', '2026-05-29 03:10:05', 1),
(74, 21, '$2b$10$l7eBWYm2nSJWp4AqT2XN7ulAvhjyeAeQwSndxUzkxJ6bW2cysEeIG', '2026-06-05 04:41:41', '2026-05-29 04:41:40', 1),
(75, 2, '$2b$10$3HuOVwmzOjzPIh0/ybt5L.z7qaQ2zE0y2aEdJgb.cFbZadTqMrEfi', '2026-06-05 07:20:55', '2026-05-29 07:20:54', 1),
(76, 6, '$2b$10$NGvjgx0ne/CgdPgwZz334.QST7ZK0HDfzxj0Jz9iQo54Tj1842cAm', '2026-06-05 07:21:35', '2026-05-29 07:21:34', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'SALE'),
(3, 'CUSTOMER'),
(4, 'WAREHOUSE_EMPLOYEE'),
(5, 'MANAGER'),
(6, 'PRODUCT_MANAGER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL COMMENT 'Khóa chính của bảng nhà cung cấp',
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tên nhà cung cấp vật tư nông nghiệp',
  `contact_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tên người đại diện hoặc người liên hệ của nhà cung cấp',
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Số điện thoại liên hệ của nhà cung cấp',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email liên hệ của nhà cung cấp',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Địa chỉ của nhà cung cấp',
  `tax_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mã số thuế của nhà cung cấp',
  `status` enum('ACTIVE','INACTIVE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'ACTIVE' COMMENT 'Trạng thái hoạt động của nhà cung cấp',
  `created_by` int DEFAULT NULL COMMENT 'Người tạo thông tin nhà cung cấp',
  `updated_by` int DEFAULT NULL COMMENT 'Người cập nhật thông tin nhà cung cấp gần nhất',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời điểm tạo thông tin nhà cung cấp',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Thời điểm cập nhật thông tin nhà cung cấp gần nhất'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `contact_name`, `phone_number`, `email`, `address`, `tax_code`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Công ty TNHH Vật tư Nông nghiệp An Phú', 'Nguyễn Văn An', '0901123456', 'anphu.agri@example.com', '123 Quốc lộ 1A, TP. Cần Thơ', '1800123456', 'ACTIVE', 1, 1, '2026-05-18 08:24:47', '2026-05-18 08:24:47'),
(2, 'Công ty CP Phân bón Miền Tây', 'Trần Thị Bình', '0912233445', 'phanbonmientay@example.com', '45 Đường Nguyễn Văn Cừ, TP. Cần Thơ', '1800654321', 'ACTIVE', 1, 1, '2026-05-18 08:24:47', '2026-05-18 08:24:47'),
(3, 'Đại lý Thuốc BVTV Hưng Thịnh', 'Lê Minh Hưng', '0988777666', 'hungthinh.bvtv@example.com', '88 Đường 30/4, TP. Hồ Chí Minh', '0311223344', 'ACTIVE', 1, 1, '2026-05-18 08:24:47', '2026-05-18 08:24:47'),
(4, 'Công ty TNHH Nông Nghiệp Xanh Miền Tây', 'Nguyễn Văn Bình', '0909123456', 'xanhmientay@example.com', '123 Nguyễn Văn Cừ, Cần Thơ', '1800999888', 'ACTIVE', 6, 6, '2026-05-19 15:38:12', '2026-05-19 15:38:12'),
(5, 'CamTuCompany', 'Võ Thị Cẩm Tú', '0398820296', 'tuvo068@gmail.com', '06', '0404200422', 'ACTIVE', 6, 6, '2026-05-19 17:43:18', '2026-05-19 17:43:18'),
(6, 'CamTuCompany3', 'Võ Thị Cẩm Tú', '0398820292', 'tuvo0_68@gmail.com', '06', '0404200423', 'ACTIVE', 6, 6, '2026-05-20 07:35:40', '2026-05-20 07:35:40'),
(7, 'CamTuCompany3', 'Võ Thị Cẩm Tú', '0398820296', 'tuvo468@gmail.com', '06', '0404200429', 'ACTIVE', 21, 21, '2026-05-22 15:55:57', '2026-05-22 15:55:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `toxicity_level_detail`
--

CREATE TABLE `toxicity_level_detail` (
  `ToxicID` int NOT NULL,
  `Level` varchar(50) DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `toxicity_level_detail`
--

INSERT INTO `toxicity_level_detail` (`ToxicID`, `Level`, `Description`) VALUES
(1, 'Ít độc', 'Mức độc thấp. Khi sử dụng vẫn cần mang găng tay, khẩu trang và tránh tiếp xúc trực tiếp với da, mắt.'),
(2, 'Độc trung bình', 'Có thể gây ảnh hưởng sức khỏe nếu hít phải, nuốt phải hoặc tiếp xúc trực tiếp. Cần sử dụng đồ bảo hộ khi pha và phun thuốc.'),
(3, 'Độc cao', 'Nguy hiểm nếu sử dụng sai cách. Cần tuân thủ nghiêm hướng dẫn sử dụng, thời gian cách ly và biện pháp an toàn.'),
(4, 'Rất độc', 'Mức độ nguy hiểm cao. Chỉ sử dụng khi thật cần thiết, cần trang bị bảo hộ đầy đủ và tránh xa trẻ em, vật nuôi, nguồn nước.'),
(5, 'Độc với thủy sinh', 'Có nguy cơ gây hại cho cá, tôm và sinh vật thủy sinh. Không sử dụng gần ao hồ, kênh rạch hoặc nguồn nước sinh hoạt.'),
(6, 'Độc với ong và côn trùng có ích', 'Có thể ảnh hưởng đến ong mật và côn trùng có ích. Không phun thuốc trong thời điểm cây đang ra hoa hoặc khi ong hoạt động mạnh.'),
(7, 'Gây kích ứng da và mắt', 'Có thể gây kích ứng khi tiếp xúc trực tiếp với da hoặc mắt. Cần rửa sạch bằng nước nếu bị dính thuốc.'),
(8, 'Nguy cơ hít phải hơi thuốc', 'Có thể gây khó chịu nếu hít phải hơi thuốc trong quá trình pha hoặc phun. Cần dùng khẩu trang và phun ở nơi thông thoáng.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_first_login` tinyint(1) DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `failed_attempts` int DEFAULT '0',
  `locked_until` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role_id`, `created_at`, `is_first_login`, `created_by`, `failed_attempts`, `locked_until`, `is_active`) VALUES
(1, 'admin@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 1, '2026-04-21 16:22:31', 0, NULL, 0, NULL, 1),
(2, 'sale01@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 2, '2026-04-21 17:05:38', 0, NULL, 0, NULL, 1),
(3, 'customer01@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 3, '2026-04-21 17:07:18', 1, NULL, 0, NULL, 1),
(4, 'customer02@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 3, '2026-04-21 17:08:03', 1, NULL, 0, NULL, 1),
(5, 'customer03@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 3, '2026-04-21 17:08:48', 1, NULL, 0, NULL, 0),
(6, 'warehouse01@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 4, '2026-04-21 17:18:47', 0, NULL, 0, NULL, 1),
(7, 'warehouse02@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 4, '2026-04-21 17:32:15', 1, NULL, 0, NULL, 0),
(8, 'customer04@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0...', 3, '2026-05-12 08:02:15', 1, NULL, 0, NULL, 1),
(9, 'customer05@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0...', 3, '2026-05-12 08:02:15', 1, NULL, 0, NULL, 1),
(20, 'dtttrinh0404@gmail.com', '$2b$10$InhTWYf8DrzmclXi2myBour2.trA2h0Dh4mb/vwaKv3YtGd9Ii6r.', 2, '2026-05-18 07:21:20', 1, NULL, 0, NULL, 0),
(21, 'productmanager01@gmail.com', '$2b$10$BW8PDuzCz2Z.AjSy9lv/yu3tKw8WoTgByidYv49hGV0ygaWszhx1u', 6, '2026-05-20 05:46:37', 0, 1, 0, NULL, 1),
(33, 'tuvo068@gmail.com', '$2b$10$slz9Gbh4S4.HhIQEMqvVYueUxZavAS6EARlQ8AngYC7FvMh04JH5q', 2, '2026-05-21 07:59:38', 1, 2, 0, NULL, 1),
(34, 'nhunguyentu1811@gmail.com', '$2b$10$yOILMhph3Z7hx0COGv7TWuaFQuMW77spVQC64UkPOb5abHVlvgQ2.', 2, '2026-05-24 04:49:20', 1, 2, 0, NULL, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Chỉ mục cho bảng `company_bank_accounts`
--
ALTER TABLE `company_bank_accounts`
  ADD PRIMARY KEY (`bank_account_id`),
  ADD UNIQUE KEY `uq_company_bank_account` (`bank_bin`,`account_no`),
  ADD KEY `idx_company_bank_accounts_default` (`is_default`),
  ADD KEY `idx_company_bank_accounts_active` (`is_active`);

--
-- Chỉ mục cho bảng `crops`
--
ALTER TABLE `crops`
  ADD PRIMARY KEY (`CropID`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `dealer_commissions`
--
ALTER TABLE `dealer_commissions`
  ADD PRIMARY KEY (`dealer_commission_id`),
  ADD UNIQUE KEY `uq_dealer_commission_order` (`order_id`),
  ADD KEY `idx_dealer_commissions_customer` (`customer_id`),
  ADD KEY `idx_dealer_commissions_order` (`order_id`),
  ADD KEY `idx_dealer_commissions_status` (`status`),
  ADD KEY `idx_dealer_commissions_created_by` (`created_by`),
  ADD KEY `idx_dealer_commissions_approved_by` (`approved_by`);

--
-- Chỉ mục cho bảng `dealer_commission_logs`
--
ALTER TABLE `dealer_commission_logs`
  ADD PRIMARY KEY (`dealer_commission_log_id`),
  ADD KEY `idx_commission_logs_commission` (`dealer_commission_id`),
  ADD KEY `idx_commission_logs_customer` (`customer_id`),
  ADD KEY `idx_commission_logs_action` (`action`),
  ADD KEY `idx_commission_logs_created_by` (`created_by`);

--
-- Chỉ mục cho bảng `debt_logs`
--
ALTER TABLE `debt_logs`
  ADD PRIMARY KEY (`debt_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `goods_receipts`
--
ALTER TABLE `goods_receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `receipt_code` (`receipt_code`),
  ADD KEY `purchase_order_id` (`purchase_order_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `received_by` (`received_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `goods_receipt_details`
--
ALTER TABLE `goods_receipt_details`
  ADD PRIMARY KEY (`receipt_detail_id`),
  ADD KEY `receipt_id` (`receipt_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `fk_grd_purchase_order_detail` (`purchase_order_detail_id`);

--
-- Chỉ mục cho bảng `goods_receipt_supplier_emails`
--
ALTER TABLE `goods_receipt_supplier_emails`
  ADD PRIMARY KEY (`email_log_id`),
  ADD KEY `fk_grse_receipt` (`receipt_id`),
  ADD KEY `fk_grse_supplier` (`supplier_id`);

--
-- Chỉ mục cho bảng `home_banners`
--
ALTER TABLE `home_banners`
  ADD PRIMARY KEY (`BannerID`);

--
-- Chỉ mục cho bảng `import_requests`
--
ALTER TABLE `import_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_code` (`request_code`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Chỉ mục cho bảng `import_request_details`
--
ALTER TABLE `import_request_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `import_request_id` (`import_request_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`InventoryID`),
  ADD UNIQUE KEY `ProductID_2` (`ProductID`,`BatchNumber`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Chỉ mục cho bảng `inventory_logs`
--
ALTER TABLE `inventory_logs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `InventoryID` (`InventoryID`);

--
-- Chỉ mục cho bảng `inventory_stocktakes`
--
ALTER TABLE `inventory_stocktakes`
  ADD PRIMARY KEY (`stocktake_id`),
  ADD UNIQUE KEY `stocktake_code` (`stocktake_code`),
  ADD KEY `idx_inventory_stocktakes_status` (`status`),
  ADD KEY `idx_inventory_stocktakes_date` (`stocktake_date`),
  ADD KEY `idx_inventory_stocktakes_created_by` (`created_by`);

--
-- Chỉ mục cho bảng `inventory_stocktake_details`
--
ALTER TABLE `inventory_stocktake_details`
  ADD PRIMARY KEY (`stocktake_detail_id`),
  ADD KEY `idx_stocktake_detail_stocktake` (`stocktake_id`),
  ADD KEY `idx_stocktake_detail_inventory` (`inventory_id`),
  ADD KEY `idx_stocktake_detail_product` (`product_id`);

--
-- Chỉ mục cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `create_by` (`create_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_payment_status` (`payment_status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `order_payment_terms`
--
ALTER TABLE `order_payment_terms`
  ADD PRIMARY KEY (`order_payment_term_id`),
  ADD UNIQUE KEY `uq_order_payment_terms_order` (`order_id`),
  ADD KEY `idx_order_payment_terms_template` (`payment_term_template_id`),
  ADD KEY `idx_order_payment_terms_due_date` (`due_date`);

--
-- Chỉ mục cho bảng `order_status_log`
--
ALTER TABLE `order_status_log`
  ADD PRIMARY KEY (`LogID`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `uq_transaction_code` (`transaction_code`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `fk_payments_installment` (`payment_installment_id`),
  ADD KEY `fk_payments_qr` (`payment_qr_id`),
  ADD KEY `fk_payments_confirmed_by` (`confirmed_by`);

--
-- Chỉ mục cho bảng `payment_installments`
--
ALTER TABLE `payment_installments`
  ADD PRIMARY KEY (`payment_installment_id`),
  ADD UNIQUE KEY `uq_order_installment_no` (`order_id`,`installment_no`),
  ADD KEY `idx_payment_installments_order` (`order_id`),
  ADD KEY `idx_payment_installments_customer` (`customer_id`),
  ADD KEY `idx_payment_installments_status` (`status`),
  ADD KEY `idx_payment_installments_created_by` (`created_by`),
  ADD KEY `idx_payment_installments_confirmed_by` (`confirmed_by`);

--
-- Chỉ mục cho bảng `payment_qr_codes`
--
ALTER TABLE `payment_qr_codes`
  ADD PRIMARY KEY (`payment_qr_id`),
  ADD UNIQUE KEY `uq_payment_qr_transfer_content` (`transfer_content`),
  ADD UNIQUE KEY `payment_code` (`payment_code`),
  ADD KEY `idx_payment_qr_installment` (`payment_installment_id`),
  ADD KEY `idx_payment_qr_order` (`order_id`),
  ADD KEY `idx_payment_qr_customer` (`customer_id`),
  ADD KEY `idx_payment_qr_bank_account` (`bank_account_id`),
  ADD KEY `idx_payment_qr_status` (`status`),
  ADD KEY `idx_payment_qr_created_by` (`created_by`);

--
-- Chỉ mục cho bảng `payment_term_templates`
--
ALTER TABLE `payment_term_templates`
  ADD PRIMARY KEY (`payment_term_template_id`),
  ADD KEY `idx_payment_term_templates_active` (`is_active`),
  ADD KEY `idx_payment_term_templates_created_by` (`created_by`),
  ADD KEY `idx_payment_term_templates_updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `payment_webhook_logs`
--
ALTER TABLE `payment_webhook_logs`
  ADD PRIMARY KEY (`webhook_log_id`),
  ADD KEY `idx_webhook_transaction_code` (`transaction_code`),
  ADD KEY `idx_webhook_status` (`process_status`),
  ADD KEY `idx_webhook_payment_qr` (`matched_payment_qr_id`),
  ADD KEY `idx_webhook_installment` (`matched_payment_installment_id`),
  ADD KEY `idx_webhook_order` (`matched_order_id`);

--
-- Chỉ mục cho bảng `pesticide`
--
ALTER TABLE `pesticide`
  ADD PRIMARY KEY (`PID`),
  ADD UNIQUE KEY `ProductID` (`ProductID`);

--
-- Chỉ mục cho bảng `pesticide_crops`
--
ALTER TABLE `pesticide_crops`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PDetailID` (`PDetailID`),
  ADD KEY `CropID` (`CropID`);

--
-- Chỉ mục cho bảng `pesticide_detail`
--
ALTER TABLE `pesticide_detail`
  ADD PRIMARY KEY (`PDetailID`),
  ADD KEY `PID` (`PID`);

--
-- Chỉ mục cho bảng `pesticide_pests`
--
ALTER TABLE `pesticide_pests`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `pesticide_pests_detail_fk` (`PDetailID`),
  ADD KEY `pesticide_pests_pest_fk` (`PestID`);

--
-- Chỉ mục cho bảng `pesticide_usage`
--
ALTER TABLE `pesticide_usage`
  ADD PRIMARY KEY (`UsageID`),
  ADD KEY `PDetailID` (`PDetailID`),
  ADD KEY `ToxicID` (`ToxicID`);

--
-- Chỉ mục cho bảng `pests`
--
ALTER TABLE `pests`
  ADD PRIMARY KEY (`PestID`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD UNIQUE KEY `SKU` (`SKU`),
  ADD UNIQUE KEY `Slug` (`Slug`),
  ADD KEY `CategoryID` (`CategoryID`),
  ADD KEY `StatusID` (`StatusID`),
  ADD KEY `UnitID` (`UnitID`);

--
-- Chỉ mục cho bảng `product_embeddings`
--
ALTER TABLE `product_embeddings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_product_embedding` (`ProductID`);

--
-- Chỉ mục cho bảng `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`ImageID`),
  ADD KEY `ImageTypeID` (`ImageTypeID`);

--
-- Chỉ mục cho bảng `product_image_type`
--
ALTER TABLE `product_image_type`
  ADD PRIMARY KEY (`ImageTypeID`);

--
-- Chỉ mục cho bảng `product_status`
--
ALTER TABLE `product_status`
  ADD PRIMARY KEY (`StatusID`);

--
-- Chỉ mục cho bảng `product_unit`
--
ALTER TABLE `product_unit`
  ADD PRIMARY KEY (`PUnitID`);

--
-- Chỉ mục cho bảng `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Chỉ mục cho bảng `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`purchase_order_id`),
  ADD UNIQUE KEY `po_code` (`po_code`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `status_id` (`status_id`);

--
-- Chỉ mục cho bảng `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD PRIMARY KEY (`purchase_order_detail_id`),
  ADD KEY `purchase_order_id` (`purchase_order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `purchase_order_statuses`
--
ALTER TABLE `purchase_order_statuses`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `status_code` (`status_code`);

--
-- Chỉ mục cho bảng `purchase_order_status_logs`
--
ALTER TABLE `purchase_order_status_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `purchase_order_id` (`purchase_order_id`),
  ADD KEY `old_status_id` (`old_status_id`),
  ADD KEY `new_status_id` (`new_status_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Chỉ mục cho bảng `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`RequestID`),
  ADD KEY `ProductID` (`ProductID`),
  ADD KEY `RequestedBy` (`RequestedBy`);

--
-- Chỉ mục cho bảng `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `uq_suppliers_email` (`email`),
  ADD UNIQUE KEY `uq_suppliers_tax_code` (`tax_code`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `toxicity_level_detail`
--
ALTER TABLE `toxicity_level_detail`
  ADD PRIMARY KEY (`ToxicID`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=331;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `CategoryID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `company_bank_accounts`
--
ALTER TABLE `company_bank_accounts`
  MODIFY `bank_account_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `crops`
--
ALTER TABLE `crops`
  MODIFY `CropID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `dealer_commissions`
--
ALTER TABLE `dealer_commissions`
  MODIFY `dealer_commission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `dealer_commission_logs`
--
ALTER TABLE `dealer_commission_logs`
  MODIFY `dealer_commission_log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `debt_logs`
--
ALTER TABLE `debt_logs`
  MODIFY `debt_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `goods_receipts`
--
ALTER TABLE `goods_receipts`
  MODIFY `receipt_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của phiếu nhập kho thực tế', AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `goods_receipt_details`
--
ALTER TABLE `goods_receipt_details`
  MODIFY `receipt_detail_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của chi tiết phiếu nhập kho', AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `goods_receipt_supplier_emails`
--
ALTER TABLE `goods_receipt_supplier_emails`
  MODIFY `email_log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `home_banners`
--
ALTER TABLE `home_banners`
  MODIFY `BannerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `import_requests`
--
ALTER TABLE `import_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `import_request_details`
--
ALTER TABLE `import_request_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `inventory`
--
ALTER TABLE `inventory`
  MODIFY `InventoryID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT cho bảng `inventory_logs`
--
ALTER TABLE `inventory_logs`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `inventory_stocktakes`
--
ALTER TABLE `inventory_stocktakes`
  MODIFY `stocktake_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `inventory_stocktake_details`
--
ALTER TABLE `inventory_stocktake_details`
  MODIFY `stocktake_detail_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order_payment_terms`
--
ALTER TABLE `order_payment_terms`
  MODIFY `order_payment_term_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order_status_log`
--
ALTER TABLE `order_status_log`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `payment_installments`
--
ALTER TABLE `payment_installments`
  MODIFY `payment_installment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `payment_qr_codes`
--
ALTER TABLE `payment_qr_codes`
  MODIFY `payment_qr_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `payment_term_templates`
--
ALTER TABLE `payment_term_templates`
  MODIFY `payment_term_template_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `payment_webhook_logs`
--
ALTER TABLE `payment_webhook_logs`
  MODIFY `webhook_log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `pesticide`
--
ALTER TABLE `pesticide`
  MODIFY `PID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `pesticide_crops`
--
ALTER TABLE `pesticide_crops`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `pesticide_detail`
--
ALTER TABLE `pesticide_detail`
  MODIFY `PDetailID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `pesticide_pests`
--
ALTER TABLE `pesticide_pests`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `pesticide_usage`
--
ALTER TABLE `pesticide_usage`
  MODIFY `UsageID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `pests`
--
ALTER TABLE `pests`
  MODIFY `PestID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=431;

--
-- AUTO_INCREMENT cho bảng `product_embeddings`
--
ALTER TABLE `product_embeddings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_image`
--
ALTER TABLE `product_image`
  MODIFY `ImageID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5480;

--
-- AUTO_INCREMENT cho bảng `product_image_type`
--
ALTER TABLE `product_image_type`
  MODIFY `ImageTypeID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `product_status`
--
ALTER TABLE `product_status`
  MODIFY `StatusID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `product_unit`
--
ALTER TABLE `product_unit`
  MODIFY `PUnitID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `purchase_order_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của phiếu yêu cầu nhập hàng', AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  MODIFY `purchase_order_detail_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của chi tiết phiếu yêu cầu nhập hàng', AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `purchase_order_statuses`
--
ALTER TABLE `purchase_order_statuses`
  MODIFY `status_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của bảng trạng thái phiếu yêu cầu nhập hàng', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `purchase_order_status_logs`
--
ALTER TABLE `purchase_order_status_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của log thay đổi trạng thái phiếu yêu cầu nhập hàng', AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `RequestID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int NOT NULL AUTO_INCREMENT COMMENT 'Khóa chính của bảng nhà cung cấp', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `toxicity_level_detail`
--
ALTER TABLE `toxicity_level_detail`
  MODIFY `ToxicID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Ràng buộc đối với các bảng kết xuất
--

--
-- Ràng buộc cho bảng `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `dealer_commissions`
--
ALTER TABLE `dealer_commissions`
  ADD CONSTRAINT `fk_dealer_commissions_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_dealer_commissions_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_dealer_commissions_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_dealer_commissions_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Ràng buộc cho bảng `dealer_commission_logs`
--
ALTER TABLE `dealer_commission_logs`
  ADD CONSTRAINT `fk_commission_logs_commission` FOREIGN KEY (`dealer_commission_id`) REFERENCES `dealer_commissions` (`dealer_commission_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_commission_logs_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_commission_logs_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ràng buộc cho bảng `debt_logs`
--
ALTER TABLE `debt_logs`
  ADD CONSTRAINT `debt_logs_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ràng buộc cho bảng `goods_receipts`
--
ALTER TABLE `goods_receipts`
  ADD CONSTRAINT `goods_receipts_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`),
  ADD CONSTRAINT `goods_receipts_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `goods_receipts_ibfk_3` FOREIGN KEY (`received_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `goods_receipts_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `goods_receipts_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `goods_receipt_details`
--
ALTER TABLE `goods_receipt_details`
  ADD CONSTRAINT `fk_grd_purchase_order_detail` FOREIGN KEY (`purchase_order_detail_id`) REFERENCES `purchase_order_details` (`purchase_order_detail_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `goods_receipt_details_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `goods_receipts` (`receipt_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `goods_receipt_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `goods_receipt_details_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `goods_receipt_details_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `goods_receipt_supplier_emails`
--
ALTER TABLE `goods_receipt_supplier_emails`
  ADD CONSTRAINT `fk_grse_receipt` FOREIGN KEY (`receipt_id`) REFERENCES `goods_receipts` (`receipt_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_grse_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `import_requests`
--
ALTER TABLE `import_requests`
  ADD CONSTRAINT `import_requests_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `import_requests_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `import_request_details`
--
ALTER TABLE `import_request_details`
  ADD CONSTRAINT `import_request_details_ibfk_1` FOREIGN KEY (`import_request_id`) REFERENCES `import_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `import_request_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`ProductID`);

--
-- Ràng buộc cho bảng `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Ràng buộc cho bảng `inventory_logs`
--
ALTER TABLE `inventory_logs`
  ADD CONSTRAINT `inventory_logs_ibfk_1` FOREIGN KEY (`InventoryID`) REFERENCES `inventory` (`InventoryID`);

--
-- Ràng buộc cho bảng `inventory_stocktake_details`
--
ALTER TABLE `inventory_stocktake_details`
  ADD CONSTRAINT `fk_stocktake_detail_header` FOREIGN KEY (`stocktake_id`) REFERENCES `inventory_stocktakes` (`stocktake_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`ProductID`);

--
-- Ràng buộc cho bảng `order_payment_terms`
--
ALTER TABLE `order_payment_terms`
  ADD CONSTRAINT `fk_order_payment_terms_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_payment_terms_template` FOREIGN KEY (`payment_term_template_id`) REFERENCES `payment_term_templates` (`payment_term_template_id`);

--
-- Ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_confirmed_by` FOREIGN KEY (`confirmed_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payments_installment` FOREIGN KEY (`payment_installment_id`) REFERENCES `payment_installments` (`payment_installment_id`),
  ADD CONSTRAINT `fk_payments_qr` FOREIGN KEY (`payment_qr_id`) REFERENCES `payment_qr_codes` (`payment_qr_id`),
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `payment_installments`
--
ALTER TABLE `payment_installments`
  ADD CONSTRAINT `fk_payment_installments_confirmed_by` FOREIGN KEY (`confirmed_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payment_installments_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payment_installments_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_payment_installments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `payment_qr_codes`
--
ALTER TABLE `payment_qr_codes`
  ADD CONSTRAINT `fk_payment_qr_bank_account` FOREIGN KEY (`bank_account_id`) REFERENCES `company_bank_accounts` (`bank_account_id`),
  ADD CONSTRAINT `fk_payment_qr_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payment_qr_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_payment_qr_installment` FOREIGN KEY (`payment_installment_id`) REFERENCES `payment_installments` (`payment_installment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_payment_qr_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `payment_term_templates`
--
ALTER TABLE `payment_term_templates`
  ADD CONSTRAINT `fk_payment_term_templates_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payment_term_templates_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `payment_webhook_logs`
--
ALTER TABLE `payment_webhook_logs`
  ADD CONSTRAINT `fk_webhook_order` FOREIGN KEY (`matched_order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_webhook_payment_installment` FOREIGN KEY (`matched_payment_installment_id`) REFERENCES `payment_installments` (`payment_installment_id`),
  ADD CONSTRAINT `fk_webhook_payment_qr` FOREIGN KEY (`matched_payment_qr_id`) REFERENCES `payment_qr_codes` (`payment_qr_id`);

--
-- Ràng buộc cho bảng `pesticide`
--
ALTER TABLE `pesticide`
  ADD CONSTRAINT `pesticide_product_fk` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `pesticide_crops`
--
ALTER TABLE `pesticide_crops`
  ADD CONSTRAINT `pesticide_crops_ibfk_1` FOREIGN KEY (`PDetailID`) REFERENCES `pesticide_detail` (`PDetailID`),
  ADD CONSTRAINT `pesticide_crops_ibfk_2` FOREIGN KEY (`CropID`) REFERENCES `crops` (`CropID`);

--
-- Ràng buộc cho bảng `pesticide_detail`
--
ALTER TABLE `pesticide_detail`
  ADD CONSTRAINT `pesticide_detail_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `pesticide` (`PID`);

--
-- Ràng buộc cho bảng `pesticide_pests`
--
ALTER TABLE `pesticide_pests`
  ADD CONSTRAINT `pesticide_pests_detail_fk` FOREIGN KEY (`PDetailID`) REFERENCES `pesticide_detail` (`PDetailID`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesticide_pests_pest_fk` FOREIGN KEY (`PestID`) REFERENCES `pests` (`PestID`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `pesticide_usage`
--
ALTER TABLE `pesticide_usage`
  ADD CONSTRAINT `pesticide_usage_ibfk_1` FOREIGN KEY (`PDetailID`) REFERENCES `pesticide_detail` (`PDetailID`),
  ADD CONSTRAINT `pesticide_usage_ibfk_2` FOREIGN KEY (`ToxicID`) REFERENCES `toxicity_level_detail` (`ToxicID`);

--
-- Ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`StatusID`) REFERENCES `product_status` (`StatusID`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`UnitID`) REFERENCES `product_unit` (`PUnitID`);

--
-- Ràng buộc cho bảng `product_embeddings`
--
ALTER TABLE `product_embeddings`
  ADD CONSTRAINT `product_embeddings_product_fk` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`ImageTypeID`) REFERENCES `product_image_type` (`ImageTypeID`);

--
-- Ràng buộc cho bảng `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `fk_user_profile` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ràng buộc cho bảng `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchase_orders_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchase_orders_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchase_orders_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `purchase_order_statuses` (`status_id`);

--
-- Ràng buộc cho bảng `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD CONSTRAINT `purchase_order_details_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `purchase_order_details_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchase_order_details_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `purchase_order_status_logs`
--
ALTER TABLE `purchase_order_status_logs`
  ADD CONSTRAINT `purchase_order_status_logs_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_order_status_logs_ibfk_2` FOREIGN KEY (`old_status_id`) REFERENCES `purchase_order_statuses` (`status_id`),
  ADD CONSTRAINT `purchase_order_status_logs_ibfk_3` FOREIGN KEY (`new_status_id`) REFERENCES `purchase_order_statuses` (`status_id`),
  ADD CONSTRAINT `purchase_order_status_logs_ibfk_4` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD CONSTRAINT `purchase_requests_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `purchase_requests_ibfk_2` FOREIGN KEY (`RequestedBy`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `suppliers_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
