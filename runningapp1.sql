-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2020 at 04:41 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `runningapp1`
--

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

DROP TABLE IF EXISTS `challenge`;
CREATE TABLE IF NOT EXISTS `challenge` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `end_date` timestamp NOT NULL COMMENT 'Till which date the task can be completed',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `challenge`
--

INSERT INTO `challenge` (`ID`, `end_date`) VALUES
(1, '2020-07-08 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `challenge_task`
--

DROP TABLE IF EXISTS `challenge_task`;
CREATE TABLE IF NOT EXISTS `challenge_task` (
  `challenge_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `coins` int(11) DEFAULT '0' COMMENT 'Coins earned on task completion',
  `experience` int(11) DEFAULT '0' COMMENT 'Experience earned on task completion',
  PRIMARY KEY (`challenge_id`,`task_id`),
  KEY `challenge_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `challenge_task`
--

INSERT INTO `challenge_task` (`challenge_id`, `task_id`, `coins`, `experience`) VALUES
(1, 5, 500, 300);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `ID` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of the event that is happening',
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'What type of event it is (user made, official)',
  `latitude` decimal(10,8) NOT NULL,
  `longtitude` decimal(11,8) NOT NULL,
  `start_time` timestamp NOT NULL COMMENT 'When does the event start',
  `end_time` timestamp NOT NULL COMMENT 'When does the event end',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Item name',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'Short description about the item',
  `image_name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'What image should be used to show it in the shop/inventory and on avatar',
  `price` int(11) DEFAULT '0',
  `type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Position of item is based on its type',
  `level` int(11) DEFAULT '0' COMMENT 'What level is needed to buy this item',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`ID`, `name`, `description`, `image_name`, `price`, `type`, `level`) VALUES
(5, 'Closed eyes', 'Just some closed eyes', 'eyes_02', 10, 'EYES', 0),
(6, 'Happy eyes', 'Yay!', 'eyes_03', 0, 'EYES', 0),
(7, 'Closed mouth', 'mmmmm', 'mouth_02', 0, 'MOUTH', 3),
(8, 'Meh mouth', 'Meh', 'mouth_03', 10, 'MOUTH', 3),
(9, 'Star pants', 'Look at the sky', 'pants_02', 0, 'PANTS', 0),
(10, 'Red shirt', 'Looks like santa!', 'shirt_02', 0, 'SHIRT', 0),
(11, 'Flower shirt', 'Lets go to hawaii', 'shirt_03', 0, 'SHIRT', 0);

-- --------------------------------------------------------

--
-- Table structure for table `run`
--

DROP TABLE IF EXISTS `run`;
CREATE TABLE IF NOT EXISTS `run` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(1) DEFAULT NULL COMMENT 'Rating from 1 to 5',
  `experience` int(11) NOT NULL DEFAULT '0' COMMENT 'How much experience earned',
  `coins` int(11) NOT NULL DEFAULT '0' COMMENT 'How many coins earned from run',
  PRIMARY KEY (`ID`),
  KEY `user_run` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `run`
--

INSERT INTO `run` (`ID`, `user_id`, `rating`, `experience`, `coins`) VALUES
(34, '1d876d20fc27515f09f9c1cea3352fe1', 4, 59, 59),
(35, '1d876d20fc27515f09f9c1cea3352fe1', 2, 39, 39);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
CREATE TABLE IF NOT EXISTS `setting` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of the tas that will appear for challenges or achievements',
  `type` enum('CHALLENGE','ACHIEVEMENT','USER_CHALLENGE') COLLATE utf8mb4_unicode_ci DEFAULT 'ACHIEVEMENT' COMMENT 'What type of task it is',
  `requirements` json NOT NULL COMMENT 'What is needed to complete the task',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`ID`, `name`, `type`, `requirements`) VALUES
(1, 'Ryn 10 km', 'ACHIEVEMENT', '{}'),
(3, 'Run 20km', 'ACHIEVEMENT', '{}'),
(4, 'Run 30km', 'ACHIEVEMENT', '{}'),
(5, 'Run 10 km', 'CHALLENGE', '{}');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Identifier when searching for users',
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Visible name other users can see',
  `number` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Can be null because of google users',
  `role` enum('USER','ADMIN') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER' COMMENT 'Admin can user the admin functions',
  `coins` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'How many coins the user has',
  `experience` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'How much experience the user has',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date the user registered',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When was the user modified (password changed, username changed)',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `identifier_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `username`, `number`, `email`, `password`, `role`, `coins`, `experience`, `created_at`, `updated_at`) VALUES
('1d876d20fc27515f09f9c1cea3352fe1', 'John Doe', 0, 'johndoe@email.com', '$2b$10$7Vy7e2WH3R9WU9TsxcBah.OeD.GAS.mtIggsxrZ1s/JP2qb20CYJK', 'ADMIN', 148, 134, '2020-06-09 12:11:22', '2020-06-17 18:24:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_bought_item`
--

DROP TABLE IF EXISTS `user_bought_item`;
CREATE TABLE IF NOT EXISTS `user_bought_item` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `bought_item_idx` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_bought_item`
--

INSERT INTO `user_bought_item` (`user_id`, `item_id`) VALUES
('1d876d20fc27515f09f9c1cea3352fe1', 5),
('1d876d20fc27515f09f9c1cea3352fe1', 6),
('1d876d20fc27515f09f9c1cea3352fe1', 7),
('1d876d20fc27515f09f9c1cea3352fe1', 8),
('1d876d20fc27515f09f9c1cea3352fe1', 9),
('1d876d20fc27515f09f9c1cea3352fe1', 10),
('1d876d20fc27515f09f9c1cea3352fe1', 11);

-- --------------------------------------------------------

--
-- Table structure for table `user_equipped_item`
--

DROP TABLE IF EXISTS `user_equipped_item`;
CREATE TABLE IF NOT EXISTS `user_equipped_item` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `equipped_item_idx` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_equipped_item`
--

INSERT INTO `user_equipped_item` (`user_id`, `item_id`) VALUES
('1d876d20fc27515f09f9c1cea3352fe1', 9),
('1d876d20fc27515f09f9c1cea3352fe1', 11);

-- --------------------------------------------------------

--
-- Table structure for table `user_finished_event`
--

DROP TABLE IF EXISTS `user_finished_event`;
CREATE TABLE IF NOT EXISTS `user_finished_event` (
  `event_id` int(11) NOT NULL,
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` int(11) DEFAULT NULL COMMENT 'What place the user got',
  `prize` json DEFAULT NULL COMMENT 'What prize did the user win',
  `coins` int(11) DEFAULT '0' COMMENT 'How many coins earned for winning',
  `experience` int(11) DEFAULT '0' COMMENT 'Experience earned for winning',
  PRIMARY KEY (`event_id`,`user_id`),
  KEY `user_finished_event` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_friend`
--

DROP TABLE IF EXISTS `user_friend`;
CREATE TABLE IF NOT EXISTS `user_friend` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `friend_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ACCEPTED','BLOCKED','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING' COMMENT 'What status is between the users',
  PRIMARY KEY (`user_id`,`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_joined_event`
--

DROP TABLE IF EXISTS `user_joined_event`;
CREATE TABLE IF NOT EXISTS `user_joined_event` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_id` int(11) NOT NULL,
  `date_joined` timestamp NULL DEFAULT NULL COMMENT 'When did the user join the event',
  PRIMARY KEY (`user_id`,`event_id`),
  KEY `joined_event_idx` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_run_data`
--

DROP TABLE IF EXISTS `user_run_data`;
CREATE TABLE IF NOT EXISTS `user_run_data` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `run_id` int(11) NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longtitude` decimal(11,8) DEFAULT NULL,
  `altitude` float(8,2) DEFAULT NULL,
  `speed` float(8,2) DEFAULT NULL COMMENT 'Speed in meters per second',
  `time` bigint(32) UNSIGNED DEFAULT NULL COMMENT 'Time in seconds since epoch',
  PRIMARY KEY (`ID`),
  KEY `user_run_data_idx` (`run_id`)
) ENGINE=InnoDB AUTO_INCREMENT=448 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_run_data`
--

INSERT INTO `user_run_data` (`ID`, `run_id`, `latitude`, `longtitude`, `altitude`, `speed`, `time`) VALUES
(179, 34, '56.95816160', '24.14010190', 51.50, 1.15, 1592417391099),
(180, 34, '56.95815820', '24.14009810', 51.20, 1.19, 1592417391000),
(181, 34, '56.95813450', '24.14006400', 49.80, 0.96, 1592417394379),
(182, 34, '56.95806050', '24.13997770', 46.90, 1.05, 1592417397079),
(183, 34, '56.95798230', '24.13985850', 44.10, 1.04, 1592417400268),
(184, 34, '56.95793730', '24.13979870', 42.70, 1.12, 1592417403019),
(185, 34, '56.95785040', '24.13972570', 42.20, 0.96, 1592417405679),
(186, 34, '56.95782760', '24.13969630', 41.80, 1.00, 1592417408459),
(187, 34, '56.95778610', '24.13962500', 41.80, 1.08, 1592417411000),
(188, 34, '56.95777000', '24.13958720', 41.90, 1.15, 1592417414368),
(189, 34, '56.95774210', '24.13950040', 42.40, 1.16, 1592417417139),
(190, 34, '56.95774410', '24.13944320', 43.00, 1.06, 1592417420000),
(191, 34, '56.95772910', '24.13939010', 43.20, 1.05, 1592417423359),
(192, 34, '56.95771590', '24.13931260', 43.20, 1.35, 1592417425939),
(193, 34, '56.95769520', '24.13926810', 43.40, 1.42, 1592417428000),
(194, 34, '56.95766570', '24.13923350', 44.50, 1.43, 1592417431000),
(195, 34, '56.95764300', '24.13919100', 44.50, 1.22, 1592417434288),
(196, 34, '56.95761630', '24.13915120', 45.10, 1.18, 1592417437439),
(197, 34, '56.95760990', '24.13911690', 45.20, 0.01, 1592417439979),
(198, 34, '56.95758760', '24.13907200', 45.50, 1.48, 1592417442488),
(199, 34, '56.95756890', '24.13903750', 45.60, 1.40, 1592417445000),
(200, 34, '56.95754580', '24.13901280', 46.10, 1.43, 1592417448000),
(201, 34, '56.95755230', '24.13893020', 46.20, 1.33, 1592417451179),
(202, 34, '56.95753170', '24.13889150', 45.70, 0.98, 1592417454000),
(203, 34, '56.95752980', '24.13886790', 45.70, 0.03, 1592417457000),
(204, 34, '56.95751370', '24.13880710', 45.80, 0.02, 1592417460431),
(205, 34, '56.95749700', '24.13879810', 45.40, 1.01, 1592417463508),
(206, 34, '56.95746810', '24.13875850', 44.80, 0.96, 1592417466479),
(207, 34, '56.95745080', '24.13872420', 44.20, 1.34, 1592417469279),
(208, 34, '56.95743300', '24.13867640', 43.70, 1.49, 1592417472458),
(209, 34, '56.95741240', '24.13863440', 43.50, 0.01, 1592417475159),
(210, 34, '56.95738780', '24.13858250', 43.30, 1.21, 1592417478471),
(211, 34, '56.95737000', '24.13852350', 43.30, 1.39, 1592417481139),
(212, 34, '56.95733760', '24.13848080', 43.40, 1.47, 1592417483789),
(213, 34, '56.95732280', '24.13839780', 43.50, 1.40, 1592417487039),
(214, 34, '56.95729640', '24.13836640', 42.20, 1.34, 1592417489719),
(215, 34, '56.95727620', '24.13835260', 41.60, 1.10, 1592417492359),
(216, 34, '56.95724500', '24.13831390', 41.60, 1.26, 1592417494999),
(217, 34, '56.95721470', '24.13829450', 41.10, 1.45, 1592417497618),
(218, 34, '56.95721200', '24.13823850', 40.70, 0.02, 1592417500319),
(219, 34, '56.95719070', '24.13820050', 39.90, 1.47, 1592417502939),
(220, 34, '56.95718310', '24.13816090', 40.10, 0.01, 1592417505000),
(221, 34, '56.95715010', '24.13811990', 39.70, 1.34, 1592417508000),
(222, 34, '56.95712320', '24.13808030', 40.00, 1.16, 1592417511339),
(223, 34, '56.95709310', '24.13804160', 40.50, 1.17, 1592417513919),
(224, 34, '56.95704900', '24.13798930', 41.20, 1.34, 1592417517070),
(225, 34, '56.95701220', '24.13791130', 42.10, 0.02, 1592417520250),
(226, 34, '56.95699120', '24.13787970', 42.30, 1.19, 1592417523268),
(227, 34, '56.95696640', '24.13783200', 43.10, 1.41, 1592417526004),
(228, 34, '56.95693760', '24.13771760', 43.00, 1.41, 1592417529494),
(229, 34, '56.95691780', '24.13767590', 43.00, 1.46, 1592417532199),
(230, 34, '56.95687840', '24.13761190', 43.10, 1.44, 1592417535000),
(231, 34, '56.95686100', '24.13756330', 42.80, 1.33, 1592417538339),
(232, 34, '56.95684380', '24.13753070', 42.40, 1.43, 1592417541039),
(233, 34, '56.95681900', '24.13748760', 42.40, 1.47, 1592417543639),
(234, 34, '56.95680600', '24.13739010', 42.10, 1.43, 1592417546000),
(235, 34, '56.95678430', '24.13732760', 42.10, 1.45, 1592417549000),
(236, 34, '56.95676490', '24.13730460', 42.40, 1.03, 1592417552119),
(237, 34, '56.95674190', '24.13726760', 42.30, 0.98, 1592417554770),
(238, 34, '56.95670830', '24.13722740', 41.80, 1.36, 1592417557308),
(239, 34, '56.95668470', '24.13719150', 40.70, 1.44, 1592417559889),
(240, 34, '56.95666670', '24.13714060', 40.10, 1.55, 1592417563088),
(241, 34, '56.95665840', '24.13710820', 39.50, 1.28, 1592417565759),
(242, 34, '56.95663730', '24.13706680', 39.10, 1.29, 1592417568459),
(243, 34, '56.95661190', '24.13702660', 39.20, 1.46, 1592417571478),
(244, 34, '56.95658170', '24.13698480', 39.80, 1.52, 1592417574318),
(245, 34, '56.95653970', '24.13693430', 40.20, 1.55, 1592417576959),
(246, 34, '56.95651250', '24.13688560', 40.20, 1.56, 1592417579000),
(247, 34, '56.95648600', '24.13682320', 40.10, 1.54, 1592417582139),
(248, 34, '56.95645460', '24.13675840', 40.20, 0.00, 1592417585375),
(249, 34, '56.95643300', '24.13671460', 40.40, 1.27, 1592417588012),
(250, 34, '56.95640370', '24.13667470', 40.40, 1.42, 1592417591039),
(251, 34, '56.95638100', '24.13662430', 40.70, 1.51, 1592417594059),
(252, 34, '56.95635760', '24.13658730', 41.20, 1.15, 1592417597409),
(253, 34, '56.95631790', '24.13653750', 40.90, 1.49, 1592417601230),
(254, 34, '56.95628210', '24.13647290', 41.00, 1.56, 1592417604359),
(255, 34, '56.95626260', '24.13642290', 40.70, 1.50, 1592417607139),
(256, 34, '56.95624090', '24.13638020', 40.80, 1.50, 1592417609760),
(257, 34, '56.95621980', '24.13631820', 40.80, 1.29, 1592417612000),
(258, 34, '56.95619920', '24.13628000', 40.40, 1.37, 1592417615139),
(259, 34, '56.95617580', '24.13620650', 39.80, 1.53, 1592417618259),
(260, 34, '56.95615240', '24.13613430', 39.80, 1.53, 1592417620979),
(261, 34, '56.95613040', '24.13607390', 40.70, 1.54, 1592417623000),
(262, 34, '56.95611110', '24.13601060', 41.10, 1.47, 1592417626078),
(263, 34, '56.95609020', '24.13594630', 41.10, 1.53, 1592417628579),
(264, 34, '56.95605790', '24.13590510', 41.40, 1.50, 1592417631179),
(265, 34, '56.95602400', '24.13586610', 41.50, 1.29, 1592417634000),
(266, 34, '56.95602270', '24.13587850', 41.30, 0.79, 1592417637178),
(267, 34, '56.95599600', '24.13591500', 41.60, 1.00, 1592417640119),
(268, 34, '56.95597020', '24.13598610', 42.10, 1.09, 1592417643299),
(269, 34, '56.95595910', '24.13604770', 42.10, 1.27, 1592417645838),
(270, 34, '56.95595160', '24.13608550', 43.00, 1.33, 1592417648338),
(271, 34, '56.95594410', '24.13611240', 43.10, 1.35, 1592417651359),
(272, 34, '56.95591180', '24.13616300', 42.00, 1.45, 1592417654321),
(273, 34, '56.95582980', '24.13620940', 42.60, 1.33, 1592417656989),
(274, 34, '56.95579680', '24.13624230', 42.70, 1.49, 1592417659878),
(275, 34, '56.95572500', '24.13632200', 42.60, 1.61, 1592417663099),
(276, 34, '56.95565240', '24.13638980', 43.20, 0.04, 1592417666199),
(277, 34, '56.95561330', '24.13642490', 44.10, 1.45, 1592417669168),
(278, 34, '56.95556560', '24.13649740', 44.80, 1.38, 1592417671738),
(279, 34, '56.95553930', '24.13652320', 44.90, 1.44, 1592417674420),
(280, 34, '56.95549510', '24.13657050', 45.00, 1.56, 1592417677000),
(281, 34, '56.95546270', '24.13659720', 45.30, 1.58, 1592417680119),
(282, 34, '56.95545440', '24.13669400', 45.40, 1.27, 1592417682889),
(283, 34, '56.95543080', '24.13672630', 46.50, 1.20, 1592417685000),
(284, 34, '56.95542000', '24.13680400', 47.00, 1.41, 1592417687989),
(285, 34, '56.95540180', '24.13688460', 48.60, 0.03, 1592417690619),
(286, 34, '56.95537710', '24.13691860', 51.10, 1.01, 1592417693318),
(287, 34, '56.95533950', '24.13697640', 53.30, 0.97, 1592417696000),
(288, 34, '56.95531930', '24.13700830', 53.60, 1.05, 1592417698975),
(289, 34, '56.95530320', '24.13706070', 54.10, 0.80, 1592417701799),
(290, 34, '56.95528050', '24.13709580', 54.50, 0.92, 1592417704000),
(291, 34, '56.95525820', '24.13715690', 54.90, 1.05, 1592417707119),
(292, 34, '56.95524780', '24.13722490', 53.70, 0.01, 1592417709819),
(293, 34, '56.95522240', '24.13727420', 52.90, 0.98, 1592417712878),
(294, 34, '56.95519330', '24.13731520', 52.00, 1.13, 1592417715000),
(295, 34, '56.95515130', '24.13736150', 52.00, 1.15, 1592417718198),
(296, 34, '56.95509490', '24.13738780', 52.30, 1.30, 1592417721239),
(297, 34, '56.95505430', '24.13743010', 52.20, 1.45, 1592417724399),
(298, 34, '56.95503100', '24.13750850', 51.50, 1.30, 1592417727039),
(299, 34, '56.95499610', '24.13754850', 51.00, 1.43, 1592417730159),
(300, 34, '56.95497320', '24.13764330', 50.20, 1.57, 1592417733098),
(301, 34, '56.95496780', '24.13771880', 50.20, 0.04, 1592417736299),
(302, 34, '56.95494620', '24.13775670', 50.90, 1.10, 1592417738859),
(303, 34, '56.95493120', '24.13780780', 51.30, 1.33, 1592417741399),
(304, 34, '56.95491610', '24.13786050', 52.00, 1.39, 1592417743969),
(305, 34, '56.95489300', '24.13792100', 53.30, 0.02, 1592417746000),
(306, 34, '56.95487220', '24.13796530', 53.80, 1.45, 1592417749199),
(307, 34, '56.95485070', '24.13802530', 54.50, 1.27, 1592417752189),
(308, 34, '56.95482070', '24.13807400', 54.50, 1.30, 1592417754843),
(309, 34, '56.95479010', '24.13817520', 55.20, 1.35, 1592417758099),
(310, 34, '56.95477990', '24.13821980', 55.00, 0.02, 1592417761199),
(311, 34, '56.95475770', '24.13826610', 54.00, 1.18, 1592417763819),
(312, 34, '56.95473060', '24.13835370', 53.70, 1.23, 1592417766000),
(313, 34, '56.95472810', '24.13841380', 52.70, 1.28, 1592417769119),
(314, 34, '56.95473780', '24.13850210', 50.60, 1.42, 1592417771645),
(315, 34, '56.95475040', '24.13855910', 46.00, 1.48, 1592417774000),
(316, 35, '56.95480110', '24.13890560', 0.00, 0.00, 1592417810273),
(317, 35, '56.95480110', '24.13890560', 0.00, 0.00, 1592417810273),
(318, 35, '56.95486140', '24.13914570', 40.30, 0.07, 1592417813113),
(319, 35, '56.95490190', '24.13920660', 36.30, 0.72, 1592417816409),
(320, 35, '56.95486860', '24.13908250', 44.80, 0.96, 1592417819149),
(321, 35, '56.95488380', '24.13904500', 46.30, 0.01, 1592417821789),
(322, 35, '56.95490390', '24.13905480', 46.70, 1.36, 1592417824000),
(323, 35, '56.95491570', '24.13909040', 46.30, 0.00, 1592417827207),
(324, 35, '56.95493920', '24.13912240', 45.30, 1.23, 1592417829789),
(325, 35, '56.95496030', '24.13914930', 44.00, 0.01, 1592417832000),
(326, 35, '56.95498620', '24.13920540', 43.10, 1.25, 1592417835148),
(327, 35, '56.95501670', '24.13936770', 41.80, 1.15, 1592417837769),
(328, 35, '56.95503380', '24.13942360', 41.30, 1.25, 1592417840369),
(329, 35, '56.95505180', '24.13954620', 41.20, 1.18, 1592417842988),
(330, 35, '56.95506880', '24.13962570', 41.50, 1.19, 1592417845989),
(331, 35, '56.95510830', '24.13972030', 41.20, 1.16, 1592417849229),
(332, 35, '56.95517230', '24.13980960', 40.60, 0.01, 1592417851809),
(333, 35, '56.95520680', '24.13982830', 41.10, 1.09, 1592417854000),
(334, 35, '56.95527170', '24.13982970', 41.50, 0.02, 1592417857289),
(335, 35, '56.95532240', '24.13986390', 41.00, 1.37, 1592417860388),
(336, 35, '56.95538190', '24.13989270', 40.30, 1.25, 1592417863392),
(337, 35, '56.95541900', '24.13992220', 40.40, 1.35, 1592417866109),
(338, 35, '56.95545580', '24.13996180', 40.50, 1.29, 1592417868749),
(339, 35, '56.95548090', '24.14001060', 40.70, 1.31, 1592417871369),
(340, 35, '56.95551210', '24.14006140', 40.10, 1.32, 1592417874000),
(341, 35, '56.95552970', '24.14013410', 39.60, 0.06, 1592417877128),
(342, 35, '56.95556150', '24.14016720', 38.60, 1.55, 1592417879689),
(343, 35, '56.95558750', '24.14021390', 38.30, 1.40, 1592417882409),
(344, 35, '56.95561340', '24.14025460', 37.70, 1.43, 1592417884909),
(345, 35, '56.95563080', '24.14029750', 36.20, 0.03, 1592417887000),
(346, 35, '56.95565820', '24.14031300', 35.20, 1.14, 1592417890209),
(347, 35, '56.95570030', '24.14030010', 34.50, 1.22, 1592417892952),
(348, 35, '56.95572590', '24.14025150', 34.70, 1.32, 1592417895000),
(349, 35, '56.95574860', '24.14019230', 34.20, 1.28, 1592417898129),
(350, 35, '56.95576530', '24.14013850', 33.10, 1.24, 1592417900770),
(351, 35, '56.95578890', '24.14008230', 32.20, 1.18, 1592417903000),
(352, 35, '56.95581100', '24.14003330', 31.60, 1.12, 1592417906329),
(353, 35, '56.95583270', '24.13997400', 31.70, 1.10, 1592417908949),
(354, 35, '56.95585510', '24.13991550', 32.40, 1.18, 1592417911628),
(355, 35, '56.95587760', '24.13986310', 32.70, 1.15, 1592417914429),
(356, 35, '56.95589980', '24.13981890', 32.20, 1.18, 1592417917087),
(357, 35, '56.95592490', '24.13976700', 32.20, 1.24, 1592417919810),
(358, 35, '56.95595500', '24.13971470', 32.50, 0.98, 1592417922387),
(359, 35, '56.95598260', '24.13967100', 33.10, 1.31, 1592417925129),
(360, 35, '56.95601590', '24.13965920', 33.00, 1.15, 1592417927789),
(361, 35, '56.95603960', '24.13962880', 32.80, 1.24, 1592417930409),
(362, 35, '56.95606260', '24.13956960', 32.80, 1.18, 1592417933088),
(363, 35, '56.95607840', '24.13954780', 33.00, 1.21, 1592417935773),
(364, 35, '56.95608960', '24.13951000', 33.00, 1.21, 1592417938000),
(365, 35, '56.95611160', '24.13947410', 33.00, 1.24, 1592417941169),
(366, 35, '56.95613500', '24.13940590', 33.60, 1.33, 1592417943787),
(367, 35, '56.95615740', '24.13937980', 34.30, 1.29, 1592417946329),
(368, 35, '56.95620030', '24.13937900', 35.40, 1.24, 1592417949169),
(369, 35, '56.95622730', '24.13944070', 36.80, 1.19, 1592417951709),
(370, 35, '56.95625530', '24.13949420', 37.30, 1.21, 1592417954000),
(371, 35, '56.95629070', '24.13956320', 37.10, 0.03, 1592417957169),
(372, 35, '56.95631290', '24.13961040', 36.20, 1.16, 1592417959849),
(373, 35, '56.95634020', '24.13966220', 36.50, 1.16, 1592417962000),
(374, 35, '56.95638640', '24.13969520', 36.40, 1.20, 1592417965369),
(375, 35, '56.95640420', '24.13974920', 36.50, 1.13, 1592417967969),
(376, 35, '56.95642160', '24.13980200', 37.00, 1.17, 1592417970628),
(377, 35, '56.95645160', '24.13985180', 36.90, 1.15, 1592417973369),
(378, 35, '56.95646660', '24.13989960', 37.30, 1.14, 1592417976048),
(379, 35, '56.95647700', '24.13996890', 37.30, 1.07, 1592417978889),
(380, 35, '56.95649840', '24.14001120', 36.40, 1.09, 1592417981000),
(381, 35, '56.95652190', '24.14005200', 36.10, 0.76, 1592417984000),
(382, 35, '56.95650740', '24.14009660', 35.80, 0.01, 1592417987449),
(383, 35, '56.95647110', '24.14010550', 35.70, 1.12, 1592417990169),
(384, 35, '56.95642590', '24.14008050', 35.90, 1.24, 1592417992907),
(385, 35, '56.95638450', '24.14004270', 36.00, 1.41, 1592417996329),
(386, 35, '56.95635090', '24.13997990', 35.70, 1.19, 1592417999168),
(387, 35, '56.95631790', '24.14000360', 35.90, 1.20, 1592418002091),
(388, 35, '56.95628660', '24.14004030', 36.30, 1.07, 1592418004949),
(389, 35, '56.95626140', '24.14008350', 35.80, 0.02, 1592418007000),
(390, 35, '56.95623880', '24.14007970', 35.50, 0.88, 1592418010170),
(391, 35, '56.95620420', '24.14010640', 35.00, 0.66, 1592418013209),
(392, 35, '56.95617790', '24.14009750', 35.00, 0.54, 1592418015988),
(393, 35, '56.95618820', '24.14013570', 35.10, 0.68, 1592418019129),
(394, 35, '56.95621200', '24.14013820', 35.10, 0.38, 1592418021769),
(395, 35, '56.95625120', '24.14011490', 34.40, 0.19, 1592418024000),
(396, 35, '56.95623400', '24.14009090', 33.90, 0.90, 1592418027789),
(397, 35, '56.95620780', '24.14008680', 33.20, 0.98, 1592418030000),
(398, 35, '56.95620580', '24.14009910', 32.90, 0.49, 1592418033087),
(399, 35, '56.95622620', '24.14010750', 32.70, 0.20, 1592418035969),
(400, 35, '56.95620370', '24.14011380', 32.40, 0.87, 1592418038000),
(401, 35, '56.95618920', '24.14012170', 32.10, 0.06, 1592418041348),
(402, 35, '56.95620230', '24.14013340', 31.80, 0.04, 1592418044000),
(403, 35, '56.95622100', '24.14014650', 31.60, 0.04, 1592418047108),
(404, 35, '56.95621330', '24.14017000', 30.80, 0.36, 1592418050000),
(405, 35, '56.95620360', '24.14017320', 30.80, 0.53, 1592418053000),
(406, 35, '56.95619730', '24.14017110', 30.80, 0.53, 1592418056000),
(407, 35, '56.95619300', '24.14016950', 30.80, 0.53, 1592418059000),
(408, 35, '56.95619260', '24.14016770', 30.80, 0.53, 1592418062229),
(409, 35, '56.95618940', '24.14015230', 33.80, 1.07, 1592418065169),
(410, 35, '56.95617360', '24.14009730', 35.10, 0.53, 1592418068269),
(411, 35, '56.95615980', '24.14014750', 35.60, 0.96, 1592418070849),
(412, 35, '56.95617270', '24.14019720', 36.70, 0.65, 1592418073503),
(413, 35, '56.95618750', '24.14018710', 37.10, 0.65, 1592418076048),
(414, 35, '56.95619680', '24.14017770', 36.30, 0.58, 1592418079000),
(415, 35, '56.95618330', '24.14018360', 36.30, 0.00, 1592418082000),
(416, 35, '56.95618500', '24.14018410', 36.30, 0.05, 1592418085000),
(417, 35, '56.95617810', '24.14018540', 36.30, 0.20, 1592418088000),
(418, 35, '56.95616950', '24.14018980', 36.30, 0.27, 1592418091000),
(419, 35, '56.95619560', '24.14016670', 36.30, 0.00, 1592418094000),
(420, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418097000),
(421, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418100000),
(422, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418103000),
(423, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418106000),
(424, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418109000),
(425, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418112000),
(426, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418115000),
(427, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418118000),
(428, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418121000),
(429, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418124000),
(430, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418127000),
(431, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418130000),
(432, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418133000),
(433, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418136000),
(434, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418139000),
(435, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418142000),
(436, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418145000),
(437, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418148000),
(438, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418151000),
(439, 35, '56.95619640', '24.14016540', 36.30, 0.14, 1592418154000),
(440, 35, '56.95619640', '24.14016450', 36.30, 0.05, 1592418157000),
(441, 35, '56.95619640', '24.14016510', 36.30, 0.02, 1592418160000),
(442, 35, '56.95619640', '24.14016600', 36.30, 0.01, 1592418163000),
(443, 35, '56.95619640', '24.14016590', 36.30, 0.00, 1592418166000),
(444, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418169000),
(445, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418172000),
(446, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418175000),
(447, 35, '56.95619640', '24.14016600', 36.30, 0.00, 1592418178000);

-- --------------------------------------------------------

--
-- Table structure for table `user_shared_run`
--

DROP TABLE IF EXISTS `user_shared_run`;
CREATE TABLE IF NOT EXISTS `user_shared_run` (
  `run_id` int(11) NOT NULL,
  `shared_link` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_shared` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`run_id`,`shared_link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_task`
--

DROP TABLE IF EXISTS `user_task`;
CREATE TABLE IF NOT EXISTS `user_task` (
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_id` int(11) NOT NULL,
  `progress` int(3) NOT NULL COMMENT 'percentage of progress 100 means completed',
  PRIMARY KEY (`user_id`,`task_id`),
  KEY `task_name` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_task`
--

INSERT INTO `user_task` (`user_id`, `task_id`, `progress`) VALUES
('1d876d20fc27515f09f9c1cea3352fe1', 1, 50);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenge_task`
--
ALTER TABLE `challenge_task`
  ADD CONSTRAINT `challenge_name` FOREIGN KEY (`challenge_id`) REFERENCES `challenge` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `challenge_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `run`
--
ALTER TABLE `run`
  ADD CONSTRAINT `user_run` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `setting`
--
ALTER TABLE `setting`
  ADD CONSTRAINT `user_setting` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_bought_item`
--
ALTER TABLE `user_bought_item`
  ADD CONSTRAINT `bought_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_bought_item` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_equipped_item`
--
ALTER TABLE `user_equipped_item`
  ADD CONSTRAINT `equipped_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_equipped_items` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_finished_event`
--
ALTER TABLE `user_finished_event`
  ADD CONSTRAINT `finished_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_finished_event` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_friend`
--
ALTER TABLE `user_friend`
  ADD CONSTRAINT `user_friend` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_joined_event`
--
ALTER TABLE `user_joined_event`
  ADD CONSTRAINT `joined_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_joined_event` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_run_data`
--
ALTER TABLE `user_run_data`
  ADD CONSTRAINT `user_run_data` FOREIGN KEY (`run_id`) REFERENCES `run` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_shared_run`
--
ALTER TABLE `user_shared_run`
  ADD CONSTRAINT `shared_run` FOREIGN KEY (`run_id`) REFERENCES `run` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_task`
--
ALTER TABLE `user_task`
  ADD CONSTRAINT `task_name` FOREIGN KEY (`task_id`) REFERENCES `task` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_task` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;