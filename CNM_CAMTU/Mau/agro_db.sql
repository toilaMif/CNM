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

INSERT INTO `inventory` (`InventoryID`, `ProductID`, `Quantity`, `AllocatedQuantity`, `MinStockLevel`, `LocationRack`, `ExpiryDate`, `BatchNumber`, `ManufacturerBatch`, `UpdatedAt`) VALUES
(1, 1, 87, 5, 10, 'A-02', '2028-12-31', 'LO-SP-001-000001', NULL, '2026-05-26 15:25:38'),
(2, 2, 94, 0, 10, 'A-03', '2028-12-31', 'LO-SP-001-000002', NULL, '2026-05-20 10:03:14'),
(3, 3, 101, 0, 10, 'A-04', '2028-12-31', 'LO-SP-001-000003', NULL, '2026-05-20 10:03:14'),
(4, 4, 108, 0, 10, 'A-05', '2028-12-31', 'LO-SP-001-000004', NULL, '2026-05-20 10:03:14'),
(5, 5, 115, 0, 10, 'A-06', '2028-12-31', 'LO-SP-001-000005', NULL, '2026-05-20 10:03:14'),
(6, 6, 122, 0, 10, 'A-07', '2028-12-31', 'LO-SP-001-000006', NULL, '2026-05-20 10:03:14'),
(7, 7, 129, 0, 10, 'A-08', '2028-12-31', 'LO-SP-001-000007', NULL, '2026-05-20 10:03:14'),
(8, 8, 136, 0, 10, 'A-09', '2028-12-31', 'LO-SP-001-000008', NULL, '2026-05-20 10:03:14'),
(9, 9, 143, 0, 10, 'A-10', '2028-12-31', 'LO-SP-001-000009', NULL, '2026-05-20 10:03:14'),
(10, 10, 150, 0, 10, 'A-01', '2028-12-31', 'LO-SP-001-000010', NULL, '2026-05-20 10:03:14'),
(11, 11, 157, 0, 10, 'A-02', '2028-12-31', 'LO-SP-001-000011', NULL, '2026-05-20 10:03:14'),
(12, 12, 164, 0, 10, 'A-03', '2028-12-31', 'LO-SP-001-000012', NULL, '2026-05-20 10:03:14'),
(13, 13, 171, 0, 10, 'A-04', '2028-12-31', 'LO-SP-001-000013', NULL, '2026-05-20 10:03:14'),
(14, 14, 178, 0, 10, 'A-05', '2028-12-31', 'LO-SP-001-000014', NULL, '2026-05-20 10:03:14'),
(15, 15, 185, 0, 10, 'A-06', '2028-12-31', 'LO-SP-001-000015', NULL, '2026-05-20 10:03:14'),
(16, 16, 192, 0, 10, 'A-07', '2028-12-31', 'LO-SP-001-000016', NULL, '2026-05-20 10:03:14'),
(17, 17, 199, 0, 10, 'A-08', '2028-12-31', 'LO-SP-001-000017', NULL, '2026-05-20 10:03:14'),
(18, 18, 206, 0, 10, 'A-09', '2028-12-31', 'LO-SP-001-000018', NULL, '2026-05-20 10:03:14'),
(19, 19, 213, 0, 10, 'A-10', '2028-12-31', 'LO-SP-001-000019', NULL, '2026-05-20 10:03:14'),
(20, 20, 220, 0, 10, 'A-01', '2028-12-31', 'LO-SP-001-000020', NULL, '2026-05-20 10:03:14'),
(21, 21, 227, 0, 5, 'B-02', '2028-12-31', 'LO-SP-002-000021', NULL, '2026-05-20 10:03:14'),
(22, 22, 234, 0, 5, 'B-03', '2028-12-31', 'LO-SP-002-000022', NULL, '2026-05-20 10:03:14'),
(23, 23, 241, 0, 5, 'B-04', '2028-12-31', 'LO-SP-002-000023', NULL, '2026-05-20 10:03:14'),
(24, 24, 248, 0, 5, 'B-05', '2028-12-31', 'LO-SP-002-000024', NULL, '2026-05-20 10:03:14'),
(25, 25, 85, 0, 5, 'B-06', '2028-12-31', 'LO-SP-002-000025', NULL, '2026-05-20 10:03:14'),
(26, 26, 92, 0, 5, 'B-07', '2028-12-31', 'LO-SP-002-000026', NULL, '2026-05-20 10:03:14'),
(27, 27, 99, 0, 5, 'B-08', '2028-12-31', 'LO-SP-002-000027', NULL, '2026-05-20 10:03:14'),
(28, 28, 106, 0, 5, 'B-09', '2028-12-31', 'LO-SP-002-000028', NULL, '2026-05-20 10:03:14'),
(29, 29, 113, 0, 5, 'B-10', '2028-12-31', 'LO-SP-002-000029', NULL, '2026-05-20 10:03:14'),
(30, 30, 120, 0, 5, 'B-01', '2028-12-31', 'LO-SP-002-000030', NULL, '2026-05-20 10:03:14'),
(31, 31, 127, 0, 5, 'B-02', '2028-12-31', 'LO-SP-002-000031', NULL, '2026-05-20 10:03:14'),
(32, 32, 134, 0, 5, 'B-03', '2028-12-31', 'LO-SP-002-000032', NULL, '2026-05-20 10:03:14'),
(33, 33, 141, 0, 5, 'B-04', '2028-12-31', 'LO-SP-002-000033', NULL, '2026-05-20 10:03:14'),
(34, 34, 148, 0, 5, 'B-05', '2028-12-31', 'LO-SP-002-000034', NULL, '2026-05-20 10:03:14'),
(35, 35, 155, 0, 5, 'B-06', '2028-12-31', 'LO-SP-002-000035', NULL, '2026-05-20 10:03:14'),
(36, 36, 162, 0, 5, 'B-07', '2028-12-31', 'LO-SP-002-000036', NULL, '2026-05-20 10:03:14'),
(37, 37, 169, 0, 5, 'B-08', '2028-12-31', 'LO-SP-002-000037', NULL, '2026-05-20 10:03:14'),
(38, 38, 176, 0, 5, 'B-09', '2028-12-31', 'LO-SP-002-000038', NULL, '2026-05-20 10:03:14'),
(39, 39, 183, 0, 5, 'B-10', '2028-12-31', 'LO-SP-002-000039', NULL, '2026-05-20 10:03:14'),
(40, 40, 190, 0, 5, 'B-01', '2028-12-31', 'LO-SP-002-000040', NULL, '2026-05-20 10:03:14'),
(41, 41, 197, 0, 5, 'B-02', '2028-12-31', 'LO-SP-002-000041', NULL, '2026-05-20 10:03:14'),
(42, 42, 204, 0, 5, 'B-03', '2028-12-31', 'LO-SP-002-000042', NULL, '2026-05-20 10:03:14'),
(43, 43, 211, 0, 5, 'B-04', '2028-12-31', 'LO-SP-002-000043', NULL, '2026-05-20 10:03:14'),
(44, 44, 218, 0, 5, 'B-05', '2028-12-31', 'LO-SP-002-000044', NULL, '2026-05-20 10:03:14'),
(45, 45, 225, 0, 5, 'B-06', '2028-12-31', 'LO-SP-002-000045', NULL, '2026-05-20 10:03:14'),
(46, 46, 232, 0, 5, 'B-07', '2028-12-31', 'LO-SP-002-000046', NULL, '2026-05-20 10:03:14'),
(47, 47, 239, 0, 5, 'B-08', '2028-12-31', 'LO-SP-002-000047', NULL, '2026-05-20 10:03:14'),
(48, 48, 246, 0, 5, 'B-09', '2028-12-31', 'LO-SP-002-000048', NULL, '2026-05-20 10:03:14'),
(49, 49, 83, 0, 5, 'B-10', '2028-12-31', 'LO-SP-002-000049', NULL, '2026-05-20 10:03:14'),
(50, 50, 90, 0, 5, 'B-01', '2028-12-31', 'LO-SP-002-000050', NULL, '2026-05-20 10:03:14'),
(51, 51, 97, 0, 10, 'C-02', '2028-12-31', 'LO-SP-003-000051', NULL, '2026-05-20 10:03:14'),
(52, 52, 104, 0, 10, 'C-03', '2028-12-31', 'LO-SP-003-000052', NULL, '2026-05-20 10:03:14'),
(53, 53, 111, 0, 10, 'C-04', '2028-12-31', 'LO-SP-003-000053', NULL, '2026-05-20 10:03:14'),
(54, 54, 118, 0, 10, 'C-05', '2028-12-31', 'LO-SP-003-000054', NULL, '2026-05-20 10:03:14'),
(55, 55, 125, 0, 10, 'C-06', '2028-12-31', 'LO-SP-003-000055', NULL, '2026-05-20 10:03:14'),
(56, 56, 132, 0, 10, 'C-07', '2028-12-31', 'LO-SP-003-000056', NULL, '2026-05-20 10:03:14'),
(57, 57, 139, 0, 10, 'C-08', '2028-12-31', 'LO-SP-003-000057', NULL, '2026-05-20 10:03:14'),
(58, 58, 146, 0, 10, 'C-09', '2028-12-31', 'LO-SP-003-000058', NULL, '2026-05-20 10:03:14'),
(59, 59, 153, 0, 10, 'C-10', '2028-12-31', 'LO-SP-003-000059', NULL, '2026-05-20 10:03:14'),
(60, 60, 160, 0, 10, 'C-01', '2028-12-31', 'LO-SP-003-000060', NULL, '2026-05-20 10:03:14'),
(61, 61, 167, 0, 10, 'C-02', '2028-12-31', 'LO-SP-003-000061', NULL, '2026-05-20 10:03:14'),
(62, 62, 174, 0, 10, 'C-03', '2028-12-31', 'LO-SP-003-000062', NULL, '2026-05-20 10:03:14'),
(63, 63, 181, 0, 10, 'C-04', '2028-12-31', 'LO-SP-003-000063', NULL, '2026-05-20 10:03:14'),
(64, 64, 188, 0, 10, 'C-05', '2028-12-31', 'LO-SP-003-000064', NULL, '2026-05-20 10:03:14'),
(65, 65, 195, 0, 10, 'C-06', '2028-12-31', 'LO-SP-003-000065', NULL, '2026-05-20 10:03:14'),
(66, 66, 202, 0, 10, 'C-07', '2028-12-31', 'LO-SP-003-000066', NULL, '2026-05-20 10:03:14'),
(67, 67, 209, 0, 10, 'C-08', '2028-12-31', 'LO-SP-003-000067', NULL, '2026-05-20 10:03:14'),
(68, 68, 216, 0, 10, 'C-09', '2028-12-31', 'LO-SP-003-000068', NULL, '2026-05-20 10:03:14'),
(69, 69, 223, 0, 10, 'C-10', '2028-12-31', 'LO-SP-003-000069', NULL, '2026-05-20 10:03:14'),
(70, 70, 230, 0, 10, 'C-01', '2028-12-31', 'LO-SP-003-000070', NULL, '2026-05-20 10:03:14'),
(71, 71, 237, 0, 10, 'D-02', NULL, 'LO-SP-004-000071', NULL, '2026-05-20 10:03:14'),
(72, 72, 244, 0, 10, 'D-03', NULL, 'LO-SP-004-000072', NULL, '2026-05-20 10:03:14'),
(73, 73, 81, 0, 10, 'D-04', NULL, 'LO-SP-004-000073', NULL, '2026-05-20 10:03:14'),
(74, 74, 88, 0, 10, 'D-05', NULL, 'LO-SP-004-000074', NULL, '2026-05-20 10:03:14'),
(75, 75, 95, 0, 10, 'D-06', NULL, 'LO-SP-004-000075', NULL, '2026-05-20 10:03:14'),
(76, 76, 102, 0, 10, 'D-07', NULL, 'LO-SP-004-000076', NULL, '2026-05-20 10:03:14'),
(77, 77, 109, 0, 10, 'D-08', NULL, 'LO-SP-004-000077', NULL, '2026-05-20 10:03:14'),
(78, 78, 116, 0, 10, 'D-09', NULL, 'LO-SP-004-000078', NULL, '2026-05-20 10:03:14'),
(79, 79, 123, 0, 10, 'D-10', NULL, 'LO-SP-004-000079', NULL, '2026-05-20 10:03:14'),
(80, 80, 130, 0, 10, 'D-01', NULL, 'LO-SP-004-000080', NULL, '2026-05-20 10:03:14'),
(81, 81, 137, 0, 10, 'D-02', NULL, 'LO-SP-004-000081', NULL, '2026-05-20 10:03:14'),
(82, 82, 144, 0, 10, 'D-03', NULL, 'LO-SP-004-000082', NULL, '2026-05-20 10:03:14'),
(83, 83, 151, 0, 10, 'D-04', NULL, 'LO-SP-004-000083', NULL, '2026-05-20 10:03:14'),
(84, 84, 158, 0, 10, 'D-05', NULL, 'LO-SP-004-000084', NULL, '2026-05-20 10:03:14'),
(85, 85, 165, 0, 10, 'D-06', NULL, 'LO-SP-004-000085', NULL, '2026-05-20 10:03:14'),
(86, 86, 172, 0, 10, 'D-07', NULL, 'LO-SP-004-000086', NULL, '2026-05-20 10:03:14'),
(87, 87, 179, 0, 10, 'D-08', NULL, 'LO-SP-004-000087', NULL, '2026-05-20 10:03:14'),
(88, 88, 186, 0, 10, 'D-09', NULL, 'LO-SP-004-000088', NULL, '2026-05-20 10:03:14'),
(89, 89, 193, 0, 10, 'D-10', NULL, 'LO-SP-004-000089', NULL, '2026-05-20 10:03:14'),
(90, 90, 200, 0, 10, 'D-01', NULL, 'LO-SP-004-000090', NULL, '2026-05-20 10:03:14'),
(91, 73, 4, 0, 10, 'A1-02', NULL, 'LOT-20260523-P73-6259', NULL, '2026-05-23 06:29:01'),
(92, 76, 1500, 0, 10, 'V2-01', NULL, 'LOT-20260523-P76-1409', NULL, '2026-05-23 07:20:02'),
(93, 51, 1000000, 0, 10, 'V2-03', NULL, 'LOT-20260523-P51-7074', NULL, '2026-05-23 07:20:02'),
(94, 6, 4850, 0, 10, 'A2-12', NULL, 'LOT-20260523-P6-1263', NULL, '2026-05-23 08:08:33'),
(95, 76, 1952, 0, 10, 'A8-09', NULL, 'LOT-20260524-P76-9154', NULL, '2026-05-24 05:56:58'),
(96, 51, 1000000, 0, 10, 'A8-10', NULL, 'LOT-20260524-P51-4467', NULL, '2026-05-24 05:56:58'),
(97, 76, 48, 0, 10, 'A8-02', NULL, 'LOT-20260524-P76-6367', NULL, '2026-05-24 06:15:59'),
(98, 76, 10, 0, 10, 'A01', NULL, 'LOT-20260524-P76-4424', NULL, '2026-05-24 06:27:53'),
(99, 76, 48, 0, 10, 'A03r', NULL, 'LOT-20260524-P76-9938', NULL, '2026-05-24 06:31:57');

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

INSERT INTO `pesticide` (`PID`, `ProductID`, `Name`, `Description`) VALUES
(1, 16, 'ABAMECTIN 3.6EC', 'Diệt nhện đỏ, sâu tơ, bọ trĩ, sâu cuốn lá non'),
(2, 17, 'EMAMECTIN BENZOATE 5WG', 'Trừ sâu tơ, sâu xanh da láng, sâu đục trái, sâu cuốn lá'),
(3, 18, 'CHLORANTRANILIPROLE 35WG', 'Đặc trị sâu đục thân, sâu cuốn lá, sâu keo, sâu đục trái'),
(4, 19, 'DINOTEFURAN 20SG', 'Trừ rầy nâu, rệp sáp, bọ phấn, rệp mềm, côn trùng chích hút'),
(5, 20, 'IMIDACLOPRID 100SL', 'Trừ rầy, rệp, bọ trĩ, bọ phấn; tác động lưu dẫn'),
(6, 21, 'PYMETROZINE 50WG', 'Trừ rầy nâu, rầy lưng trắng, rệp mềm bằng cơ chế ức chế chích hút'),
(7, 22, 'CYPERMETHRIN 25EC', 'Trừ sâu ăn lá, bọ xít, sâu khoang, sâu xanh'),
(8, 23, 'LAMBDA-CYHALOTHRIN 2.5EC', 'Trừ sâu cuốn lá, sâu xanh, bọ nhảy, bọ xít'),
(9, 24, 'SPIROTETRAMAT 100SC', 'Trừ rệp sáp, rệp vảy, bọ phấn, côn trùng chích hút lưu dẫn hai chiều'),
(10, 25, 'FIPRONIL 800WG', 'Trừ sâu đục thân, bọ trĩ, kiến, mối, một số côn trùng đất'),
(11, 26, 'METALAXYL + MANCOZEB 72WP', 'Phòng trị sương mai, thối rễ, chết cây con do nấm giả'),
(12, 27, 'HEXACONAZOLE 5SC', 'Trừ lem lép hạt, khô vằn, phấn trắng, đốm lá'),
(13, 28, 'DIFENOCONAZOLE 250EC', 'Trừ thán thư, đốm lá, rỉ sắt, phấn trắng'),
(14, 29, 'PROPICONAZOLE 250EC', 'Trị rỉ sắt, đốm lá, khô vằn, vàng lá do nấm'),
(15, 30, 'AZOXYSTROBIN 250SC', 'Phòng trị nhiều bệnh nấm, xanh lá, kéo dài thời gian quang hợp'),
(16, 31, 'COPPER HYDROXIDE 77WP', 'Phòng trị loét vi khuẩn, sẹo trái, thán thư, đốm lá'),
(17, 32, 'KASUGAMYCIN 2SL', 'Trị bệnh vi khuẩn, cháy bìa lá, thối nhũn, đốm lá vi khuẩn'),
(18, 33, 'VALIDAMYCIN 5SL', 'Đặc trị khô vằn lúa, nấm hại bẹ và thân'),
(19, 34, 'CARBENDAZIM 500FL', 'Trừ thán thư, đốm lá, héo rũ do nấm, nấm hại hạt giống'),
(20, 35, 'TEBUCONAZOLE 250EW', 'Trừ lem lép hạt, rỉ sắt, phấn trắng, thán thư'),
(21, 36, 'GLYPHOSATE 480SL', 'Trừ cỏ không chọn lọc, diệt cỏ lâu năm qua lá'),
(22, 37, 'PARAQUAT 276SL', 'Trừ cỏ tiếp xúc, làm cháy nhanh phần xanh của cỏ'),
(23, 38, 'BUTACHLOR 600EC', 'Trừ cỏ tiền nảy mầm và hậu nảy mầm sớm trên ruộng lúa'),
(24, 39, 'PRETILACHLOR 300EC', 'Trừ cỏ tiền nảy mầm trên lúa, an toàn khi dùng đúng liều'),
(25, 40, '2,4-D 720SL', 'Trừ cỏ lá rộng, cỏ chác lác trong ruộng lúa'),
(26, 41, 'BISPYRIBAC-SODIUM 10SC', 'Trừ cỏ hậu nảy mầm trên ruộng lúa, cỏ hòa bản và lá rộng'),
(27, 42, 'GA3 10SP', 'Kích thích kéo dài tế bào, tăng sinh trưởng, hỗ trợ ra hoa đậu trái tùy cây'),
(28, 43, 'NAA 1.8SL', 'Hạn chế rụng trái non, kích thích ra rễ, tăng đậu trái'),
(29, 44, 'ATONIK 1.8SL', 'Kích thích sinh trưởng, tăng trao đổi chất, phục hồi cây sau stress'),
(30, 45, 'PACLOBUTRAZOL 15WP', 'Ức chế sinh trưởng thân lá, hỗ trợ phân hóa mầm hoa'),
(31, 46, 'CYTOKININ 6-BA 2SL', 'Kích thích phân chia tế bào, bật chồi, tăng kích thước trái non'),
(32, 47, 'ETHREL 480SL', 'Thúc chín đồng loạt, xử lý ra hoa một số cây, điều hòa sinh trưởng'),
(33, 68, 'COPPER OXYCHLORIDE 85WP', 'Phòng trị bệnh do nấm và vi khuẩn như loét, đốm lá, sẹo trái'),
(34, 69, 'MANCOZEB 80WP', 'Phòng trị đốm lá, thán thư, sương mai, cháy lá'),
(35, 70, 'CHLOROTHALONIL 75WP', 'Thuốc tiếp xúc phổ rộng, phòng trị đốm lá, cháy lá, sương mai'),
(36, 71, 'CYMOXANIL + MANCOZEB 72WP', 'Đặc trị sương mai, mốc sương, cháy lá do nấm giả'),
(37, 72, 'FOSETYL-AL 80WP', 'Phòng trị thối rễ, xì mủ, sương mai; tăng sức đề kháng cây'),
(38, 73, 'METALAXYL 25WP', 'Trị nấm giả, thối rễ, chết cây con, sương mai'),
(39, 74, 'TRIFLOXYSTROBIN + TEBUCONAZOLE', 'Trừ thán thư, phấn trắng, đốm lá, lem lép hạt; hiệu lực phòng và trị'),
(40, 75, 'THIOPHANATE-METHYL 70WP', 'Trừ nấm lưu dẫn như thán thư, đốm lá, héo rũ, thối thân'),
(41, 76, 'SULFUR 80WG', 'Phòng trị phấn trắng, nhện nhẹ; hỗ trợ giảm nấm ngoài bề mặt lá'),
(42, 77, 'BACILLUS SUBTILIS SINH HỌC', 'Đối kháng nấm bệnh, giảm thối rễ, chết cây con, tăng vi sinh có lợi'),
(43, 78, 'SPINETORAM 60SC', 'Trừ sâu tơ, sâu xanh, bọ trĩ, sâu đục trái; hiệu lực tốt trên sâu non'),
(44, 79, 'SPINOSAD 25SC', 'Trừ sâu tơ, sâu xanh, ruồi đục lá, bọ trĩ theo hướng sinh học'),
(45, 80, 'INDOXACARB 150SC', 'Trừ sâu khoang, sâu xanh, sâu tơ, sâu đục trái'),
(46, 81, 'LUFENURON 50EC', 'Ức chế lột xác sâu non, trừ sâu tơ, sâu xanh, sâu khoang'),
(47, 82, 'CHLORFENAPYR 240SC', 'Trừ sâu kháng thuốc, bọ trĩ, nhện, sâu ăn lá'),
(48, 83, 'BUPROFEZIN 25SC', 'Trừ rầy nâu, rệp sáp, rệp vảy bằng cơ chế ức chế lột xác'),
(49, 84, 'ACETAMIPRID 20SP', 'Trừ rệp, bọ phấn, rầy xanh, rầy mềm, bọ trĩ nhẹ'),
(50, 85, 'THIAMETHOXAM 25WG', 'Trừ rầy nâu, rệp, bọ phấn, bọ trĩ; có tính lưu dẫn'),
(51, 86, 'CARTAP HYDROCHLORIDE 95SP', 'Trừ sâu đục thân, sâu cuốn lá, sâu ăn lá trên lúa và rau'),
(52, 87, 'MATRINE 0.6SL', 'Trừ rệp, sâu non, bọ trĩ mức nhẹ; phù hợp chương trình sinh học'),
(53, 88, 'BEAUVERIA BASSIANA SINH HỌC', 'Ký sinh côn trùng, hỗ trợ quản lý rầy, rệp, bọ cánh cứng, sâu non'),
(54, 89, 'DẦU KHOÁNG 99EC', 'Phòng trừ rệp sáp, rệp vảy, nhện, trứng sâu; hỗ trợ rửa nấm bồ hóng'),
(55, 90, 'METALDEHYDE 6GR', 'Diệt ốc bươu vàng, ốc sên, nhớt hại cây con'),
(56, 91, 'GLUFOSINATE-AMMONIUM 200SL', 'Trừ cỏ không chọn lọc, tác động tiếp xúc-lưu dẫn hạn chế'),
(57, 92, 'QUIZALOFOP-P-ETHYL 10EC', 'Trừ cỏ hòa bản hậu nảy mầm trong cây lá rộng'),
(58, 93, 'FENOXAPROP-P-ETHYL 69EC', 'Trừ cỏ hòa bản hậu nảy mầm trong ruộng lúa'),
(59, 94, 'PENOXSULAM 25OD', 'Trừ cỏ lúa hậu nảy mầm, phổ rộng trên cỏ hòa bản, lá rộng, chác lác'),
(60, 95, 'ATRAZINE 80WP', 'Trừ cỏ tiền và hậu nảy mầm sớm trên bắp, mía'),
(61, 96, 'IBA KÍCH RỄ 98%', 'Kích thích ra rễ cho hom giâm, cây chiết, cây cấy mô'),
(62, 97, 'BRASSINOLIDE 0.01SL', 'Tăng sức chống chịu, hỗ trợ quang hợp, cải thiện đậu trái và phục hồi stress'),
(63, 98, 'CHITOSAN OLIGO 5SL', 'Kích kháng tự nhiên, tăng đề kháng nấm khuẩn, hỗ trợ phục hồi mô cây');

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

INSERT INTO `pesticide_crops` (`ID`, `PDetailID`, `CropID`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 2, 3),
(5, 3, 3),
(6, 3, 4),
(7, 4, 4),
(8, 4, 5),
(9, 5, 5),
(10, 5, 6),
(11, 6, 6),
(12, 6, 7),
(13, 7, 7),
(14, 7, 8),
(15, 8, 8),
(16, 8, 9),
(17, 9, 9),
(18, 9, 10),
(19, 10, 10),
(20, 10, 11),
(21, 11, 11),
(22, 11, 12),
(23, 12, 12),
(24, 12, 13),
(25, 13, 13),
(26, 13, 14),
(27, 14, 14),
(28, 14, 15),
(29, 15, 15),
(30, 15, 1),
(31, 16, 1),
(32, 16, 2),
(33, 17, 2),
(34, 17, 3),
(35, 18, 3),
(36, 18, 4),
(37, 19, 4),
(38, 19, 5),
(39, 20, 5),
(40, 20, 6),
(41, 21, 6),
(42, 21, 7),
(43, 22, 7),
(44, 22, 8),
(45, 23, 8),
(46, 23, 9),
(47, 24, 9),
(48, 24, 10),
(49, 25, 10),
(50, 25, 11),
(51, 26, 11),
(52, 26, 12),
(53, 27, 12),
(54, 27, 13),
(55, 28, 13),
(56, 28, 14),
(57, 29, 14),
(58, 29, 15),
(59, 30, 15),
(60, 30, 1),
(61, 31, 1),
(62, 31, 2),
(63, 32, 2),
(64, 32, 3),
(65, 33, 3),
(66, 33, 4),
(67, 34, 4),
(68, 34, 5),
(69, 35, 5),
(70, 35, 6),
(71, 36, 6),
(72, 36, 7),
(73, 37, 7),
(74, 37, 8),
(75, 38, 8),
(76, 38, 9),
(77, 39, 9),
(78, 39, 10),
(79, 40, 10),
(80, 40, 11),
(81, 41, 11),
(82, 41, 12),
(83, 42, 12),
(84, 42, 13),
(85, 43, 13),
(86, 43, 14),
(87, 44, 14),
(88, 44, 15),
(89, 45, 15),
(90, 45, 1),
(91, 46, 1),
(92, 46, 2),
(93, 47, 2),
(94, 47, 3),
(95, 48, 3),
(96, 48, 4),
(97, 49, 4),
(98, 49, 5),
(99, 50, 5),
(100, 50, 6),
(101, 51, 6),
(102, 51, 7),
(103, 52, 7),
(104, 52, 8),
(105, 53, 8),
(106, 53, 9),
(107, 54, 9),
(108, 54, 10),
(109, 55, 10),
(110, 55, 11),
(111, 56, 11),
(112, 56, 12),
(113, 57, 12),
(114, 57, 13),
(115, 58, 13),
(116, 58, 14),
(117, 59, 14),
(118, 59, 15),
(119, 60, 15),
(120, 60, 1),
(121, 61, 1),
(122, 61, 2),
(123, 62, 2),
(124, 62, 3),
(125, 63, 3),
(126, 63, 4);

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

INSERT INTO `pesticide_detail` (`PDetailID`, `PID`, `Dosage`, `Method`, `Time`, `Harvest_interval`, `Safety_warning`) VALUES
(1, 1, 'Pha 8-12ml/bình 16 lít; phun kỹ mặt dưới lá', 'Diệt nhện đỏ, sâu tơ, bọ trĩ, sâu cuốn lá non', 'Khi phát hiện mật số sâu nhện thấp đến trung bình', 'Theo nhãn sản phẩm', 'Mang đồ bảo hộ; không phun gần ao cá; tuân thủ thời gian cách ly'),
(2, 2, 'Pha 5-8g/bình 16 lít; phun đều tán lá', 'Trừ sâu tơ, sâu xanh da láng, sâu đục trái, sâu cuốn lá', 'Phun khi sâu tuổi nhỏ, trước khi sâu chui sâu vào trái', 'Theo nhãn sản phẩm', 'Luân phiên hoạt chất để tránh kháng thuốc; không phun khi cây đang ra hoa rộ'),
(3, 3, 'Pha 2-4g/bình 16 lít; lúa dùng theo khuyến cáo trên nhãn', 'Đặc trị sâu đục thân, sâu cuốn lá, sâu keo, sâu đục trái', 'Phun sớm khi trứng mới nở hoặc sâu tuổi 1-2', 'Theo nhãn sản phẩm', 'Không lạm dụng một hoạt chất nhiều vụ; bảo quản xa trẻ em'),
(4, 4, 'Pha 8-12g/bình 16 lít; phun kỹ nơi côn trùng cư trú', 'Trừ rầy nâu, rệp sáp, bọ phấn, rệp mềm, côn trùng chích hút', 'Khi thấy rầy, rệp, bọ phấn xuất hiện rải rác', 'Theo nhãn sản phẩm', 'Hạn chế phun lúc có ong hoạt động; không pha tùy tiện với thuốc kiềm'),
(5, 5, 'Pha 10-15ml/bình 16 lít; phun đều thân lá', 'Trừ rầy, rệp, bọ trĩ, bọ phấn; tác động lưu dẫn', 'Giai đoạn cây con, ra đọt non, khi rầy rệp mới xuất hiện', 'Theo nhãn sản phẩm', 'Độc với ong; không dùng sát ngày thu hoạch; đọc kỹ nhãn'),
(6, 6, 'Pha 6-10g/bình 16 lít; ruộng lúa phun đủ nước thuốc', 'Trừ rầy nâu, rầy lưng trắng, rệp mềm bằng cơ chế ức chế chích hút', 'Khi rầy tuổi nhỏ, mật số vừa phải, trước khi cháy rầy', 'Theo nhãn sản phẩm', 'Không phun trễ khi mật số quá cao; luân phiên với nhóm khác'),
(7, 7, 'Pha 15-25ml/bình 16 lít; phun đều nơi sâu trú ẩn', 'Trừ sâu ăn lá, bọ xít, sâu khoang, sâu xanh', 'Khi sâu mới phát sinh, phun vào chiều mát', 'Theo nhãn sản phẩm', 'Có thể ảnh hưởng thiên địch; không phun gần nguồn nước'),
(8, 8, 'Pha 10-15ml/bình 16 lít', 'Trừ sâu cuốn lá, sâu xanh, bọ nhảy, bọ xít', 'Phun khi sâu tuổi nhỏ hoặc bọ nhảy mới xuất hiện', 'Theo nhãn sản phẩm', 'Đeo khẩu trang, kính, găng tay; tránh phun ngược chiều gió'),
(9, 9, 'Pha 12-20ml/bình 16 lít; phun kỹ cành, kẽ lá, chùm trái', 'Trừ rệp sáp, rệp vảy, bọ phấn, côn trùng chích hút lưu dẫn hai chiều', 'Khi rệp mới xuất hiện, sau cắt tỉa tạo tán', 'Theo nhãn sản phẩm', 'Không pha với dầu khoáng liều cao nếu cây đang yếu'),
(10, 10, 'Pha 3-5g/bình 16 lít hoặc xử lý theo nhãn cho từng cây', 'Trừ sâu đục thân, bọ trĩ, kiến, mối, một số côn trùng đất', 'Xử lý sớm khi phát hiện ổ sâu hoặc trước giai đoạn mẫn cảm', 'Theo nhãn sản phẩm', 'Độc với thủy sinh; không để thuốc chảy xuống ao hồ'),
(11, 11, 'Pha 25-35g/bình 16 lít; phun hoặc tưới gốc tùy bệnh', 'Phòng trị sương mai, thối rễ, chết cây con do nấm giả', 'Trước và sau mưa, khi bệnh mới chớm', 'Theo nhãn sản phẩm', 'Luân phiên hoạt chất; không phun gần ngày thu hoạch'),
(12, 12, 'Pha 15-20ml/bình 16 lít; phun đều vùng bệnh', 'Trừ lem lép hạt, khô vằn, phấn trắng, đốm lá', 'Khi bệnh mới xuất hiện hoặc trước giai đoạn trổ lúa', 'Theo nhãn sản phẩm', 'Không dùng liên tục nhiều lần; mang bảo hộ khi pha phun'),
(13, 13, 'Pha 8-12ml/bình 16 lít; phun 2 lần cách nhau 7 ngày', 'Trừ thán thư, đốm lá, rỉ sắt, phấn trắng', 'Phun phòng trước mưa hoặc khi bệnh mới chớm', 'Theo nhãn sản phẩm', 'Không pha với dung dịch kiềm; tuân thủ thời gian cách ly'),
(14, 14, 'Pha 10-15ml/bình 16 lít', 'Trị rỉ sắt, đốm lá, khô vằn, vàng lá do nấm', 'Khi bệnh xuất hiện 5-10% lá hoặc phun phòng mùa mưa', 'Theo nhãn sản phẩm', 'Luân phiên thuốc để hạn chế kháng; tránh phun lúc trời gió mạnh'),
(15, 15, 'Pha 8-12ml/bình 16 lít', 'Phòng trị nhiều bệnh nấm, xanh lá, kéo dài thời gian quang hợp', 'Phun phòng đầu mùa bệnh hoặc khi vết bệnh mới xuất hiện', 'Theo nhãn sản phẩm', 'Không dùng quá 2 lần liên tiếp; tránh pha với thuốc kiềm mạnh'),
(16, 16, 'Pha 20-30g/bình 16 lít; phun phủ đều bề mặt lá', 'Phòng trị loét vi khuẩn, sẹo trái, thán thư, đốm lá', 'Phun phòng trước mưa, sau cắt tỉa, sau mưa đá/gió mạnh', 'Theo nhãn sản phẩm', 'Không pha với phân bón lá chứa lân cao; có thể gây xót lá non'),
(17, 17, 'Pha 15-25ml/bình 16 lít; phun 2 lần cách 5-7 ngày', 'Trị bệnh vi khuẩn, cháy bìa lá, thối nhũn, đốm lá vi khuẩn', 'Khi bệnh mới xuất hiện, sau mưa kéo dài', 'Theo nhãn sản phẩm', 'Không lạm dụng kháng sinh nông nghiệp; dùng đúng nhãn'),
(18, 18, 'Pha 30-40ml/bình 16 lít hoặc dùng theo liều ruộng lúa trên nhãn', 'Đặc trị khô vằn lúa, nấm hại bẹ và thân', 'Giai đoạn lúa đẻ nhánh rộ đến làm đòng, khi bệnh chớm', 'Theo nhãn sản phẩm', 'Giữ mực nước hợp lý; không bón thừa đạm'),
(19, 19, 'Pha 10-20ml/bình 16 lít; xử lý theo nhãn từng mục đích', 'Trừ thán thư, đốm lá, héo rũ do nấm, nấm hại hạt giống', 'Khi bệnh mới xuất hiện hoặc xử lý hạt giống trước gieo', 'Theo nhãn sản phẩm', 'Luân phiên hoạt chất; không dùng quá liều để tránh tồn dư'),
(20, 20, 'Pha 10-15ml/bình 16 lít', 'Trừ lem lép hạt, rỉ sắt, phấn trắng, thán thư', 'Trước trổ, sau trổ 5-7 ngày hoặc khi bệnh chớm', 'Theo nhãn sản phẩm', 'Không phun lúc cây đang thiếu nước nặng; tránh phun giữa trưa'),
(21, 21, 'Pha 80-120ml/bình 16 lít; phun ướt đều lá cỏ', 'Trừ cỏ không chọn lọc, diệt cỏ lâu năm qua lá', 'Phun khi cỏ đang sinh trưởng mạnh, cao 15-30cm', 'Theo nhãn sản phẩm', 'Tránh để thuốc dính lá, thân xanh cây trồng; không phun lúc gió mạnh'),
(22, 22, 'Pha theo nhãn; chỉ dùng khi sản phẩm được phép lưu hành tại địa phương', 'Trừ cỏ tiếp xúc, làm cháy nhanh phần xanh của cỏ', 'Khi cỏ còn non, phun tránh cây trồng', 'Theo nhãn sản phẩm', 'Rất độc, bắt buộc đồ bảo hộ đầy đủ; không dùng sai quy định pháp luật'),
(23, 23, 'Pha 40-60ml/bình 16 lít hoặc dùng 1-1,5 lít/ha tùy nhãn', 'Trừ cỏ tiền nảy mầm và hậu nảy mầm sớm trên ruộng lúa', 'Sau sạ 1-4 ngày, ruộng đủ ẩm hoặc có nước mỏng', 'Theo nhãn sản phẩm', 'Không dùng khi lúa yếu, ruộng khô nứt; giữ nước đúng kỹ thuật'),
(24, 24, 'Dùng 0,8-1,2 lít/ha; phun khi ruộng đủ ẩm', 'Trừ cỏ tiền nảy mầm trên lúa, an toàn khi dùng đúng liều', 'Sau sạ 1-3 ngày, trước khi cỏ mọc mạnh', 'Theo nhãn sản phẩm', 'Không phun khi mưa lớn sắp xảy ra; không để nước ngập sâu sau phun'),
(25, 25, 'Pha 20-30ml/bình 16 lít; phun tránh gió tạt sang cây mẫn cảm', 'Trừ cỏ lá rộng, cỏ chác lác trong ruộng lúa', 'Sau sạ 15-25 ngày, khi lúa đã cứng cây', 'Theo nhãn sản phẩm', 'Không phun gần rau màu, bông, cây ăn trái non; dễ gây dị dạng cây mẫn cảm'),
(26, 26, 'Pha 20-30ml/bình 16 lít; rút cạn nước trước phun, cho nước lại sau 1-2 ngày', 'Trừ cỏ hậu nảy mầm trên ruộng lúa, cỏ hòa bản và lá rộng', 'Sau sạ 8-18 ngày, khi cỏ 2-4 lá', 'Theo nhãn sản phẩm', 'Không phun khi lúa bị ngộ độc phèn, mặn hoặc rét'),
(27, 27, 'Pha 1-2g/100 lít nước tùy mục đích; cần theo đúng khuyến cáo từng cây', 'Kích thích kéo dài tế bào, tăng sinh trưởng, hỗ trợ ra hoa đậu trái tùy cây', 'Giai đoạn cần kích chồi, kéo gié, xử lý ra hoa tùy cây', 'Theo nhãn sản phẩm', 'Dùng quá liều dễ làm cây vống, yếu; không pha tùy tiện'),
(28, 28, 'Pha 5-10ml/bình 16 lít cho phun; xử lý hom theo nhãn', 'Hạn chế rụng trái non, kích thích ra rễ, tăng đậu trái', 'Sau đậu trái, khi giâm hom, giai đoạn cây cần phục hồi rễ', 'Theo nhãn sản phẩm', 'Dùng sai liều có thể gây rụng lá, dị dạng trái; đọc kỹ hướng dẫn'),
(29, 29, 'Pha 6-10ml/bình 16 lít; phun 1-2 lần cách 7 ngày', 'Kích thích sinh trưởng, tăng trao đổi chất, phục hồi cây sau stress', 'Sau cấy, sau trồng, trước ra hoa, sau khi cây bị stress', 'Theo nhãn sản phẩm', 'Không thay thế phân bón; không dùng quá liều vì dễ rối loạn sinh trưởng'),
(30, 30, 'Liều phụ thuộc tuổi cây và đường kính tán; thường tưới quanh vùng rễ theo nhãn', 'Ức chế sinh trưởng thân lá, hỗ trợ phân hóa mầm hoa', 'Trước giai đoạn xử lý ra hoa, khi cây đã đủ sức', 'Theo nhãn sản phẩm', 'Không dùng cho cây yếu; dư liều gây suy cây kéo dài nhiều vụ'),
(31, 31, 'Pha 5-10ml/bình 16 lít; phun theo tán hoặc xử lý điểm', 'Kích thích phân chia tế bào, bật chồi, tăng kích thước trái non', 'Sau cắt tỉa, giai đoạn nuôi trái non, kích chồi', 'Theo nhãn sản phẩm', 'Dùng đúng liều; không phun khi cây thiếu nước nặng'),
(32, 32, 'Pha theo nhãn từng cây; không dùng tùy tiện vì liều rất nhạy', 'Thúc chín đồng loạt, xử lý ra hoa một số cây, điều hòa sinh trưởng', 'Giai đoạn xử lý chín hoặc xử lý ra hoa theo quy trình kỹ thuật', 'Theo nhãn sản phẩm', 'Có tính acid; tránh dính da mắt; không pha với thuốc kiềm mạnh'),
(33, 33, 'Pha 20-30g/bình 16 lít; phun phủ đều tán lá và trái', 'Phòng trị bệnh do nấm và vi khuẩn như loét, đốm lá, sẹo trái', 'Phun phòng trước mưa, sau cắt tỉa hoặc khi bệnh mới xuất hiện', 'Theo nhãn sản phẩm', 'Có thể gây xót lá non; không pha với phân bón lá chứa lân cao'),
(34, 34, 'Pha 25-40g/bình 16 lít; phun ướt đều hai mặt lá', 'Phòng trị đốm lá, thán thư, sương mai, cháy lá', 'Phun phòng định kỳ mùa mưa hoặc khi bệnh mới chớm', 'Theo nhãn sản phẩm', 'Không dùng quá gần thu hoạch; mang khẩu trang khi pha bột thuốc'),
(35, 35, 'Pha 20-30g/bình 16 lít; phun phủ đều bề mặt lá', 'Thuốc tiếp xúc phổ rộng, phòng trị đốm lá, cháy lá, sương mai', 'Phun phòng trước thời kỳ bệnh thường phát sinh hoặc sau mưa', 'Theo nhãn sản phẩm', 'Không pha với dầu khoáng; tránh hít bụi thuốc khi pha'),
(36, 36, 'Pha 25-35g/bình 16 lít; phun 2 lần cách 5-7 ngày', 'Đặc trị sương mai, mốc sương, cháy lá do nấm giả', 'Khi bệnh mới chớm hoặc phun phòng trước mưa kéo dài', 'Theo nhãn sản phẩm', 'Luân phiên hoạt chất; không phun quá liều trên cây non'),
(37, 37, 'Pha 30-40g/bình 16 lít phun hoặc tưới gốc theo nhãn', 'Phòng trị thối rễ, xì mủ, sương mai; tăng sức đề kháng cây', 'Đầu mùa mưa, sau mưa kéo dài, khi vườn có biểu hiện thối rễ', 'Theo nhãn sản phẩm', 'Kết hợp cải tạo thoát nước; không chỉ dựa vào thuốc khi đất úng nặng'),
(38, 38, 'Pha 15-25g/bình 16 lít tưới gốc hoặc phun theo nhãn', 'Trị nấm giả, thối rễ, chết cây con, sương mai', 'Xử lý đất trước trồng, tưới gốc khi bệnh mới xuất hiện', 'Theo nhãn sản phẩm', 'Dễ kháng thuốc nếu dùng đơn hoạt chất liên tục; cần luân phiên'),
(39, 39, 'Pha 3-5g/bình 16 lít; phun đều tán cây', 'Trừ thán thư, phấn trắng, đốm lá, lem lép hạt; hiệu lực phòng và trị', 'Khi bệnh mới xuất hiện, trước trổ lúa hoặc trước mùa mưa', 'Theo nhãn sản phẩm', 'Không dùng liên tục nhiều lần; tuân thủ thời gian cách ly'),
(40, 40, 'Pha 10-20g/bình 16 lít; phun ướt đều vùng bệnh', 'Trừ nấm lưu dẫn như thán thư, đốm lá, héo rũ, thối thân', 'Phun khi bệnh chớm hoặc xử lý vết cắt sau tỉa cành', 'Theo nhãn sản phẩm', 'Luân phiên với nhóm khác để hạn chế kháng thuốc'),
(41, 41, 'Pha 20-30g/bình 16 lít; phun phủ đều hai mặt lá', 'Phòng trị phấn trắng, nhện nhẹ; hỗ trợ giảm nấm ngoài bề mặt lá', 'Khi bệnh mới chớm, phun phòng thời kỳ dễ phát bệnh', 'Theo nhãn sản phẩm', 'Không phun khi nhiệt độ quá cao; không pha chung dầu khoáng gần thời điểm phun'),
(42, 42, 'Pha 500g/200-400 lít nước tưới gốc; có thể trộn phân hữu cơ hoai', 'Đối kháng nấm bệnh, giảm thối rễ, chết cây con, tăng vi sinh có lợi', 'Xử lý đất trước trồng, tưới định kỳ phòng bệnh rễ', 'Theo nhãn sản phẩm', 'Không pha cùng thuốc nấm hóa học mạnh; dùng chiều mát để bảo vệ vi sinh'),
(43, 43, 'Pha 6-10ml/bình 16 lít; phun kỹ đọt non, hoa và mặt dưới lá', 'Trừ sâu tơ, sâu xanh, bọ trĩ, sâu đục trái; hiệu lực tốt trên sâu non', 'Khi sâu tuổi nhỏ hoặc bọ trĩ mới xuất hiện', 'Theo nhãn sản phẩm', 'Hạn chế phun lúc ong hoạt động; luân phiên hoạt chất để tránh kháng'),
(44, 44, 'Pha 10-15ml/bình 16 lít; phun chiều mát', 'Trừ sâu tơ, sâu xanh, ruồi đục lá, bọ trĩ theo hướng sinh học', 'Giai đoạn cây non, ra hoa, khi sâu mới phát sinh', 'Theo nhãn sản phẩm', 'Tương đối chọn lọc nhưng vẫn cần tránh phun trực tiếp lên ong'),
(45, 45, 'Pha 8-12ml/bình 16 lít; phun đều tán lá', 'Trừ sâu khoang, sâu xanh, sâu tơ, sâu đục trái', 'Phun sớm khi sâu mới nở, trước khi sâu chui vào trái', 'Theo nhãn sản phẩm', 'Không phun quá liều; tuân thủ cách ly trên rau ăn lá'),
(46, 46, 'Pha 10-15ml/bình 16 lít; phun lặp lại sau 7 ngày nếu cần', 'Ức chế lột xác sâu non, trừ sâu tơ, sâu xanh, sâu khoang', 'Phun khi sâu còn nhỏ hoặc khi thấy ổ trứng mới nở', 'Theo nhãn sản phẩm', 'Không mong hiệu lực hạ gục tức thì; phối hợp quản lý IPM'),
(47, 47, 'Pha 8-12ml/bình 16 lít; phun kỹ mặt dưới lá', 'Trừ sâu kháng thuốc, bọ trĩ, nhện, sâu ăn lá', 'Khi mật số sâu/bọ trĩ tăng, phun lúc chiều mát', 'Theo nhãn sản phẩm', 'Không phun khi cây đang stress nặng; tránh để thuốc trôi xuống ao cá'),
(48, 48, 'Pha 20-30ml/bình 16 lít; phun kỹ nơi rầy rệp trú', 'Trừ rầy nâu, rệp sáp, rệp vảy bằng cơ chế ức chế lột xác', 'Khi rầy/rệp tuổi non chiếm đa số', 'Theo nhãn sản phẩm', 'Hiệu lực chậm, không dùng đơn độc khi mật số quá cao'),
(49, 49, 'Pha 8-12g/bình 16 lít; phun đều tán lá', 'Trừ rệp, bọ phấn, rầy xanh, rầy mềm, bọ trĩ nhẹ', 'Khi phát hiện côn trùng chích hút trên đọt non hoặc mặt dưới lá', 'Theo nhãn sản phẩm', 'Không lạm dụng nhóm neonicotinoid; tránh phun lúc ong hoạt động'),
(50, 50, 'Pha 5-10g/bình 16 lít; xử lý hạt giống theo liều ghi trên nhãn', 'Trừ rầy nâu, rệp, bọ phấn, bọ trĩ; có tính lưu dẫn', 'Xử lý hạt, tưới gốc hoặc phun khi dịch hại mới xuất hiện theo nhãn', 'Theo nhãn sản phẩm', 'Độc với ong; không dùng tùy tiện trên cây đang ra hoa'),
(51, 51, 'Pha 8-12g/bình 16 lít; ruộng lúa dùng lượng nước đủ phủ tán', 'Trừ sâu đục thân, sâu cuốn lá, sâu ăn lá trên lúa và rau', 'Giai đoạn sâu tuổi nhỏ, lúa đẻ nhánh-làm đòng', 'Theo nhãn sản phẩm', 'Không pha với thuốc có tính kiềm mạnh; bảo quản xa thức ăn'),
(52, 52, 'Pha 20-30ml/bình 16 lít; phun lặp lại 5-7 ngày nếu cần', 'Trừ rệp, sâu non, bọ trĩ mức nhẹ; phù hợp chương trình sinh học', 'Phun phòng hoặc khi dịch hại mới xuất hiện mật số thấp', 'Theo nhãn sản phẩm', 'Hiệu lực nhẹ hơn thuốc hóa học; tránh phun khi mưa sắp đến'),
(53, 53, 'Pha 500g/200 lít nước; phun kỹ nơi côn trùng trú ẩn', 'Ký sinh côn trùng, hỗ trợ quản lý rầy, rệp, bọ cánh cứng, sâu non', 'Phun chiều mát khi ẩm độ cao, giai đoạn dịch hại mới phát sinh', 'Theo nhãn sản phẩm', 'Không pha chung thuốc trừ nấm; tránh nắng gắt để bảo vệ bào tử'),
(54, 54, 'Pha 50-80ml/bình 16 lít; phun ướt đều thân cành và mặt dưới lá', 'Phòng trừ rệp sáp, rệp vảy, nhện, trứng sâu; hỗ trợ rửa nấm bồ hóng', 'Khi rệp mới xuất hiện, sau cắt tỉa, trước mùa khô', 'Theo nhãn sản phẩm', 'Không phun lúc nắng nóng hoặc cây đang thiếu nước; không pha gần thời điểm dùng lưu huỳnh'),
(55, 55, 'Rải 3-5kg/ha hoặc theo nhãn; rải nơi ốc tập trung', 'Diệt ốc bươu vàng, ốc sên, nhớt hại cây con', 'Sau sạ/cấy, sau mưa, khi thấy ốc xuất hiện', 'Theo nhãn sản phẩm', 'Không để gia súc, gia cầm ăn phải; tránh rải gần nguồn nước sinh hoạt'),
(56, 56, 'Pha 80-120ml/bình 16 lít; phun ướt đều lá cỏ', 'Trừ cỏ không chọn lọc, tác động tiếp xúc-lưu dẫn hạn chế', 'Khi cỏ xanh tốt, cao 10-25cm, tránh để thuốc dính cây trồng', 'Theo nhãn sản phẩm', 'Che chắn cây trồng non; không phun lúc gió mạnh hoặc sắp mưa'),
(57, 57, 'Pha 20-30ml/bình 16 lít; phun tránh để cỏ quá già', 'Trừ cỏ hòa bản hậu nảy mầm trong cây lá rộng', 'Khi cỏ 3-5 lá, cây trồng đã bén rễ', 'Theo nhãn sản phẩm', 'Không dùng trên lúa, bắp hoặc cây hòa bản; đọc kỹ nhãn trước dùng'),
(58, 58, 'Pha 20-30ml/bình 16 lít; rút nước trước phun, cho nước lại sau 1-2 ngày', 'Trừ cỏ hòa bản hậu nảy mầm trong ruộng lúa', 'Sau sạ 10-20 ngày, khi cỏ 2-4 lá', 'Theo nhãn sản phẩm', 'Không phun khi lúa yếu do phèn, mặn, ngộ độc hữu cơ'),
(59, 59, 'Pha 20-30ml/bình 16 lít hoặc theo liều/ha trên nhãn', 'Trừ cỏ lúa hậu nảy mầm, phổ rộng trên cỏ hòa bản, lá rộng, chác lác', 'Sau sạ 7-15 ngày, khi cỏ còn nhỏ', 'Theo nhãn sản phẩm', 'Không phun khi ruộng khô nứt hoặc lúa đang stress; không tăng liều tùy tiện'),
(60, 60, 'Pha theo liều/ha trên nhãn; phun đất đủ ẩm để tăng hiệu quả', 'Trừ cỏ tiền và hậu nảy mầm sớm trên bắp, mía', 'Sau gieo trước mọc hoặc khi cỏ còn nhỏ', 'Theo nhãn sản phẩm', 'Không dùng trên cây mẫn cảm; tránh thuốc trôi sang ruộng rau, đậu'),
(61, 61, 'Pha nồng độ thấp theo từng loại hom; nhúng nhanh gốc hom hoặc quét vào vết chiết', 'Kích thích ra rễ cho hom giâm, cây chiết, cây cấy mô', 'Trước khi giâm hom, chiết cành hoặc phục hồi cây con', 'Theo nhãn sản phẩm', 'Hoạt chất rất mạnh, phải cân đúng liều; tránh tiếp xúc trực tiếp da mắt'),
(62, 62, 'Pha 5-8ml/bình 16 lít; phun 1-2 lần cách nhau 7-10 ngày', 'Tăng sức chống chịu, hỗ trợ quang hợp, cải thiện đậu trái và phục hồi stress', 'Trước ra hoa, sau đậu trái, sau stress thời tiết', 'Theo nhãn sản phẩm', 'Không dùng quá liều; không thay thế phân bón và quản lý nước'),
(63, 63, 'Pha 20-30ml/bình 16 lít; phun đều tán cây', 'Kích kháng tự nhiên, tăng đề kháng nấm khuẩn, hỗ trợ phục hồi mô cây', 'Phun phòng trước mùa bệnh, sau mưa, sau cắt tỉa', 'Theo nhãn sản phẩm', 'Không xem là thuốc trị bệnh nặng; phối hợp vệ sinh vườn và dinh dưỡng cân đối');

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

INSERT INTO `pesticide_pests` (`ID`, `PDetailID`, `PestID`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 2, 3),
(5, 3, 3),
(6, 3, 4),
(7, 4, 4),
(8, 4, 5),
(9, 5, 5),
(10, 5, 6),
(11, 6, 6),
(12, 6, 7),
(13, 7, 7),
(14, 7, 8),
(15, 8, 8),
(16, 8, 9),
(17, 9, 9),
(18, 9, 10),
(19, 10, 10),
(20, 10, 11),
(21, 11, 11),
(22, 11, 12),
(23, 12, 12),
(24, 12, 13),
(25, 13, 13),
(26, 13, 14),
(27, 14, 14),
(28, 14, 15),
(29, 15, 15),
(30, 15, 16),
(31, 16, 16),
(32, 16, 17),
(33, 17, 17),
(34, 17, 18),
(35, 18, 18),
(36, 18, 19),
(37, 19, 19),
(38, 19, 20),
(39, 20, 20),
(40, 20, 1),
(41, 21, 1),
(42, 21, 2),
(43, 22, 2),
(44, 22, 3),
(45, 23, 3),
(46, 23, 4),
(47, 24, 4),
(48, 24, 5),
(49, 25, 5),
(50, 25, 6),
(51, 26, 6),
(52, 26, 7),
(53, 27, 7),
(54, 27, 8),
(55, 28, 8),
(56, 28, 9),
(57, 29, 9),
(58, 29, 10),
(59, 30, 10),
(60, 30, 11),
(61, 31, 11),
(62, 31, 12),
(63, 32, 12),
(64, 32, 13),
(65, 33, 13),
(66, 33, 14),
(67, 34, 14),
(68, 34, 15),
(69, 35, 15),
(70, 35, 16),
(71, 36, 16),
(72, 36, 17),
(73, 37, 17),
(74, 37, 18),
(75, 38, 18),
(76, 38, 19),
(77, 39, 19),
(78, 39, 20),
(79, 40, 20),
(80, 40, 1),
(81, 41, 1),
(82, 41, 2),
(83, 42, 2),
(84, 42, 3),
(85, 43, 3),
(86, 43, 4),
(87, 44, 4),
(88, 44, 5),
(89, 45, 5),
(90, 45, 6),
(91, 46, 6),
(92, 46, 7),
(93, 47, 7),
(94, 47, 8),
(95, 48, 8),
(96, 48, 9),
(97, 49, 9),
(98, 49, 10),
(99, 50, 10),
(100, 50, 11),
(101, 51, 11),
(102, 51, 12),
(103, 52, 12),
(104, 52, 13),
(105, 53, 13),
(106, 53, 14),
(107, 54, 14),
(108, 54, 15),
(109, 55, 15),
(110, 55, 16),
(111, 56, 16),
(112, 56, 17),
(113, 57, 17),
(114, 57, 18),
(115, 58, 18),
(116, 58, 19),
(117, 59, 19),
(118, 59, 20),
(119, 60, 20),
(120, 60, 1),
(121, 61, 1),
(122, 61, 2),
(123, 62, 2),
(124, 62, 3),
(125, 63, 3),
(126, 63, 4);

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

INSERT INTO `pesticide_usage` (`UsageID`, `PDetailID`, `ToxicID`, `Precaution`) VALUES
(1, 1, 1, 'Mang đồ bảo hộ; không phun gần ao cá; tuân thủ thời gian cách ly'),
(2, 2, 2, 'Luân phiên hoạt chất để tránh kháng thuốc; không phun khi cây đang ra hoa rộ'),
(3, 3, 3, 'Không lạm dụng một hoạt chất nhiều vụ; bảo quản xa trẻ em'),
(4, 4, 4, 'Hạn chế phun lúc có ong hoạt động; không pha tùy tiện với thuốc kiềm'),
(5, 5, 5, 'Độc với ong; không dùng sát ngày thu hoạch; đọc kỹ nhãn'),
(6, 6, 6, 'Không phun trễ khi mật số quá cao; luân phiên với nhóm khác'),
(7, 7, 7, 'Có thể ảnh hưởng thiên địch; không phun gần nguồn nước'),
(8, 8, 8, 'Đeo khẩu trang, kính, găng tay; tránh phun ngược chiều gió'),
(9, 9, 1, 'Không pha với dầu khoáng liều cao nếu cây đang yếu'),
(10, 10, 2, 'Độc với thủy sinh; không để thuốc chảy xuống ao hồ'),
(11, 11, 3, 'Luân phiên hoạt chất; không phun gần ngày thu hoạch'),
(12, 12, 4, 'Không dùng liên tục nhiều lần; mang bảo hộ khi pha phun'),
(13, 13, 5, 'Không pha với dung dịch kiềm; tuân thủ thời gian cách ly'),
(14, 14, 6, 'Luân phiên thuốc để hạn chế kháng; tránh phun lúc trời gió mạnh'),
(15, 15, 7, 'Không dùng quá 2 lần liên tiếp; tránh pha với thuốc kiềm mạnh'),
(16, 16, 8, 'Không pha với phân bón lá chứa lân cao; có thể gây xót lá non'),
(17, 17, 1, 'Không lạm dụng kháng sinh nông nghiệp; dùng đúng nhãn'),
(18, 18, 2, 'Giữ mực nước hợp lý; không bón thừa đạm'),
(19, 19, 3, 'Luân phiên hoạt chất; không dùng quá liều để tránh tồn dư'),
(20, 20, 4, 'Không phun lúc cây đang thiếu nước nặng; tránh phun giữa trưa'),
(21, 21, 5, 'Tránh để thuốc dính lá, thân xanh cây trồng; không phun lúc gió mạnh'),
(22, 22, 6, 'Rất độc, bắt buộc đồ bảo hộ đầy đủ; không dùng sai quy định pháp luật'),
(23, 23, 7, 'Không dùng khi lúa yếu, ruộng khô nứt; giữ nước đúng kỹ thuật'),
(24, 24, 8, 'Không phun khi mưa lớn sắp xảy ra; không để nước ngập sâu sau phun'),
(25, 25, 1, 'Không phun gần rau màu, bông, cây ăn trái non; dễ gây dị dạng cây mẫn cảm'),
(26, 26, 2, 'Không phun khi lúa bị ngộ độc phèn, mặn hoặc rét'),
(27, 27, 3, 'Dùng quá liều dễ làm cây vống, yếu; không pha tùy tiện'),
(28, 28, 4, 'Dùng sai liều có thể gây rụng lá, dị dạng trái; đọc kỹ hướng dẫn'),
(29, 29, 5, 'Không thay thế phân bón; không dùng quá liều vì dễ rối loạn sinh trưởng'),
(30, 30, 6, 'Không dùng cho cây yếu; dư liều gây suy cây kéo dài nhiều vụ'),
(31, 31, 7, 'Dùng đúng liều; không phun khi cây thiếu nước nặng'),
(32, 32, 8, 'Có tính acid; tránh dính da mắt; không pha với thuốc kiềm mạnh'),
(33, 33, 1, 'Có thể gây xót lá non; không pha với phân bón lá chứa lân cao'),
(34, 34, 2, 'Không dùng quá gần thu hoạch; mang khẩu trang khi pha bột thuốc'),
(35, 35, 3, 'Không pha với dầu khoáng; tránh hít bụi thuốc khi pha'),
(36, 36, 4, 'Luân phiên hoạt chất; không phun quá liều trên cây non'),
(37, 37, 5, 'Kết hợp cải tạo thoát nước; không chỉ dựa vào thuốc khi đất úng nặng'),
(38, 38, 6, 'Dễ kháng thuốc nếu dùng đơn hoạt chất liên tục; cần luân phiên'),
(39, 39, 7, 'Không dùng liên tục nhiều lần; tuân thủ thời gian cách ly'),
(40, 40, 8, 'Luân phiên với nhóm khác để hạn chế kháng thuốc'),
(41, 41, 1, 'Không phun khi nhiệt độ quá cao; không pha chung dầu khoáng gần thời điểm phun'),
(42, 42, 2, 'Không pha cùng thuốc nấm hóa học mạnh; dùng chiều mát để bảo vệ vi sinh'),
(43, 43, 3, 'Hạn chế phun lúc ong hoạt động; luân phiên hoạt chất để tránh kháng'),
(44, 44, 4, 'Tương đối chọn lọc nhưng vẫn cần tránh phun trực tiếp lên ong'),
(45, 45, 5, 'Không phun quá liều; tuân thủ cách ly trên rau ăn lá'),
(46, 46, 6, 'Không mong hiệu lực hạ gục tức thì; phối hợp quản lý IPM'),
(47, 47, 7, 'Không phun khi cây đang stress nặng; tránh để thuốc trôi xuống ao cá'),
(48, 48, 8, 'Hiệu lực chậm, không dùng đơn độc khi mật số quá cao'),
(49, 49, 1, 'Không lạm dụng nhóm neonicotinoid; tránh phun lúc ong hoạt động'),
(50, 50, 2, 'Độc với ong; không dùng tùy tiện trên cây đang ra hoa'),
(51, 51, 3, 'Không pha với thuốc có tính kiềm mạnh; bảo quản xa thức ăn'),
(52, 52, 4, 'Hiệu lực nhẹ hơn thuốc hóa học; tránh phun khi mưa sắp đến'),
(53, 53, 5, 'Không pha chung thuốc trừ nấm; tránh nắng gắt để bảo vệ bào tử'),
(54, 54, 6, 'Không phun lúc nắng nóng hoặc cây đang thiếu nước; không pha gần thời điểm dùng lưu huỳnh'),
(55, 55, 7, 'Không để gia súc, gia cầm ăn phải; tránh rải gần nguồn nước sinh hoạt'),
(56, 56, 8, 'Che chắn cây trồng non; không phun lúc gió mạnh hoặc sắp mưa'),
(57, 57, 1, 'Không dùng trên lúa, bắp hoặc cây hòa bản; đọc kỹ nhãn trước dùng'),
(58, 58, 2, 'Không phun khi lúa yếu do phèn, mặn, ngộ độc hữu cơ'),
(59, 59, 3, 'Không phun khi ruộng khô nứt hoặc lúa đang stress; không tăng liều tùy tiện'),
(60, 60, 4, 'Không dùng trên cây mẫn cảm; tránh thuốc trôi sang ruộng rau, đậu'),
(61, 61, 5, 'Hoạt chất rất mạnh, phải cân đúng liều; tránh tiếp xúc trực tiếp da mắt'),
(62, 62, 6, 'Không dùng quá liều; không thay thế phân bón và quản lý nước'),
(63, 63, 7, 'Không xem là thuốc trị bệnh nặng; phối hợp vệ sinh vườn và dinh dưỡng cân đối');

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
(1, 'KẼM BORON 50.000ppm', 'SP-001-000001', 'kem-boron-50-000ppm-sp1', 'Công dụng: Tăng khả năng thụ phấn, đậu trái, hạn chế rụng hoa và trái non. Triệu chứng phù hợp: Hoa khô, rụng hàng loạt; trái non dễ rụng; lá non biến dạng. Nguyên nhân thường gặp: Thiếu vi lượng Kẽm và Bo trong giai đoạn phân hóa mầm hoa. Đối tượng cây trồng: Cây ăn trái, cà phê, hồ tiêu, lúa, rau màu. Thời điểm xử lý: Trước ra hoa, sau đậu trái, giai đoạn nuôi trái non. Quy cách: Gói 500g. Giá tham khảo: Khoảng 75.000 - 90.000 VNĐ.', 82500.00, 1, 1, 4, 1, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Kẽm Zn: 50.000ppm; Bo B: 50.000ppm; độ ẩm: 1%. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 500g cho phuy 200-250 lít nước, phun đều hai mặt lá. An toàn sử dụng: Không pha chung với thuốc có tính kiềm mạnh; bảo quản nơi khô ráo.'),
(2, 'NPK 20-20-15 TE', 'SP-001-000002', 'npk-20-20-15-te-sp2', 'Công dụng: Cung cấp dinh dưỡng cân đối, giúp cây phát triển thân lá, rễ và nuôi trái. Triệu chứng phù hợp: Cây sinh trưởng chậm, lá nhạt màu, đậu trái kém. Nguyên nhân thường gặp: Đất thiếu đa lượng NPK hoặc bón phân mất cân đối. Đối tượng cây trồng: Lúa, bắp, rau màu, cây ăn trái, cây công nghiệp. Thời điểm xử lý: Giai đoạn sinh trưởng mạnh, sau thu hoạch, trước ra hoa. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 520.000 - 650.000 VNĐ/bao.', 585000.00, 1, 1, 2, 2, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Đạm N: 20%; Lân P2O5: 20%; Kali K2O: 15%; TE: Zn, B, Cu, Mn. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón gốc 200-500kg/ha tùy cây trồng và độ phì đất. An toàn sử dụng: Không bón sát gốc; tưới nước sau khi bón để tránh cháy rễ.'),
(3, 'DAP 18-46-0', 'SP-001-000003', 'dap-18-46-0-sp3', 'Công dụng: Kích thích ra rễ, phục hồi cây con, tăng sức bật chồi. Triệu chứng phù hợp: Rễ yếu, cây còi, chậm bén rễ sau trồng. Nguyên nhân thường gặp: Thiếu lân trong giai đoạn đầu hoặc đất chua làm lân khó hấp thu. Đối tượng cây trồng: Lúa, rau màu, cây ăn trái, cà phê, hồ tiêu. Thời điểm xử lý: Bón lót, bón thúc sớm sau trồng. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 1.100.000 - 1.350.000 VNĐ/bao.', 1225000.00, 1, 1, 2, 3, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Đạm N: 18%; Lân hữu hiệu P2O5: 46%. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 100-300kg/ha; cây ăn trái bón 0,2-1kg/gốc tùy tuổi cây. An toàn sử dụng: Tránh trộn trực tiếp với vôi; bảo quản khô, tránh vón cục.'),
(4, 'KALI CLORUA KCl 60%', 'SP-001-000004', 'kali-clorua-kcl-60-sp4', 'Công dụng: Tăng độ ngọt, chắc hạt, cứng cây, tăng khả năng chống chịu. Triệu chứng phù hợp: Trái nhạt, mềm; lá mép vàng cháy; cây yếu dễ đổ ngã. Nguyên nhân thường gặp: Thiếu Kali hoặc cây đang nuôi trái, nuôi củ cần nhiều Kali. Đối tượng cây trồng: Lúa, mía, chuối, cây ăn trái, khoai, sắn. Thời điểm xử lý: Giai đoạn làm đòng, nuôi trái, nuôi củ. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 750.000 - 950.000 VNĐ/bao.', 850000.00, 1, 1, 2, 4, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Kali hữu hiệu K2O: 60%; dạng KCl. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 100-250kg/ha; cây ăn trái 0,3-1,5kg/gốc tùy tuổi cây. An toàn sử dụng: Không bón quá liều trên cây mẫn cảm Clo; tránh bón lúc nắng gắt.'),
(5, 'CANXI BO MAX', 'SP-001-000005', 'canxi-bo-max-sp5', 'Công dụng: Chống nứt trái, thối đít trái, tăng cứng vỏ và cuống trái. Triệu chứng phù hợp: Trái cà chua thối đáy; sầu riêng nứt gai; ớt rụng hoa. Nguyên nhân thường gặp: Thiếu Canxi và Bo, rối loạn vận chuyển dinh dưỡng khi cây thiếu nước. Đối tượng cây trồng: Cà chua, ớt, dưa leo, sầu riêng, xoài, cam quýt. Thời điểm xử lý: Trước ra hoa, sau đậu trái, giai đoạn trái lớn nhanh. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 95.000 - 140.000 VNĐ.', 117500.00, 1, 1, 3, 5, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: CaO: 15%; Bo B: 2%; MgO: 2%; phụ gia bám dính. Loại sản phẩm: phan_bon. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 25-40ml/bình 16 lít; phun 7-10 ngày/lần. An toàn sử dụng: Không pha với phân chứa phosphate đậm đặc; lắc đều trước khi dùng.'),
(6, 'HUMIC ACID 70%', 'SP-001-000006', 'humic-acid-70-sp6', 'Công dụng: Cải tạo đất, kích rễ, tăng hấp thu phân bón, giảm ngộ độc hữu cơ. Triệu chứng phù hợp: Rễ ít, đất chai cứng, cây vàng lá sau mưa hoặc sau bón phân mạnh. Nguyên nhân thường gặp: Đất nghèo hữu cơ, pH bất lợi, rễ bị nghẹt do úng hoặc phèn. Đối tượng cây trồng: Rau màu, lúa, cây ăn trái, hoa kiểng, cà phê. Thời điểm xử lý: Sau trồng, sau thu hoạch, sau ngập úng, giai đoạn phục hồi rễ. Quy cách: Gói 1kg. Giá tham khảo: Khoảng 120.000 - 180.000 VNĐ.', 150000.00, 1, 1, 4, 6, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Acid humic: 70%; K2O: 10%; Fulvic acid: 3%. Loại sản phẩm: phan_bon. Quy cách: Gói 1kg.', 'Hướng dẫn sử dụng: Tưới gốc 1kg/400-600 lít nước hoặc rải 2-5kg/ha. An toàn sử dụng: Có thể phối với NPK nhưng nên thử trước; tránh để nơi ẩm.'),
(7, 'SEAWEED AMINO 30', 'SP-001-000007', 'seaweed-amino-30-sp7', 'Công dụng: Giải stress, phục hồi cây sau hạn, mặn, ngộ độc thuốc; kích chồi. Triệu chứng phù hợp: Cây đứng lá, chậm phát triển, lá xoăn nhẹ sau thời tiết xấu. Nguyên nhân thường gặp: Cây bị sốc sinh lý do nắng nóng, lạnh, hạn, mặn hoặc phun thuốc quá liều. Đối tượng cây trồng: Rau màu, lúa, hoa, cây ăn trái, cây công nghiệp. Thời điểm xử lý: Sau thời tiết bất lợi, sau phun thuốc, giai đoạn cây con. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 85.000 - 120.000 VNĐ.', 102500.00, 1, 1, 3, 7, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Dịch chiết rong biển: 20%; Amino acid: 10%; K2O: 5%; vi lượng. Loại sản phẩm: phan_bon. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha 15-25ml/bình 16 lít, phun sáng sớm hoặc chiều mát. An toàn sử dụng: Không pha với thuốc có tính kiềm cao; đeo găng khi pha.'),
(8, 'NPK 16-16-8 + TE', 'SP-001-000008', 'npk-16-16-8-te-sp8', 'Công dụng: Bón thúc đa dụng, giúp cây phát triển thân lá và rễ khỏe. Triệu chứng phù hợp: Lá xanh nhạt, cây yếu, đẻ nhánh kém, chậm lớn. Nguyên nhân thường gặp: Thiếu dinh dưỡng đa lượng trong giai đoạn sinh trưởng. Đối tượng cây trồng: Lúa, bắp, rau màu, cây ăn trái, cà phê. Thời điểm xử lý: Bón thúc lần 1-2, sau thu hoạch, sau cắt tỉa. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 650.000 - 850.000 VNĐ/bao.', 750000.00, 1, 1, 2, 8, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 16%; P2O5: 16%; K2O: 8%; S: 5%; TE: Zn, B. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 200-500kg/ha tùy cây; cây ăn trái 0,5-2kg/gốc. An toàn sử dụng: Không bón sát thân; không để phân dính lá non.'),
(9, 'MAGIE KẼM LƯU HUỲNH', 'SP-001-000009', 'magie-kem-luu-huynh-sp9', 'Công dụng: Giúp lá xanh dày, tăng quang hợp, hạn chế vàng lá gân xanh. Triệu chứng phù hợp: Lá già vàng giữa gân, gân còn xanh; cây kém quang hợp. Nguyên nhân thường gặp: Thiếu Magie, Kẽm, Lưu huỳnh hoặc đất pH thấp làm rễ hấp thu kém. Đối tượng cây trồng: Cà phê, hồ tiêu, sầu riêng, cam quýt, rau màu. Thời điểm xử lý: Giai đoạn phát triển lá, trước ra hoa, sau thu hoạch. Quy cách: Gói 1kg. Giá tham khảo: Khoảng 60.000 - 90.000 VNĐ.', 75000.00, 1, 1, 4, 9, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: MgO: 16%; Zn: 5%; S: 12%; phụ gia trung vi lượng. Loại sản phẩm: phan_bon. Quy cách: Gói 1kg.', 'Hướng dẫn sử dụng: Pha 40-60g/bình 16 lít hoặc tưới 1kg/400 lít nước. An toàn sử dụng: Không pha chung với Canxi đậm đặc; thử nhỏ trước khi phối thuốc.'),
(10, 'PHÂN BÓN LÁ 10-55-10', 'SP-001-000010', 'phan-bon-la-10-55-10-sp10', 'Công dụng: Kích thích ra rễ, phân hóa mầm hoa, giúp cây chuyển sang sinh sản. Triệu chứng phù hợp: Cây tốt lá nhưng chậm ra hoa; rễ yếu sau trồng. Nguyên nhân thường gặp: Thiếu lân hoặc bón dư đạm làm cây thiên về sinh trưởng thân lá. Đối tượng cây trồng: Xoài, nhãn, sầu riêng, hoa kiểng, rau màu. Thời điểm xử lý: Trước xử lý ra hoa, sau trồng, giai đoạn cây con. Quy cách: Gói 500g. Giá tham khảo: Khoảng 55.000 - 80.000 VNĐ.', 67500.00, 1, 1, 4, 10, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 10%; P2O5: 55%; K2O: 10%; TE. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun 2-3 lần cách nhau 7 ngày. An toàn sử dụng: Không lạm dụng khi cây đang suy kiệt; tránh phun lúc nắng mạnh.'),
(11, 'PHÂN BÓN LÁ 6-30-30', 'SP-001-000011', 'phan-bon-la-6-30-30-sp11', 'Công dụng: Hỗ trợ ra hoa, tăng đậu trái, nuôi trái chắc và lên màu. Triệu chứng phù hợp: Hoa ít, trái non rụng, trái lớn chậm. Nguyên nhân thường gặp: Cây thiếu lân và kali ở giai đoạn sinh sản. Đối tượng cây trồng: Cây ăn trái, ớt, cà chua, dưa, hoa màu. Thời điểm xử lý: Trước ra hoa, sau đậu trái, giai đoạn trái phát triển. Quy cách: Gói 500g. Giá tham khảo: Khoảng 60.000 - 85.000 VNĐ.', 72500.00, 1, 1, 4, 11, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 6%; P2O5: 30%; K2O: 30%; Mg, Zn, B. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 20-40g/bình 16 lít; phun 7-10 ngày/lần. An toàn sử dụng: Không pha với dầu khoáng liều cao; bảo quản kín sau mở gói.'),
(12, 'NPK 30-10-10', 'SP-001-000012', 'npk-30-10-10-sp12', 'Công dụng: Kích chồi, dưỡng lá, phục hồi tán sau thu hoạch. Triệu chứng phù hợp: Lá nhỏ, chồi ra yếu, cây suy sau thu hoạch. Nguyên nhân thường gặp: Cây thiếu đạm hoặc mất sức sau nuôi trái. Đối tượng cây trồng: Cây ăn trái, rau ăn lá, hoa kiểng, cà phê. Thời điểm xử lý: Sau thu hoạch, sau cắt tỉa, giai đoạn cây cần ra đọt. Quy cách: Gói 500g. Giá tham khảo: Khoảng 55.000 - 75.000 VNĐ.', 65000.00, 1, 1, 4, 12, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 30%; P2O5: 10%; K2O: 10%; TE. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun 2-3 lần cách 7 ngày. An toàn sử dụng: Không dùng quá nhiều khi cây chuẩn bị ra hoa vì dễ làm cây ra lá.'),
(13, 'UREA PHÚ MỸ', 'SP-001-000013', 'urea-phu-my-sp13', 'Công dụng: Cung cấp đạm nhanh, giúp cây xanh lá và phát triển thân lá. Triệu chứng phù hợp: Lá vàng nhạt, cây còi, đẻ nhánh kém. Nguyên nhân thường gặp: Thiếu đạm, đất nghèo dinh dưỡng hoặc rửa trôi sau mưa. Đối tượng cây trồng: Lúa, bắp, rau màu, cây công nghiệp. Thời điểm xử lý: Giai đoạn sinh trưởng thân lá, sau sạ, sau trồng. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 580.000 - 750.000 VNĐ/bao.', 665000.00, 1, 1, 2, 13, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Đạm tổng số N: 46,3%; Biuret thấp. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 50-200kg/ha tùy cây; chia nhiều lần để giảm thất thoát. An toàn sử dụng: Không bón lúc trời nắng gắt; vùi nhẹ hoặc tưới nước sau bón.'),
(14, 'PHÂN HỮU CƠ VI SINH', 'SP-001-000014', 'phan-huu-co-vi-sinh-sp14', 'Công dụng: Cải tạo đất, tăng hệ vi sinh có lợi, hạn chế nấm hại vùng rễ. Triệu chứng phù hợp: Đất chai, rễ thâm, cây vàng lá sinh lý, kém hấp thu phân. Nguyên nhân thường gặp: Đất bạc màu, bón hóa học lâu năm, ít hữu cơ. Đối tượng cây trồng: Rau màu, cây ăn trái, hồ tiêu, cà phê, hoa kiểng. Thời điểm xử lý: Bón lót, sau thu hoạch, đầu mùa mưa. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 85.000 - 130.000 VNĐ/bao.', 107500.00, 1, 1, 2, 14, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Hữu cơ: 22%; Acid humic; vi sinh Bacillus spp.; Trichoderma spp.. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón 500-2000kg/ha; cây ăn trái 2-10kg/gốc tùy tuổi. An toàn sử dụng: Không trộn trực tiếp với thuốc trừ nấm mạnh khi vừa bón.'),
(15, 'TRICHODERMA NANO', 'SP-001-000015', 'trichoderma-nano-sp15', 'Công dụng: Phân giải hữu cơ, đối kháng nấm bệnh trong đất, giúp rễ khỏe. Triệu chứng phù hợp: Cây con chết rạp, rễ thối, đất có mùi yếm khí. Nguyên nhân thường gặp: Nấm Fusarium, Pythium, Rhizoctonia phát triển trong đất ẩm. Đối tượng cây trồng: Rau màu, tiêu, cà phê, cây ăn trái, vườn ươm. Thời điểm xử lý: Trộn phân chuồng ủ hoai, bón lót, xử lý đất trước trồng. Quy cách: Gói 1kg. Giá tham khảo: Khoảng 90.000 - 150.000 VNĐ.', 120000.00, 1, 1, 4, 15, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Bào tử Trichoderma harzianum ≥ 10^8 CFU/g; hữu cơ nền. Loại sản phẩm: phan_bon. Quy cách: Gói 1kg.', 'Hướng dẫn sử dụng: Trộn 1kg với 500-1000kg phân hữu cơ hoặc tưới 1kg/400 lít nước. An toàn sử dụng: Không dùng chung lúc với thuốc nấm hóa học mạnh; giữ ẩm sau bón.'),
(16, 'ABAMECTIN 3.6EC', 'SP-002-000016', 'abamectin-3-6ec-sp16', 'Công dụng: Diệt nhện đỏ, sâu tơ, bọ trĩ, sâu cuốn lá non. Triệu chứng phù hợp: Lá xoăn, bạc màu, có chấm vàng; đọt non biến dạng. Nguyên nhân thường gặp: Nhện, bọ trĩ hoặc sâu non chích hút và ăn biểu bì lá. Đối tượng cây trồng: Rau màu, hoa, cam quýt, ớt, dưa, chè. Thời điểm xử lý: Khi phát hiện mật số sâu nhện thấp đến trung bình. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 45.000 - 70.000 VNĐ.', 57500.00, 2, 1, 3, 16, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Abamectin: 36g/lít; phụ gia dung môi. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 8-12ml/bình 16 lít; phun kỹ mặt dưới lá. An toàn sử dụng: Mang đồ bảo hộ; không phun gần ao cá; tuân thủ thời gian cách ly.'),
(17, 'EMAMECTIN BENZOATE 5WG', 'SP-002-000017', 'emamectin-benzoate-5wg-sp17', 'Công dụng: Trừ sâu tơ, sâu xanh da láng, sâu đục trái, sâu cuốn lá. Triệu chứng phù hợp: Lá bị ăn khuyết, trái non bị đục lỗ, có phân sâu. Nguyên nhân thường gặp: Sâu non bộ cánh vảy gây hại mạnh vào giai đoạn non. Đối tượng cây trồng: Rau cải, ớt, cà chua, bắp, cây ăn trái. Thời điểm xử lý: Phun khi sâu tuổi nhỏ, trước khi sâu chui sâu vào trái. Quy cách: Gói 100g. Giá tham khảo: Khoảng 35.000 - 60.000 VNĐ.', 47500.00, 2, 1, 4, 17, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Emamectin benzoate: 5% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 5-8g/bình 16 lít; phun đều tán lá. An toàn sử dụng: Luân phiên hoạt chất để tránh kháng thuốc; không phun khi cây đang ra hoa rộ.'),
(18, 'CHLORANTRANILIPROLE 35WG', 'SP-002-000018', 'chlorantraniliprole-35wg-sp18', 'Công dụng: Đặc trị sâu đục thân, sâu cuốn lá, sâu keo, sâu đục trái. Triệu chứng phù hợp: Lá bị cuốn, thân có lỗ đục, bông lúa bạc trắng. Nguyên nhân thường gặp: Sâu non đục vào thân, bẹ lá, trái hoặc cuốn lá làm tổ. Đối tượng cây trồng: Lúa, bắp, rau màu, cây ăn trái. Thời điểm xử lý: Phun sớm khi trứng mới nở hoặc sâu tuổi 1-2. Quy cách: Gói 50g. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 4, 18, 'Theo nhà cung cấp', 'Việt Nam', 0.05, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Chlorantraniliprole: 35% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 50g.', 'Hướng dẫn sử dụng: Pha 2-4g/bình 16 lít; lúa dùng theo khuyến cáo trên nhãn. An toàn sử dụng: Không lạm dụng một hoạt chất nhiều vụ; bảo quản xa trẻ em.'),
(19, 'DINOTEFURAN 20SG', 'SP-002-000019', 'dinotefuran-20sg-sp19', 'Công dụng: Trừ rầy nâu, rệp sáp, bọ phấn, rệp mềm, côn trùng chích hút. Triệu chứng phù hợp: Lá xoăn, mật ngọt, nấm bồ hóng, cây còi cọc. Nguyên nhân thường gặp: Côn trùng chích hút làm mất nhựa cây và truyền bệnh virus. Đối tượng cây trồng: Lúa, xoài, cam quýt, rau màu, hoa kiểng. Thời điểm xử lý: Khi thấy rầy, rệp, bọ phấn xuất hiện rải rác. Quy cách: Gói 100g. Giá tham khảo: Khoảng 55.000 - 90.000 VNĐ.', 72500.00, 2, 1, 4, 19, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Dinotefuran: 20% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 8-12g/bình 16 lít; phun kỹ nơi côn trùng cư trú. An toàn sử dụng: Hạn chế phun lúc có ong hoạt động; không pha tùy tiện với thuốc kiềm.'),
(20, 'IMIDACLOPRID 100SL', 'SP-002-000020', 'imidacloprid-100sl-sp20', 'Công dụng: Trừ rầy, rệp, bọ trĩ, bọ phấn; tác động lưu dẫn. Triệu chứng phù hợp: Đọt xoăn, lá vàng, cây lùn, có rầy rệp dưới lá. Nguyên nhân thường gặp: Côn trùng chích hút gây hại trực tiếp và truyền bệnh. Đối tượng cây trồng: Lúa, rau màu, hoa, cây ăn trái. Thời điểm xử lý: Giai đoạn cây con, ra đọt non, khi rầy rệp mới xuất hiện. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 35.000 - 55.000 VNĐ.', 45000.00, 2, 1, 3, 20, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Imidacloprid: 100g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít; phun đều thân lá. An toàn sử dụng: Độc với ong; không dùng sát ngày thu hoạch; đọc kỹ nhãn.'),
(21, 'PYMETROZINE 50WG', 'SP-002-000021', 'pymetrozine-50wg-sp21', 'Công dụng: Trừ rầy nâu, rầy lưng trắng, rệp mềm bằng cơ chế ức chế chích hút. Triệu chứng phù hợp: Lúa vàng từng chòm, cháy rầy; rau bị rệp bu kín đọt. Nguyên nhân thường gặp: Rầy rệp hút nhựa, mật số cao trong thời tiết nóng ẩm. Đối tượng cây trồng: Lúa, rau màu, dưa, hoa kiểng. Thời điểm xử lý: Khi rầy tuổi nhỏ, mật số vừa phải, trước khi cháy rầy. Quy cách: Gói 100g. Giá tham khảo: Khoảng 60.000 - 95.000 VNĐ.', 77500.00, 2, 1, 4, 21, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Pymetrozine: 50% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 6-10g/bình 16 lít; ruộng lúa phun đủ nước thuốc. An toàn sử dụng: Không phun trễ khi mật số quá cao; luân phiên với nhóm khác.'),
(22, 'CYPERMETHRIN 25EC', 'SP-002-000022', 'cypermethrin-25ec-sp22', 'Công dụng: Trừ sâu ăn lá, bọ xít, sâu khoang, sâu xanh. Triệu chứng phù hợp: Lá bị cắn phá, búp non cụt, trái bị bọ xít chích. Nguyên nhân thường gặp: Sâu ăn lá và côn trùng miệng nhai gây hại ngoài tán. Đối tượng cây trồng: Đậu, rau màu, bông, cây ăn trái. Thời điểm xử lý: Khi sâu mới phát sinh, phun vào chiều mát. Quy cách: Chai 250ml. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 2, 1, 3, 22, 'Theo nhà cung cấp', 'Việt Nam', 0.25, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Cypermethrin: 250g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 250ml.', 'Hướng dẫn sử dụng: Pha 15-25ml/bình 16 lít; phun đều nơi sâu trú ẩn. An toàn sử dụng: Có thể ảnh hưởng thiên địch; không phun gần nguồn nước.'),
(23, 'LAMBDA-CYHALOTHRIN 2.5EC', 'SP-002-000023', 'lambda-cyhalothrin-2-5ec-sp23', 'Công dụng: Trừ sâu cuốn lá, sâu xanh, bọ nhảy, bọ xít. Triệu chứng phù hợp: Lá bị thủng lỗ, sâu non bò trên lá, bọ nhảy cắn rau. Nguyên nhân thường gặp: Côn trùng miệng nhai phát sinh mạnh khi thời tiết khô nóng. Đối tượng cây trồng: Rau cải, lúa, đậu, bắp, cây ăn trái. Thời điểm xử lý: Phun khi sâu tuổi nhỏ hoặc bọ nhảy mới xuất hiện. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 30.000 - 50.000 VNĐ.', 40000.00, 2, 1, 3, 23, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Lambda-cyhalothrin: 25g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít. An toàn sử dụng: Đeo khẩu trang, kính, găng tay; tránh phun ngược chiều gió.'),
(24, 'SPIROTETRAMAT 100SC', 'SP-002-000024', 'spirotetramat-100sc-sp24', 'Công dụng: Trừ rệp sáp, rệp vảy, bọ phấn, côn trùng chích hút lưu dẫn hai chiều. Triệu chứng phù hợp: Cành lá có rệp trắng, trái dính mật, nấm đen bám vỏ. Nguyên nhân thường gặp: Rệp sáp và rệp vảy hút nhựa, tiết mật tạo nấm bồ hóng. Đối tượng cây trồng: Cam quýt, xoài, mãng cầu, cà phê, hồ tiêu. Thời điểm xử lý: Khi rệp mới xuất hiện, sau cắt tỉa tạo tán. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 120.000 - 180.000 VNĐ.', 150000.00, 2, 1, 3, 24, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Spirotetramat: 100g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 12-20ml/bình 16 lít; phun kỹ cành, kẽ lá, chùm trái. An toàn sử dụng: Không pha với dầu khoáng liều cao nếu cây đang yếu.'),
(25, 'FIPRONIL 800WG', 'SP-002-000025', 'fipronil-800wg-sp25', 'Công dụng: Trừ sâu đục thân, bọ trĩ, kiến, mối, một số côn trùng đất. Triệu chứng phù hợp: Lúa có dảnh héo, bông bạc; cây con bị cắn gốc. Nguyên nhân thường gặp: Sâu đục thân, mối, kiến hoặc côn trùng đất phá rễ và thân. Đối tượng cây trồng: Lúa, mía, rau màu, vườn ươm. Thời điểm xử lý: Xử lý sớm khi phát hiện ổ sâu hoặc trước giai đoạn mẫn cảm. Quy cách: Gói 100g. Giá tham khảo: Khoảng 70.000 - 110.000 VNĐ.', 90000.00, 2, 1, 4, 25, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fipronil: 80% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 3-5g/bình 16 lít hoặc xử lý theo nhãn cho từng cây. An toàn sử dụng: Độc với thủy sinh; không để thuốc chảy xuống ao hồ.'),
(26, 'METALAXYL + MANCOZEB 72WP', 'SP-002-000026', 'metalaxyl-mancozeb-72wp-sp26', 'Công dụng: Phòng trị sương mai, thối rễ, chết cây con do nấm giả. Triệu chứng phù hợp: Lá có vết vàng loang, mặt dưới có mốc trắng; cây con rũ. Nguyên nhân thường gặp: Nấm Phytophthora, Pythium, Peronospora phát triển khi ẩm cao. Đối tượng cây trồng: Dưa leo, cà chua, khoai tây, hồ tiêu, cây ăn trái. Thời điểm xử lý: Trước và sau mưa, khi bệnh mới chớm. Quy cách: Gói 100g. Giá tham khảo: Khoảng 35.000 - 60.000 VNĐ.', 47500.00, 2, 1, 4, 26, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Metalaxyl: 8%; Mancozeb: 64%. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 25-35g/bình 16 lít; phun hoặc tưới gốc tùy bệnh. An toàn sử dụng: Luân phiên hoạt chất; không phun gần ngày thu hoạch.'),
(27, 'HEXACONAZOLE 5SC', 'SP-002-000027', 'hexaconazole-5sc-sp27', 'Công dụng: Trừ lem lép hạt, khô vằn, phấn trắng, đốm lá. Triệu chứng phù hợp: Lá có vết nâu, bẹ lúa khô vằn, bông lem lép. Nguyên nhân thường gặp: Nấm bệnh phát triển khi ruộng rậm, ẩm độ cao. Đối tượng cây trồng: Lúa, xoài, rau màu, hoa kiểng. Thời điểm xử lý: Khi bệnh mới xuất hiện hoặc trước giai đoạn trổ lúa. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 40.000 - 65.000 VNĐ.', 52500.00, 2, 1, 3, 27, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Hexaconazole: 50g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 15-20ml/bình 16 lít; phun đều vùng bệnh. An toàn sử dụng: Không dùng liên tục nhiều lần; mang bảo hộ khi pha phun.'),
(28, 'DIFENOCONAZOLE 250EC', 'SP-002-000028', 'difenoconazole-250ec-sp28', 'Công dụng: Trừ thán thư, đốm lá, rỉ sắt, phấn trắng. Triệu chứng phù hợp: Lá, trái có đốm nâu đen lõm; vết bệnh lan nhanh sau mưa. Nguyên nhân thường gặp: Nấm Colletotrichum, Cercospora, Alternaria gây hại. Đối tượng cây trồng: Xoài, ớt, cà chua, thanh long, cây ăn trái. Thời điểm xử lý: Phun phòng trước mưa hoặc khi bệnh mới chớm. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 75.000 - 110.000 VNĐ.', 92500.00, 2, 1, 3, 28, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Difenoconazole: 250g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 8-12ml/bình 16 lít; phun 2 lần cách nhau 7 ngày. An toàn sử dụng: Không pha với dung dịch kiềm; tuân thủ thời gian cách ly.'),
(29, 'PROPICONAZOLE 250EC', 'SP-002-000029', 'propiconazole-250ec-sp29', 'Công dụng: Trị rỉ sắt, đốm lá, khô vằn, vàng lá do nấm. Triệu chứng phù hợp: Lá có ổ rỉ màu cam nâu, đốm cháy lan rộng. Nguyên nhân thường gặp: Nấm bệnh phát sinh trong điều kiện ẩm, tán rậm. Đối tượng cây trồng: Cà phê, lúa, đậu, rau màu, cây công nghiệp. Thời điểm xử lý: Khi bệnh xuất hiện 5-10% lá hoặc phun phòng mùa mưa. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 60.000 - 90.000 VNĐ.', 75000.00, 2, 1, 3, 29, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Propiconazole: 250g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít. An toàn sử dụng: Luân phiên thuốc để hạn chế kháng; tránh phun lúc trời gió mạnh.'),
(30, 'AZOXYSTROBIN 250SC', 'SP-002-000030', 'azoxystrobin-250sc-sp30', 'Công dụng: Phòng trị nhiều bệnh nấm, xanh lá, kéo dài thời gian quang hợp. Triệu chứng phù hợp: Đốm lá, cháy lá, thán thư, phấn trắng, lá già nhanh. Nguyên nhân thường gặp: Nấm gây hại trên lá và trái khi ẩm độ cao. Đối tượng cây trồng: Rau màu, lúa, cây ăn trái, hoa, cà phê. Thời điểm xử lý: Phun phòng đầu mùa bệnh hoặc khi vết bệnh mới xuất hiện. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 100.000 - 150.000 VNĐ.', 125000.00, 2, 1, 3, 30, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Azoxystrobin: 250g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 8-12ml/bình 16 lít. An toàn sử dụng: Không dùng quá 2 lần liên tiếp; tránh pha với thuốc kiềm mạnh.'),
(31, 'COPPER HYDROXIDE 77WP', 'SP-002-000031', 'copper-hydroxide-77wp-sp31', 'Công dụng: Phòng trị loét vi khuẩn, sẹo trái, thán thư, đốm lá. Triệu chứng phù hợp: Lá có đốm vàng nâu, trái sẹo, vết bệnh có quầng vàng. Nguyên nhân thường gặp: Vi khuẩn và nấm phát triển qua vết thương sau mưa gió. Đối tượng cây trồng: Cam quýt, xoài, ớt, cà chua, cây ăn trái. Thời điểm xử lý: Phun phòng trước mưa, sau cắt tỉa, sau mưa đá/gió mạnh. Quy cách: Gói 100g. Giá tham khảo: Khoảng 45.000 - 70.000 VNĐ.', 57500.00, 2, 1, 4, 31, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Copper hydroxide: 77% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun phủ đều bề mặt lá. An toàn sử dụng: Không pha với phân bón lá chứa lân cao; có thể gây xót lá non.'),
(32, 'KASUGAMYCIN 2SL', 'SP-002-000032', 'kasugamycin-2sl-sp32', 'Công dụng: Trị bệnh vi khuẩn, cháy bìa lá, thối nhũn, đốm lá vi khuẩn. Triệu chứng phù hợp: Lá cháy mép, vết bệnh ướt nước, mô cây mềm nhũn. Nguyên nhân thường gặp: Vi khuẩn Xanthomonas, Erwinia phát triển khi ẩm cao. Đối tượng cây trồng: Lúa, rau cải, hành, ớt, cà chua. Thời điểm xử lý: Khi bệnh mới xuất hiện, sau mưa kéo dài. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 55.000 - 85.000 VNĐ.', 70000.00, 2, 1, 3, 32, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Kasugamycin: 20g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 15-25ml/bình 16 lít; phun 2 lần cách 5-7 ngày. An toàn sử dụng: Không lạm dụng kháng sinh nông nghiệp; dùng đúng nhãn.'),
(33, 'VALIDAMYCIN 5SL', 'SP-002-000033', 'validamycin-5sl-sp33', 'Công dụng: Đặc trị khô vằn lúa, nấm hại bẹ và thân. Triệu chứng phù hợp: Bẹ lúa có vết loang hình mắt cua, ruộng cháy từng đám. Nguyên nhân thường gặp: Nấm Rhizoctonia solani phát triển khi ruộng rậm, thừa đạm. Đối tượng cây trồng: Lúa, một số rau màu. Thời điểm xử lý: Giai đoạn lúa đẻ nhánh rộ đến làm đòng, khi bệnh chớm. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 65.000 - 100.000 VNĐ.', 82500.00, 2, 1, 3, 33, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Validamycin A: 50g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha 30-40ml/bình 16 lít hoặc dùng theo liều ruộng lúa trên nhãn. An toàn sử dụng: Giữ mực nước hợp lý; không bón thừa đạm.'),
(34, 'CARBENDAZIM 500FL', 'SP-002-000034', 'carbendazim-500fl-sp34', 'Công dụng: Trừ thán thư, đốm lá, héo rũ do nấm, nấm hại hạt giống. Triệu chứng phù hợp: Vết bệnh nâu đen trên lá, trái; cây con chết rạp. Nguyên nhân thường gặp: Nấm Colletotrichum, Fusarium, Cercospora. Đối tượng cây trồng: Xoài, thanh long, rau màu, đậu, cây ăn trái. Thời điểm xử lý: Khi bệnh mới xuất hiện hoặc xử lý hạt giống trước gieo. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 70.000 - 110.000 VNĐ.', 90000.00, 2, 1, 3, 34, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Carbendazim: 500g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha 10-20ml/bình 16 lít; xử lý theo nhãn từng mục đích. An toàn sử dụng: Luân phiên hoạt chất; không dùng quá liều để tránh tồn dư.'),
(35, 'TEBUCONAZOLE 250EW', 'SP-002-000035', 'tebuconazole-250ew-sp35', 'Công dụng: Trừ lem lép hạt, rỉ sắt, phấn trắng, thán thư. Triệu chứng phù hợp: Bông lúa lem đen, hạt lép; lá có nấm trắng hoặc rỉ sắt. Nguyên nhân thường gặp: Nấm bệnh tấn công giai đoạn ra hoa, trổ bông, nuôi trái. Đối tượng cây trồng: Lúa, đậu phộng, cây ăn trái, rau màu. Thời điểm xử lý: Trước trổ, sau trổ 5-7 ngày hoặc khi bệnh chớm. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 60.000 - 95.000 VNĐ.', 77500.00, 2, 1, 3, 35, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Tebuconazole: 250g/lít. Loại sản phẩm: thuoc_tru_benh. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít. An toàn sử dụng: Không phun lúc cây đang thiếu nước nặng; tránh phun giữa trưa.'),
(36, 'GLYPHOSATE 480SL', 'SP-002-000036', 'glyphosate-480sl-sp36', 'Công dụng: Trừ cỏ không chọn lọc, diệt cỏ lâu năm qua lá. Triệu chứng phù hợp: Cỏ tranh, cỏ ống, cỏ lá rộng mọc dày trong vườn. Nguyên nhân thường gặp: Cỏ cạnh tranh dinh dưỡng, ánh sáng, nước với cây trồng. Đối tượng cây trồng: Vườn cây ăn trái, cao su, cà phê, đất trước gieo trồng. Thời điểm xử lý: Phun khi cỏ đang sinh trưởng mạnh, cao 15-30cm. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 95.000 - 140.000 VNĐ.', 117500.00, 2, 1, 3, 36, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Glyphosate IPA salt: 480g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 80-120ml/bình 16 lít; phun ướt đều lá cỏ. An toàn sử dụng: Tránh để thuốc dính lá, thân xanh cây trồng; không phun lúc gió mạnh.'),
(37, 'PARAQUAT 276SL', 'SP-002-000037', 'paraquat-276sl-sp37', 'Công dụng: Trừ cỏ tiếp xúc, làm cháy nhanh phần xanh của cỏ. Triệu chứng phù hợp: Cỏ non, cỏ lá rộng, cỏ hòa bản mọc trên mặt đất. Nguyên nhân thường gặp: Cỏ cạnh tranh dinh dưỡng và là nơi trú sâu bệnh. Đối tượng cây trồng: Vườn cây lâu năm, bờ ruộng, đất không canh tác. Thời điểm xử lý: Khi cỏ còn non, phun tránh cây trồng. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 100.000 - 160.000 VNĐ.', 130000.00, 2, 1, 3, 37, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Paraquat dichloride: 276g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha theo nhãn; chỉ dùng khi sản phẩm được phép lưu hành tại địa phương. An toàn sử dụng: Rất độc, bắt buộc đồ bảo hộ đầy đủ; không dùng sai quy định pháp luật.'),
(38, 'BUTACHLOR 600EC', 'SP-002-000038', 'butachlor-600ec-sp38', 'Công dụng: Trừ cỏ tiền nảy mầm và hậu nảy mầm sớm trên ruộng lúa. Triệu chứng phù hợp: Cỏ lồng vực, cỏ chác, cỏ lá rộng mọc sau sạ. Nguyên nhân thường gặp: Hạt cỏ nảy mầm cùng lúa, cạnh tranh dinh dưỡng. Đối tượng cây trồng: Lúa sạ, lúa cấy. Thời điểm xử lý: Sau sạ 1-4 ngày, ruộng đủ ẩm hoặc có nước mỏng. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 120.000 - 180.000 VNĐ.', 150000.00, 2, 1, 3, 38, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Butachlor: 600g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 40-60ml/bình 16 lít hoặc dùng 1-1,5 lít/ha tùy nhãn. An toàn sử dụng: Không dùng khi lúa yếu, ruộng khô nứt; giữ nước đúng kỹ thuật.'),
(39, 'PRETILACHLOR 300EC', 'SP-002-000039', 'pretilachlor-300ec-sp39', 'Công dụng: Trừ cỏ tiền nảy mầm trên lúa, an toàn khi dùng đúng liều. Triệu chứng phù hợp: Cỏ lồng vực, cỏ đuôi phụng, cỏ lá rộng mới mọc. Nguyên nhân thường gặp: Cỏ nảy mầm trong giai đoạn đầu sau sạ. Đối tượng cây trồng: Lúa sạ ướt, lúa cấy. Thời điểm xử lý: Sau sạ 1-3 ngày, trước khi cỏ mọc mạnh. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 130.000 - 190.000 VNĐ.', 160000.00, 2, 1, 3, 39, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Pretilachlor: 300g/lít; chất an toàn cây trồng. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Dùng 0,8-1,2 lít/ha; phun khi ruộng đủ ẩm. An toàn sử dụng: Không phun khi mưa lớn sắp xảy ra; không để nước ngập sâu sau phun.'),
(40, '2,4-D 720SL', 'SP-002-000040', '2-4-d-720sl-sp40', 'Công dụng: Trừ cỏ lá rộng, cỏ chác lác trong ruộng lúa. Triệu chứng phù hợp: Cỏ lá rộng mọc chen lúa, cạnh tranh ánh sáng và dinh dưỡng. Nguyên nhân thường gặp: Cỏ dại phát triển sau sạ, đặc biệt nơi ruộng thưa. Đối tượng cây trồng: Lúa, bãi cỏ theo hướng dẫn nhãn. Thời điểm xử lý: Sau sạ 15-25 ngày, khi lúa đã cứng cây. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 45.000 - 70.000 VNĐ.', 57500.00, 2, 1, 3, 40, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: 2,4-D dimethylamine salt: 720g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; phun tránh gió tạt sang cây mẫn cảm. An toàn sử dụng: Không phun gần rau màu, bông, cây ăn trái non; dễ gây dị dạng cây mẫn cảm.'),
(41, 'BISPYRIBAC-SODIUM 10SC', 'SP-002-000041', 'bispyribac-sodium-10sc-sp41', 'Công dụng: Trừ cỏ hậu nảy mầm trên ruộng lúa, cỏ hòa bản và lá rộng. Triệu chứng phù hợp: Cỏ lồng vực, cỏ đuôi phụng, cỏ chác mọc lẫn lúa. Nguyên nhân thường gặp: Cỏ đã mọc sau sạ, cạnh tranh mạnh với lúa non. Đối tượng cây trồng: Lúa sạ. Thời điểm xử lý: Sau sạ 8-18 ngày, khi cỏ 2-4 lá. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 70.000 - 110.000 VNĐ.', 90000.00, 2, 1, 3, 41, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Bispyribac-sodium: 100g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; rút cạn nước trước phun, cho nước lại sau 1-2 ngày. An toàn sử dụng: Không phun khi lúa bị ngộ độc phèn, mặn hoặc rét.'),
(42, 'GA3 10SP', 'SP-002-000042', 'ga3-10sp-sp42', 'Công dụng: Kích thích kéo dài tế bào, tăng sinh trưởng, hỗ trợ ra hoa đậu trái tùy cây. Triệu chứng phù hợp: Cây chậm lớn, chồi ngắn, hoa nở không đồng đều. Nguyên nhân thường gặp: Thiếu cân bằng hormone sinh trưởng hoặc điều kiện thời tiết bất lợi. Đối tượng cây trồng: Nho, lúa giống, rau, hoa, cây ăn trái theo khuyến cáo. Thời điểm xử lý: Giai đoạn cần kích chồi, kéo gié, xử lý ra hoa tùy cây. Quy cách: Gói 10g. Giá tham khảo: Khoảng 25.000 - 45.000 VNĐ.', 35000.00, 2, 1, 4, 42, 'Theo nhà cung cấp', 'Việt Nam', 0.01, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Gibberellic acid GA3: 10% w/w. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Gói 10g.', 'Hướng dẫn sử dụng: Pha 1-2g/100 lít nước tùy mục đích; cần theo đúng khuyến cáo từng cây. An toàn sử dụng: Dùng quá liều dễ làm cây vống, yếu; không pha tùy tiện.'),
(43, 'NAA 1.8SL', 'SP-002-000043', 'naa-1-8sl-sp43', 'Công dụng: Hạn chế rụng trái non, kích thích ra rễ, tăng đậu trái. Triệu chứng phù hợp: Trái non rụng nhiều, cành giâm khó ra rễ. Nguyên nhân thường gặp: Mất cân bằng auxin, cây bị sốc sau đậu trái hoặc cành giâm chưa hình thành rễ. Đối tượng cây trồng: Cây ăn trái, hoa kiểng, rau màu, cây giâm cành. Thời điểm xử lý: Sau đậu trái, khi giâm hom, giai đoạn cây cần phục hồi rễ. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 2, 1, 3, 43, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Alpha-naphthalene acetic acid NAA: 18g/lít. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 5-10ml/bình 16 lít cho phun; xử lý hom theo nhãn. An toàn sử dụng: Dùng sai liều có thể gây rụng lá, dị dạng trái; đọc kỹ hướng dẫn.'),
(44, 'ATONIK 1.8SL', 'SP-002-000044', 'atonik-1-8sl-sp44', 'Công dụng: Kích thích sinh trưởng, tăng trao đổi chất, phục hồi cây sau stress. Triệu chứng phù hợp: Cây chậm hồi phục, lá nhỏ, ra hoa kém đồng loạt. Nguyên nhân thường gặp: Cây bị stress do thời tiết, sâu bệnh, ngộ độc hoặc thiếu dinh dưỡng. Đối tượng cây trồng: Lúa, rau màu, cây ăn trái, hoa, cây công nghiệp. Thời điểm xử lý: Sau cấy, sau trồng, trước ra hoa, sau khi cây bị stress. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 55.000 - 85.000 VNĐ.', 70000.00, 2, 1, 3, 44, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Sodium nitrophenolate hỗn hợp: 1.8%. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 6-10ml/bình 16 lít; phun 1-2 lần cách 7 ngày. An toàn sử dụng: Không thay thế phân bón; không dùng quá liều vì dễ rối loạn sinh trưởng.'),
(45, 'PACLOBUTRAZOL 15WP', 'SP-002-000045', 'paclobutrazol-15wp-sp45', 'Công dụng: Ức chế sinh trưởng thân lá, hỗ trợ phân hóa mầm hoa. Triệu chứng phù hợp: Cây quá tốt lá, khó ra hoa, ra đọt liên tục. Nguyên nhân thường gặp: Dư đạm, cây sinh trưởng sinh dưỡng mạnh, chưa chuyển sang sinh sản. Đối tượng cây trồng: Xoài, sầu riêng, nhãn, cây ăn trái theo kỹ thuật xử lý. Thời điểm xử lý: Trước giai đoạn xử lý ra hoa, khi cây đã đủ sức. Quy cách: Gói 100g. Giá tham khảo: Khoảng 70.000 - 120.000 VNĐ.', 95000.00, 2, 1, 4, 45, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Paclobutrazol: 15% w/w. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Liều phụ thuộc tuổi cây và đường kính tán; thường tưới quanh vùng rễ theo nhãn. An toàn sử dụng: Không dùng cho cây yếu; dư liều gây suy cây kéo dài nhiều vụ.'),
(46, 'CYTOKININ 6-BA 2SL', 'SP-002-000046', 'cytokinin-6-ba-2sl-sp46', 'Công dụng: Kích thích phân chia tế bào, bật chồi, tăng kích thước trái non. Triệu chứng phù hợp: Chồi ngủ khó bật, trái phát triển không đều, cành ít nhánh. Nguyên nhân thường gặp: Thiếu cân bằng cytokinin hoặc cây suy sau thu hoạch. Đối tượng cây trồng: Hoa kiểng, cây ăn trái, rau màu, vườn ươm. Thời điểm xử lý: Sau cắt tỉa, giai đoạn nuôi trái non, kích chồi. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 3, 46, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: 6-Benzylaminopurine 6-BA: 20g/lít. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 5-10ml/bình 16 lít; phun theo tán hoặc xử lý điểm. An toàn sử dụng: Dùng đúng liều; không phun khi cây thiếu nước nặng.'),
(47, 'ETHREL 480SL', 'SP-002-000047', 'ethrel-480sl-sp47', 'Công dụng: Thúc chín đồng loạt, xử lý ra hoa một số cây, điều hòa sinh trưởng. Triệu chứng phù hợp: Trái chín không đều, ra hoa lệch vụ khó kiểm soát. Nguyên nhân thường gặp: Cần điều chỉnh ethylene nội sinh để thúc đẩy quá trình chín/ra hoa. Đối tượng cây trồng: Dứa, cao su, cà phê, một số cây ăn trái theo nhãn. Thời điểm xử lý: Giai đoạn xử lý chín hoặc xử lý ra hoa theo quy trình kỹ thuật. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 90.000 - 150.000 VNĐ.', 120000.00, 2, 1, 3, 47, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Ethephon: 480g/lít. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha theo nhãn từng cây; không dùng tùy tiện vì liều rất nhạy. An toàn sử dụng: Có tính acid; tránh dính da mắt; không pha với thuốc kiềm mạnh.'),
(48, 'ROOTMAX KÍCH RỄ', 'SP-001-000048', 'rootmax-kich-re-sp48', 'Công dụng: Kích thích ra rễ trắng, phục hồi cây sau trồng hoặc sau úng. Triệu chứng phù hợp: Cây héo nhẹ, chậm bén rễ, rễ ít lông hút. Nguyên nhân thường gặp: Rễ bị tổn thương do bứng trồng, úng nước, đất bí hoặc thiếu lân. Đối tượng cây trồng: Cây con, rau màu, cây ăn trái, hoa kiểng. Thời điểm xử lý: Sau trồng, sau thay chậu, sau ngập úng, sau thu hoạch. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 95.000 - 140.000 VNĐ.', 117500.00, 1, 1, 3, 48, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 5%; P2O5: 30%; Humic: 5%; Amino acid; Vitamin B1; Zn. Loại sản phẩm: phan_bon. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 30-50ml/bình 16 lít tưới gốc; 7 ngày/lần. An toàn sử dụng: Không tưới lúc đất quá khô nóng; cần kết hợp cải tạo thoát nước.'),
(49, 'SIÊU KALI BO', 'SP-001-000049', 'sieu-kali-bo-sp49', 'Công dụng: Tăng vận chuyển đường, chắc trái, hạn chế rụng và nứt trái. Triệu chứng phù hợp: Trái nhạt, vỏ mỏng, dễ nứt, rụng sinh lý. Nguyên nhân thường gặp: Thiếu Kali và Bo trong giai đoạn trái lớn nhanh. Đối tượng cây trồng: Sầu riêng, xoài, cam quýt, thanh long, cà phê, hồ tiêu. Thời điểm xử lý: Sau đậu trái, giai đoạn trái phát triển, trước thu hoạch 20-30 ngày. Quy cách: Gói 500g. Giá tham khảo: Khoảng 65.000 - 95.000 VNĐ.', 80000.00, 1, 1, 4, 49, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: K2O: 30%; Bo B: 3%; MgO: 2%; phụ gia hữu cơ. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 25-40g/bình 16 lít; phun 2-3 lần cách 7-10 ngày. An toàn sử dụng: Không phun quá gần thu hoạch nếu có phối thuốc BVTV; tránh pha với Canxi đậm đặc.'),
(50, 'PHÂN BÓN LÁ VI LƯỢNG CHELATE', 'SP-001-000050', 'phan-bon-la-vi-luong-chelate-sp50', 'Công dụng: Bổ sung vi lượng tổng hợp, chống vàng lá, tăng quang hợp và sức đề kháng. Triệu chứng phù hợp: Lá non vàng, gân xanh; đọt nhỏ; cây ra hoa kém. Nguyên nhân thường gặp: Thiếu vi lượng do đất pH cao/thấp, rễ yếu hoặc bón NPK mất cân đối. Đối tượng cây trồng: Rau màu, cây ăn trái, hoa, lúa, cà phê, hồ tiêu. Thời điểm xử lý: Giai đoạn cây con, ra đọt non, trước ra hoa, sau thu hoạch. Quy cách: Gói 250g. Giá tham khảo: Khoảng 45.000 - 70.000 VNĐ.', 57500.00, 1, 1, 4, 50, 'Theo nhà cung cấp', 'Việt Nam', 0.25, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fe-EDTA: 3%; Zn-EDTA: 3%; Mn-EDTA: 2%; Cu-EDTA: 1%; B: 1%; Mo: 0,05%. Loại sản phẩm: phan_bon. Quy cách: Gói 250g.', 'Hướng dẫn sử dụng: Pha 10-20g/bình 16 lít; phun sáng sớm hoặc chiều mát. An toàn sử dụng: Không pha chung với vôi, thuốc kiềm mạnh; đậy kín sau khi dùng.'),
(51, 'NPK 15-15-15 TE', 'SP-001-000051', 'npk-15-15-15-te-sp51', 'Công dụng: Cung cấp dinh dưỡng cân đối, giúp cây phát triển đồng đều thân, lá, rễ và trái. Triệu chứng phù hợp: Cây còi, lá nhạt màu, ra hoa đậu trái kém, trái nhỏ. Nguyên nhân thường gặp: Đất thiếu dinh dưỡng đa lượng hoặc bón phân không cân đối. Đối tượng cây trồng: Lúa, rau màu, cây ăn trái, cà phê, hồ tiêu, cao su. Thời điểm xử lý: Bón thúc sinh trưởng, sau thu hoạch, trước ra hoa hoặc giai đoạn nuôi trái. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 720.000 - 950.000 VNĐ/bao.', 835000.00, 1, 1, 2, 51, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 15%; P2O5: 15%; K2O: 15%; S: 5%; TE: Zn, B, Mn. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 200-500kg/ha tùy cây; cây ăn trái 0,5-2kg/gốc, vùi nhẹ và tưới nước. An toàn sử dụng: Không bón sát gốc non; tránh bón khi đất quá khô hoặc trời nắng gắt.'),
(52, 'NPK 12-12-17+2MgO', 'SP-001-000052', 'npk-12-12-17-2mgo-sp52', 'Công dụng: Tăng kali và magie, giúp chắc trái, xanh lá, tăng phẩm chất nông sản. Triệu chứng phù hợp: Lá già vàng mép, trái nhỏ, chất lượng thấp, cây yếu khi nuôi trái. Nguyên nhân thường gặp: Thiếu Kali và Magie trong giai đoạn nuôi trái hoặc đất bị rửa trôi. Đối tượng cây trồng: Sầu riêng, cam quýt, xoài, cà phê, hồ tiêu, rau ăn quả. Thời điểm xử lý: Giai đoạn sau đậu trái, nuôi trái, nuôi hạt, sau thu hoạch phục hồi cây. Quy cách: Bao 50kg. Giá tham khảo: Khoảng 780.000 - 1.050.000 VNĐ/bao.', 915000.00, 1, 1, 2, 52, 'Theo nhà cung cấp', 'Việt Nam', 50.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 12%; P2O5: 12%; K2O: 17%; MgO: 2%; TE. Loại sản phẩm: phan_bon. Quy cách: Bao 50kg.', 'Hướng dẫn sử dụng: Bón 0,5-2kg/gốc cây ăn trái hoặc 250-500kg/ha tùy mật độ. An toàn sử dụng: Không bón quá liều gây mặn rễ; kết hợp tưới đủ ẩm.'),
(53, 'NPK 13-13-13+TE', 'SP-001-000053', 'npk-13-13-13-te-sp53', 'Công dụng: Bón nền đa dụng, cân bằng dinh dưỡng cho cây con và cây kinh doanh. Triệu chứng phù hợp: Sinh trưởng chậm, bộ rễ kém, lá xanh không đều. Nguyên nhân thường gặp: Thiếu đồng thời đạm, lân, kali và vi lượng do đất nghèo dinh dưỡng. Đối tượng cây trồng: Rau màu, hoa kiểng, cây ăn trái, lúa, cây công nghiệp. Thời điểm xử lý: Bón lót, bón thúc đầu vụ, sau cắt tỉa hoặc sau thu hoạch. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 360.000 - 480.000 VNĐ/bao 25kg.', 280008.00, 1, 1, 2, 53, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 13%; P2O5: 13%; K2O: 13%; TE: Zn, B, Fe, Mn. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón 150-400kg/ha; cây chậu dùng 5-20g/chậu tùy kích thước. An toàn sử dụng: Đọc kỹ hướng dẫn từng cây; không để phân tiếp xúc trực tiếp rễ non.'),
(54, 'NPK 20-10-10+TE', 'SP-001-000054', 'npk-20-10-10-te-sp54', 'Công dụng: Kích thích ra đọt, phát triển thân lá, phục hồi cây sau thu hoạch. Triệu chứng phù hợp: Cây ra đọt yếu, lá nhỏ, tán thưa, vàng lá nhẹ. Nguyên nhân thường gặp: Thiếu đạm và dinh dưỡng sau giai đoạn nuôi trái hoặc cắt tỉa. Đối tượng cây trồng: Cây ăn trái, rau ăn lá, cà phê, tiêu, hoa kiểng. Thời điểm xử lý: Sau thu hoạch, sau cắt cành, giai đoạn cây cần phát triển tán lá. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 390.000 - 560.000 VNĐ/bao.', 475000.00, 1, 1, 2, 54, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 20%; P2O5: 10%; K2O: 10%; TE. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón 0,3-1,5kg/gốc tùy tuổi cây hoặc 200-400kg/ha. An toàn sử dụng: Không dùng nhiều sát giai đoạn xử lý ra hoa vì dễ làm cây đi đọt.'),
(55, 'NPK 7-5-44', 'SP-001-000055', 'npk-7-5-44-sp55', 'Công dụng: Tăng kali cao, giúp trái lớn nhanh, chắc, ngọt và lên màu tốt. Triệu chứng phù hợp: Trái phát triển chậm, nhạt vị, mềm trái, dễ nứt. Nguyên nhân thường gặp: Cây thiếu kali ở giai đoạn cuối nuôi trái hoặc năng suất cao làm cạn dinh dưỡng. Đối tượng cây trồng: Dưa hấu, ớt, cà chua, thanh long, xoài, cam quýt. Thời điểm xử lý: Giai đoạn trái lớn, trước thu hoạch 20-30 ngày tùy cây. Quy cách: Gói 500g. Giá tham khảo: Khoảng 65.000 - 95.000 VNĐ.', 80000.00, 1, 1, 4, 55, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N: 7%; P2O5: 5%; K2O: 44%; TE. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít, phun 2-3 lần cách nhau 7-10 ngày. An toàn sử dụng: Không pha chung với Canxi đậm đặc; không phun quá gần ngày thu hoạch nếu phối thuốc BVTV.'),
(56, 'MKP 0-52-34', 'SP-001-000056', 'mkp-0-52-34-sp56', 'Công dụng: Bổ sung lân và kali tinh khiết, hỗ trợ ra hoa, chắc trái, tăng chất lượng. Triệu chứng phù hợp: Ra hoa kém, trái non rụng, trái chậm lớn, cây mất cân đối dinh dưỡng. Nguyên nhân thường gặp: Thiếu lân-kali hoặc cây cần chuyển từ sinh trưởng sang sinh sản. Đối tượng cây trồng: Cây ăn trái, rau ăn quả, hoa, nho, thanh long. Thời điểm xử lý: Trước ra hoa, sau đậu trái, giai đoạn nuôi trái. Quy cách: Gói 1kg. Giá tham khảo: Khoảng 110.000 - 160.000 VNĐ/kg.', 135000.00, 1, 1, 4, 56, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Mono potassium phosphate; P2O5: 52%; K2O: 34%. Loại sản phẩm: phan_bon. Quy cách: Gói 1kg.', 'Hướng dẫn sử dụng: Pha 20-40g/bình 16 lít; tưới nhỏ giọt theo nồng độ khuyến cáo. An toàn sử dụng: Không pha trực tiếp với Canxi hoặc Magie đậm đặc vì dễ kết tủa.'),
(57, 'CANXI NITRAT 15.5-0-0+26CaO', 'SP-001-000057', 'canxi-nitrat-15-5-0-0-26cao-sp57', 'Công dụng: Cung cấp Canxi dễ hấp thu, hạn chế thối đít trái, nứt trái, cháy mép lá. Triệu chứng phù hợp: Đọt non cháy mép, trái thối đáy, vỏ trái yếu, rễ non kém. Nguyên nhân thường gặp: Thiếu Canxi do đất khô, mặn, cạnh tranh dinh dưỡng hoặc rễ yếu. Đối tượng cây trồng: Rau ăn quả, dưa, cà chua, ớt, cây ăn trái, hoa. Thời điểm xử lý: Giai đoạn cây con, ra hoa, sau đậu trái, trái lớn nhanh. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 320.000 - 460.000 VNĐ/bao.', 390000.00, 1, 1, 2, 57, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: N dạng nitrate: 15,5%; CaO: 26%. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón gốc 50-150kg/ha hoặc pha tưới 1-2kg/200 lít nước tùy cây. An toàn sử dụng: Không trộn chung với phân lân, sulfate đậm đặc; bảo quản tránh ẩm.');
INSERT INTO `products` (`ProductID`, `ProductName`, `SKU`, `Slug`, `Description`, `Price`, `CategoryID`, `StatusID`, `UnitID`, `ImageID`, `Brand`, `OriginCountry`, `Weight`, `IsActive`, `CreatedAt`, `UpdatedAt`, `TechnicalContent`, `UsageInstructions`) VALUES
(58, 'MAGIE SULPHATE MgSO4', 'SP-001-000058', 'magie-sulphate-mgso4-sp58', 'Công dụng: Bổ sung Magie và Lưu huỳnh, tăng diệp lục và quang hợp. Triệu chứng phù hợp: Lá già vàng giữa gân, gân còn xanh, cây kém xanh. Nguyên nhân thường gặp: Thiếu Mg do đất chua, rửa trôi hoặc bón Kali/Canxi quá nhiều. Đối tượng cây trồng: Cà phê, hồ tiêu, sầu riêng, cam quýt, rau màu, hoa. Thời điểm xử lý: Giai đoạn phát triển lá, sau thu hoạch, trước ra hoa. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 260.000 - 380.000 VNĐ/bao.', 320000.00, 1, 1, 2, 58, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: MgO: 16%; SO3: 32%; dạng magnesium sulfate. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón 100-300kg/ha hoặc phun 20-30g/bình 16 lít dạng hòa tan. An toàn sử dụng: Không pha chung Canxi nitrat đậm đặc; tránh bón quá liều gây mất cân đối.'),
(59, 'SILIC KALI', 'SP-001-000059', 'silic-kali-sp59', 'Công dụng: Tăng cứng cây, dày lá, cứng vỏ trái, hạn chế đổ ngã và sâu bệnh xâm nhập. Triệu chứng phù hợp: Lúa dễ đổ ngã, lá mỏng, trái dễ trầy xước, cây yếu. Nguyên nhân thường gặp: Thiếu Silic và Kali, mô cây mềm do dư đạm hoặc thời tiết bất lợi. Đối tượng cây trồng: Lúa, dưa, rau màu, cây ăn trái, mía. Thời điểm xử lý: Giai đoạn lúa đẻ nhánh-làm đòng, cây ăn trái nuôi trái. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 90.000 - 140.000 VNĐ.', 115000.00, 1, 1, 3, 59, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: SiO2 hữu hiệu: 20%; K2O: 10%; vi lượng. Loại sản phẩm: phan_bon. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 25-40ml/bình 16 lít; phun 2-3 lần cách 7-10 ngày. An toàn sử dụng: Không pha với thuốc/phân có pH quá thấp; thử trước khi phối trộn.'),
(60, 'AMINO ACID 80%', 'SP-001-000060', 'amino-acid-80-sp60', 'Công dụng: Giải độc, phục hồi cây, tăng hấp thu dinh dưỡng và tăng sức chống chịu. Triệu chứng phù hợp: Cây chậm phục hồi sau hạn, úng, ngộ độc thuốc hoặc sau thu hoạch. Nguyên nhân thường gặp: Cây bị stress sinh lý, rễ yếu, mất cân bằng dinh dưỡng. Đối tượng cây trồng: Rau màu, cây ăn trái, lúa, hoa, cà phê, tiêu. Thời điểm xử lý: Sau stress thời tiết, sau phun thuốc, sau thu hoạch hoặc giai đoạn nuôi trái. Quy cách: Gói 500g. Giá tham khảo: Khoảng 95.000 - 150.000 VNĐ.', 122500.00, 1, 1, 4, 60, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Amino acid tổng số: 80%; N hữu cơ; peptide sinh học. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 10-20g/bình 16 lít phun lá hoặc 500g/400 lít tưới gốc. An toàn sử dụng: Không thay thế phân đa lượng; bảo quản kín để tránh hút ẩm.'),
(61, 'PHÂN CÁ THỦY PHÂN', 'SP-001-000061', 'phan-ca-thuy-phan-sp61', 'Công dụng: Tăng hữu cơ, kích rễ, cải tạo đất và giúp cây xanh bền. Triệu chứng phù hợp: Đất chai, cây kém hấp thu, lá thiếu sức sống. Nguyên nhân thường gặp: Đất thiếu hữu cơ, hệ vi sinh yếu, rễ hoạt động kém. Đối tượng cây trồng: Rau hữu cơ, cây ăn trái, hoa, cây công nghiệp. Thời điểm xử lý: Tưới định kỳ trong mùa sinh trưởng, sau thu hoạch, sau trồng. Quy cách: Can 5 lít. Giá tham khảo: Khoảng 180.000 - 280.000 VNĐ/can.', 230000.00, 1, 1, 6, 61, 'Theo nhà cung cấp', 'Việt Nam', 5.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Đạm hữu cơ: 5%; amino acid; acid hữu cơ; khoáng vi lượng từ cá. Loại sản phẩm: phan_bon. Quy cách: Can 5 lít.', 'Hướng dẫn sử dụng: Pha 100-200ml/20 lít nước tưới gốc; 7-15 ngày/lần. An toàn sử dụng: Có mùi hữu cơ đặc trưng; đậy kín, tránh nắng trực tiếp.'),
(62, 'PHÂN DƠI HỮU CƠ', 'SP-001-000062', 'phan-doi-huu-co-sp62', 'Công dụng: Bổ sung hữu cơ và lân tự nhiên, giúp rễ khỏe, ra hoa tốt. Triệu chứng phù hợp: Cây chậm ra hoa, đất nghèo hữu cơ, rễ yếu. Nguyên nhân thường gặp: Đất bạc màu, thiếu lân hữu cơ và vi sinh vật có lợi. Đối tượng cây trồng: Hoa kiểng, rau màu, cây ăn trái, lan, cây chậu. Thời điểm xử lý: Bón lót, bón trước ra hoa, sau thay chậu. Quy cách: Bao 10kg. Giá tham khảo: Khoảng 70.000 - 120.000 VNĐ/bao.', 95000.00, 1, 1, 2, 62, 'Theo nhà cung cấp', 'Việt Nam', 10.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Hữu cơ: 50%; P2O5: 8%; N: 3%; K2O: 2%; vi sinh có ích. Loại sản phẩm: phan_bon. Quy cách: Bao 10kg.', 'Hướng dẫn sử dụng: Bón 0,5-2kg/gốc hoặc 20-50g/chậu tùy kích thước. An toàn sử dụng: Cần ủ hoai kỹ nếu dùng dạng thô; bảo quản khô tránh nấm mốc.'),
(63, 'BOKASHI HỮU CƠ VI SINH', 'SP-001-000063', 'bokashi-huu-co-vi-sinh-sp63', 'Công dụng: Cải tạo đất, tăng vi sinh, giảm mùi phân hữu cơ, giúp cây hấp thu tốt. Triệu chứng phù hợp: Đất chai cứng, cây sinh trưởng yếu, rễ ít lông hút. Nguyên nhân thường gặp: Đất nghèo hữu cơ, hệ vi sinh đất suy giảm, bón phân hóa học lâu năm. Đối tượng cây trồng: Rau màu, cây ăn trái, hoa, cây công nghiệp. Thời điểm xử lý: Bón lót trước trồng, bón bổ sung định kỳ 1-2 tháng/lần. Quy cách: Bao 20kg. Giá tham khảo: Khoảng 90.000 - 150.000 VNĐ/bao.', 120000.00, 1, 1, 2, 63, 'Theo nhà cung cấp', 'Việt Nam', 20.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Hữu cơ lên men; vi sinh Lactobacillus, Bacillus, nấm men; khoáng tự nhiên. Loại sản phẩm: phan_bon. Quy cách: Bao 20kg.', 'Hướng dẫn sử dụng: Bón 500-1500kg/ha hoặc 1-5kg/gốc tùy tuổi cây. An toàn sử dụng: Không phơi nắng trực tiếp lâu; giữ ẩm đất sau bón.'),
(64, 'ĐẠM CÁ + RONG BIỂN', 'SP-001-000064', 'am-ca-rong-bien-sp64', 'Công dụng: Phục hồi cây nhanh, kích rễ, kích chồi, tăng sức đề kháng sinh lý. Triệu chứng phù hợp: Lá xỉn màu, đọt chậm ra, cây suy sau thu hoạch. Nguyên nhân thường gặp: Thiếu dinh dưỡng hữu cơ dễ hấp thu hoặc cây bị stress. Đối tượng cây trồng: Cây ăn trái, rau, hoa, lúa, cây công nghiệp. Thời điểm xử lý: Sau thu hoạch, sau sâu bệnh, thời kỳ cây con và ra đọt. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 100.000 - 160.000 VNĐ.', 130000.00, 1, 1, 3, 64, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Amino acid cá: 15%; dịch rong biển: 10%; K2O: 3%; vi lượng. Loại sản phẩm: phan_bon. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 25-40ml/bình 16 lít phun lá hoặc 50ml/20 lít tưới gốc. An toàn sử dụng: Không pha với thuốc có tính kiềm mạnh; lắc đều trước khi dùng.'),
(65, 'VI LƯỢNG BO 15%', 'SP-001-000065', 'vi-luong-bo-15-sp65', 'Công dụng: Tăng thụ phấn, đậu trái, vận chuyển đường và hạn chế nứt trái. Triệu chứng phù hợp: Hoa rụng, trái méo, trái rỗng ruột, nứt trái. Nguyên nhân thường gặp: Thiếu Bo trong giai đoạn ra hoa và nuôi trái; đất khô hạn làm Bo khó vận chuyển. Đối tượng cây trồng: Cây ăn trái, rau ăn quả, cà phê, đậu, lúa. Thời điểm xử lý: Trước ra hoa 10-15 ngày, sau đậu trái, giai đoạn trái lớn. Quy cách: Gói 500g. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 1, 1, 4, 65, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Boron B: 15%; dạng hòa tan nhanh. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 10-20g/bình 16 lít hoặc bón gốc liều thấp theo khuyến cáo. An toàn sử dụng: Bo dễ gây độc nếu quá liều; không dùng tùy tiện cho cây mẫn cảm.'),
(66, 'SẮT CHELATE Fe-EDDHA 6%', 'SP-001-000066', 'sat-chelate-fe-eddha-6-sp66', 'Công dụng: Khắc phục vàng lá gân xanh do thiếu sắt, đặc biệt trên đất kiềm. Triệu chứng phù hợp: Lá non vàng nhạt nhưng gân còn xanh, đọt yếu. Nguyên nhân thường gặp: Thiếu Fe do pH đất cao, rễ yếu, đất bị úng hoặc nhiều vôi. Đối tượng cây trồng: Cam quýt, sầu riêng, rau màu, hoa kiểng, cây chậu. Thời điểm xử lý: Khi xuất hiện vàng lá non hoặc bón phòng trên đất kiềm. Quy cách: Gói 100g. Giá tham khảo: Khoảng 85.000 - 130.000 VNĐ.', 107500.00, 1, 1, 4, 66, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fe-EDDHA: 6%; sắt chelate bền trong pH cao. Loại sản phẩm: phan_bon. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha tưới 5-10g/gốc nhỏ hoặc 20-50g/gốc lớn tùy cây. An toàn sử dụng: Không pha với thuốc kiềm mạnh; bảo quản kín tránh ánh sáng.'),
(67, 'MOLYPDEN 5%', 'SP-001-000067', 'molypden-5-sp67', 'Công dụng: Hỗ trợ cố định đạm, chuyển hóa nitrate, giảm vàng lá do rối loạn đạm. Triệu chứng phù hợp: Lá vàng, cây họ đậu nốt sần kém, rau phát triển chậm. Nguyên nhân thường gặp: Thiếu Mo, đặc biệt trên đất chua làm cây khó chuyển hóa đạm. Đối tượng cây trồng: Đậu nành, đậu phộng, rau họ cải, lúa, cây ăn trái. Thời điểm xử lý: Giai đoạn cây con, trước ra hoa, khi lá vàng do rối loạn dinh dưỡng. Quy cách: Gói 100g. Giá tham khảo: Khoảng 35.000 - 60.000 VNĐ.', 47500.00, 1, 1, 4, 67, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Molybdenum Mo: 5%; phụ gia hòa tan. Loại sản phẩm: phan_bon. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 2-5g/bình 16 lít; phun 1-2 lần cách nhau 10 ngày. An toàn sử dụng: Dùng liều thấp; không trộn với dung dịch quá kiềm hoặc quá acid.'),
(68, 'COPPER OXYCHLORIDE 85WP', 'SP-002-000068', 'copper-oxychloride-85wp-sp68', 'Công dụng: Phòng trị bệnh do nấm và vi khuẩn như loét, đốm lá, sẹo trái. Triệu chứng phù hợp: Vết bệnh có quầng vàng, lá đốm nâu, trái bị sẹo sần. Nguyên nhân thường gặp: Vi khuẩn/nấm xâm nhập qua vết thương sau mưa, cắt tỉa, côn trùng chích hút. Đối tượng cây trồng: Cam quýt, xoài, cà chua, ớt, cây ăn trái. Thời điểm xử lý: Phun phòng trước mưa, sau cắt tỉa hoặc khi bệnh mới xuất hiện. Quy cách: Gói 100g. Giá tham khảo: Khoảng 40.000 - 65.000 VNĐ.', 52500.00, 2, 1, 4, 68, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Copper oxychloride: 85% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun phủ đều tán lá và trái. An toàn sử dụng: Có thể gây xót lá non; không pha với phân bón lá chứa lân cao.'),
(69, 'MANCOZEB 80WP', 'SP-002-000069', 'mancozeb-80wp-sp69', 'Công dụng: Phòng trị đốm lá, thán thư, sương mai, cháy lá. Triệu chứng phù hợp: Lá có đốm nâu, mép cháy, trái có vết bệnh lan rộng. Nguyên nhân thường gặp: Nấm bệnh phát triển khi ẩm độ cao, mưa nhiều, tán cây rậm. Đối tượng cây trồng: Khoai tây, cà chua, dưa, xoài, thanh long, rau màu. Thời điểm xử lý: Phun phòng định kỳ mùa mưa hoặc khi bệnh mới chớm. Quy cách: Gói 100g. Giá tham khảo: Khoảng 30.000 - 55.000 VNĐ.', 42500.00, 2, 1, 4, 69, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Mancozeb: 80% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 25-40g/bình 16 lít; phun ướt đều hai mặt lá. An toàn sử dụng: Không dùng quá gần thu hoạch; mang khẩu trang khi pha bột thuốc.'),
(70, 'CHLOROTHALONIL 75WP', 'SP-002-000070', 'chlorothalonil-75wp-sp70', 'Công dụng: Thuốc tiếp xúc phổ rộng, phòng trị đốm lá, cháy lá, sương mai. Triệu chứng phù hợp: Lá xuất hiện đốm tròn, cháy mép, bệnh lan nhanh sau mưa. Nguyên nhân thường gặp: Bào tử nấm bám trên bề mặt lá trong điều kiện ẩm. Đối tượng cây trồng: Rau màu, đậu, khoai, cây ăn trái, hoa. Thời điểm xử lý: Phun phòng trước thời kỳ bệnh thường phát sinh hoặc sau mưa. Quy cách: Gói 100g. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 2, 1, 4, 70, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Chlorothalonil: 75% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun phủ đều bề mặt lá. An toàn sử dụng: Không pha với dầu khoáng; tránh hít bụi thuốc khi pha.'),
(71, 'CYMOXANIL + MANCOZEB 72WP', 'SP-002-000071', 'cymoxanil-mancozeb-72wp-sp71', 'Công dụng: Đặc trị sương mai, mốc sương, cháy lá do nấm giả. Triệu chứng phù hợp: Mặt dưới lá có mốc trắng, lá vàng loang, vết bệnh lan nhanh. Nguyên nhân thường gặp: Nấm giả phát triển mạnh khi đêm lạnh, ngày ẩm, mưa kéo dài. Đối tượng cây trồng: Dưa leo, nho, khoai tây, cà chua, rau màu. Thời điểm xử lý: Khi bệnh mới chớm hoặc phun phòng trước mưa kéo dài. Quy cách: Gói 100g. Giá tham khảo: Khoảng 40.000 - 70.000 VNĐ.', 55000.00, 2, 1, 4, 71, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Cymoxanil: 8%; Mancozeb: 64%. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 25-35g/bình 16 lít; phun 2 lần cách 5-7 ngày. An toàn sử dụng: Luân phiên hoạt chất; không phun quá liều trên cây non.'),
(72, 'FOSETYL-AL 80WP', 'SP-002-000072', 'fosetyl-al-80wp-sp72', 'Công dụng: Phòng trị thối rễ, xì mủ, sương mai; tăng sức đề kháng cây. Triệu chứng phù hợp: Gốc xì mủ, rễ thối, lá vàng rụng, cây suy nhanh. Nguyên nhân thường gặp: Nấm Phytophthora và Pythium gây hại trong đất ẩm, thoát nước kém. Đối tượng cây trồng: Sầu riêng, cam quýt, hồ tiêu, dưa, cây ăn trái. Thời điểm xử lý: Đầu mùa mưa, sau mưa kéo dài, khi vườn có biểu hiện thối rễ. Quy cách: Gói 100g. Giá tham khảo: Khoảng 70.000 - 110.000 VNĐ.', 90000.00, 2, 1, 4, 72, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fosetyl-aluminium: 80% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 30-40g/bình 16 lít phun hoặc tưới gốc theo nhãn. An toàn sử dụng: Kết hợp cải tạo thoát nước; không chỉ dựa vào thuốc khi đất úng nặng.'),
(73, 'METALAXYL 25WP', 'SP-002-000073', 'metalaxyl-25wp-sp73', 'Công dụng: Trị nấm giả, thối rễ, chết cây con, sương mai. Triệu chứng phù hợp: Cây con héo rũ, gốc thâm, lá có mốc trắng dưới mặt lá. Nguyên nhân thường gặp: Nấm Pythium, Phytophthora, Peronospora phát sinh do ẩm độ cao. Đối tượng cây trồng: Dưa, rau màu, hồ tiêu, cây con vườn ươm. Thời điểm xử lý: Xử lý đất trước trồng, tưới gốc khi bệnh mới xuất hiện. Quy cách: Gói 100g. Giá tham khảo: Khoảng 35.000 - 60.000 VNĐ.', 47500.00, 2, 1, 4, 73, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Metalaxyl: 25% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 15-25g/bình 16 lít tưới gốc hoặc phun theo nhãn. An toàn sử dụng: Dễ kháng thuốc nếu dùng đơn hoạt chất liên tục; cần luân phiên.'),
(74, 'TRIFLOXYSTROBIN + TEBUCONAZOLE', 'SP-002-000074', 'trifloxystrobin-tebuconazole-sp74', 'Công dụng: Trừ thán thư, phấn trắng, đốm lá, lem lép hạt; hiệu lực phòng và trị. Triệu chứng phù hợp: Lá đốm nâu, trái thán thư lõm, bông lúa lem lép. Nguyên nhân thường gặp: Tổ hợp nấm bệnh phát sinh trong giai đoạn ẩm, cây rậm tán. Đối tượng cây trồng: Lúa, xoài, ớt, cà chua, nho, cây ăn trái. Thời điểm xử lý: Khi bệnh mới xuất hiện, trước trổ lúa hoặc trước mùa mưa. Quy cách: Gói 50g. Giá tham khảo: Khoảng 95.000 - 150.000 VNĐ.', 122500.00, 2, 1, 4, 74, 'Theo nhà cung cấp', 'Việt Nam', 0.05, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Trifloxystrobin: 25%; Tebuconazole: 50%; dạng WG. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 50g.', 'Hướng dẫn sử dụng: Pha 3-5g/bình 16 lít; phun đều tán cây. An toàn sử dụng: Không dùng liên tục nhiều lần; tuân thủ thời gian cách ly.'),
(75, 'THIOPHANATE-METHYL 70WP', 'SP-002-000075', 'thiophanate-methyl-70wp-sp75', 'Công dụng: Trừ nấm lưu dẫn như thán thư, đốm lá, héo rũ, thối thân. Triệu chứng phù hợp: Vết bệnh nâu đen, thân thối, lá rụng sớm. Nguyên nhân thường gặp: Nấm Colletotrichum, Fusarium, Botrytis, Cercospora. Đối tượng cây trồng: Rau màu, hoa, cây ăn trái, đậu, cây công nghiệp. Thời điểm xử lý: Phun khi bệnh chớm hoặc xử lý vết cắt sau tỉa cành. Quy cách: Gói 100g. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 2, 1, 4, 75, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Thiophanate-methyl: 70% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 10-20g/bình 16 lít; phun ướt đều vùng bệnh. An toàn sử dụng: Luân phiên với nhóm khác để hạn chế kháng thuốc.'),
(76, 'SULFUR 80WG', 'SP-002-000076', 'sulfur-80wg-sp76', 'Công dụng: Phòng trị phấn trắng, nhện nhẹ; hỗ trợ giảm nấm ngoài bề mặt lá. Triệu chứng phù hợp: Lá phủ lớp bột trắng, đọt non cong, lá vàng khô. Nguyên nhân thường gặp: Nấm phấn trắng phát triển trong điều kiện khô xen ẩm. Đối tượng cây trồng: Nho, dưa, xoài, hoa hồng, rau màu. Thời điểm xử lý: Khi bệnh mới chớm, phun phòng thời kỳ dễ phát bệnh. Quy cách: Gói 100g. Giá tham khảo: Khoảng 30.000 - 55.000 VNĐ.', 42500.00, 2, 1, 4, 76, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Sulfur: 80% w/w. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 20-30g/bình 16 lít; phun phủ đều hai mặt lá. An toàn sử dụng: Không phun khi nhiệt độ quá cao; không pha chung dầu khoáng gần thời điểm phun.'),
(77, 'BACILLUS SUBTILIS SINH HỌC', 'SP-002-000077', 'bacillus-subtilis-sinh-hoc-sp77', 'Công dụng: Đối kháng nấm bệnh, giảm thối rễ, chết cây con, tăng vi sinh có lợi. Triệu chứng phù hợp: Rễ thâm, cây con chết rạp, đất có mùi hôi nhẹ. Nguyên nhân thường gặp: Nấm đất và vi khuẩn hại phát triển khi đất ẩm, hữu cơ chưa hoai. Đối tượng cây trồng: Rau màu, cây ăn trái, vườn ươm, hoa, hồ tiêu. Thời điểm xử lý: Xử lý đất trước trồng, tưới định kỳ phòng bệnh rễ. Quy cách: Gói 500g. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 4, 77, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Bacillus subtilis ≥ 10^8 CFU/g; chất mang hữu cơ. Loại sản phẩm: thuoc_tru_benh. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 500g/200-400 lít nước tưới gốc; có thể trộn phân hữu cơ hoai. An toàn sử dụng: Không pha cùng thuốc nấm hóa học mạnh; dùng chiều mát để bảo vệ vi sinh.'),
(78, 'SPINETORAM 60SC', 'SP-002-000078', 'spinetoram-60sc-sp78', 'Công dụng: Trừ sâu tơ, sâu xanh, bọ trĩ, sâu đục trái; hiệu lực tốt trên sâu non. Triệu chứng phù hợp: Lá bị cắn khuyết, đọt xoăn, hoa và trái non bị hại. Nguyên nhân thường gặp: Sâu non và bọ trĩ gây hại mạnh ở đọt non, hoa, trái. Đối tượng cây trồng: Rau cải, ớt, dưa, xoài, hoa, cây ăn trái. Thời điểm xử lý: Khi sâu tuổi nhỏ hoặc bọ trĩ mới xuất hiện. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 90.000 - 140.000 VNĐ.', 115000.00, 2, 1, 3, 78, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Spinetoram: 60g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 6-10ml/bình 16 lít; phun kỹ đọt non, hoa và mặt dưới lá. An toàn sử dụng: Hạn chế phun lúc ong hoạt động; luân phiên hoạt chất để tránh kháng.'),
(79, 'SPINOSAD 25SC', 'SP-002-000079', 'spinosad-25sc-sp79', 'Công dụng: Trừ sâu tơ, sâu xanh, ruồi đục lá, bọ trĩ theo hướng sinh học. Triệu chứng phù hợp: Lá có đường đục ngoằn ngoèo, đọt non hư, hoa rụng. Nguyên nhân thường gặp: Sâu non, ruồi đục lá và bọ trĩ gây hại trên mô non. Đối tượng cây trồng: Rau màu, hoa, ớt, dưa, cây ăn trái. Thời điểm xử lý: Giai đoạn cây non, ra hoa, khi sâu mới phát sinh. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 75.000 - 120.000 VNĐ.', 97500.00, 2, 1, 3, 79, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Spinosad: 25g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít; phun chiều mát. An toàn sử dụng: Tương đối chọn lọc nhưng vẫn cần tránh phun trực tiếp lên ong.'),
(80, 'INDOXACARB 150SC', 'SP-002-000080', 'indoxacarb-150sc-sp80', 'Công dụng: Trừ sâu khoang, sâu xanh, sâu tơ, sâu đục trái. Triệu chứng phù hợp: Sâu ăn thủng lá, trái bị đục, phân sâu xuất hiện quanh vết đục. Nguyên nhân thường gặp: Sâu tuổi nhỏ đến trung bình gây hại mạnh khi thời tiết nóng ẩm. Đối tượng cây trồng: Rau cải, ớt, cà chua, bắp, đậu, cây ăn trái. Thời điểm xử lý: Phun sớm khi sâu mới nở, trước khi sâu chui vào trái. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 85.000 - 130.000 VNĐ.', 107500.00, 2, 1, 3, 80, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Indoxacarb: 150g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 8-12ml/bình 16 lít; phun đều tán lá. An toàn sử dụng: Không phun quá liều; tuân thủ cách ly trên rau ăn lá.'),
(81, 'LUFENURON 50EC', 'SP-002-000081', 'lufenuron-50ec-sp81', 'Công dụng: Ức chế lột xác sâu non, trừ sâu tơ, sâu xanh, sâu khoang. Triệu chứng phù hợp: Sâu non ăn lá kéo dài, mật số tăng sau vài ngày. Nguyên nhân thường gặp: Trứng và sâu non phát triển liên tục, sâu kháng thuốc tiếp xúc thông thường. Đối tượng cây trồng: Rau màu, bông, cây ăn trái, hoa. Thời điểm xử lý: Phun khi sâu còn nhỏ hoặc khi thấy ổ trứng mới nở. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 65.000 - 100.000 VNĐ.', 82500.00, 2, 1, 3, 81, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Lufenuron: 50g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 10-15ml/bình 16 lít; phun lặp lại sau 7 ngày nếu cần. An toàn sử dụng: Không mong hiệu lực hạ gục tức thì; phối hợp quản lý IPM.'),
(82, 'CHLORFENAPYR 240SC', 'SP-002-000082', 'chlorfenapyr-240sc-sp82', 'Công dụng: Trừ sâu kháng thuốc, bọ trĩ, nhện, sâu ăn lá. Triệu chứng phù hợp: Lá bạc màu, đọt xoăn, sâu ăn lá khó trị bằng thuốc cũ. Nguyên nhân thường gặp: Dịch hại kháng thuốc hoặc ẩn dưới mặt lá, trong đọt non. Đối tượng cây trồng: Ớt, dưa, rau màu, hoa, cây ăn trái. Thời điểm xử lý: Khi mật số sâu/bọ trĩ tăng, phun lúc chiều mát. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 95.000 - 150.000 VNĐ.', 122500.00, 2, 1, 3, 82, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Chlorfenapyr: 240g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 8-12ml/bình 16 lít; phun kỹ mặt dưới lá. An toàn sử dụng: Không phun khi cây đang stress nặng; tránh để thuốc trôi xuống ao cá.'),
(83, 'BUPROFEZIN 25SC', 'SP-002-000083', 'buprofezin-25sc-sp83', 'Công dụng: Trừ rầy nâu, rệp sáp, rệp vảy bằng cơ chế ức chế lột xác. Triệu chứng phù hợp: Rầy non nhiều, lá vàng, mật ngọt và nấm bồ hóng xuất hiện. Nguyên nhân thường gặp: Côn trùng chích hút sinh sản nhanh, mật số cao trong tán rậm. Đối tượng cây trồng: Lúa, xoài, cam quýt, cà phê, cây cảnh. Thời điểm xử lý: Khi rầy/rệp tuổi non chiếm đa số. Quy cách: Chai 250ml. Giá tham khảo: Khoảng 65.000 - 100.000 VNĐ.', 82500.00, 2, 1, 3, 83, 'Theo nhà cung cấp', 'Việt Nam', 0.25, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Buprofezin: 250g/lít. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 250ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; phun kỹ nơi rầy rệp trú. An toàn sử dụng: Hiệu lực chậm, không dùng đơn độc khi mật số quá cao.'),
(84, 'ACETAMIPRID 20SP', 'SP-002-000084', 'acetamiprid-20sp-sp84', 'Công dụng: Trừ rệp, bọ phấn, rầy xanh, rầy mềm, bọ trĩ nhẹ. Triệu chứng phù hợp: Lá xoăn, đọt non biến dạng, mặt lá có mật ngọt. Nguyên nhân thường gặp: Côn trùng chích hút làm suy cây và truyền virus. Đối tượng cây trồng: Rau màu, chè, cây ăn trái, hoa kiểng. Thời điểm xử lý: Khi phát hiện côn trùng chích hút trên đọt non hoặc mặt dưới lá. Quy cách: Gói 100g. Giá tham khảo: Khoảng 45.000 - 75.000 VNĐ.', 60000.00, 2, 1, 4, 84, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Acetamiprid: 20% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 8-12g/bình 16 lít; phun đều tán lá. An toàn sử dụng: Không lạm dụng nhóm neonicotinoid; tránh phun lúc ong hoạt động.'),
(85, 'THIAMETHOXAM 25WG', 'SP-002-000085', 'thiamethoxam-25wg-sp85', 'Công dụng: Trừ rầy nâu, rệp, bọ phấn, bọ trĩ; có tính lưu dẫn. Triệu chứng phù hợp: Cây vàng lùn, lá xoăn, rầy rệp bám dưới lá. Nguyên nhân thường gặp: Côn trùng chích hút truyền bệnh và làm cây mất nhựa. Đối tượng cây trồng: Lúa, rau, hoa, cây ăn trái, cây công nghiệp. Thời điểm xử lý: Xử lý hạt, tưới gốc hoặc phun khi dịch hại mới xuất hiện theo nhãn. Quy cách: Gói 100g. Giá tham khảo: Khoảng 60.000 - 95.000 VNĐ.', 77500.00, 2, 1, 4, 85, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Thiamethoxam: 25% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 5-10g/bình 16 lít; xử lý hạt giống theo liều ghi trên nhãn. An toàn sử dụng: Độc với ong; không dùng tùy tiện trên cây đang ra hoa.'),
(86, 'CARTAP HYDROCHLORIDE 95SP', 'SP-002-000086', 'cartap-hydrochloride-95sp-sp86', 'Công dụng: Trừ sâu đục thân, sâu cuốn lá, sâu ăn lá trên lúa và rau. Triệu chứng phù hợp: Dảnh lúa héo, bông bạc, lá bị cuốn và cắn phá. Nguyên nhân thường gặp: Sâu non đục vào thân hoặc cuốn lá làm giảm quang hợp. Đối tượng cây trồng: Lúa, rau màu, mía, cây trồng cạn theo nhãn. Thời điểm xử lý: Giai đoạn sâu tuổi nhỏ, lúa đẻ nhánh-làm đòng. Quy cách: Gói 100g. Giá tham khảo: Khoảng 50.000 - 80.000 VNĐ.', 65000.00, 2, 1, 4, 86, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Cartap hydrochloride: 95% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 100g.', 'Hướng dẫn sử dụng: Pha 8-12g/bình 16 lít; ruộng lúa dùng lượng nước đủ phủ tán. An toàn sử dụng: Không pha với thuốc có tính kiềm mạnh; bảo quản xa thức ăn.'),
(87, 'MATRINE 0.6SL', 'SP-002-000087', 'matrine-0-6sl-sp87', 'Công dụng: Trừ rệp, sâu non, bọ trĩ mức nhẹ; phù hợp chương trình sinh học. Triệu chứng phù hợp: Đọt non có rệp, lá bị chích hút, sâu non rải rác. Nguyên nhân thường gặp: Dịch hại mới phát sinh, mật số thấp, cần giảm áp lực hóa học. Đối tượng cây trồng: Rau hữu cơ, hoa, cây ăn trái, cây gia vị. Thời điểm xử lý: Phun phòng hoặc khi dịch hại mới xuất hiện mật số thấp. Quy cách: Chai 250ml. Giá tham khảo: Khoảng 60.000 - 100.000 VNĐ.', 80000.00, 2, 1, 3, 87, 'Theo nhà cung cấp', 'Việt Nam', 0.25, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Matrine: 0,6% từ thảo mộc. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 250ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; phun lặp lại 5-7 ngày nếu cần. An toàn sử dụng: Hiệu lực nhẹ hơn thuốc hóa học; tránh phun khi mưa sắp đến.'),
(88, 'BEAUVERIA BASSIANA SINH HỌC', 'SP-002-000088', 'beauveria-bassiana-sinh-hoc-sp88', 'Công dụng: Ký sinh côn trùng, hỗ trợ quản lý rầy, rệp, bọ cánh cứng, sâu non. Triệu chứng phù hợp: Côn trùng xuất hiện rải rác, cần kiểm soát sinh học lâu dài. Nguyên nhân thường gặp: Dịch hại cư trú trong tán, môi trường ẩm thuận lợi cho nấm ký sinh. Đối tượng cây trồng: Rau, lúa, cà phê, hồ tiêu, cây ăn trái. Thời điểm xử lý: Phun chiều mát khi ẩm độ cao, giai đoạn dịch hại mới phát sinh. Quy cách: Gói 500g. Giá tham khảo: Khoảng 90.000 - 140.000 VNĐ.', 115000.00, 2, 1, 4, 88, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Nấm Beauveria bassiana ≥ 10^8 bào tử/g. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 500g/200 lít nước; phun kỹ nơi côn trùng trú ẩn. An toàn sử dụng: Không pha chung thuốc trừ nấm; tránh nắng gắt để bảo vệ bào tử.'),
(89, 'DẦU KHOÁNG 99EC', 'SP-002-000089', 'dau-khoang-99ec-sp89', 'Công dụng: Phòng trừ rệp sáp, rệp vảy, nhện, trứng sâu; hỗ trợ rửa nấm bồ hóng. Triệu chứng phù hợp: Lá và trái có lớp muội đen, rệp vảy bám cành, nhện đỏ li ti. Nguyên nhân thường gặp: Côn trùng chích hút tiết mật, trứng và ấu trùng bám trên bề mặt cây. Đối tượng cây trồng: Cam quýt, xoài, cà phê, hoa kiểng, cây ăn trái. Thời điểm xử lý: Khi rệp mới xuất hiện, sau cắt tỉa, trước mùa khô. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 3, 89, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Mineral oil: 99% w/w. Loại sản phẩm: thuoc_tru_sau. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 50-80ml/bình 16 lít; phun ướt đều thân cành và mặt dưới lá. An toàn sử dụng: Không phun lúc nắng nóng hoặc cây đang thiếu nước; không pha gần thời điểm dùng lưu huỳnh.'),
(90, 'METALDEHYDE 6GR', 'SP-002-000090', 'metaldehyde-6gr-sp90', 'Công dụng: Diệt ốc bươu vàng, ốc sên, nhớt hại cây con. Triệu chứng phù hợp: Lá non bị cắn cụt, cây con mất lá, ruộng lúa bị ốc ăn mạ. Nguyên nhân thường gặp: Ốc hoạt động mạnh khi ruộng ngập nước, ẩm độ cao. Đối tượng cây trồng: Lúa, rau màu, vườn ươm, hoa kiểng. Thời điểm xử lý: Sau sạ/cấy, sau mưa, khi thấy ốc xuất hiện. Quy cách: Gói 500g. Giá tham khảo: Khoảng 45.000 - 70.000 VNĐ.', 57500.00, 2, 1, 4, 90, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Metaldehyde: 6%; dạng hạt bả. Loại sản phẩm: thuoc_tru_sau. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Rải 3-5kg/ha hoặc theo nhãn; rải nơi ốc tập trung. An toàn sử dụng: Không để gia súc, gia cầm ăn phải; tránh rải gần nguồn nước sinh hoạt.'),
(91, 'GLUFOSINATE-AMMONIUM 200SL', 'SP-002-000091', 'glufosinate-ammonium-200sl-sp91', 'Công dụng: Trừ cỏ không chọn lọc, tác động tiếp xúc-lưu dẫn hạn chế. Triệu chứng phù hợp: Cỏ lá rộng, cỏ hòa bản, cỏ non mọc dày trong vườn. Nguyên nhân thường gặp: Cỏ cạnh tranh nước, phân bón và là nơi trú sâu bệnh. Đối tượng cây trồng: Vườn cây ăn trái, cao su, cà phê, đất trước trồng. Thời điểm xử lý: Khi cỏ xanh tốt, cao 10-25cm, tránh để thuốc dính cây trồng. Quy cách: Chai 1 lít. Giá tham khảo: Khoảng 130.000 - 190.000 VNĐ.', 160000.00, 2, 1, 3, 91, 'Theo nhà cung cấp', 'Việt Nam', 1.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Glufosinate-ammonium: 200g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 1 lít.', 'Hướng dẫn sử dụng: Pha 80-120ml/bình 16 lít; phun ướt đều lá cỏ. An toàn sử dụng: Che chắn cây trồng non; không phun lúc gió mạnh hoặc sắp mưa.'),
(92, 'QUIZALOFOP-P-ETHYL 10EC', 'SP-002-000092', 'quizalofop-p-ethyl-10ec-sp92', 'Công dụng: Trừ cỏ hòa bản hậu nảy mầm trong cây lá rộng. Triệu chứng phù hợp: Cỏ lồng vực, cỏ tranh non, cỏ chỉ mọc lẫn trong ruộng đậu/rau. Nguyên nhân thường gặp: Cỏ hòa bản cạnh tranh mạnh, khó nhổ hết bằng tay. Đối tượng cây trồng: Đậu nành, đậu phộng, rau lá rộng, cây công nghiệp lá rộng. Thời điểm xử lý: Khi cỏ 3-5 lá, cây trồng đã bén rễ. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 70.000 - 110.000 VNĐ.', 90000.00, 2, 1, 3, 92, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Quizalofop-P-ethyl: 100g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; phun tránh để cỏ quá già. An toàn sử dụng: Không dùng trên lúa, bắp hoặc cây hòa bản; đọc kỹ nhãn trước dùng.'),
(93, 'FENOXAPROP-P-ETHYL 69EC', 'SP-002-000093', 'fenoxaprop-p-ethyl-69ec-sp93', 'Công dụng: Trừ cỏ hòa bản hậu nảy mầm trong ruộng lúa. Triệu chứng phù hợp: Cỏ lồng vực, cỏ đuôi phụng mọc cao hơn lúa. Nguyên nhân thường gặp: Cỏ hòa bản phát triển sau sạ, cạnh tranh dinh dưỡng với lúa. Đối tượng cây trồng: Lúa sạ. Thời điểm xử lý: Sau sạ 10-20 ngày, khi cỏ 2-4 lá. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 65.000 - 100.000 VNĐ.', 82500.00, 2, 1, 3, 93, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fenoxaprop-P-ethyl: 69g/lít; chất an toàn lúa. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; rút nước trước phun, cho nước lại sau 1-2 ngày. An toàn sử dụng: Không phun khi lúa yếu do phèn, mặn, ngộ độc hữu cơ.'),
(94, 'PENOXSULAM 25OD', 'SP-002-000094', 'penoxsulam-25od-sp94', 'Công dụng: Trừ cỏ lúa hậu nảy mầm, phổ rộng trên cỏ hòa bản, lá rộng, chác lác. Triệu chứng phù hợp: Ruộng có nhiều loại cỏ hỗn hợp, cỏ mọc sau sạ 7-15 ngày. Nguyên nhân thường gặp: Quản lý nước không tốt hoặc đất có nguồn hạt cỏ cao. Đối tượng cây trồng: Lúa sạ. Thời điểm xử lý: Sau sạ 7-15 ngày, khi cỏ còn nhỏ. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 3, 94, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Penoxsulam: 25g/lít. Loại sản phẩm: thuoc_tru_co. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít hoặc theo liều/ha trên nhãn. An toàn sử dụng: Không phun khi ruộng khô nứt hoặc lúa đang stress; không tăng liều tùy tiện.'),
(95, 'ATRAZINE 80WP', 'SP-002-000095', 'atrazine-80wp-sp95', 'Công dụng: Trừ cỏ tiền và hậu nảy mầm sớm trên bắp, mía. Triệu chứng phù hợp: Cỏ lá rộng và cỏ hòa bản non mọc dày sau gieo. Nguyên nhân thường gặp: Hạt cỏ nảy mầm cùng cây trồng, cạnh tranh giai đoạn đầu. Đối tượng cây trồng: Bắp, mía theo khuyến cáo nhãn. Thời điểm xử lý: Sau gieo trước mọc hoặc khi cỏ còn nhỏ. Quy cách: Gói 500g. Giá tham khảo: Khoảng 85.000 - 130.000 VNĐ.', 107500.00, 2, 1, 4, 95, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Atrazine: 80% w/w. Loại sản phẩm: thuoc_tru_co. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha theo liều/ha trên nhãn; phun đất đủ ẩm để tăng hiệu quả. An toàn sử dụng: Không dùng trên cây mẫn cảm; tránh thuốc trôi sang ruộng rau, đậu.'),
(96, 'IBA KÍCH RỄ 98%', 'SP-002-000096', 'iba-kich-re-98-sp96', 'Công dụng: Kích thích ra rễ cho hom giâm, cây chiết, cây cấy mô. Triệu chứng phù hợp: Hom lâu ra rễ, tỷ lệ sống thấp, rễ ít và ngắn. Nguyên nhân thường gặp: Thiếu auxin kích rễ hoặc điều kiện giâm chưa phù hợp. Đối tượng cây trồng: Hoa kiểng, cây ăn trái, cây lâm nghiệp, vườn ươm. Thời điểm xử lý: Trước khi giâm hom, chiết cành hoặc phục hồi cây con. Quy cách: Gói 10g. Giá tham khảo: Khoảng 45.000 - 80.000 VNĐ.', 62500.00, 2, 1, 4, 96, 'Theo nhà cung cấp', 'Việt Nam', 0.01, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Indole-3-butyric acid IBA: 98%; dạng bột kỹ thuật pha loãng. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Gói 10g.', 'Hướng dẫn sử dụng: Pha nồng độ thấp theo từng loại hom; nhúng nhanh gốc hom hoặc quét vào vết chiết. An toàn sử dụng: Hoạt chất rất mạnh, phải cân đúng liều; tránh tiếp xúc trực tiếp da mắt.'),
(97, 'BRASSINOLIDE 0.01SL', 'SP-002-000097', 'brassinolide-0-01sl-sp97', 'Công dụng: Tăng sức chống chịu, hỗ trợ quang hợp, cải thiện đậu trái và phục hồi stress. Triệu chứng phù hợp: Cây chậm lớn, lá nhỏ, hoa dễ rụng khi thời tiết bất lợi. Nguyên nhân thường gặp: Cây bị stress nhiệt, hạn, mặn hoặc rối loạn hormone sinh trưởng. Đối tượng cây trồng: Lúa, rau màu, cây ăn trái, hoa, cây công nghiệp. Thời điểm xử lý: Trước ra hoa, sau đậu trái, sau stress thời tiết. Quy cách: Chai 100ml. Giá tham khảo: Khoảng 60.000 - 95.000 VNĐ.', 77500.00, 2, 1, 3, 97, 'Theo nhà cung cấp', 'Việt Nam', 0.10, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Brassinolide: 0,01% w/v. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 100ml.', 'Hướng dẫn sử dụng: Pha 5-8ml/bình 16 lít; phun 1-2 lần cách nhau 7-10 ngày. An toàn sử dụng: Không dùng quá liều; không thay thế phân bón và quản lý nước.'),
(98, 'CHITOSAN OLIGO 5SL', 'SP-002-000098', 'chitosan-oligo-5sl-sp98', 'Công dụng: Kích kháng tự nhiên, tăng đề kháng nấm khuẩn, hỗ trợ phục hồi mô cây. Triệu chứng phù hợp: Cây dễ nhiễm bệnh sau mưa, vết thương lâu lành, lá yếu. Nguyên nhân thường gặp: Sức đề kháng cây thấp, mô cây mềm, áp lực nấm khuẩn cao. Đối tượng cây trồng: Rau màu, cây ăn trái, lúa, hoa, hồ tiêu. Thời điểm xử lý: Phun phòng trước mùa bệnh, sau mưa, sau cắt tỉa. Quy cách: Chai 500ml. Giá tham khảo: Khoảng 80.000 - 130.000 VNĐ.', 105000.00, 2, 1, 3, 98, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Chitosan oligosaccharide: 5%; acid hữu cơ sinh học. Loại sản phẩm: thuoc_kich_thich_sinh_truong. Quy cách: Chai 500ml.', 'Hướng dẫn sử dụng: Pha 20-30ml/bình 16 lít; phun đều tán cây. An toàn sử dụng: Không xem là thuốc trị bệnh nặng; phối hợp vệ sinh vườn và dinh dưỡng cân đối.'),
(99, 'FULVIC KALI 70%', 'SP-001-000099', 'fulvic-kali-70-sp99', 'Công dụng: Tăng hấp thu phân bón, giải độc phèn mặn nhẹ, kích rễ và xanh lá. Triệu chứng phù hợp: Cây vàng lá sinh lý, rễ yếu, hấp thu phân kém sau mưa. Nguyên nhân thường gặp: Đất phèn, mặn nhẹ, pH bất lợi hoặc rễ bị stress. Đối tượng cây trồng: Lúa, rau màu, cây ăn trái, cà phê, hồ tiêu. Thời điểm xử lý: Sau mưa lớn, sau bón phân, giai đoạn cây cần phục hồi rễ. Quy cách: Gói 500g. Giá tham khảo: Khoảng 90.000 - 140.000 VNĐ.', 115000.00, 1, 1, 4, 99, 'Theo nhà cung cấp', 'Việt Nam', 0.50, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Fulvic acid: 70%; K2O: 8%; vi lượng dạng chelate. Loại sản phẩm: phan_bon. Quy cách: Gói 500g.', 'Hướng dẫn sử dụng: Pha 100-200g/phuy 200 lít tưới gốc hoặc 10-15g/bình 16 lít phun lá. An toàn sử dụng: Không pha chung với dung dịch quá acid/kiềm; bảo quản kín tránh ẩm.'),
(100, 'NPK HỮU CƠ KHOÁNG 5-3-4', 'SP-001-000100', 'npk-huu-co-khoang-5-3-4-sp100', 'Công dụng: Cải tạo đất kết hợp bổ sung dinh dưỡng nhẹ, phù hợp canh tác bền vững. Triệu chứng phù hợp: Đất bạc màu, cây xanh không bền, rễ kém phát triển. Nguyên nhân thường gặp: Thiếu hữu cơ lâu dài, đất mất tơi xốp, hệ vi sinh suy giảm. Đối tượng cây trồng: Rau màu, cây ăn trái, hoa, cà phê, hồ tiêu, cây chậu. Thời điểm xử lý: Bón lót, sau thu hoạch, định kỳ 1-2 tháng/lần. Quy cách: Bao 25kg. Giá tham khảo: Khoảng 120.000 - 190.000 VNĐ/bao.', 155000.00, 1, 1, 2, 100, 'Theo nhà cung cấp', 'Việt Nam', 25.00, 1, '2026-05-20 10:03:14', '2026-05-20 10:03:14', 'Thành phần: Hữu cơ: 30%; N: 5%; P2O5: 3%; K2O: 4%; Humic; vi sinh hữu ích. Loại sản phẩm: phan_bon. Quy cách: Bao 25kg.', 'Hướng dẫn sử dụng: Bón 500-1500kg/ha hoặc 1-5kg/gốc tùy tuổi cây. An toàn sử dụng: Bảo quản nơi khô; không trộn trực tiếp với thuốc sát khuẩn/nấm mạnh.');

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
(1, 1, '1.png', '/images/uploads/products/1.png', 'Ảnh sản phẩm KẼM BORON 50.000ppm', 1, 1, 1, '2026-05-26 04:46:20'),
(2, 2, '2.png', '/images/uploads/products/2.png', 'Ảnh sản phẩm NPK 20-20-15 TE', 1, 1, 1, '2026-05-26 04:46:20'),
(3, 3, '3.png', '/images/uploads/products/3.png', 'Ảnh sản phẩm DAP 18-46-0', 1, 1, 1, '2026-05-26 04:46:20'),
(4, 4, '4.png', '/images/uploads/products/4.png', 'Ảnh sản phẩm KALI CLORUA KCl 60%', 1, 1, 1, '2026-05-26 04:46:20'),
(5, 5, '5.png', '/images/uploads/products/5.png', 'Ảnh sản phẩm CANXI BO MAX', 1, 1, 1, '2026-05-26 04:46:20'),
(6, 6, '6.png', '/images/uploads/products/6.png', 'Ảnh sản phẩm HUMIC ACID 70%', 1, 1, 1, '2026-05-26 04:46:20'),
(7, 7, '7.png', '/images/uploads/products/7.png', 'Ảnh sản phẩm SEAWEED AMINO 30', 1, 1, 1, '2026-05-26 04:46:20'),
(8, 8, '8.png', '/images/uploads/products/8.png', 'Ảnh sản phẩm NPK 16-16-8 + TE', 1, 1, 1, '2026-05-26 04:46:20'),
(9, 9, '9.png', '/images/uploads/products/9.png', 'Ảnh sản phẩm MAGIE KẼM LƯU HUỲNH', 1, 1, 1, '2026-05-26 04:46:20'),
(10, 10, '10.png', '/images/uploads/products/10.png', 'Ảnh sản phẩm PHÂN BÓN LÁ 10-55-10', 1, 1, 1, '2026-05-26 04:46:20'),
(11, 11, '11.png', '/images/uploads/products/11.png', 'Ảnh sản phẩm PHÂN BÓN LÁ 6-30-30', 1, 1, 1, '2026-05-26 04:46:20'),
(12, 12, '12.png', '/images/uploads/products/12.png', 'Ảnh sản phẩm NPK 30-10-10', 1, 1, 1, '2026-05-26 04:46:20'),
(13, 13, '13.png', '/images/uploads/products/13.png', 'Ảnh sản phẩm UREA PHÚ MỸ', 1, 1, 1, '2026-05-26 04:46:20'),
(14, 14, '14.png', '/images/uploads/products/14.png', 'Ảnh sản phẩm PHÂN HỮU CƠ VI SINH', 1, 1, 1, '2026-05-26 04:46:20'),
(15, 15, '15.png', '/images/uploads/products/15.png', 'Ảnh sản phẩm TRICHODERMA NANO', 1, 1, 1, '2026-05-26 04:46:20'),
(16, 16, '16.png', '/images/uploads/products/16.png', 'Ảnh sản phẩm ABAMECTIN 3.6EC', 1, 1, 1, '2026-05-26 04:46:20'),
(17, 17, '17.png', '/images/uploads/products/17.png', 'Ảnh sản phẩm EMAMECTIN BENZOATE 5WG', 1, 1, 1, '2026-05-26 04:46:20'),
(18, 18, '18.png', '/images/uploads/products/18.png', 'Ảnh sản phẩm CHLORANTRANILIPROLE 35WG', 1, 1, 1, '2026-05-26 04:46:20'),
(19, 19, '19.png', '/images/uploads/products/19.png', 'Ảnh sản phẩm DINOTEFURAN 20SG', 1, 1, 1, '2026-05-26 04:46:20'),
(20, 20, '20.png', '/images/uploads/products/20.png', 'Ảnh sản phẩm IMIDACLOPRID 100SL', 1, 1, 1, '2026-05-26 04:46:20'),
(21, 21, '21.png', '/images/uploads/products/21.png', 'Ảnh sản phẩm PYMETROZINE 50WG', 1, 1, 1, '2026-05-26 04:46:20'),
(22, 22, '22.png', '/images/uploads/products/22.png', 'Ảnh sản phẩm CYPERMETHRIN 25EC', 1, 1, 1, '2026-05-26 04:46:20'),
(23, 23, '23.png', '/images/uploads/products/23.png', 'Ảnh sản phẩm LAMBDA-CYHALOTHRIN 2.5EC', 1, 1, 1, '2026-05-26 04:46:20'),
(24, 24, '24.png', '/images/uploads/products/24.png', 'Ảnh sản phẩm SPIROTETRAMAT 100SC', 1, 1, 1, '2026-05-26 04:46:20'),
(25, 25, '25.png', '/images/uploads/products/25.png', 'Ảnh sản phẩm FIPRONIL 800WG', 1, 1, 1, '2026-05-26 04:46:20'),
(26, 26, '26.png', '/images/uploads/products/26.png', 'Ảnh sản phẩm METALAXYL + MANCOZEB 72WP', 1, 1, 1, '2026-05-26 04:46:20'),
(27, 27, '27.png', '/images/uploads/products/27.png', 'Ảnh sản phẩm HEXACONAZOLE 5SC', 1, 1, 1, '2026-05-26 04:46:20'),
(28, 28, '28.png', '/images/uploads/products/28.png', 'Ảnh sản phẩm DIFENOCONAZOLE 250EC', 1, 1, 1, '2026-05-26 04:46:20'),
(29, 29, '29.png', '/images/uploads/products/29.png', 'Ảnh sản phẩm PROPICONAZOLE 250EC', 1, 1, 1, '2026-05-26 04:46:20'),
(30, 30, '30.png', '/images/uploads/products/30.png', 'Ảnh sản phẩm AZOXYSTROBIN 250SC', 1, 1, 1, '2026-05-26 04:46:20'),
(31, 31, '31.png', '/images/uploads/products/31.png', 'Ảnh sản phẩm COPPER HYDROXIDE 77WP', 1, 1, 1, '2026-05-26 04:46:20'),
(32, 32, '32.png', '/images/uploads/products/32.png', 'Ảnh sản phẩm KASUGAMYCIN 2SL', 1, 1, 1, '2026-05-26 04:46:20'),
(33, 33, '33.png', '/images/uploads/products/33.png', 'Ảnh sản phẩm VALIDAMYCIN 5SL', 1, 1, 1, '2026-05-26 04:46:20'),
(34, 34, '34.png', '/images/uploads/products/34.png', 'Ảnh sản phẩm CARBENDAZIM 500FL', 1, 1, 1, '2026-05-26 04:46:20'),
(35, 35, '35.png', '/images/uploads/products/35.png', 'Ảnh sản phẩm TEBUCONAZOLE 250EW', 1, 1, 1, '2026-05-26 04:46:20'),
(36, 36, '36.png', '/images/uploads/products/36.png', 'Ảnh sản phẩm GLYPHOSATE 480SL', 1, 1, 1, '2026-05-26 04:46:20'),
(37, 37, '37.png', '/images/uploads/products/37.png', 'Ảnh sản phẩm PARAQUAT 276SL', 1, 1, 1, '2026-05-26 04:46:20'),
(38, 38, '38.png', '/images/uploads/products/38.png', 'Ảnh sản phẩm BUTACHLOR 600EC', 1, 1, 1, '2026-05-26 04:46:20'),
(39, 39, '39.png', '/images/uploads/products/39.png', 'Ảnh sản phẩm PRETILACHLOR 300EC', 1, 1, 1, '2026-05-26 04:46:20'),
(40, 40, '40.png', '/images/uploads/products/40.png', 'Ảnh sản phẩm 2,4-D 720SL', 1, 1, 1, '2026-05-26 04:46:20'),
(41, 41, '41.png', '/images/uploads/products/41.png', 'Ảnh sản phẩm BISPYRIBAC-SODIUM 10SC', 1, 1, 1, '2026-05-26 04:46:20'),
(42, 42, '42.png', '/images/uploads/products/42.png', 'Ảnh sản phẩm GA3 10SP', 1, 1, 1, '2026-05-26 04:46:20'),
(43, 43, '43.png', '/images/uploads/products/43.png', 'Ảnh sản phẩm NAA 1.8SL', 1, 1, 1, '2026-05-26 04:46:20'),
(44, 44, '44.png', '/images/uploads/products/44.png', 'Ảnh sản phẩm ATONIK 1.8SL', 1, 1, 1, '2026-05-26 04:46:20'),
(45, 45, '45.png', '/images/uploads/products/45.png', 'Ảnh sản phẩm PACLOBUTRAZOL 15WP', 1, 1, 1, '2026-05-26 04:46:20'),
(46, 46, '46.png', '/images/uploads/products/46.png', 'Ảnh sản phẩm CYTOKININ 6-BA 2SL', 1, 1, 1, '2026-05-26 04:46:20'),
(47, 47, 'default.jpg', '/images/uploads/products/default.jpg', 'Ảnh sản phẩm ETHREL 480SL', 1, 1, 1, '2026-05-26 04:46:20'),
(48, 48, '48.png', '/images/uploads/products/48.png', 'Ảnh sản phẩm ROOTMAX KÍCH RỄ', 1, 1, 1, '2026-05-26 04:46:20'),
(49, 49, '49.png', '/images/uploads/products/49.png', 'Ảnh sản phẩm SIÊU KALI BO', 1, 1, 1, '2026-05-26 04:46:20'),
(50, 50, '50.png', '/images/uploads/products/50.png', 'Ảnh sản phẩm PHÂN BÓN LÁ VI LƯỢNG CHELATE', 1, 1, 1, '2026-05-26 04:46:20'),
(51, 51, '51.png', '/images/uploads/products/51.png', 'Ảnh sản phẩm NPK 15-15-15 TE', 1, 1, 1, '2026-05-26 04:46:20'),
(52, 52, '52.png', '/images/uploads/products/52.png', 'Ảnh sản phẩm NPK 12-12-17+2MgO', 1, 1, 1, '2026-05-26 04:46:20'),
(53, 53, '53.png', '/images/uploads/products/53.png', 'Ảnh sản phẩm NPK 13-13-13+TE', 1, 1, 1, '2026-05-26 04:46:20'),
(54, 54, '54.png', '/images/uploads/products/54.png', 'Ảnh sản phẩm NPK 20-10-10+TE', 1, 1, 1, '2026-05-26 04:46:20'),
(55, 55, '55.png', '/images/uploads/products/55.png', 'Ảnh sản phẩm NPK 7-5-44', 1, 1, 1, '2026-05-26 04:46:20'),
(56, 56, '56.png', '/images/uploads/products/56.png', 'Ảnh sản phẩm MKP 0-52-34', 1, 1, 1, '2026-05-26 04:46:20'),
(57, 57, '57.png', '/images/uploads/products/57.png', 'Ảnh sản phẩm CANXI NITRAT 15.5-0-0+26CaO', 1, 1, 1, '2026-05-26 04:46:20'),
(58, 58, '58.png', '/images/uploads/products/58.png', 'Ảnh sản phẩm MAGIE SULPHATE MgSO4', 1, 1, 1, '2026-05-26 04:46:20'),
(59, 59, '59.png', '/images/uploads/products/59.png', 'Ảnh sản phẩm SILIC KALI', 1, 1, 1, '2026-05-26 04:46:20'),
(60, 60, '60.png', '/images/uploads/products/60.png', 'Ảnh sản phẩm AMINO ACID 80%', 1, 1, 1, '2026-05-26 04:46:20'),
(61, 61, '61.png', '/images/uploads/products/61.png', 'Ảnh sản phẩm PHÂN CÁ THỦY PHÂN', 1, 1, 1, '2026-05-26 04:46:20'),
(62, 62, '62.png', '/images/uploads/products/62.png', 'Ảnh sản phẩm PHÂN DƠI HỮU CƠ', 1, 1, 1, '2026-05-26 04:46:20'),
(63, 63, '63.png', '/images/uploads/products/63.png', 'Ảnh sản phẩm BOKASHI HỮU CƠ VI SINH', 1, 1, 1, '2026-05-26 04:46:20'),
(64, 64, '64.png', '/images/uploads/products/64.png', 'Ảnh sản phẩm ĐẠM CÁ + RONG BIỂN', 1, 1, 1, '2026-05-26 04:46:20'),
(65, 65, '65.png', '/images/uploads/products/65.png', 'Ảnh sản phẩm VI LƯỢNG BO 15%', 1, 1, 1, '2026-05-26 04:46:20'),
(66, 66, '66.png', '/images/uploads/products/66.png', 'Ảnh sản phẩm SẮT CHELATE Fe-EDDHA 6%', 1, 1, 1, '2026-05-26 04:46:20'),
(67, 67, '67.png', '/images/uploads/products/67.png', 'Ảnh sản phẩm MOLYPDEN 5%', 1, 1, 1, '2026-05-26 04:46:20'),
(68, 68, '68.png', '/images/uploads/products/68.png', 'Ảnh sản phẩm COPPER OXYCHLORIDE 85WP', 1, 1, 1, '2026-05-26 04:46:20'),
(69, 69, '69.png', '/images/uploads/products/69.png', 'Ảnh sản phẩm MANCOZEB 80WP', 1, 1, 1, '2026-05-26 04:46:20'),
(70, 70, '70.png', '/images/uploads/products/70.png', 'Ảnh sản phẩm CHLOROTHALONIL 75WP', 1, 1, 1, '2026-05-26 04:46:20'),
(71, 71, '71.png', '/images/uploads/products/71.png', 'Ảnh sản phẩm CYMOXANIL + MANCOZEB 72WP', 1, 1, 1, '2026-05-26 04:46:20'),
(72, 72, '72.png', '/images/uploads/products/72.png', 'Ảnh sản phẩm FOSETYL-AL 80WP', 1, 1, 1, '2026-05-26 04:46:20'),
(73, 73, '73.png', '/images/uploads/products/73.png', 'Ảnh sản phẩm METALAXYL 25WP', 1, 1, 1, '2026-05-26 04:46:20'),
(74, 74, '74.png', '/images/uploads/products/74.png', 'Ảnh sản phẩm TRIFLOXYSTROBIN + TEBUCONAZOLE', 1, 1, 1, '2026-05-26 04:46:20'),
(75, 75, '75.png', '/images/uploads/products/75.png', 'Ảnh sản phẩm THIOPHANATE-METHYL 70WP', 1, 1, 1, '2026-05-26 04:46:20'),
(76, 76, '76.png', '/images/uploads/products/76.png', 'Ảnh sản phẩm SULFUR 80WG', 1, 1, 1, '2026-05-26 04:46:20'),
(77, 77, '77.png', '/images/uploads/products/77.png', 'Ảnh sản phẩm BACILLUS SUBTILIS SINH HỌC', 1, 1, 1, '2026-05-26 04:46:20'),
(78, 78, '78.png', '/images/uploads/products/78.png', 'Ảnh sản phẩm SPINETORAM 60SC', 1, 1, 1, '2026-05-26 04:46:20'),
(79, 79, '79.png', '/images/uploads/products/79.png', 'Ảnh sản phẩm SPINOSAD 25SC', 1, 1, 1, '2026-05-26 04:46:20'),
(80, 80, '80.png', '/images/uploads/products/80.png', 'Ảnh sản phẩm INDOXACARB 150SC', 1, 1, 1, '2026-05-26 04:46:20'),
(81, 81, '81.png', '/images/uploads/products/81.png', 'Ảnh sản phẩm LUFENURON 50EC', 1, 1, 1, '2026-05-26 04:46:20'),
(82, 82, '82.png', '/images/uploads/products/82.png', 'Ảnh sản phẩm CHLORFENAPYR 240SC', 1, 1, 1, '2026-05-26 04:46:20'),
(83, 83, '83.png', '/images/uploads/products/83.png', 'Ảnh sản phẩm BUPROFEZIN 25SC', 1, 1, 1, '2026-05-26 04:46:20'),
(84, 84, '84.png', '/images/uploads/products/84.png', 'Ảnh sản phẩm ACETAMIPRID 20SP', 1, 1, 1, '2026-05-26 04:46:20'),
(85, 85, '85.png', '/images/uploads/products/85.png', 'Ảnh sản phẩm THIAMETHOXAM 25WG', 1, 1, 1, '2026-05-26 04:46:20'),
(86, 86, '86.png', '/images/uploads/products/86.png', 'Ảnh sản phẩm CARTAP HYDROCHLORIDE 95SP', 1, 1, 1, '2026-05-26 04:46:20'),
(87, 87, '87.png', '/images/uploads/products/87.png', 'Ảnh sản phẩm MATRINE 0.6SL', 1, 1, 1, '2026-05-26 04:46:20'),
(88, 88, '88.png', '/images/uploads/products/88.png', 'Ảnh sản phẩm BEAUVERIA BASSIANA SINH HỌC', 1, 1, 1, '2026-05-26 04:46:20'),
(89, 89, '89.png', '/images/uploads/products/89.png', 'Ảnh sản phẩm DẦU KHOÁNG 99EC', 1, 1, 1, '2026-05-26 04:46:20'),
(90, 90, '90.png', '/images/uploads/products/90.png', 'Ảnh sản phẩm METALDEHYDE 6GR', 1, 1, 1, '2026-05-26 04:46:20'),
(91, 91, '91.png', '/images/uploads/products/91.png', 'Ảnh sản phẩm GLUFOSINATE-AMMONIUM 200SL', 1, 1, 1, '2026-05-26 04:46:20'),
(92, 92, '92.png', '/images/uploads/products/92.png', 'Ảnh sản phẩm QUIZALOFOP-P-ETHYL 10EC', 1, 1, 1, '2026-05-26 04:46:20'),
(93, 93, '93.png', '/images/uploads/products/93.png', 'Ảnh sản phẩm FENOXAPROP-P-ETHYL 69EC', 1, 1, 1, '2026-05-26 04:46:20'),
(94, 94, '94.png', '/images/uploads/products/94.png', 'Ảnh sản phẩm PENOXSULAM 25OD', 1, 1, 1, '2026-05-26 04:46:20'),
(95, 95, '95.png', '/images/uploads/products/95.png', 'Ảnh sản phẩm ATRAZINE 80WP', 1, 1, 1, '2026-05-26 04:46:20'),
(96, 96, '96.png', '/images/uploads/products/96.png', 'Ảnh sản phẩm IBA KÍCH RỄ 98%', 1, 1, 1, '2026-05-26 04:46:20'),
(97, 97, '97.png', '/images/uploads/products/97.png', 'Ảnh sản phẩm BRASSINOLIDE 0.01SL', 1, 1, 1, '2026-05-26 04:46:20'),
(98, 98, '98.png', '/images/uploads/products/98.png', 'Ảnh sản phẩm CHITOSAN OLIGO 5SL', 1, 1, 1, '2026-05-26 04:46:20'),
(99, 99, '99.png', '/images/uploads/products/99.png', 'Ảnh sản phẩm FULVIC KALI 70%', 1, 1, 1, '2026-05-26 04:46:20'),
(100, 100, '100.png', '/images/uploads/products/100.png', 'Ảnh sản phẩm NPK HỮU CƠ KHOÁNG 5-3-4', 1, 1, 1, '2026-05-26 04:46:20');

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
  MODIFY `PID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `pesticide_crops`
--
ALTER TABLE `pesticide_crops`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT cho bảng `pesticide_detail`
--
ALTER TABLE `pesticide_detail`
  MODIFY `PDetailID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `pesticide_pests`
--
ALTER TABLE `pesticide_pests`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT cho bảng `pesticide_usage`
--
ALTER TABLE `pesticide_usage`
  MODIFY `UsageID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `pests`
--
ALTER TABLE `pests`
  MODIFY `PestID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT cho bảng `product_embeddings`
--
ALTER TABLE `product_embeddings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_image`
--
ALTER TABLE `product_image`
  MODIFY `ImageID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

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
