-- phpMyAdmin SQL Dump
-- version 4.8.0-dev
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 16, 2019 at 03:37 AM
-- Server version: 5.7.21-log
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ezyvet_octavionancul`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `street1` varchar(100) DEFAULT NULL,
  `street2` varchar(100) DEFAULT NULL,
  `suburb` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `post_code` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `contact_id`, `street1`, `street2`, `suburb`, `city`, `post_code`) VALUES
(1, 1, '23 Wilson St', '', 'Newton', 'Auckland', '1010'),
(2, 2, '111 Bakers Ave', '', 'Grey Lynn', 'Auckland', '1012'),
(3, 3, '49 Hadsfield Cres', '', 'Mt Albert', 'Auckland', '1025'),
(4, 4, '15a Andrews lane', '', 'Grey Lynn', 'Auckland', '1012'),
(5, 5, '73 Phillips Road', '', 'mt albert', 'auckland', '1025'),
(6, 6, '31 Futures Cres', '', 'Newton', 'Auckland', '1010'),
(7, 7, '5 Queens Road', '', 'Grey Lynn', 'Auckland', '1012'),
(8, 8, '54 King Street', '', 'Mt Albert', 'Auckland', '1025'),
(9, 9, 'Unit 9', '87 Georges Road', 'Grey Lynn', 'auckland', '1012'),
(10, 10, '74 House Place', '', 'mt albert', 'Auckland', '1025'),
(11, 11, '74 House Place', '', 'Newton', 'Auckland', '1010'),
(12, 12, '5', 'Living Road', 'Grey Lynn', 'Auckland', '1012'),
(13, 13, '65 Flemming Way', '', 'Mt Albert', 'auckland', '1025'),
(14, 14, '47 Road Road', '', 'Grey Lynn', 'Auckland', '1012'),
(15, 15, '', '10a fortitude way', 'mt albert', 'Auckland', '1025');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `title` enum('Mr','Mrs','Miss','Ms','Dr') DEFAULT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `company_name` varchar(64) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `title`, `first_name`, `last_name`, `company_name`, `date_of_birth`, `notes`) VALUES
(1, 'Mr', 'John', 'Smith', 'ABC Imports', '1969-01-13 00:00:00', '\"A little bit deaf'),
(2, 'Mr', 'Carl', 'Jones', '', '1988-07-09 00:00:00', '\r'),
(3, 'Dr', 'Jenna', 'Bates', 'MT ALBERT PHARMACY', '1972-11-02 00:00:00', '\r'),
(4, 'Ms', 'Lucy', 'Farange', '', '1983-03-08 00:00:00', '; DROP TABLE `contact`;\r'),
(5, 'Mr', '', '', 'A.N.Z.A.C Associates', '1900-01-01 00:00:00', '\r'),
(6, 'Mr', 'Justin', 'Smith-wesson', '', '1995-02-02 00:00:00', '\r'),
(7, 'Mrs', 'Sarah', 'O\'malley', '', '1951-03-21 00:00:00', '\r'),
(8, 'Mr', 'Michael', 'Manly', 'P.P.P pet product providers', '1970-10-01 00:00:00', 'Hi vet clinic you are my favourite clinic ðŸ˜Š kind regards michael manly (PPP)\r'),
(9, 'Mr', 'Jason', '', '', '1993-05-24 00:00:00', '\r'),
(10, 'Mr', 'Albert', 'Grant', '', '1986-06-27 00:00:00', '\r'),
(11, 'Mr', 'Anna', 'Grant', '', '1978-10-26 00:00:00', '\r'),
(12, 'Mr', 'Alfred', '', '', '1973-12-20 00:00:00', '\r'),
(13, 'Mr', '', '', 'Guide Dog Services', '1900-01-01 00:00:00', '\r'),
(14, 'Mr', 'Lisa', '', '', '2001-08-14 00:00:00', '\r'),
(15, 'Mr', 'Alan', 'Fields', '', '1960-09-20 00:00:00', '\"\"\"CONTACT OWES A LOT OF MONEY! ON A CREDIT STOP (don\'t let them book any new appointments before paying off account)\"\"\"');

-- --------------------------------------------------------

--
-- Table structure for table `phone`
--

CREATE TABLE `phone` (
  `id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `content` varchar(64) DEFAULT NULL,
  `type` enum('Home','Work','Mobile','Other') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phone`
--

INSERT INTO `phone` (`id`, `contact_id`, `name`, `content`, `type`) VALUES
(1, 1, '', '09 559-4886', 'Home'),
(2, 1, '', '64292267751', 'Mobile'),
(3, 2, '', '09582-4491', 'Home'),
(4, 2, '', '09 382-8858', 'Work'),
(5, 3, '', '09482-6975', 'Home'),
(6, 3, '', '64256648795', 'Mobile'),
(7, 4, '', '6425325474', 'Work'),
(8, 4, '', '6425325474', 'Mobile'),
(9, 5, '', '09555 9462', 'Home'),
(10, 6, '', '642751353288', 'Mobile'),
(11, 7, '', '64245756955', 'Home'),
(12, 7, '', '64245756955', 'Mobile'),
(13, 9, '', '095132545', 'Home'),
(14, 10, '', '0902745621568', 'Work'),
(15, 13, '', '09-254-1158', 'Work'),
(16, 13, '', '642545678', 'Other');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `phone`
--
ALTER TABLE `phone`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `phone`
--
ALTER TABLE `phone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
