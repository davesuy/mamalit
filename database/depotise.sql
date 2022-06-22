-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3308
-- Generation Time: Jan 09, 2020 at 09:00 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `depotise`
--

-- --------------------------------------------------------

--
-- Table structure for table `assetindexdata`
--

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) UNSIGNED DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) UNSIGNED DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `size` bigint(20) UNSIGNED DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `assettransformindex`
--

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `assettransforms`
--

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) UNSIGNED DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categorygroups`
--

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categorygroups_sites`
--

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_addresses`
--

CREATE TABLE `commerce_addresses` (
  `id` int(11) NOT NULL,
  `countryId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `isStoreLocation` tinyint(1) NOT NULL DEFAULT '0',
  `attention` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `alternativePhone` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `notes` text,
  `businessName` varchar(255) DEFAULT NULL,
  `businessTaxId` varchar(255) DEFAULT NULL,
  `businessId` varchar(255) DEFAULT NULL,
  `stateName` varchar(255) DEFAULT NULL,
  `custom1` varchar(255) DEFAULT NULL,
  `custom2` varchar(255) DEFAULT NULL,
  `custom3` varchar(255) DEFAULT NULL,
  `custom4` varchar(255) DEFAULT NULL,
  `isEstimated` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_countries`
--

CREATE TABLE `commerce_countries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `iso` varchar(2) NOT NULL,
  `isStateRequired` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_countries`
--

INSERT INTO `commerce_countries` (`id`, `name`, `iso`, `isStateRequired`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'Andorra', 'AD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ec1a0f1e-85cc-4257-9d73-013b04c0b1cf'),
(2, 'United Arab Emirates', 'AE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '950912c7-0a5a-47f6-a01a-81c86cfb6dfa'),
(3, 'Afghanistan', 'AF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0baabc0a-5c0f-4aaa-bb7e-a37a4293b56a'),
(4, 'Antigua and Barbuda', 'AG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '15a9bbf7-63f9-4859-9338-74721ac7b45b'),
(5, 'Anguilla', 'AI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'bb189c2a-6419-46a9-a446-4e6e26603891'),
(6, 'Albania', 'AL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6d7f3685-b11f-415f-bdad-f96cee6929ce'),
(7, 'Armenia', 'AM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '789526b7-9ce9-4428-be3f-56bfecf892de'),
(8, 'Angola', 'AO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2432cb39-7e84-4599-b38e-f73be54d17a9'),
(9, 'Antarctica', 'AQ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6c3f22a1-9827-4bc4-a326-0d31468c3388'),
(10, 'Argentina', 'AR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '93f3ba19-bbcd-41e5-8121-ad62098d794b'),
(11, 'American Samoa', 'AS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '86b10bbf-5ba9-4307-93e2-6398ad6ad9b8'),
(12, 'Austria', 'AT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b4d026fb-f51e-465c-987c-1a2eeecf4d5a'),
(13, 'Australia', 'AU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b2a9cce4-b0a5-4532-be4d-c6b3718da155'),
(14, 'Aruba', 'AW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '86dd9d3d-de32-4bbc-bfac-b9230f56686e'),
(15, 'Aland Islands', 'AX', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '595e9a7a-8e8e-43be-92b5-61ddbb04c16c'),
(16, 'Azerbaijan', 'AZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1c44dbbe-8fd5-4c1c-a089-36a05ba114c6'),
(17, 'Bosnia and Herzegovina', 'BA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a6927981-dece-48a6-937e-ed567c87215c'),
(18, 'Barbados', 'BB', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1e2e5251-0749-43c5-96f0-0390cb529342'),
(19, 'Bangladesh', 'BD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '158fa3aa-5e23-45ca-936b-3eeb866043d9'),
(20, 'Belgium', 'BE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '128bf9f0-fbcf-4b00-bf0c-509e83ad4d60'),
(21, 'Burkina Faso', 'BF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1bd1375d-a572-42fa-aecf-b3d5a9826722'),
(22, 'Bulgaria', 'BG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8acff27a-f2b0-426f-89cb-b399964a5cca'),
(23, 'Bahrain', 'BH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c85e954d-73f7-4bed-b8f0-884706fb45b8'),
(24, 'Burundi', 'BI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '45112602-5ac2-4280-b1c4-4c4b5b018d1c'),
(25, 'Benin', 'BJ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c6ef0b63-58f5-4e80-8ae0-19b83012b743'),
(26, 'Saint Barthelemy', 'BL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ae66a741-f2e9-4979-a369-5db9177cac8f'),
(27, 'Bermuda', 'BM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6cf93121-fe82-431c-a12d-a1a462b8ae09'),
(28, 'Brunei Darussalam', 'BN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c4ac7a67-0263-43de-b459-17e93badb6e9'),
(29, 'Bolivia', 'BO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7cc9e44c-0acd-48d9-8dd7-a68ae6db2979'),
(30, 'Bonaire, Sint Eustatius and Saba', 'BQ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '30c20786-30f2-4610-a1f7-80d9c966f69c'),
(31, 'Brazil', 'BR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f587acee-b8f3-47a0-9708-3bf8da51906e'),
(32, 'Bahamas', 'BS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2a16a5a9-88c7-4188-bcc3-14dec06cb97f'),
(33, 'Bhutan', 'BT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '987f79ea-06ed-4800-b86b-b36051e4ab07'),
(34, 'Bouvet Island', 'BV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7ac4f56f-343a-46aa-b2c5-46933071452d'),
(35, 'Botswana', 'BW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ea59e557-65cb-4cd5-bfd1-85a149a8fe84'),
(36, 'Belarus', 'BY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '933e2436-a217-4d3e-bbd3-16b1b8479d66'),
(37, 'Belize', 'BZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ab8317ed-cd7a-4907-a195-05d0e4ef6fc8'),
(38, 'Canada', 'CA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4ee4c706-0ea0-417b-8d61-3cdd959c6014'),
(39, 'Cocos (Keeling) Islands', 'CC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f9f16844-2c2b-438b-b5ad-e037f2125797'),
(40, 'Democratic Republic of Congo', 'CD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '56ccc486-47c0-4883-b3c1-0fa6282743f4'),
(41, 'Central African Republic', 'CF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8536d8e4-7428-4f1a-a667-fdac2223bf3b'),
(42, 'Congo', 'CG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4d6eaae1-67e9-4f35-96c1-7d5047fba885'),
(43, 'Switzerland', 'CH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0dd07017-9995-474c-aae8-b952cbf59c9c'),
(44, 'Ivory Coast', 'CI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '32a0d18b-ba93-45fa-abd6-d2117319952d'),
(45, 'Cook Islands', 'CK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ac4c6b51-fe91-4040-9ea6-ed50b66fc481'),
(46, 'Chile', 'CL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c3de5bfd-9e03-4805-b82c-943997337815'),
(47, 'Cameroon', 'CM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '36d5280c-4a65-488f-a5f9-1b680c6e9a37'),
(48, 'China', 'CN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '74d03d67-025c-46e9-833d-1795d94a52ca'),
(49, 'Colombia', 'CO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9347d983-587d-4964-bd19-d3db286cce92'),
(50, 'Costa Rica', 'CR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '417b7dfe-3976-4349-9b70-77863282b851'),
(51, 'Cuba', 'CU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '772f9891-6dbe-40ff-8555-ec202ff8edd0'),
(52, 'Cape Verde', 'CV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ec14f85a-940c-4215-b4f8-3f63b93f1f7f'),
(53, 'Curacao', 'CW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7d808f18-11a2-47db-b566-2e14dd547898'),
(54, 'Christmas Island', 'CX', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ef8450d6-f719-4999-af84-b918a04658ed'),
(55, 'Cyprus', 'CY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '118c3803-da4f-4ed8-ad00-55b37df87a45'),
(56, 'Czech Republic', 'CZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '79629df0-7407-4386-9de3-18120cd72236'),
(57, 'Germany', 'DE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd5353114-8df8-4f12-bd04-c18564f57cf7'),
(58, 'Djibouti', 'DJ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ce1b8fa0-a1fd-4f81-a71d-7aa56f5f6fc4'),
(59, 'Denmark', 'DK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7e69c6e2-7da0-4e77-b9be-9f641fe67707'),
(60, 'Dominica', 'DM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f294d47c-2287-4efb-b06a-e5cc3d8c2134'),
(61, 'Dominican Republic', 'DO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '96d05e02-8aa6-4f93-a31e-8b437b886a01'),
(62, 'Algeria', 'DZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0e47732b-31b1-4c44-8be9-363ead889888'),
(63, 'Ecuador', 'EC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1f3a0168-832e-4734-a0df-b1875631bcf5'),
(64, 'Estonia', 'EE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '13a0de35-4397-4be7-a7df-de8eb18eaff5'),
(65, 'Egypt', 'EG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '06fa3a90-a18f-46ed-b962-53daa4d5d912'),
(66, 'Western Sahara', 'EH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '584aff40-4988-49ca-b680-9837578fc0fc'),
(67, 'Eritrea', 'ER', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '761cfe28-1f0b-4abf-9244-bfae44625750'),
(68, 'Spain', 'ES', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ea1c4902-30eb-4ebd-9637-b9e6c9760860'),
(69, 'Ethiopia', 'ET', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'bac4864b-49e4-4b58-9c8c-d9b9487417aa'),
(70, 'Finland', 'FI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e4593347-3c7c-4666-861a-263885b8dbd5'),
(71, 'Fiji', 'FJ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7df9da42-c1d6-4815-ab10-10e58d68dffe'),
(72, 'Falkland Islands (Malvinas)', 'FK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e3bbf4b1-0f31-482c-b64d-d2a30a4fd550'),
(73, 'Micronesia', 'FM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a1619f5b-be59-406c-b557-a4346c0b2c3e'),
(74, 'Faroe Islands', 'FO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8b6cccc5-acea-438f-8fe4-5583612621dc'),
(75, 'France', 'FR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd847ffa6-ec02-4329-9796-54e6645b239e'),
(76, 'Gabon', 'GA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0e4fd00b-c023-4b43-a291-4f846fe291aa'),
(77, 'United Kingdom', 'GB', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '333612e3-c68c-49a9-a056-a69db4cfa5e0'),
(78, 'Grenada', 'GD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ac0d6a11-70fb-41d7-91e8-8b8342f67af3'),
(79, 'Georgia', 'GE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6be9c34b-9fe0-47b6-b41c-d9c346755a6b'),
(80, 'French Guiana', 'GF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6dacfde1-aa4c-40b9-91ac-adf597b22f8e'),
(81, 'Guernsey', 'GG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'bdf2a686-84d0-4700-8b2a-f8acbcfaadd9'),
(82, 'Ghana', 'GH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f1e2d5f2-dd6a-42e0-b9bc-b1f3dfee2374'),
(83, 'Gibraltar', 'GI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3b3362bf-496f-47ff-8afb-2fa7b3582172'),
(84, 'Greenland', 'GL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f862bc97-72d6-48a1-968a-97398152a48f'),
(85, 'Gambia', 'GM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '24d85d46-a97c-4751-a530-4c9695dbdd18'),
(86, 'Guinea', 'GN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9f9976fc-403b-4fd2-ba58-636e3b928663'),
(87, 'Guadeloupe', 'GP', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b702420d-5607-4926-b0af-d6a9157dc79a'),
(88, 'Equatorial Guinea', 'GQ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'db3c0cd1-27b7-4737-a3a6-6d0150b146e8'),
(89, 'Greece', 'GR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3a448f8d-f1c5-4aca-b823-518bfce9ecff'),
(90, 'S. Georgia and S. Sandwich Isls.', 'GS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1a28a4c7-f6f9-4a52-8022-a31e3d12e6d4'),
(91, 'Guatemala', 'GT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd70a6ac6-c9d7-496a-ade0-00b181967f98'),
(92, 'Guam', 'GU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1044ec45-6689-4240-9149-025f2453dadb'),
(93, 'Guinea-Bissau', 'GW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ae24a194-dd3e-4067-881c-b32e9ee0be51'),
(94, 'Guyana', 'GY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a437f397-b8f0-4031-9c04-a25a587c1ad1'),
(95, 'Hong Kong', 'HK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd997be87-41a5-418d-8f75-ce65c02676ed'),
(96, 'Heard and McDonald Islands', 'HM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7ba4e5d2-c8a4-4022-b759-a897e100892e'),
(97, 'Honduras', 'HN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7dcb2e37-a097-47ef-85a9-f91b944d4418'),
(98, 'Croatia (Hrvatska)', 'HR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8bae5b8f-8ee0-40b5-8a16-a842a69838d1'),
(99, 'Haiti', 'HT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8bf7cddc-15f2-4f02-bea4-fbe7862e4d40'),
(100, 'Hungary', 'HU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '52770e5e-9dad-4a7d-92d5-f9d1eef7eae8'),
(101, 'Indonesia', 'ID', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0fd91373-ba1f-40bf-9468-0cc07a6742c3'),
(102, 'Ireland', 'IE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '26ef7de8-a57b-449e-a929-79c4912c3f37'),
(103, 'Israel', 'IL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f44091f1-166c-49f1-8286-c2e271569cd5'),
(104, 'Isle Of Man', 'IM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5feff946-9e44-45b4-b08c-8c88d0639cce'),
(105, 'India', 'IN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'fc90e2ea-379a-4e99-969f-5674186a73a1'),
(106, 'British Indian Ocean Territory', 'IO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'fb98bf2c-aaaa-4a5d-90f1-22bd80778646'),
(107, 'Iraq', 'IQ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '29c53d34-f762-4728-9844-dcdfa463c1cc'),
(108, 'Iran', 'IR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '02ef2040-e12e-494a-915e-d94c165d1299'),
(109, 'Iceland', 'IS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a63fbe6a-476d-4c8a-aafd-693a1df11d9f'),
(110, 'Italy', 'IT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '93970524-4c41-40b3-8169-1242a2786dd6'),
(111, 'Jersey', 'JE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9a6c3141-e219-4e63-a52d-4f68a7785ca4'),
(112, 'Jamaica', 'JM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4a270982-7719-4457-8310-1d6bd7b8f1a2'),
(113, 'Jordan', 'JO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3b3d6968-6fe1-4252-9e3e-a71e26119b1f'),
(114, 'Japan', 'JP', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd381dc99-eb4c-4d44-86e6-4720429aaa6e'),
(115, 'Kenya', 'KE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7f253563-2a62-467b-af8d-20e932cd2c8e'),
(116, 'Kyrgyzstan', 'KG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6bffbfc9-0c9d-44f9-b689-63f8be0bbf32'),
(117, 'Cambodia', 'KH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '622f3485-e1db-479b-a5be-e3302fcc4f2f'),
(118, 'Kiribati', 'KI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '04f6b3c9-78d8-483c-b6b8-edc3244ab05b'),
(119, 'Comoros', 'KM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0bd2a1b0-ed57-41e5-bf06-01a3ea215bcd'),
(120, 'Saint Kitts and Nevis', 'KN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '77cf3811-e387-4c90-9ea0-7e7b30b68b9c'),
(121, 'Korea (North)', 'KP', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a2d1bcf3-fa8d-4d34-915b-cc0617fd2eba'),
(122, 'Korea (South)', 'KR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2a674e43-ae49-45c1-bec5-62c9082bbc48'),
(123, 'Kuwait', 'KW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '02c4504c-f3bb-4f08-bc4f-5b7e3bece366'),
(124, 'Cayman Islands', 'KY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ce3c7f63-789c-4017-9e05-cc3a338c04fc'),
(125, 'Kazakhstan', 'KZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'dd44743a-83a9-4e89-bc98-17d321ec63f9'),
(126, 'Laos', 'LA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4884a220-ca7d-4a69-9b93-4168a58f44b8'),
(127, 'Lebanon', 'LB', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '60434f0d-29bf-4c2d-95bc-6d57ebcb545a'),
(128, 'Saint Lucia', 'LC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7ead83e9-d271-42de-8919-5cdec65ea699'),
(129, 'Liechtenstein', 'LI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd7ba11d1-980d-497d-97cc-06f79891b088'),
(130, 'Sri Lanka', 'LK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '49b9ff2a-c899-48bb-b8e9-155e6a3d571b'),
(131, 'Liberia', 'LR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '46fa2a52-a130-4d6a-bc52-b28f6556223c'),
(132, 'Lesotho', 'LS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3c50e263-a7de-4f73-a21a-0bd856fe6f48'),
(133, 'Lithuania', 'LT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '53e86fa9-1e76-418f-ad9a-173546282bb5'),
(134, 'Luxembourg', 'LU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '346040d9-c910-4c2b-95f6-5b1a7ba1e0fe'),
(135, 'Latvia', 'LV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '55f6e191-769a-4606-99c2-433424194b92'),
(136, 'Libya', 'LY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6723b872-1c43-4dec-a5ca-c00c492ef4bf'),
(137, 'Morocco', 'MA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '97b9c0f0-ed2d-4202-af12-6ced54411e10'),
(138, 'Monaco', 'MC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '924de08c-32e1-42e3-9c0b-5622b3ec61c1'),
(139, 'Moldova', 'MD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '052790e3-65bb-4b27-9579-a2730132f7e8'),
(140, 'Montenegro', 'ME', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '150ca2d6-56f8-4659-abed-1424ba8c9d14'),
(141, 'Saint Martin (French part)', 'MF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '74145fa9-1da2-4ba9-9edb-9165d7f2c03d'),
(142, 'Madagascar', 'MG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b2118bde-5345-4c4a-8876-00b484259d4a'),
(143, 'Marshall Islands', 'MH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'cc7eeb7c-2e99-4b09-9f7e-b50cfeac971d'),
(144, 'Macedonia', 'MK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '35c92a07-a1be-44d4-975a-a8f4a29c9e8d'),
(145, 'Mali', 'ML', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '74b97f0a-213b-45a6-8b3f-99478d715b9e'),
(146, 'Burma (Myanmar)', 'MM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd9c5432a-6800-4728-ac80-5fa0ebec8aac'),
(147, 'Mongolia', 'MN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3b2641be-a81d-4f50-b65b-01fd38e3ffb9'),
(148, 'Macau', 'MO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1ef5500f-d2ad-46c1-b98c-779df1dcd03d'),
(149, 'Northern Mariana Islands', 'MP', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3a21a2e2-151e-4f63-93b5-6020536367ca'),
(150, 'Martinique', 'MQ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2f677530-bcd4-4399-b3fd-d3386ee282d7'),
(151, 'Mauritania', 'MR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '73fde776-859e-4a74-914a-59e6a24ff229'),
(152, 'Montserrat', 'MS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'dc6b2030-4ec2-4aa4-8caf-8c295b3d3bc3'),
(153, 'Malta', 'MT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f7af84a9-fd39-4436-9a68-a2c7e282d9f6'),
(154, 'Mauritius', 'MU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '822c6399-637f-4d66-8ee8-f1dd4b454afd'),
(155, 'Maldives', 'MV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '50c89118-0bca-44b8-8b94-86ad7bb6101c'),
(156, 'Malawi', 'MW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '25af6073-e963-460c-8ac3-1fed81918c89'),
(157, 'Mexico', 'MX', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c947cf26-86a6-4843-946b-f1edf41920ee'),
(158, 'Malaysia', 'MY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4b7e016c-5d4c-40a6-96a8-9755d908b10f'),
(159, 'Mozambique', 'MZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1a06b658-1273-4fae-873c-3c7d8317a37c'),
(160, 'Namibia', 'NA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '660c929c-5f77-493f-b521-245b1796365d'),
(161, 'New Caledonia', 'NC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd4080178-d2f9-4536-89a2-2fcec2b7420b'),
(162, 'Niger', 'NE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8b3ee906-7a1c-402f-a0c9-e4343fcbe83b'),
(163, 'Norfolk Island', 'NF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '60642710-7545-4f8f-bb24-68308397bff3'),
(164, 'Nigeria', 'NG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'acb7df10-43be-4bee-b922-893a9d9ec28f'),
(165, 'Nicaragua', 'NI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '264c49a4-0db4-4e6d-b7a9-a27fb1b1c507'),
(166, 'Netherlands', 'NL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '858af14e-e7ca-4358-83c7-a1f0ba6f000d'),
(167, 'Norway', 'NO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '066ef0b2-8f45-4c57-8713-54ee05ddc16d'),
(168, 'Nepal', 'NP', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '633693d4-ba6a-49ed-a88e-398f7d1f179f'),
(169, 'Nauru', 'NR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '504b6e2e-ed46-4a77-b341-a3fd8cc1392a'),
(170, 'Niue', 'NU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '87f8fb4b-f500-4e83-afbd-5ffd0ddab427'),
(171, 'New Zealand', 'NZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e9d8bf16-5118-45b7-a5a7-71e59cdf255c'),
(172, 'Oman', 'OM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '99cb8f64-0463-4f8b-b636-06e70230dca3'),
(173, 'Panama', 'PA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b235d861-a166-4b19-847c-5701c9abad30'),
(174, 'Peru', 'PE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c89b88f9-669e-47a5-9214-ba52da3eb329'),
(175, 'French Polynesia', 'PF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1680c726-a71f-463c-bfd7-125b59b1509f'),
(176, 'Papua New Guinea', 'PG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '181acbc1-1774-45a5-a494-01a91692e990'),
(177, 'Philippines', 'PH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c29fa965-e212-4698-a5d6-06d8865a5ba9'),
(178, 'Pakistan', 'PK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '09c24301-d686-4015-a826-f4559664fdf8'),
(179, 'Poland', 'PL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b7fffa8b-6c96-4a7e-bf5c-83c390077835'),
(180, 'St. Pierre and Miquelon', 'PM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '801ee6ce-c37d-4ad5-9228-2cd0d84d4478'),
(181, 'Pitcairn', 'PN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '120c11f6-3428-4cb1-bcd2-c1b102bb7b8f'),
(182, 'Puerto Rico', 'PR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c569ec4d-4abe-4835-b47b-73af40e3c801'),
(183, 'Palestinian Territory, Occupied', 'PS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'dadf46de-83e6-43eb-9137-2ee4f0adb61e'),
(184, 'Portugal', 'PT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c472a662-6eca-403e-bd56-8b0b56966c0c'),
(185, 'Palau', 'PW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2baa36bd-8e57-4e13-ba6b-3e0b1075d0b7'),
(186, 'Paraguay', 'PY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1b259fc0-e33e-47fb-9e12-18b9e1e8261f'),
(187, 'Qatar', 'QA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3b67c7be-afbb-4533-82f6-7c50b7937e63'),
(188, 'Reunion', 'RE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4f9a71ee-0aa4-4f4d-ab88-cf413a030c9c'),
(189, 'Romania', 'RO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'cdbffbe2-2dfb-4e65-96ab-8e65a6172d9d'),
(190, 'Republic of Serbia', 'RS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1fe3041c-b0ab-4295-be1a-34fccbc88354'),
(191, 'Russia', 'RU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5836b9b4-a6fb-42b8-b902-b5321203e919'),
(192, 'Rwanda', 'RW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6d6c3910-a08d-440d-885a-ccd898aba0ba'),
(193, 'Saudi Arabia', 'SA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '762309bd-b8b9-4acb-8ead-c6e50d22b440'),
(194, 'Solomon Islands', 'SB', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7de6e6cd-7625-4a90-a16d-71295570a29c'),
(195, 'Seychelles', 'SC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b637c8b6-e680-4d79-8f6d-c974abdaa4c3'),
(196, 'Sudan', 'SD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0f2af760-1b4a-4703-828c-3d89d7da024b'),
(197, 'Sweden', 'SE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '62ae697e-bfd7-42ac-a8de-09522c2c33b0'),
(198, 'Singapore', 'SG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '58f71d1d-20f5-4827-a2c0-8544060f0925'),
(199, 'St. Helena', 'SH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8b852803-8a77-438d-bbbe-7c4a53b3e375'),
(200, 'Slovenia', 'SI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2dbfab49-d0fc-4701-aadd-82c561e29973'),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f7c875de-46be-41e0-8b52-f4dbb860b771'),
(202, 'Slovak Republic', 'SK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '56b5ac51-7cc5-4dec-8501-ec6d3f59c9ce'),
(203, 'Sierra Leone', 'SL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3fa41963-a75c-450e-8550-5aadc23ea35e'),
(204, 'San Marino', 'SM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5bfe876e-567b-44a2-a3ca-1d4559fdd71b'),
(205, 'Senegal', 'SN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '75debb05-4283-4662-976e-0f964af9d26a'),
(206, 'Somalia', 'SO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b189ebfe-923a-4ab8-9f5d-741120a58aff'),
(207, 'Suriname', 'SR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd560ed21-983e-4417-8dca-309ecd6c25b5'),
(208, 'South Sudan', 'SS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd3a6c315-bd22-4b2b-95c8-57049d0ad9bf'),
(209, 'Sao Tome and Principe', 'ST', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c27aba46-9c20-4898-bd53-f34aa63ff232'),
(210, 'El Salvador', 'SV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'fee56d1b-e4bc-41a7-9cc9-00b2a3bf6b4e'),
(211, 'Sint Maarten (Dutch part)', 'SX', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd94271e2-8aee-434b-9749-f0a51fca57b0'),
(212, 'Syria', 'SY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '608e61bd-9f8f-4576-a440-c6f9587b7eef'),
(213, 'Swaziland', 'SZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6f24ba68-4808-4b24-ba22-70572cb5212a'),
(214, 'Turks and Caicos Islands', 'TC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '104dbdf5-81c2-4ca5-9acf-a83d15b70670'),
(215, 'Chad', 'TD', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1457aa07-c829-436a-8188-0fd0c955b449'),
(216, 'French Southern Territories', 'TF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f660b5d9-ea9b-42ca-8bc0-3411d982fd11'),
(217, 'Togo', 'TG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '15503ac8-4193-4498-a8fa-8846b6fec71d'),
(218, 'Thailand', 'TH', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '3620b866-b457-4801-9699-8183e5111b97'),
(219, 'Tajikistan', 'TJ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0668496e-0cdc-4da4-8b65-9e6002567b8b'),
(220, 'Tokelau', 'TK', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6a170f4e-3843-46bf-891a-8f16b335d08d'),
(221, 'Timor-Leste', 'TL', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '021ce1cf-bd36-47be-be66-1c0e6412bb7c'),
(222, 'Turkmenistan', 'TM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6d3135d9-9ed4-408e-a7b3-e7e9e6d9157f'),
(223, 'Tunisia', 'TN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '09f61350-2491-46a4-bc62-13205a13a15d'),
(224, 'Tonga', 'TO', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '643ab8f9-92d7-4fb9-8f8c-807a1c3b0856'),
(225, 'Turkey', 'TR', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e59bba63-6de9-4e6e-802c-77d9e4342794'),
(226, 'Trinidad and Tobago', 'TT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '98ee3889-29ed-423f-948a-845761493ab5'),
(227, 'Tuvalu', 'TV', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4431c7fb-3a8c-43ac-91e4-e28b1a40f614'),
(228, 'Taiwan', 'TW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f1195be3-6582-41e5-a475-b7bdff7e22e8'),
(229, 'Tanzania', 'TZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '549927f4-5808-4a25-83b3-9a27c56b5770'),
(230, 'Ukraine', 'UA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'da5be04e-5b3a-415e-8ee7-4343b9e4f05b'),
(231, 'Uganda', 'UG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8d594b52-07ab-4d8b-a54c-046825ea006b'),
(232, 'United States Minor Outlying Islands', 'UM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '261010e3-594d-49bf-9b53-0c2801d52397'),
(233, 'United States', 'US', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'af296456-a919-406a-9213-1a17ef487936'),
(234, 'Uruguay', 'UY', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '51548b94-0459-47cf-a71d-9e10ba51a46b'),
(235, 'Uzbekistan', 'UZ', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '029105af-afec-47d0-a456-3ab24bc67c12'),
(236, 'Vatican City State (Holy See)', 'VA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c438bf6f-49a9-4945-93a5-893f5eaedbec'),
(237, 'Saint Vincent and the Grenadines', 'VC', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '03422352-5834-4593-964b-5fd0fee7da87'),
(238, 'Venezuela', 'VE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ff5c6847-7830-442f-8f32-f3b023eff33a'),
(239, 'Virgin Islands (British)', 'VG', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '179d1121-2fe2-4fbe-b103-fc11eac79f9a'),
(240, 'Virgin Islands (U.S.)', 'VI', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '24c9e3b3-b4be-4f00-822f-8968505ccfd7'),
(241, 'Viet Nam', 'VN', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'bb926cb0-4f3f-48d4-b8d3-74068cc6d9ba'),
(242, 'Vanuatu', 'VU', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4b060663-0e4f-4c86-bbb0-6aa49501b0b6'),
(243, 'Wallis and Futuna Islands', 'WF', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2fc9a8ec-fa0e-4e50-8e42-cc4017736d2b'),
(244, 'Samoa', 'WS', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5febbf13-6b92-4eac-a4b4-0e7ef1877140'),
(245, 'Yemen', 'YE', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '14cb312e-77fe-49d1-8c02-d78cb2d21d66'),
(246, 'Mayotte', 'YT', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b26577b4-2429-4b67-a060-378fa3625248'),
(247, 'South Africa', 'ZA', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '66ba1af7-d266-4e01-9827-c9376ba1fa79'),
(248, 'Zambia', 'ZM', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c727badb-aaf0-485d-bd18-81b6c3304124'),
(249, 'Zimbabwe', 'ZW', NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'da65cc13-0500-4a72-a745-94693919b113');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_customers`
--

CREATE TABLE `commerce_customers` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `primaryBillingAddressId` int(11) DEFAULT NULL,
  `primaryShippingAddressId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_customers`
--

INSERT INTO `commerce_customers` (`id`, `userId`, `primaryBillingAddressId`, `primaryShippingAddressId`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 1, NULL, NULL, '2020-01-09 12:14:44', '2020-01-09 12:57:30', '5a14b42c-3071-46c1-b3ff-66270a0d4b87');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_customers_addresses`
--

CREATE TABLE `commerce_customers_addresses` (
  `id` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `addressId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_customer_discountuses`
--

CREATE TABLE `commerce_customer_discountuses` (
  `id` int(11) NOT NULL,
  `discountId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `uses` int(11) UNSIGNED NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_discounts`
--

CREATE TABLE `commerce_discounts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `code` varchar(255) DEFAULT NULL,
  `perUserLimit` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `perEmailLimit` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `totalUseLimit` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `totalUses` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `purchaseTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `purchaseQty` int(11) NOT NULL DEFAULT '0',
  `maxPurchaseQty` int(11) NOT NULL DEFAULT '0',
  `baseDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageOffSubject` enum('original','discounted') NOT NULL,
  `excludeOnSale` tinyint(1) DEFAULT NULL,
  `hasFreeShippingForMatchingItems` tinyint(1) DEFAULT NULL,
  `hasFreeShippingForOrder` tinyint(1) DEFAULT NULL,
  `allGroups` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `ignoreSales` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_discount_categories`
--

CREATE TABLE `commerce_discount_categories` (
  `id` int(11) NOT NULL,
  `discountId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_discount_purchasables`
--

CREATE TABLE `commerce_discount_purchasables` (
  `id` int(11) NOT NULL,
  `discountId` int(11) NOT NULL,
  `purchasableId` int(11) NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_discount_usergroups`
--

CREATE TABLE `commerce_discount_usergroups` (
  `id` int(11) NOT NULL,
  `discountId` int(11) NOT NULL,
  `userGroupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_donations`
--

CREATE TABLE `commerce_donations` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `availableForPurchase` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_donations`
--

INSERT INTO `commerce_donations` (`id`, `sku`, `availableForPurchase`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(2, 'DONATION-CC3', 0, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0fb47c62-9b65-4d4e-9f28-5373ebc54cd7');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_emails`
--

CREATE TABLE `commerce_emails` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `recipientType` enum('customer','custom') DEFAULT 'custom',
  `to` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `attachPdf` tinyint(1) DEFAULT NULL,
  `templatePath` varchar(255) NOT NULL,
  `pdfTemplatePath` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_email_discountuses`
--

CREATE TABLE `commerce_email_discountuses` (
  `id` int(11) NOT NULL,
  `discountId` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `uses` int(11) UNSIGNED NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_gateways`
--

CREATE TABLE `commerce_gateways` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `settings` text,
  `paymentType` enum('authorize','purchase') NOT NULL DEFAULT 'purchase',
  `isFrontendEnabled` tinyint(1) DEFAULT NULL,
  `sendCartInfo` tinyint(1) DEFAULT NULL,
  `isArchived` tinyint(1) DEFAULT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_gateways`
--

INSERT INTO `commerce_gateways` (`id`, `type`, `name`, `handle`, `settings`, `paymentType`, `isFrontendEnabled`, `sendCartInfo`, `isArchived`, `dateArchived`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'craft\\commerce\\gateways\\Dummy', 'Dummy', 'dummy', NULL, 'purchase', 1, NULL, 0, NULL, 99, '2020-01-09 11:22:02', '2020-01-09 11:22:02', '3d58a519-71af-4e37-882d-e6a3e3b32206');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_lineitems`
--

CREATE TABLE `commerce_lineitems` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `purchasableId` int(11) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `options` text,
  `optionsSignature` varchar(255) NOT NULL,
  `price` decimal(14,4) UNSIGNED NOT NULL,
  `saleAmount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `salePrice` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weight` decimal(14,4) UNSIGNED NOT NULL DEFAULT '0.0000',
  `height` decimal(14,4) UNSIGNED NOT NULL DEFAULT '0.0000',
  `length` decimal(14,4) UNSIGNED NOT NULL DEFAULT '0.0000',
  `width` decimal(14,4) UNSIGNED NOT NULL DEFAULT '0.0000',
  `subtotal` decimal(14,4) UNSIGNED NOT NULL DEFAULT '0.0000',
  `total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `qty` int(11) UNSIGNED NOT NULL,
  `note` text,
  `snapshot` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_lineitems`
--

INSERT INTO `commerce_lineitems` (`id`, `orderId`, `purchasableId`, `taxCategoryId`, `shippingCategoryId`, `options`, `optionsSignature`, `price`, `saleAmount`, `salePrice`, `weight`, `height`, `length`, `width`, `subtotal`, `total`, `qty`, `note`, `snapshot`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 13, 6, 1, 1, '[]', 'd751713988987e9331980363e24189ce', '30.0000', '0.0000', '30.0000', '0.0000', '0.0000', '0.0000', '0.0000', '30.0000', '30.0000', 1, '', '{\"productId\":\"5\",\"isDefault\":\"1\",\"sku\":\"PSB-001\",\"price\":30,\"sortOrder\":\"1\",\"width\":null,\"height\":null,\"length\":null,\"weight\":null,\"stock\":\"0\",\"hasUnlimitedStock\":\"1\",\"minQty\":null,\"maxQty\":null,\"deletedWithProduct\":false,\"id\":\"6\",\"tempId\":null,\"draftId\":null,\"revisionId\":null,\"uid\":\"f98ae3af-5609-4fe0-ab91-03da261ef4a2\",\"fieldLayoutId\":null,\"contentId\":\"5\",\"enabled\":\"1\",\"archived\":\"0\",\"siteId\":\"1\",\"enabledForSite\":\"1\",\"title\":\"Parka With Stripes On Back\",\"slug\":\"psb-001\",\"uri\":null,\"dateCreated\":\"2020-01-09T19:22:01+08:00\",\"dateUpdated\":\"2020-01-09T19:22:07+08:00\",\"dateDeleted\":null,\"trashed\":false,\"propagateAll\":false,\"newSiteIds\":[],\"resaving\":false,\"duplicateOf\":null,\"previewing\":false,\"hardDelete\":false,\"ref\":null,\"status\":\"enabled\",\"structureId\":null,\"url\":\"https://depotise.test:447/shop/products/psb-001?variant=6\",\"isAvailable\":true,\"isPromotable\":true,\"shippingCategoryId\":1,\"taxCategoryId\":1,\"onSale\":false,\"cpEditUrl\":\"#\",\"product\":{\"postDate\":\"2020-01-09T19:22:02+08:00\",\"expiryDate\":null,\"typeId\":\"1\",\"taxCategoryId\":\"1\",\"shippingCategoryId\":\"1\",\"promotable\":\"1\",\"freeShipping\":null,\"enabled\":\"1\",\"availableForPurchase\":\"1\",\"defaultVariantId\":\"6\",\"defaultSku\":\"PSB-001\",\"defaultPrice\":\"30.0000\",\"defaultHeight\":\"0.0000\",\"defaultLength\":\"0.0000\",\"defaultWidth\":\"0.0000\",\"defaultWeight\":\"0.0000\",\"taxCategory\":null,\"name\":null,\"id\":\"5\",\"tempId\":null,\"draftId\":null,\"revisionId\":null,\"uid\":\"8068859d-99a0-4187-a231-9baf946b609a\",\"fieldLayoutId\":null,\"contentId\":\"4\",\"archived\":\"0\",\"siteId\":\"1\",\"enabledForSite\":\"1\",\"title\":\"Parka With Stripes On Back\",\"slug\":\"psb-001\",\"uri\":\"shop/products/psb-001\",\"dateCreated\":\"2020-01-09T19:22:01+08:00\",\"dateUpdated\":\"2020-01-09T19:22:01+08:00\",\"dateDeleted\":null,\"trashed\":false,\"propagateAll\":false,\"newSiteIds\":[],\"resaving\":false,\"duplicateOf\":null,\"previewing\":false,\"hardDelete\":false,\"ref\":null,\"status\":\"live\",\"structureId\":null,\"url\":\"https://depotise.test:447/shop/products/psb-001\"},\"description\":\"Parka With Stripes On Back\",\"purchasableId\":\"6\",\"options\":[],\"sales\":[]}', '2020-01-09 12:17:28', '2020-01-09 12:57:30', '0fe37892-1527-4a5c-aa16-c2bcfc5f697d');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_orderadjustments`
--

CREATE TABLE `commerce_orderadjustments` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `lineItemId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(14,4) NOT NULL,
  `included` tinyint(1) DEFAULT NULL,
  `isEstimated` tinyint(1) NOT NULL DEFAULT '0',
  `sourceSnapshot` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_orderhistories`
--

CREATE TABLE `commerce_orderhistories` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `prevStatusId` int(11) DEFAULT NULL,
  `newStatusId` int(11) DEFAULT NULL,
  `message` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_orders`
--

CREATE TABLE `commerce_orders` (
  `id` int(11) NOT NULL,
  `billingAddressId` int(11) DEFAULT NULL,
  `shippingAddressId` int(11) DEFAULT NULL,
  `estimatedBillingAddressId` int(11) DEFAULT NULL,
  `estimatedShippingAddressId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `paymentSourceId` int(11) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `orderStatusId` int(11) DEFAULT NULL,
  `number` varchar(32) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `couponCode` varchar(255) DEFAULT NULL,
  `itemTotal` decimal(14,4) DEFAULT '0.0000',
  `total` decimal(14,4) DEFAULT '0.0000',
  `totalPrice` decimal(14,4) DEFAULT '0.0000',
  `totalPaid` decimal(14,4) DEFAULT '0.0000',
  `paidStatus` enum('paid','partial','unpaid','overPaid') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isCompleted` tinyint(1) DEFAULT NULL,
  `dateOrdered` datetime DEFAULT NULL,
  `datePaid` datetime DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `lastIp` varchar(255) DEFAULT NULL,
  `orderLanguage` varchar(12) NOT NULL,
  `message` text,
  `registerUserOnOrderComplete` tinyint(1) DEFAULT NULL,
  `returnUrl` varchar(255) DEFAULT NULL,
  `cancelUrl` varchar(255) DEFAULT NULL,
  `shippingMethodHandle` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_orders`
--

INSERT INTO `commerce_orders` (`id`, `billingAddressId`, `shippingAddressId`, `estimatedBillingAddressId`, `estimatedShippingAddressId`, `gatewayId`, `paymentSourceId`, `customerId`, `orderStatusId`, `number`, `reference`, `couponCode`, `itemTotal`, `total`, `totalPrice`, `totalPaid`, `paidStatus`, `email`, `isCompleted`, `dateOrdered`, `datePaid`, `currency`, `paymentCurrency`, `lastIp`, `orderLanguage`, `message`, `registerUserOnOrderComplete`, `returnUrl`, `cancelUrl`, `shippingMethodHandle`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(13, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, 'f99bb09f55c2819707b316c0ffa2e6bd', NULL, NULL, '30.0000', '30.0000', '30.0000', '0.0000', 'unpaid', 'dale@depotise.com', 0, NULL, NULL, 'USD', 'USD', '127.0.0.1', 'en-US', NULL, NULL, NULL, NULL, 'freeShipping', '2020-01-09 12:17:27', '2020-01-09 12:57:30', 'cb330dcb-0111-41ca-934a-f3c2ef27f866');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_orderstatuses`
--

CREATE TABLE `commerce_orderstatuses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `description` varchar(255) DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_orderstatuses`
--

INSERT INTO `commerce_orderstatuses` (`id`, `name`, `handle`, `color`, `description`, `dateDeleted`, `sortOrder`, `default`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'New', 'new', 'green', NULL, NULL, 99, 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '1297d030-490d-4a5e-974b-929e7cba3bae'),
(2, 'Shipped', 'shipped', 'blue', NULL, NULL, 99, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8f17c643-bbd6-433a-ac95-4c78583deff5');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_orderstatus_emails`
--

CREATE TABLE `commerce_orderstatus_emails` (
  `id` int(11) NOT NULL,
  `orderStatusId` int(11) NOT NULL,
  `emailId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_paymentcurrencies`
--

CREATE TABLE `commerce_paymentcurrencies` (
  `id` int(11) NOT NULL,
  `iso` varchar(3) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `rate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_paymentcurrencies`
--

INSERT INTO `commerce_paymentcurrencies` (`id`, `iso`, `primary`, `rate`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'PHP', 1, '1.0000', '2020-01-09 11:22:01', '2020-01-09 12:58:48', 'a8d1d1b9-e72a-4aa4-b40a-116e62d7ad7c');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_paymentsources`
--

CREATE TABLE `commerce_paymentsources` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `gatewayId` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_plans`
--

CREATE TABLE `commerce_plans` (
  `id` int(11) NOT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `planInformationId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `planData` text,
  `isArchived` tinyint(1) NOT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_products`
--

CREATE TABLE `commerce_products` (
  `id` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `defaultVariantId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `promotable` tinyint(1) DEFAULT NULL,
  `availableForPurchase` tinyint(1) DEFAULT NULL,
  `freeShipping` tinyint(1) DEFAULT NULL,
  `defaultSku` varchar(255) DEFAULT NULL,
  `defaultPrice` decimal(14,4) DEFAULT NULL,
  `defaultHeight` decimal(14,4) DEFAULT NULL,
  `defaultLength` decimal(14,4) DEFAULT NULL,
  `defaultWidth` decimal(14,4) DEFAULT NULL,
  `defaultWeight` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_products`
--

INSERT INTO `commerce_products` (`id`, `typeId`, `taxCategoryId`, `shippingCategoryId`, `defaultVariantId`, `postDate`, `expiryDate`, `promotable`, `availableForPurchase`, `freeShipping`, `defaultSku`, `defaultPrice`, `defaultHeight`, `defaultLength`, `defaultWidth`, `defaultWeight`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(3, 1, 1, 1, 4, '2020-01-09 11:22:01', NULL, 1, 1, NULL, 'ANT-001', '20.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 11:22:01', '2020-01-09 11:22:07', '4304f903-791c-427d-bf28-adde805c3225'),
(5, 1, 1, 1, 6, '2020-01-09 11:22:02', NULL, 1, 1, NULL, 'PSB-001', '30.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', '6f2a795e-7ced-4102-b93b-de24f74a7f80'),
(7, 1, 1, 1, 8, '2020-01-09 11:22:02', NULL, 1, 1, NULL, 'RRE-001', '40.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', '7c2cae08-e81f-43cf-8609-913c2bf56c6b'),
(9, 1, 1, 1, 10, '2020-01-09 11:22:02', NULL, 1, 1, NULL, 'TFA-001', '50.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'a8a19347-3762-4e7a-97d0-a327ea9672a5'),
(11, 1, 1, 1, 12, '2020-01-09 11:22:02', NULL, 1, 1, NULL, 'LKH-001', '60.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:08', '892e82e0-5935-4e95-9584-ffd1bfd1feda'),
(14, 2, 1, 1, 15, '2020-01-09 12:50:00', NULL, 1, 1, 0, 'plywood-marin', '880.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-01-09 12:50:07', '2020-01-09 12:50:08', '817d70e9-814f-4890-8a19-2b1f29b0fd94');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_producttypes`
--

CREATE TABLE `commerce_producttypes` (
  `id` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `variantFieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasDimensions` tinyint(1) DEFAULT NULL,
  `hasVariants` tinyint(1) DEFAULT NULL,
  `hasVariantTitleField` tinyint(1) DEFAULT NULL,
  `titleFormat` varchar(255) NOT NULL,
  `skuFormat` varchar(255) DEFAULT NULL,
  `descriptionFormat` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_producttypes`
--

INSERT INTO `commerce_producttypes` (`id`, `fieldLayoutId`, `variantFieldLayoutId`, `name`, `handle`, `hasDimensions`, `hasVariants`, `hasVariantTitleField`, `titleFormat`, `skuFormat`, `descriptionFormat`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, NULL, NULL, 'Clothing', 'clothing', 1, 0, 0, '{product.title}', '', '', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b1ac7052-ff49-47d5-8114-8ee92798c569'),
(2, NULL, NULL, 'Tools', 'tools', 1, 1, 1, '{product.title}', '', '', '2020-01-09 12:47:56', '2020-01-09 12:48:58', 'e18a3a35-71fc-4f1b-a9a6-aacf1261c024');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_producttypes_shippingcategories`
--

CREATE TABLE `commerce_producttypes_shippingcategories` (
  `id` int(11) NOT NULL,
  `productTypeId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_producttypes_sites`
--

CREATE TABLE `commerce_producttypes_sites` (
  `id` int(11) NOT NULL,
  `productTypeId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `hasUrls` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_producttypes_sites`
--

INSERT INTO `commerce_producttypes_sites` (`id`, `productTypeId`, `siteId`, `uriFormat`, `template`, `hasUrls`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 1, 1, 'shop/products/{slug}', 'shop/products/_product', 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '2bd6ff45-771d-4c80-9459-35b5769baed5'),
(2, 2, 1, 'tools/{slug}', 'tools/_product', 1, '2020-01-09 12:47:56', '2020-01-09 12:48:58', '4527beb1-ae57-4fde-b0f7-3595ee75a0a8');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_producttypes_taxcategories`
--

CREATE TABLE `commerce_producttypes_taxcategories` (
  `id` int(11) NOT NULL,
  `productTypeId` int(11) NOT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_purchasables`
--

CREATE TABLE `commerce_purchasables` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `price` decimal(14,4) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_purchasables`
--

INSERT INTO `commerce_purchasables` (`id`, `sku`, `price`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(2, 'DONATION-CC3', '0.0000', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'aaec7863-17af-4d7b-8c64-2eb1f1613ede'),
(4, 'ANT-001', '20.0000', '2020-01-09 11:22:01', '2020-01-09 11:22:07', '9773f7cd-2870-48a1-afc5-9e3228747ce8'),
(6, 'PSB-001', '30.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'b8e8a7f7-5db4-45c5-9b8e-88a0dd24a1d7'),
(8, 'RRE-001', '40.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'e4f824f3-c912-4dca-a62b-e46bf1fe76b1'),
(10, 'TFA-001', '50.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'ed95848e-ed53-4e68-9e11-13fdfb9fd4e0'),
(12, 'LKH-001', '60.0000', '2020-01-09 11:22:02', '2020-01-09 11:22:08', 'aa1b8805-b133-4dd4-b650-3d5851730036'),
(15, 'plywood-marin', '880.0000', '2020-01-09 12:50:07', '2020-01-09 12:50:07', '524ee26e-829c-47a3-9685-bbdc1363f138'),
(16, 'plywood-thin', '600.0000', '2020-01-09 12:50:08', '2020-01-09 12:50:08', 'dec56238-3c58-40cf-a5b8-abac5e06eb55');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_sales`
--

CREATE TABLE `commerce_sales` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `apply` enum('toPercent','toFlat','byPercent','byFlat') NOT NULL,
  `applyAmount` decimal(14,4) NOT NULL,
  `allGroups` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `ignorePrevious` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_sale_categories`
--

CREATE TABLE `commerce_sale_categories` (
  `id` int(11) NOT NULL,
  `saleId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_sale_purchasables`
--

CREATE TABLE `commerce_sale_purchasables` (
  `id` int(11) NOT NULL,
  `saleId` int(11) NOT NULL,
  `purchasableId` int(11) NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_sale_usergroups`
--

CREATE TABLE `commerce_sale_usergroups` (
  `id` int(11) NOT NULL,
  `saleId` int(11) NOT NULL,
  `userGroupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingcategories`
--

CREATE TABLE `commerce_shippingcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_shippingcategories`
--

INSERT INTO `commerce_shippingcategories` (`id`, `name`, `handle`, `description`, `default`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'General', 'general', NULL, 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ee044cb7-b9da-4307-98b7-27a31d526e11');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingmethods`
--

CREATE TABLE `commerce_shippingmethods` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_shippingmethods`
--

INSERT INTO `commerce_shippingmethods` (`id`, `name`, `handle`, `enabled`, `isLite`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'Free Shipping', 'freeShipping', 1, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f60fea79-1cd0-4f10-99de-356c6fda7d78');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingrules`
--

CREATE TABLE `commerce_shippingrules` (
  `id` int(11) NOT NULL,
  `shippingZoneId` int(11) DEFAULT NULL,
  `methodId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) DEFAULT NULL,
  `minQty` int(11) NOT NULL DEFAULT '0',
  `maxQty` int(11) NOT NULL DEFAULT '0',
  `minTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `baseRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weightRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_shippingrules`
--

INSERT INTO `commerce_shippingrules` (`id`, `shippingZoneId`, `methodId`, `name`, `description`, `priority`, `enabled`, `minQty`, `maxQty`, `minTotal`, `maxTotal`, `minWeight`, `maxWeight`, `baseRate`, `perItemRate`, `weightRate`, `percentageRate`, `minRate`, `maxRate`, `isLite`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, NULL, 1, 'Free Everywhere', 'All Countries, free shipping.', 0, 1, 0, 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:01', '60e16404-bc38-4020-804f-2a954337d9a6');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingrule_categories`
--

CREATE TABLE `commerce_shippingrule_categories` (
  `id` int(11) NOT NULL,
  `shippingRuleId` int(11) DEFAULT NULL,
  `shippingCategoryId` int(11) DEFAULT NULL,
  `condition` enum('allow','disallow','require') NOT NULL,
  `perItemRate` decimal(14,4) DEFAULT NULL,
  `weightRate` decimal(14,4) DEFAULT NULL,
  `percentageRate` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingzones`
--

CREATE TABLE `commerce_shippingzones` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `zipCodeConditionFormula` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingzone_countries`
--

CREATE TABLE `commerce_shippingzone_countries` (
  `id` int(11) NOT NULL,
  `shippingZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_shippingzone_states`
--

CREATE TABLE `commerce_shippingzone_states` (
  `id` int(11) NOT NULL,
  `shippingZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_states`
--

CREATE TABLE `commerce_states` (
  `id` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_states`
--

INSERT INTO `commerce_states` (`id`, `countryId`, `name`, `abbreviation`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 13, 'Australian Capital Territory', 'ACT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9740d055-24bf-4670-b0d9-54c26a9c430c'),
(2, 13, 'New South Wales', 'NSW', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9cacad41-c649-47ed-969d-0f6819aaea84'),
(3, 13, 'Northern Territory', 'NT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9cab29fb-128a-4b05-9bb9-2896469ba12e'),
(4, 13, 'Queensland', 'QLD', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '40f21335-27a0-441e-b82b-a0edd6f76cda'),
(5, 13, 'South Australia', 'SA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8e334c4f-2cbc-4965-b0c1-42ee4a414302'),
(6, 13, 'Tasmania', 'TAS', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '06e5df66-5ed7-4d33-b812-f33d83332f58'),
(7, 13, 'Victoria', 'VIC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'cbc6e701-5bd4-4479-b088-ce9a87663664'),
(8, 13, 'Western Australia', 'WA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5c26acf0-7baf-442c-b4e1-ceb5f019cca7'),
(9, 38, 'Alberta', 'AB', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e9405a02-b110-4d0d-8be0-77878f5e535e'),
(10, 38, 'British Columbia', 'BC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'df47bedc-e5a1-4f51-9e4a-353fc36a90bc'),
(11, 38, 'Manitoba', 'MB', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '875cd686-9127-4dce-9e53-7d7312772a94'),
(12, 38, 'New Brunswick', 'NB', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '17bf9972-01e4-42d8-ba78-c2989356483e'),
(13, 38, 'Newfoundland and Labrador', 'NL', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ceccc76b-9b43-4fbc-a431-77362904bb69'),
(14, 38, 'Northwest Territories', 'NT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7bb65a8f-3320-4421-8179-09d531a6675a'),
(15, 38, 'Nova Scotia', 'NS', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b2442732-dbda-4d31-8617-7b5b5afed66c'),
(16, 38, 'Nunavut', 'NU', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6dea232e-d9ac-4a94-b006-23ca991f5b48'),
(17, 38, 'Ontario', 'ON', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '54de722c-922f-491a-981c-90694030e4e9'),
(18, 38, 'Prince Edward Island', 'PE', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '390025ff-cebb-4601-8851-54abfb38a84f'),
(19, 38, 'Quebec', 'QC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5dbaf58d-04eb-41f9-9979-5478ac6b098d'),
(20, 38, 'Saskatchewan', 'SK', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '576236f7-f4ee-459c-b66e-1ac28edfc8f6'),
(21, 38, 'Yukon', 'YT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '02bc8648-b174-4acb-b088-32b9c164d9fc'),
(22, 233, 'Alabama', 'AL', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '98128cab-ebc4-4d4d-9822-07dcce30f4cb'),
(23, 233, 'Alaska', 'AK', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '31371d82-8314-47b6-979f-ad9aef2a4187'),
(24, 233, 'Arizona', 'AZ', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c93d5253-b495-445c-b9d9-f2623a5eb200'),
(25, 233, 'Arkansas', 'AR', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a6fba4b2-b7d3-493d-ad56-485d644171b8'),
(26, 233, 'California', 'CA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b624cb3e-599d-4673-8c72-696440ac7ae7'),
(27, 233, 'Colorado', 'CO', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c770e1c5-d980-4495-baf4-a194a97bbb98'),
(28, 233, 'Connecticut', 'CT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '96e6d2b4-8e24-455e-8e96-a605319e70b7'),
(29, 233, 'Delaware', 'DE', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '46341ebc-dc6e-4e20-9069-e9fb40115915'),
(30, 233, 'District of Columbia', 'DC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5df312b6-9e2e-4290-bacb-ae7ac49dcfcb'),
(31, 233, 'Florida', 'FL', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7205a15f-019b-4dcb-ad37-247b6eeec65f'),
(32, 233, 'Georgia', 'GA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'ffea81c5-533a-489c-9715-fa4c29a9c48c'),
(33, 233, 'Hawaii', 'HI', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '862e0fbc-5824-4667-9bc8-6c9c3978dd71'),
(34, 233, 'Idaho', 'ID', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd5f66832-287e-4d2e-9fd1-d0485168303a'),
(35, 233, 'Illinois', 'IL', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4ed9ccf5-0868-4b46-a6f4-421527b31a8c'),
(36, 233, 'Indiana', 'IN', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6e6ae6c8-a756-40b8-96ee-6917da4de0f6'),
(37, 233, 'Iowa', 'IA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e160219a-0170-47c7-af63-c3534e281602'),
(38, 233, 'Kansas', 'KS', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '427c84c8-958d-4b76-a088-098bc48f00ce'),
(39, 233, 'Kentucky', 'KY', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '593a9eb3-06e2-4fcd-8b7d-e56e02e5db49'),
(40, 233, 'Louisiana', 'LA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '8349b659-2521-4d79-91b7-16b904768034'),
(41, 233, 'Maine', 'ME', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f1c9c642-3bb0-4ee8-af47-7d894e147213'),
(42, 233, 'Maryland', 'MD', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '677a4b73-11ab-43c7-89a3-9a61ae8e623c'),
(43, 233, 'Massachusetts', 'MA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f2e9af00-5a20-4676-a9fc-2612f97b51c5'),
(44, 233, 'Michigan', 'MI', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9fbc695b-7733-423d-86e9-a623fb26a9d5'),
(45, 233, 'Minnesota', 'MN', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f60c86a8-689a-43ce-a70e-76b91d823502'),
(46, 233, 'Mississippi', 'MS', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'c063796d-2ab4-4ba7-9254-3139cb37cd4c'),
(47, 233, 'Missouri', 'MO', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'cd58e67d-ae27-421a-830c-56d22905b4a8'),
(48, 233, 'Montana', 'MT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f0099742-af23-4403-9ed4-c46eb680007f'),
(49, 233, 'Nebraska', 'NE', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '93ee1fd1-0ba4-46b7-87c6-3bf78920d353'),
(50, 233, 'Nevada', 'NV', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '6c6005b2-8597-4ccd-be08-d85df10de564'),
(51, 233, 'New Hampshire', 'NH', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f1d430ba-9f22-425e-b9f9-f735a94662f5'),
(52, 233, 'New Jersey', 'NJ', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b0b38d9d-e0cf-4df4-8b23-dabaa3dae8bc'),
(53, 233, 'New Mexico', 'NM', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd8149de4-1565-4334-9bb2-0e8ca03b2c53'),
(54, 233, 'New York', 'NY', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4c20c945-f16f-4b9c-a485-ff1ab9bd6d8b'),
(55, 233, 'North Carolina', 'NC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '72229f6d-031b-4b2a-85cd-8c174964b111'),
(56, 233, 'North Dakota', 'ND', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '431c99d1-f15b-4c29-9c68-fe022e8bb43e'),
(57, 233, 'Ohio', 'OH', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b03e2cba-e93d-4b84-a243-b0b880d51aa4'),
(58, 233, 'Oklahoma', 'OK', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '97c4d40d-2c41-4d1e-b874-0aff73a6795b'),
(59, 233, 'Oregon', 'OR', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '0a3e97ba-e14e-4a74-8714-ef90aa0316c9'),
(60, 233, 'Pennsylvania', 'PA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'cfc843ff-ac03-4918-8de4-e2307b2f8ef8'),
(61, 233, 'Rhode Island', 'RI', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4c1d67e9-d7a7-4d98-b077-91736728f95d'),
(62, 233, 'South Carolina', 'SC', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '7cdc7ecf-abc4-4b91-b2a5-6fd0f2ec7981'),
(63, 233, 'South Dakota', 'SD', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '4716b96d-b66d-4589-a543-e07f372e80a9'),
(64, 233, 'Tennessee', 'TN', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '9bfd15f6-2e14-4511-a486-a18b989e8e0e'),
(65, 233, 'Texas', 'TX', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '23b644cf-aed1-4363-b72e-402f60be4d03'),
(66, 233, 'Utah', 'UT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'e3299373-00b5-4e85-9013-8f9944185b8b'),
(67, 233, 'Vermont', 'VT', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '5dec808a-a10c-43e0-a464-17fa6143b63d'),
(68, 233, 'Virginia', 'VA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd3f00223-b50f-4a3a-a3bd-95a7e6d337bc'),
(69, 233, 'Washington', 'WA', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'b475b8dc-fbe6-47bf-99b5-77afe71e327d'),
(70, 233, 'West Virginia', 'WV', '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'd6dd247a-09c6-4ca0-8b90-8543fa7da386'),
(71, 233, 'Wisconsin', 'WI', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '89edbc0b-df8f-47e4-afec-8ca968725e6e'),
(72, 233, 'Wyoming', 'WY', '2020-01-09 11:22:01', '2020-01-09 11:22:01', '17c37ff8-eaff-4493-b249-75071b0f8324');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_subscriptions`
--

CREATE TABLE `commerce_subscriptions` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `planId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `orderId` int(11) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `subscriptionData` text,
  `trialDays` int(11) NOT NULL,
  `nextPaymentDate` datetime DEFAULT NULL,
  `hasStarted` tinyint(1) NOT NULL DEFAULT '1',
  `isSuspended` tinyint(1) NOT NULL DEFAULT '0',
  `dateSuspended` datetime DEFAULT NULL,
  `isCanceled` tinyint(1) NOT NULL,
  `dateCanceled` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL,
  `dateExpired` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_taxcategories`
--

CREATE TABLE `commerce_taxcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_taxcategories`
--

INSERT INTO `commerce_taxcategories` (`id`, `name`, `handle`, `description`, `default`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'General', 'general', NULL, 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'f8d657b6-043a-40db-994c-2a75b9112f49');

-- --------------------------------------------------------

--
-- Table structure for table `commerce_taxrates`
--

CREATE TABLE `commerce_taxrates` (
  `id` int(11) NOT NULL,
  `taxZoneId` int(11) DEFAULT NULL,
  `isEverywhere` tinyint(1) DEFAULT NULL,
  `taxCategoryId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `rate` decimal(14,10) NOT NULL,
  `include` tinyint(1) DEFAULT NULL,
  `isVat` tinyint(1) DEFAULT NULL,
  `taxable` enum('price','shipping','price_shipping','order_total_shipping','order_total_price') NOT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_taxzones`
--

CREATE TABLE `commerce_taxzones` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `zipCodeConditionFormula` text,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_taxzone_countries`
--

CREATE TABLE `commerce_taxzone_countries` (
  `id` int(11) NOT NULL,
  `taxZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_taxzone_states`
--

CREATE TABLE `commerce_taxzone_states` (
  `id` int(11) NOT NULL,
  `taxZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_transactions`
--

CREATE TABLE `commerce_transactions` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `hash` varchar(32) DEFAULT NULL,
  `type` enum('authorize','capture','purchase','refund') NOT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `paymentAmount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `paymentRate` decimal(14,4) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed','processing') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `note` mediumtext,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commerce_variants`
--

CREATE TABLE `commerce_variants` (
  `id` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `price` decimal(14,4) NOT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `width` decimal(14,4) DEFAULT NULL,
  `height` decimal(14,4) DEFAULT NULL,
  `length` decimal(14,4) DEFAULT NULL,
  `weight` decimal(14,4) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `hasUnlimitedStock` tinyint(1) DEFAULT NULL,
  `minQty` int(11) DEFAULT NULL,
  `maxQty` int(11) DEFAULT NULL,
  `deletedWithProduct` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commerce_variants`
--

INSERT INTO `commerce_variants` (`id`, `productId`, `sku`, `isDefault`, `price`, `sortOrder`, `width`, `height`, `length`, `weight`, `stock`, `hasUnlimitedStock`, `minQty`, `maxQty`, `deletedWithProduct`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(4, 3, 'ANT-001', 1, '20.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 11:22:01', '2020-01-09 11:22:07', '7714ef87-7375-4886-aeb2-7138666c7ba9'),
(6, 5, 'PSB-001', 1, '30.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 11:22:02', '2020-01-09 11:22:07', '3d14c5f4-2877-45f0-b9ae-fea9480f502d'),
(8, 7, 'RRE-001', 1, '40.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 11:22:02', '2020-01-09 11:22:07', '897858e4-2525-49a4-a3d3-e9dde342e8e9'),
(10, 9, 'TFA-001', 1, '50.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 11:22:02', '2020-01-09 11:22:07', '6650635e-d566-47f9-8624-13896618820c'),
(12, 11, 'LKH-001', 1, '60.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 11:22:02', '2020-01-09 11:22:08', '7ab9ae02-7661-4b31-8c7e-a35e0b8acd79'),
(15, 14, 'plywood-marin', 1, '880.0000', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 12:50:07', '2020-01-09 12:50:07', 'a5aad0b6-3b59-432e-a47e-8ee57fb3b987'),
(16, 14, 'plywood-thin', 0, '600.0000', 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, '2020-01-09 12:50:08', '2020-01-09 12:50:08', '3ed07309-d006-49e0-9262-dbc8f452feb6');

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `id` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 1, 1, NULL, '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'a51de56d-930e-43dc-b248-7d568ff6eb0f'),
(2, 3, 1, 'A New Toga', '2020-01-09 11:22:01', '2020-01-09 11:22:07', '3314abc8-f8ec-406d-869d-98d7f7af5789'),
(3, 4, 1, 'A New Toga', '2020-01-09 11:22:01', '2020-01-09 11:22:07', '1c2491b7-86cb-4afb-907c-401d92dde7f5'),
(4, 5, 1, 'Parka With Stripes On Back', '2020-01-09 11:22:01', '2020-01-09 11:22:07', '3b1b3dce-da81-4d40-9e8f-76bccdbcd45a'),
(5, 6, 1, 'Parka With Stripes On Back', '2020-01-09 11:22:02', '2020-01-09 11:22:07', '8ed816c0-a2b0-4d47-b4e3-412fedc53592'),
(6, 7, 1, 'Romper For A Red Eye', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'bc709e0c-b178-4974-946c-772baf0b7622'),
(7, 8, 1, 'Romper For A Red Eye', '2020-01-09 11:22:02', '2020-01-09 11:22:07', '55420419-f894-42a3-b96a-1047a46187ae'),
(8, 9, 1, 'The Fleece Awakens', '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'fd6780ad-a961-4abb-9be4-ff6081ba2ad0'),
(9, 10, 1, 'The Fleece Awakens', '2020-01-09 11:22:02', '2020-01-09 11:22:07', '84b3fa6e-630a-48c6-ae70-713e4761cb1d'),
(10, 11, 1, 'The Last Knee-High', '2020-01-09 11:22:02', '2020-01-09 11:22:08', '157530d9-5831-46c1-86fe-fdde2c5a08a9'),
(11, 12, 1, 'The Last Knee-High', '2020-01-09 11:22:02', '2020-01-09 11:22:08', '25080606-2b56-4d81-baba-a79ba8df39ba'),
(12, 13, 1, NULL, '2020-01-09 12:17:27', '2020-01-09 12:57:30', 'c7bb273e-9b64-4fdd-b34c-7324116ff22c'),
(13, 14, 1, 'Plywood', '2020-01-09 12:50:07', '2020-01-09 12:50:07', 'd0f5fa2f-317f-4705-9dec-e626c39967d6'),
(14, 15, 1, 'Marine', '2020-01-09 12:50:07', '2020-01-09 12:50:07', '1645100c-db22-4f4a-a7bd-78b28e25c52f'),
(15, 16, 1, 'Thin', '2020-01-09 12:50:08', '2020-01-09 12:50:08', '1bc4cf95-5ead-4848-9189-41f1e2282a3d');

-- --------------------------------------------------------

--
-- Table structure for table `craftidtokens`
--

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `deprecationerrors`
--

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) UNSIGNED DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `drafts`
--

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `elementindexsettings`
--

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `elements`
--

CREATE TABLE `elements` (
  `id` int(11) NOT NULL,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `elements`
--

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1, NULL, NULL, NULL, 'craft\\elements\\User', 1, 0, '2020-01-08 14:43:37', '2020-01-08 14:43:37', NULL, '8578d19a-b781-46e7-a6a8-c617a47af9d5'),
(2, NULL, NULL, NULL, 'craft\\commerce\\elements\\Donation', 1, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, '34517b1f-855d-4903-8f98-232c9c07e548'),
(3, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, 'b5889ee3-eb97-4cd8-a375-68662a7409a5'),
(4, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:07', NULL, '880d2cf6-995b-4a6a-9112-9bece1570a35'),
(5, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, '8068859d-99a0-4187-a231-9baf946b609a'),
(6, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 11:22:01', '2020-01-09 11:22:07', NULL, 'f98ae3af-5609-4fe0-ab91-03da261ef4a2'),
(7, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:02', NULL, 'c11239df-7a1c-4717-8b61-88b002568b00'),
(8, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:07', NULL, '16707a8a-6df9-4107-8d40-11ef86eadc7e'),
(9, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:02', NULL, '6683fdc9-89b4-4b8e-92fb-9ed0cf088944'),
(10, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:07', NULL, 'd9d868e6-c73e-4cd4-8238-231c3947b1ae'),
(11, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:02', NULL, 'aaa6a70d-cb3d-4fde-887c-a331d0d6b780'),
(12, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 11:22:02', '2020-01-09 11:22:08', NULL, '90352246-c1d9-45b4-b6ee-1c7c4d9fcfca'),
(13, NULL, NULL, 1, 'craft\\commerce\\elements\\Order', 1, 0, '2020-01-09 12:17:27', '2020-01-09 12:57:30', NULL, '9e0d11a9-1ef4-47c8-b345-763c8078e556'),
(14, NULL, NULL, NULL, 'craft\\commerce\\elements\\Product', 1, 0, '2020-01-09 12:50:07', '2020-01-09 12:50:07', NULL, '15fbf14c-8653-4d04-bdd5-2014a8423b49'),
(15, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 12:50:07', '2020-01-09 12:50:07', NULL, '4e22ab0f-cb64-4495-80aa-a0843a38c6ba'),
(16, NULL, NULL, NULL, 'craft\\commerce\\elements\\Variant', 1, 0, '2020-01-09 12:50:08', '2020-01-09 12:50:08', NULL, '2f0bd46c-ea2b-47c7-a274-54d8ec82c18a');

-- --------------------------------------------------------

--
-- Table structure for table `elements_sites`
--

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `elements_sites`
--

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 1, 1, NULL, NULL, 1, '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'bd3f409e-f77f-46ae-93d1-649796e63f45'),
(2, 2, 1, NULL, NULL, 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'bc716b84-87ad-4e41-9749-01ee05bbb885'),
(3, 3, 1, 'ant-001', 'shop/products/ant-001', 1, '2020-01-09 11:22:01', '2020-01-09 11:22:07', '04bef0d5-2748-4db7-ac98-0fe1128b1da4'),
(4, 4, 1, 'ant-001', NULL, 1, '2020-01-09 11:22:01', '2020-01-09 11:22:01', 'a4d60434-a789-4493-a9e2-91bf87d41753'),
(5, 5, 1, 'psb-001', 'shop/products/psb-001', 1, '2020-01-09 11:22:01', '2020-01-09 11:22:07', '404d8526-ea4c-4a4e-bc77-9d5f7e144e5e'),
(6, 6, 1, 'psb-001', NULL, 1, '2020-01-09 11:22:02', '2020-01-09 11:22:02', '40e55a1e-1b66-4d04-bdfd-e787ead10e75'),
(7, 7, 1, 'rre-001', 'shop/products/rre-001', 1, '2020-01-09 11:22:02', '2020-01-09 11:22:07', 'ef78c5ce-dc39-417f-afa1-ffae88754e47'),
(8, 8, 1, 'rre-001', NULL, 1, '2020-01-09 11:22:02', '2020-01-09 11:22:02', '78e45039-e633-4756-955e-626851560143'),
(9, 9, 1, 'tfa-001', 'shop/products/tfa-001', 1, '2020-01-09 11:22:02', '2020-01-09 11:22:07', '539e2c9d-324f-4373-8c55-9d71d456ac13'),
(10, 10, 1, 'tfa-001', NULL, 1, '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b14549c6-632e-47dd-89df-fca1df51349b'),
(11, 11, 1, 'lkh-001', 'shop/products/lkh-001', 1, '2020-01-09 11:22:02', '2020-01-09 11:22:08', '33b82fbe-bd6e-45c8-b4df-1b8e2df9eb79'),
(12, 12, 1, 'lkh-001', NULL, 1, '2020-01-09 11:22:02', '2020-01-09 11:22:02', '257597ea-e77a-45d0-bb23-815912f88af7'),
(13, 13, 1, NULL, NULL, 1, '2020-01-09 12:17:27', '2020-01-09 12:17:27', '70fdbcec-06b7-4744-88da-2837fb34b728'),
(14, 14, 1, 'plywood', 'tools/plywood', 1, '2020-01-09 12:50:07', '2020-01-09 12:50:07', '36faca2b-da54-4730-9071-7dfa5ed1d0ea'),
(15, 15, 1, NULL, NULL, 1, '2020-01-09 12:50:07', '2020-01-09 12:50:07', 'b7e3063d-9542-4d70-a024-d8b81c8339a9'),
(16, 16, 1, NULL, NULL, 1, '2020-01-09 12:50:08', '2020-01-09 12:50:08', 'f8b169f4-6f77-477a-b62d-3bf27ff588f7');

-- --------------------------------------------------------

--
-- Table structure for table `entries`
--

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entrytypes`
--

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fieldgroups`
--

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fieldgroups`
--

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'Common', '2020-01-08 14:43:37', '2020-01-08 14:43:37', '28f2bdbf-1df5-4391-b5b5-ec27766c59a3');

-- --------------------------------------------------------

--
-- Table structure for table `fieldlayoutfields`
--

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fieldlayouts`
--

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fieldlayouts`
--

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1, 'craft\\commerce\\elements\\Order', '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, 'ce6eab06-adbb-4d9b-9e96-bb477a4d1a2f'),
(2, 'craft\\commerce\\elements\\Product', '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, '411da85d-88ce-4eab-89dd-d408d0a74b32'),
(3, 'craft\\commerce\\elements\\Variant', '2020-01-09 11:22:01', '2020-01-09 11:22:01', NULL, '82c667e0-590b-4904-b946-339b4b02c4f4');

-- --------------------------------------------------------

--
-- Table structure for table `fieldlayouttabs`
--

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `globalsets`
--

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gqlschemas`
--

CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gqlschemas`
--

INSERT INTO `gqlschemas` (`id`, `name`, `accessToken`, `enabled`, `expiryDate`, `lastUsed`, `scope`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'Public Schema', '__PUBLIC__', 1, NULL, NULL, '[]', '2020-01-09 11:02:26', '2020-01-09 11:02:26', '8dd06b9d-73a9-42e4-9c76-aa72d874af9e');

-- --------------------------------------------------------

--
-- Table structure for table `info`
--

CREATE TABLE `info` (
  `id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `info`
--

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, '3.3.19', '3.3.3', 0, '{\"fieldGroups\":{\"28f2bdbf-1df5-4391-b5b5-ec27766c59a3\":{\"name\":\"Common\"}},\"siteGroups\":{\"739b56be-7619-489b-a794-dfd68982bb63\":{\"name\":\"Depotise\"}},\"sites\":{\"4aeceeb3-e412-4462-a9f8-246dcbfcf553\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"en-US\",\"name\":\"Depotise\",\"primary\":true,\"siteGroup\":\"739b56be-7619-489b-a794-dfd68982bb63\",\"sortOrder\":1}},\"email\":{\"fromEmail\":\"dale@depotise.com\",\"fromName\":\"Depotise\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"system\":{\"edition\":\"pro\",\"name\":\"Depotise\",\"live\":true,\"schemaVersion\":\"3.3.3\",\"timeZone\":\"Asia/Singapore\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":null,\"photoSubpath\":\"\"},\"dateModified\":1578574499,\"commerce\":{\"orderStatuses\":{\"1297d030-490d-4a5e-974b-929e7cba3bae\":{\"name\":\"New\",\"handle\":\"new\",\"color\":\"green\",\"description\":null,\"sortOrder\":99,\"default\":true},\"8f17c643-bbd6-433a-ac95-4c78583deff5\":{\"name\":\"Shipped\",\"handle\":\"shipped\",\"color\":\"blue\",\"description\":null,\"sortOrder\":99,\"default\":false}},\"productTypes\":{\"b1ac7052-ff49-47d5-8114-8ee92798c569\":{\"name\":\"Clothing\",\"handle\":\"clothing\",\"hasDimensions\":true,\"hasVariants\":false,\"hasVariantTitleField\":false,\"titleFormat\":\"{product.title}\",\"skuFormat\":\"\",\"descriptionFormat\":\"\",\"siteSettings\":{\"4aeceeb3-e412-4462-a9f8-246dcbfcf553\":{\"hasUrls\":true,\"uriFormat\":\"shop/products/{slug}\",\"template\":\"shop/products/_product\"}}},\"e18a3a35-71fc-4f1b-a9a6-aacf1261c024\":{\"name\":\"Tools\",\"handle\":\"tools\",\"hasDimensions\":true,\"hasVariants\":true,\"hasVariantTitleField\":true,\"titleFormat\":\"{product.title}\",\"skuFormat\":\"\",\"descriptionFormat\":\"\",\"siteSettings\":{\"4aeceeb3-e412-4462-a9f8-246dcbfcf553\":{\"hasUrls\":true,\"uriFormat\":\"tools/{slug}\",\"template\":\"tools/_product\"}}}},\"gateways\":{\"3d58a519-71af-4e37-882d-e6a3e3b32206\":{\"name\":\"Dummy\",\"handle\":\"dummy\",\"type\":\"craft\\\\commerce\\\\gateways\\\\Dummy\",\"sortOrder\":99,\"paymentType\":\"purchase\",\"isFrontendEnabled\":true}}},\"plugins\":{\"commerce\":{\"edition\":\"pro\",\"enabled\":true,\"schemaVersion\":\"2.2.1\",\"settings\":{\"weightUnits\":\"kg\",\"dimensionUnits\":\"cm\",\"emailSenderAddress\":\"\",\"emailSenderName\":\"\",\"orderPdfPath\":\"shop/_pdf/order\",\"pdfPaperSize\":\"letter\",\"pdfPaperOrientation\":\"portrait\",\"orderPdfFilenameFormat\":\"Order-{number}\",\"emailSenderAddressPlaceholder\":null,\"emailSenderNamePlaceholder\":null,\"minimumTotalPriceStrategy\":\"default\",\"mergeLastCartOnLogin\":true,\"paymentCurrency\":null,\"purgeInactiveCarts\":true,\"purgeInactiveCartsDuration\":\"P3M\",\"activeCartDuration\":\"PT1H\",\"gatewayPostRedirectTemplate\":\"\",\"useBillingAddressForTax\":false,\"validateBusinessTaxIdAsVatId\":false,\"requireShippingAddressAtCheckout\":false,\"requireBillingAddressAtCheckout\":false,\"requireShippingMethodSelectionAtCheckout\":false,\"autoSetNewCartAddresses\":true,\"allowEmptyCartOnCheckout\":true,\"pdfAllowRemoteImages\":false,\"orderReferenceFormat\":\"{{number[:7]}}\",\"defaultView\":\"commerce/orders\",\"cartVariable\":\"cart\",\"updateBillingDetailsUrl\":\"\"}}}}', '[]', 'pTYvwDhctY0v', '2020-01-08 14:43:37', '2020-01-08 14:43:37', '954cfe69-a159-4aa6-a3f8-9a6c970dee0c');

-- --------------------------------------------------------

--
-- Table structure for table `matrixblocks`
--

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `matrixblocktypes`
--

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, NULL, 'app', 'Install', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'a051796c-0504-497f-b8fe-7024198c4923'),
(2, NULL, 'app', 'm150403_183908_migrations_table_changes', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '68d5a1c0-1715-46f1-a6ad-7d5e0dc5c156'),
(3, NULL, 'app', 'm150403_184247_plugins_table_changes', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'ba36425d-14cb-4e22-941e-17c0bcd33e4b'),
(4, NULL, 'app', 'm150403_184533_field_version', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '9b5b4289-97fa-4ebf-bed3-821f808352a4'),
(5, NULL, 'app', 'm150403_184729_type_columns', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '6dd1ae01-637b-4d0b-93bd-7499d436d549'),
(6, NULL, 'app', 'm150403_185142_volumes', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '8c183cfa-e70f-498b-ab7a-09fa84e5cafb'),
(7, NULL, 'app', 'm150428_231346_userpreferences', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'cb68b936-7bd8-4b26-a68e-d5e9d7754ca3'),
(8, NULL, 'app', 'm150519_150900_fieldversion_conversion', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '4894ed2d-4de2-40b2-bd56-0f2b1c92fcd1'),
(9, NULL, 'app', 'm150617_213829_update_email_settings', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'e4d47c60-961a-4e24-8eb7-1f2c12fbdde3'),
(10, NULL, 'app', 'm150721_124739_templatecachequeries', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '81a8775f-ef2a-43e4-aa54-63a5c8040de6'),
(11, NULL, 'app', 'm150724_140822_adjust_quality_settings', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '85da1b64-e74f-4065-9303-e4b3dfb8c2f9'),
(12, NULL, 'app', 'm150815_133521_last_login_attempt_ip', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '28e47f98-37be-4656-9bc8-8c9eb0d8c797'),
(13, NULL, 'app', 'm151002_095935_volume_cache_settings', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '1636ef46-3040-4fc5-9ec2-671c145cd438'),
(14, NULL, 'app', 'm151005_142750_volume_s3_storage_settings', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '71a8c93d-fee0-497c-99d1-00cf3d8b4f84'),
(15, NULL, 'app', 'm151016_133600_delete_asset_thumbnails', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', 'fdccc545-bbb8-4a58-9b78-cf79664b0c5b'),
(16, NULL, 'app', 'm151209_000000_move_logo', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-08 14:43:38', '7df2ebd5-4fbe-45fb-88d2-8d29a8f19e29'),
(17, NULL, 'app', 'm151211_000000_rename_fileId_to_assetId', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '731719da-ea1f-4824-9e70-5d801b012448'),
(18, NULL, 'app', 'm151215_000000_rename_asset_permissions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1a11db8e-f0a4-47c5-8741-2038820a34fb'),
(19, NULL, 'app', 'm160707_000001_rename_richtext_assetsource_setting', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'c992181f-cdc1-461b-9b28-3c65e0adbb4f'),
(20, NULL, 'app', 'm160708_185142_volume_hasUrls_setting', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8f5a8629-1fe7-42d3-8bf5-dfc8d0b4a26d'),
(21, NULL, 'app', 'm160714_000000_increase_max_asset_filesize', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'cbda077a-6b0e-4fab-9193-a57958049665'),
(22, NULL, 'app', 'm160727_194637_column_cleanup', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f4537a75-6c4c-4d61-90f6-0a98f6aa1d2e'),
(23, NULL, 'app', 'm160804_110002_userphotos_to_assets', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4a3d49f1-2d13-4cc7-9b29-8a7094b6d27b'),
(24, NULL, 'app', 'm160807_144858_sites', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '6826e407-3d57-4009-8174-68bbd3db02cd'),
(25, NULL, 'app', 'm160829_000000_pending_user_content_cleanup', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '725603e0-53de-4041-9858-5c167838f44e'),
(26, NULL, 'app', 'm160830_000000_asset_index_uri_increase', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2bd63096-3092-4ebc-b1ce-ccb3cf736d7b'),
(27, NULL, 'app', 'm160912_230520_require_entry_type_id', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'aaa78df3-c843-4c52-9527-6089fb2b3b71'),
(28, NULL, 'app', 'm160913_134730_require_matrix_block_type_id', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '7a9a99f2-52be-4796-a180-134c421db992'),
(29, NULL, 'app', 'm160920_174553_matrixblocks_owner_site_id_nullable', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f9068795-dd40-4f58-8ad7-70ce801409db'),
(30, NULL, 'app', 'm160920_231045_usergroup_handle_title_unique', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'bdafebf7-488d-45bf-a2ca-e197abe499f2'),
(31, NULL, 'app', 'm160925_113941_route_uri_parts', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '5ed5640c-2ca7-4db2-89dc-0e3d48208534'),
(32, NULL, 'app', 'm161006_205918_schemaVersion_not_null', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9820cdf9-14e2-4767-918b-91da15e0d7fc'),
(33, NULL, 'app', 'm161007_130653_update_email_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4f258db0-cd23-47ad-ab4d-f5dd8d174c65'),
(34, NULL, 'app', 'm161013_175052_newParentId', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b9ea67cd-0478-4486-b121-7c688b21b1b9'),
(35, NULL, 'app', 'm161021_102916_fix_recent_entries_widgets', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4e432119-5403-44db-b1c1-a068be9fdfe0'),
(36, NULL, 'app', 'm161021_182140_rename_get_help_widget', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '7db831d1-9e65-4ee4-a64a-945d2319610f'),
(37, NULL, 'app', 'm161025_000000_fix_char_columns', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'cb15d1e6-12ae-4c11-b1f0-49ff0ddbf9f2'),
(38, NULL, 'app', 'm161029_124145_email_message_languages', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1064efc9-56a1-4529-9e8b-eb40a90caec2'),
(39, NULL, 'app', 'm161108_000000_new_version_format', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd4f31122-dec9-4aa3-9521-fe73746390b6'),
(40, NULL, 'app', 'm161109_000000_index_shuffle', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a9931732-280e-4be0-8ecc-ea4865005494'),
(41, NULL, 'app', 'm161122_185500_no_craft_app', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'fe266f8f-26c2-4c0f-bd69-7207c8735546'),
(42, NULL, 'app', 'm161125_150752_clear_urlmanager_cache', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '3edf748c-8f4c-4c94-800c-c6eb25191de9'),
(43, NULL, 'app', 'm161220_000000_volumes_hasurl_notnull', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '74d1c398-0de6-4524-b689-ae2eda3385bf'),
(44, NULL, 'app', 'm170114_161144_udates_permission', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '475916f1-d985-4766-85b5-c50c8bc54d1d'),
(45, NULL, 'app', 'm170120_000000_schema_cleanup', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8ce108ea-28f2-4130-a858-02e931b72fed'),
(46, NULL, 'app', 'm170126_000000_assets_focal_point', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '06d1a83f-bbec-40a7-9d39-3d3cb9b39f79'),
(47, NULL, 'app', 'm170206_142126_system_name', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '793c8d68-ca10-4ccd-9b17-fe81cba5da09'),
(48, NULL, 'app', 'm170217_044740_category_branch_limits', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b8e57356-9cae-42cc-9f2e-2f5d9cefd3bf'),
(49, NULL, 'app', 'm170217_120224_asset_indexing_columns', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'e6f28418-04c5-4f3c-b015-554de31f917b'),
(50, NULL, 'app', 'm170223_224012_plain_text_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4eb6673b-a927-40c4-9585-56b7c2c96a2c'),
(51, NULL, 'app', 'm170227_120814_focal_point_percentage', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'e08e3852-524e-4585-849c-d9700ef71e00'),
(52, NULL, 'app', 'm170228_171113_system_messages', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '44fc38b1-a179-4315-8dab-8e6fecb143b9'),
(53, NULL, 'app', 'm170303_140500_asset_field_source_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '15fa530a-0450-4693-a88c-d1c0a0b278ba'),
(54, NULL, 'app', 'm170306_150500_asset_temporary_uploads', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b4df57f0-a880-416f-a139-b239e0c230ed'),
(55, NULL, 'app', 'm170523_190652_element_field_layout_ids', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f65af5ea-02e1-4684-8a10-7dab92733616'),
(56, NULL, 'app', 'm170612_000000_route_index_shuffle', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'db161d3e-cdf3-4011-836d-daab4f009cb2'),
(57, NULL, 'app', 'm170621_195237_format_plugin_handles', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '6feda825-5901-4b76-a0f1-6007804a29e9'),
(58, NULL, 'app', 'm170630_161027_deprecation_line_nullable', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '937586a8-15eb-4360-9729-614ff744f430'),
(59, NULL, 'app', 'm170630_161028_deprecation_changes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2b8f4536-f9e5-4c47-bdbd-b44fe5070f3d'),
(60, NULL, 'app', 'm170703_181539_plugins_table_tweaks', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'ac0efcf6-b52d-400e-acff-7cb4e68908dc'),
(61, NULL, 'app', 'm170704_134916_sites_tables', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '71f963d2-fac1-4b1c-b777-1cdbbae14166'),
(62, NULL, 'app', 'm170706_183216_rename_sequences', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a48d9c4e-67ce-4ed3-b86c-f844d6e57420'),
(63, NULL, 'app', 'm170707_094758_delete_compiled_traits', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'cdd61d82-b3f7-4551-8bc5-871201630b91'),
(64, NULL, 'app', 'm170731_190138_drop_asset_packagist', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '6ca1d82c-47fe-4564-a4ab-af366520355d'),
(65, NULL, 'app', 'm170810_201318_create_queue_table', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '5267317d-a27f-4ac6-b3fc-648352cb3062'),
(66, NULL, 'app', 'm170816_133741_delete_compiled_behaviors', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '5bf3b0ac-ff50-4b08-b412-7151fc64e908'),
(67, NULL, 'app', 'm170903_192801_longblob_for_queue_jobs', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '087d7c4e-c81b-4c10-a4cf-1cb479af5504'),
(68, NULL, 'app', 'm170914_204621_asset_cache_shuffle', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '0d1d462b-9185-4380-9ba3-0352e68633a1'),
(69, NULL, 'app', 'm171011_214115_site_groups', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd5fc7e97-4f91-47ed-b414-c3700da10870'),
(70, NULL, 'app', 'm171012_151440_primary_site', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '0667ceb7-aafb-4181-ba65-09ec26bb4794'),
(71, NULL, 'app', 'm171013_142500_transform_interlace', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9d12eae5-d57d-4e18-bef2-f8679f807244'),
(72, NULL, 'app', 'm171016_092553_drop_position_select', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b1011648-a9a9-45c5-bacf-9d3a0545e205'),
(73, NULL, 'app', 'm171016_221244_less_strict_translation_method', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2d1a4cb7-59b4-41ba-801b-76e618f218e7'),
(74, NULL, 'app', 'm171107_000000_assign_group_permissions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '6bd5f426-2364-493c-b250-2e5dbacf41c6'),
(75, NULL, 'app', 'm171117_000001_templatecache_index_tune', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '3effa958-72db-4afb-a0ce-d4687a96f002'),
(76, NULL, 'app', 'm171126_105927_disabled_plugins', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '75dfb235-a2a7-4019-85c4-155c4e534d61'),
(77, NULL, 'app', 'm171130_214407_craftidtokens_table', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8751a66f-1f92-4b65-8610-bbbabd1a6f8e'),
(78, NULL, 'app', 'm171202_004225_update_email_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '537728a1-3f98-4436-81b1-4a97087e974b'),
(79, NULL, 'app', 'm171204_000001_templatecache_index_tune_deux', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1b5243bb-597d-454f-a92e-1babea03cae2'),
(80, NULL, 'app', 'm171205_130908_remove_craftidtokens_refreshtoken_column', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'df4ff9ea-d99a-4089-b563-cc9d52821d51'),
(81, NULL, 'app', 'm171218_143135_longtext_query_column', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9e8a31c0-6e4a-4846-a8a6-4ef375f64b80'),
(82, NULL, 'app', 'm171231_055546_environment_variables_to_aliases', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'fdeb8534-6f98-4782-8cb4-6d3f11442008'),
(83, NULL, 'app', 'm180113_153740_drop_users_archived_column', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd4fd840d-e70f-471a-956e-8a2fe09151c0'),
(84, NULL, 'app', 'm180122_213433_propagate_entries_setting', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f8001b7e-f22f-4642-a551-ef974bfefac0'),
(85, NULL, 'app', 'm180124_230459_fix_propagate_entries_values', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f3165882-1ae6-459c-ab2d-b473dc6163ea'),
(86, NULL, 'app', 'm180128_235202_set_tag_slugs', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'c1f1cb29-8de3-4062-b9ee-c43d16a5ee7b'),
(87, NULL, 'app', 'm180202_185551_fix_focal_points', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '5b98a6eb-f6aa-4796-8279-29396a004c30'),
(88, NULL, 'app', 'm180217_172123_tiny_ints', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1fae20a4-657d-4ae2-8c35-3cc72fc296e0'),
(89, NULL, 'app', 'm180321_233505_small_ints', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '7fc3ffbd-7d46-4c48-9885-73fe30856bf7'),
(90, NULL, 'app', 'm180328_115523_new_license_key_statuses', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b8a873cd-b368-4e45-8719-e6f223ed84f8'),
(91, NULL, 'app', 'm180404_182320_edition_changes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '98c2b638-23dd-4c5b-886c-72189e609ddf'),
(92, NULL, 'app', 'm180411_102218_fix_db_routes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1d70cf58-e69c-4977-ab6d-eddf68e5d1a7'),
(93, NULL, 'app', 'm180416_205628_resourcepaths_table', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '59aab1f7-a49e-4c7e-bdce-49479ffd6bed'),
(94, NULL, 'app', 'm180418_205713_widget_cleanup', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '49b0d517-ea4f-4e6e-ba19-58519f248fb4'),
(95, NULL, 'app', 'm180425_203349_searchable_fields', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '7cb15ff3-bb73-4073-93de-a36bf10c1367'),
(96, NULL, 'app', 'm180516_153000_uids_in_field_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f6029e6d-bca2-4463-bfb8-1902f37ee556'),
(97, NULL, 'app', 'm180517_173000_user_photo_volume_to_uid', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8d4ed18a-9710-4d62-98eb-35ada007b301'),
(98, NULL, 'app', 'm180518_173000_permissions_to_uid', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4912e020-3751-4776-aa78-685f77bfb045'),
(99, NULL, 'app', 'm180520_173000_matrix_context_to_uids', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f61f76d0-7bb4-4ffc-a1b3-780cd66fd49f'),
(100, NULL, 'app', 'm180521_173000_initial_yml_and_snapshot', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '250cb3ca-290a-46e6-8717-6eec98055673'),
(101, NULL, 'app', 'm180731_162030_soft_delete_sites', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '1a371605-2349-434c-b915-f2eebd37f94c'),
(102, NULL, 'app', 'm180810_214427_soft_delete_field_layouts', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'baa7de86-d981-45e0-8732-852698ce8fa7'),
(103, NULL, 'app', 'm180810_214439_soft_delete_elements', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'b60af8b9-4324-4106-9589-4adc9dd3a04c'),
(104, NULL, 'app', 'm180824_193422_case_sensitivity_fixes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9f737add-6bc7-4ae0-bfba-4b8a00988883'),
(105, NULL, 'app', 'm180901_151639_fix_matrixcontent_tables', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd92fb421-6fed-4fd2-ae53-a2aacf44a79c'),
(106, NULL, 'app', 'm180904_112109_permission_changes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4c616e52-9673-482f-9bbb-bf0ad32ec2ad'),
(107, NULL, 'app', 'm180910_142030_soft_delete_sitegroups', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '85d4e4bd-a8d1-447b-899c-d07a3e93595c'),
(108, NULL, 'app', 'm181011_160000_soft_delete_asset_support', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd388c9cf-8bf5-438a-87cd-c7f0a7f07dda'),
(109, NULL, 'app', 'm181016_183648_set_default_user_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '3e3edc66-1821-48ef-b930-3b356081b13c'),
(110, NULL, 'app', 'm181017_225222_system_config_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a75d3d5a-fb48-4ae2-a8fa-287e0fd2adb3'),
(111, NULL, 'app', 'm181018_222343_drop_userpermissions_from_config', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '6e2714be-c98c-491d-9b38-b9b1ce55e84a'),
(112, NULL, 'app', 'm181029_130000_add_transforms_routes_to_config', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '654c65c0-7449-4e1c-818e-7080fefc6af7'),
(113, NULL, 'app', 'm181112_203955_sequences_table', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd47614c9-541c-4960-baf9-9e985bf95a11'),
(114, NULL, 'app', 'm181121_001712_cleanup_field_configs', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '714757e8-2050-4067-903d-46c963742b45'),
(115, NULL, 'app', 'm181128_193942_fix_project_config', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'ee0ff2fb-c361-4ad6-8897-997f55e137fd'),
(116, NULL, 'app', 'm181130_143040_fix_schema_version', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '4900e420-15bd-42c4-81ee-62129c47c30d'),
(117, NULL, 'app', 'm181211_143040_fix_entry_type_uids', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f7f5939c-2f1b-4048-8ec1-258eea300256'),
(118, NULL, 'app', 'm181213_102500_config_map_aliases', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '0a0d9152-0ca7-4662-9037-fd4861c905e2'),
(119, NULL, 'app', 'm181217_153000_fix_structure_uids', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'c661e67e-5ef0-4ef7-8486-e16bb183a6cb'),
(120, NULL, 'app', 'm190104_152725_store_licensed_plugin_editions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'cd79a739-cfc5-4511-863f-62e955918dfc'),
(121, NULL, 'app', 'm190108_110000_cleanup_project_config', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '61208035-77a8-481a-ad96-bdcffe9ca135'),
(122, NULL, 'app', 'm190108_113000_asset_field_setting_change', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'dce689ae-1287-4072-a12f-b39172231b31'),
(123, NULL, 'app', 'm190109_172845_fix_colspan', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '0d5df3fc-9467-4d5b-a03a-c68482c999d3'),
(124, NULL, 'app', 'm190110_150000_prune_nonexisting_sites', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a904c13a-dc29-401f-915a-83730604b3f0'),
(125, NULL, 'app', 'm190110_214819_soft_delete_volumes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f2879f32-c731-421f-a127-4f2c0a549bf6'),
(126, NULL, 'app', 'm190112_124737_fix_user_settings', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a9baa7c7-f787-469b-989d-60916545481d'),
(127, NULL, 'app', 'm190112_131225_fix_field_layouts', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'edea604d-1d73-4de0-be12-1d8d8f5bc965'),
(128, NULL, 'app', 'm190112_201010_more_soft_deletes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'c0006199-8f4c-488c-9f3b-971d53497d53'),
(129, NULL, 'app', 'm190114_143000_more_asset_field_setting_changes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '237ebb6d-413d-41ec-b57b-48c5393310ea'),
(130, NULL, 'app', 'm190121_120000_rich_text_config_setting', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'dd72ea4e-3b1a-4b15-9025-2841d98cccd0'),
(131, NULL, 'app', 'm190125_191628_fix_email_transport_password', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '0009b71e-7acd-4c32-b1c4-ba361d6aa42a'),
(132, NULL, 'app', 'm190128_181422_cleanup_volume_folders', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd70ed424-f682-4b1e-8cf2-d058b3fe7a98'),
(133, NULL, 'app', 'm190205_140000_fix_asset_soft_delete_index', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'c983f7f2-ac5f-427f-84de-2506e3f78a96'),
(134, NULL, 'app', 'm190208_140000_reset_project_config_mapping', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8c9f0d05-6af9-4d6e-8e87-38a27ee2e7cb'),
(135, NULL, 'app', 'm190218_143000_element_index_settings_uid', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '47e1f3a5-99b7-4716-b30b-ca6931f3da2e'),
(136, NULL, 'app', 'm190312_152740_element_revisions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'edc34fca-cf35-4d3d-861b-c2c103761deb'),
(137, NULL, 'app', 'm190327_235137_propagation_method', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '25ca1d7d-cba3-4278-a411-bd9b321b0d9f'),
(138, NULL, 'app', 'm190401_223843_drop_old_indexes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd2bef72f-4dab-4263-a1eb-63901e49af26'),
(139, NULL, 'app', 'm190416_014525_drop_unique_global_indexes', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f0eca994-041f-4e6c-a6b5-a192e0208f49'),
(140, NULL, 'app', 'm190417_085010_add_image_editor_permissions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'fc788ce1-d336-4bd5-bb2f-5a6adef01292'),
(141, NULL, 'app', 'm190502_122019_store_default_user_group_uid', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '05b0cbae-2d93-4871-b2ca-b3ab8096d744'),
(142, NULL, 'app', 'm190504_150349_preview_targets', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9cad2e20-ac1e-4d87-80f7-11db9e129e94'),
(143, NULL, 'app', 'm190516_184711_job_progress_label', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9e94b4af-2f00-4a2f-9554-f48dad7e3144'),
(144, NULL, 'app', 'm190523_190303_optional_revision_creators', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '68f523f3-b156-41d6-a317-598db0e86943'),
(145, NULL, 'app', 'm190529_204501_fix_duplicate_uids', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'a77a84d5-7584-4b42-b026-6f4adffdd538'),
(146, NULL, 'app', 'm190605_223807_unsaved_drafts', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '9afc24d8-df9a-47af-b334-19bbceb89c94'),
(147, NULL, 'app', 'm190607_230042_entry_revision_error_tables', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '93a8c039-6e41-4ece-a54d-42d797881abc'),
(148, NULL, 'app', 'm190608_033429_drop_elements_uid_idx', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'f03da116-c2e7-44bd-b601-27e525dd7f84'),
(149, NULL, 'app', 'm190617_164400_add_gqlschemas_table', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '8e705223-0bcb-4d02-93e3-7fe6fd89bc46'),
(150, NULL, 'app', 'm190624_234204_matrix_propagation_method', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '80602527-8cf4-4b64-8e9f-42bfaa018e8b'),
(151, NULL, 'app', 'm190711_153020_drop_snapshots', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd12c2963-6f24-4263-9b34-94457875e633'),
(152, NULL, 'app', 'm190712_195914_no_draft_revisions', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '84f8d89d-617c-44e1-b667-56df8ddece02'),
(153, NULL, 'app', 'm190723_140314_fix_preview_targets_column', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', 'd096fcef-f2ca-46e1-950d-bb77c0d1127e'),
(154, NULL, 'app', 'm190820_003519_flush_compiled_templates', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '32414acf-7b2d-43c1-bba4-1144d75b58a3'),
(155, NULL, 'app', 'm190823_020339_optional_draft_creators', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '2020-01-08 14:43:39', '420ab9ef-66a8-41e7-a69a-51014d569627'),
(156, 1, 'plugin', 'Install', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '3254e626-3fae-4198-a485-01d32492c6b8'),
(157, 1, 'plugin', 'm160531_154500_craft3_upgrade', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '46e51bf2-13c3-4685-a6e3-1b1a64fa68e5'),
(158, 1, 'plugin', 'm170616_154500_productTypeSites_upgrade', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '1322dca7-1540-4997-803e-2f17660e89a4'),
(159, 1, 'plugin', 'm170705_154500_i18n_to_sites', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c489de04-b589-4885-b939-ec3137cef1fc'),
(160, 1, 'plugin', 'm170705_155000_order_shippingmethod_to_shippingmethodhandle', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'bc70c53a-7c44-4117-b4da-1422302e51b3'),
(161, 1, 'plugin', 'm170718_150000_paymentmethod_class_to_type', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'eec7b4aa-57ab-4ea6-944e-599d72a7df85'),
(162, 1, 'plugin', 'm170725_130000_paymentmethods_are_now_gateways', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e3926b24-a2de-4e49-88a9-10cd752c0741'),
(163, 1, 'plugin', 'm170810_130000_sendCartInfo_per_gateway', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '360d806b-7fbb-48d5-8d96-3098179116c3'),
(164, 1, 'plugin', 'm170828_130000_transaction_gatewayProcessing_flag', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'dee969f2-deb9-49b0-8eeb-55249bd99440'),
(165, 1, 'plugin', 'm170830_130000_order_refactor', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '71cb2f70-9e2e-4bdc-9bce-5b9a13976978'),
(166, 1, 'plugin', 'm170831_130000_paymentCurreny_primary_not_null', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c70568d9-6481-4ae9-8161-091e335f2025'),
(167, 1, 'plugin', 'm170904_130000_processing_transactions', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '64911a0a-d7aa-413a-88e4-fae0bb661457'),
(168, 1, 'plugin', 'm171010_170000_stock_location', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'bc8751b9-a892-458b-a550-5566a41cb6b0'),
(169, 1, 'plugin', 'm171202_180000_promotions_for_all_purchasables', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e7543b98-dd90-422c-9d52-f8caff3f5324'),
(170, 1, 'plugin', 'm171204_213000_payment_sources', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e1f8d116-41bf-4c0b-9176-abded241e8fb'),
(171, 1, 'plugin', 'm171207_160000_order_can_store_payment_sources', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '6f184965-c70b-44f4-90ad-0c749721f19a'),
(172, 1, 'plugin', 'm171221_120000_subscriptions', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b3074ad1-7808-4059-8ef5-13829f8aca49'),
(173, 1, 'plugin', 'm171221_120500_missing_indexes', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'd18f8dfe-b50a-479a-a1c9-2db21818f1ea'),
(174, 1, 'plugin', 'm180205_150646_create_state_abbreviation_index', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c62e3cd2-3a58-4ac7-90c7-ed07457ceb4b'),
(175, 1, 'plugin', 'm180209_115000_plan_description', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2dd14967-a710-4715-bd2d-64925f7bc45d'),
(176, 1, 'plugin', 'm180216_130000_rename_store_location', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '8f370282-acfa-4131-8c8d-85685bfe070a'),
(177, 1, 'plugin', 'm180217_130000_sale_migration', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c7111b5d-d825-4c0c-a234-68d55b1f8ec3'),
(178, 1, 'plugin', 'm180218_130000_sale_order', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '3347ba5c-d686-46fe-9deb-8c9881109bd1'),
(179, 1, 'plugin', 'm180219_130000_sale_can_stop_processing', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '4e00e3ae-ce25-4d5f-b1c2-ace27281342b'),
(180, 1, 'plugin', 'm180220_130000_sale_can_ignore_previous', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e6083b4b-119b-4ab1-8202-e25b005449c8'),
(181, 1, 'plugin', 'm180221_130000_sale_fixSort', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '5881a8b2-451f-44f1-8ad6-21c46f718cf9'),
(182, 1, 'plugin', 'm180222_130000_lineitemsubtotal', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '7527b945-f10b-4660-9636-f14e6d54a253'),
(183, 1, 'plugin', 'm180306_130000_renamed', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e197e0cf-176d-4fab-8017-355d5e06dcc2'),
(184, 1, 'plugin', 'm180307_130000_order_paid_status', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '5606fb14-2617-4c40-b259-2180adf40edb'),
(185, 1, 'plugin', 'm180308_130000_update_order_paid_status', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '6d0e3a86-2c4e-4df3-88db-7d1bf8c092f4'),
(186, 1, 'plugin', 'm180308_130001_has_and_is', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'a1bb9d9a-510e-4c59-aae2-b1b1e304ac56'),
(187, 1, 'plugin', 'm180312_130001_countryBased', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c3a6fad8-04a2-4c9c-be19-b478d23b6baa'),
(188, 1, 'plugin', 'm180319_130001_fieldSettings', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '6e55feb4-63f2-44b6-ba1e-8976796db36f'),
(189, 1, 'plugin', 'm180326_130001_cascadeDeleteVariants', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '87dc59c4-8bd8-4758-9199-27180ce6b4e7'),
(190, 1, 'plugin', 'm180329_161901_gateway_send_cart_info', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'fe53f349-4d30-4601-970b-fd3fc2f098aa'),
(191, 1, 'plugin', 'm180401_150701_primary_addresses', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'f363496f-205b-4f30-9080-7f28d71e5b6a'),
(192, 1, 'plugin', 'm180401_161901_first_last_name_optional', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '342d8302-f98f-424e-9d10-fe0f6227b530'),
(193, 1, 'plugin', 'm180402_161901_increase_size_of_snapshot', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '369901fb-fec7-46fc-90d2-01c79285aee6'),
(194, 1, 'plugin', 'm180402_161902_email_discount_usage', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'ffd22f2b-d5fe-49e2-a3fd-c6a8b3e1690a'),
(195, 1, 'plugin', 'm180402_161903_primary_customer_addresses_relations', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '78672ade-686a-4ffd-bda2-5f2553872742'),
(196, 1, 'plugin', 'm180402_161904_order_addresses_relations', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b7a47c3e-ea07-40e1-8b41-315b4c75dbbb'),
(197, 1, 'plugin', 'm180417_161904_fix_purchasables', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b4bed3d3-fb76-4c37-a34e-8732453def41'),
(198, 1, 'plugin', 'm180421_161904_transaction_note', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '087438da-809a-46f8-8f61-c4499866f2f5'),
(199, 1, 'plugin', 'm180525_161904_available_for_purchase', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2c644383-6cb4-4d55-9bff-63a68331be52'),
(200, 1, 'plugin', 'm180601_161904_fix_orderLanguage', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '57163b6b-600b-4229-83d5-7e5661a065de'),
(201, 1, 'plugin', 'm180620_161904_fix_primaryAddressCascade', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '16e7bdb6-bf0e-4494-8c00-892b7ca4aeab'),
(202, 1, 'plugin', 'm180718_161906_add_orderPdfAttachment', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '9c75e6e3-bb16-424f-ace6-a00b72e9604c'),
(203, 1, 'plugin', 'm180818_161906_fix_discountPurchasableType', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'cc90f430-5926-402c-97a5-2d5ecc31d1db'),
(204, 1, 'plugin', 'm180818_161907_fix_orderPaidWithAddresses', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '395f1bc2-f6ed-43ba-bfa7-5b9848ad3e74'),
(205, 1, 'plugin', 'm180918_161907_fix_uniqueEmailDiscountsUses', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'f9526dee-aca4-4c60-b644-e1c0fbc12a67'),
(206, 1, 'plugin', 'm180918_161908_fix_messageLengthOnOrder', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b660d74e-4f4d-41f7-a716-e7dfe862e76d'),
(207, 1, 'plugin', 'm181024_100600_gateway_project_config_support', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'f953fef9-0d9c-4178-8976-956640fe2aed'),
(208, 1, 'plugin', 'm181113_161908_addReferenceToOrder', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '6ac575a3-07ff-47bb-abd7-3a19536df2ab'),
(209, 1, 'plugin', 'm181119_100600_lite_shipping_and_tax', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '419a1ef2-fb84-4b41-9ff9-a3c1a84914cd'),
(210, 1, 'plugin', 'm181203_130000_order_status_archivable', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '8e3b04b8-ef76-4a5e-a860-a0d87cb98f8c'),
(211, 1, 'plugin', 'm181203_162000_gateway_unique_index_drop', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '65ee2d75-7759-4cad-a1e9-f6e29bcdf474'),
(212, 1, 'plugin', 'm181206_120000_remaining_project_config_support', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b5a985b7-1ba6-4f26-b85f-f440e3c14efa'),
(213, 1, 'plugin', 'm181221_120000_sort_order_for_plans', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'd8488bbb-874a-479e-91b6-2f2c8aeb6579'),
(214, 1, 'plugin', 'm190109_223402_set_edition', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e5837e66-f740-4eb5-9e6a-a6240b1fa85c'),
(215, 1, 'plugin', 'm190111_161909_lineItemTotalCanBeNegative', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'fdcb4b91-0a15-4caa-8233-d0ebe4ff1fa5'),
(216, 1, 'plugin', 'm190117_161909_replace_product_ref_tags', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2cbb30e2-32a4-4113-b306-98feec643a31'),
(217, 1, 'plugin', 'm190126_000856_restore_variants_with_products', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'a1618677-5c44-4651-9358-7108c3dae682'),
(218, 1, 'plugin', 'm190129_000857_insert_cached_data', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '8e779359-b312-4483-8675-ca6fd42baf22'),
(219, 1, 'plugin', 'm190131_000858_add_donation_purchasable', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c3a97bd0-decf-4a07-b1f1-a60020dd8bb5'),
(220, 1, 'plugin', 'm190213_000858_discount_free_shipping_changes', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b8e28d8f-f5b9-409b-b279-c2ce7c538d61'),
(221, 1, 'plugin', 'm190222_161405_permissions_to_uid', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'f5d20c48-33c0-45b5-aecd-0ae47e3e7916'),
(222, 1, 'plugin', 'm190301_161406_unique_sku_constraint_in_app', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'e3a01b67-0a70-4819-9e02-c69faf7b4a79'),
(223, 1, 'plugin', 'm190311_161910_order_total', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '8d766fd0-661c-4fc5-9d0b-b786c11544c4'),
(224, 1, 'plugin', 'm190322_161911_register_on_checkout', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '896d0203-d9a5-46bd-b149-fa9975be9f69'),
(225, 1, 'plugin', 'm190725_141100_subscription_suspension_fields', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '9fa3a0b1-0d78-48c6-829c-ec4a8b56c60d'),
(226, 1, 'plugin', 'm190821_150226_discount_purchaseTotal_update', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'd85ec159-8992-4688-9562-eaef52e84181'),
(227, 1, 'plugin', 'm190823_071838_taxCategoryId_allow_null', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'c078a97b-73b8-4ff4-be63-df746b5fca37'),
(228, 1, 'plugin', 'm190923_131716_update_overpaid_status', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '6001e9d0-e815-449f-ac7c-01fe8c372abb'),
(229, 1, 'plugin', 'm190923_132226_update_paidStatuses', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '31fc4be7-47b7-4915-a849-0e4c5a050c4d'),
(230, 1, 'plugin', 'm190924_184909_taxCategory_allow_null_postgres', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '3ed9f653-571c-48f9-8371-882f39097ebc'),
(231, 1, 'plugin', 'm191004_184910_orderPaidDate', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '71ca146d-6214-4432-aa62-f4cfdc72928d'),
(232, 1, 'plugin', 'm191007_184911_orderStatus_from_archived_to_deleted', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '39d394a4-b0a5-4fb3-b33a-1cb899530080'),
(233, 1, 'plugin', 'm191009_002748_add_ignoreSales_to_discounts', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'a36b33da-e9c4-4ed5-955b-bea6b7f54ef7'),
(234, 1, 'plugin', 'm191009_184912_zipCode_match_added_to_shipping_and_tax_address_zones', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b7b0d849-462d-4112-ad48-2aaa2e13e2a8'),
(235, 1, 'plugin', 'm191015_194704_add_description_to_orderStatus', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '17a5c623-005e-4dba-9335-d132a5fc382e'),
(236, 1, 'plugin', 'm191015_201444_add_code_to_taxRates', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'd243b4d7-1790-4f8d-b77c-f8743469c06a'),
(237, 1, 'plugin', 'm191016_231143_add_sortOrder_to_countries', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '39f104c6-279c-4705-9e53-fa75a4e54baa'),
(238, 1, 'plugin', 'm191017_183550_add_extra_address_fields', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '0f2a91c0-8d6d-4b09-9f1b-580ec3e39642'),
(239, 1, 'plugin', 'm191018_183551_cc_replyTo_emails', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '29b9139f-a368-4b53-8c5f-6dd58a0ee9c2'),
(240, 1, 'plugin', 'm191021_184436_add_estimated_fields_to_order', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '88bd882f-0b52-4c8a-bc61-5dca41535a79'),
(241, 1, 'plugin', 'm191021_190018_add_estimated_flag_to_addresses', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'ed6f26d6-bcec-49b5-830a-da71dec71fb6'),
(242, 1, 'plugin', 'm191022_162628_add_estimated_toadjustments', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2819a67b-b2d7-4078-86db-7f120186571e'),
(243, 1, 'plugin', 'm191202_220748_updated_zipCodeConditional_column_type', '2020-01-09 11:22:02', '2020-01-09 11:22:02', '2020-01-09 11:22:02', 'b16e98d4-5130-4203-bea2-a046adabfcdc');

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'commerce', '2.2.13', '2.2.1', 'invalid', NULL, '2020-01-09 11:21:28', '2020-01-09 11:21:28', '2020-01-09 12:45:39', '19004df0-306d-453e-a3a3-6c9081757a22');

-- --------------------------------------------------------

--
-- Table structure for table `queue`
--

CREATE TABLE `queue` (
  `id` int(11) NOT NULL,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) UNSIGNED NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `relations`
--

CREATE TABLE `relations` (
  `id` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `resourcepaths`
--

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `resourcepaths`
--

INSERT INTO `resourcepaths` (`hash`, `path`) VALUES
('10ebc44', '@app/web/assets/recententries/dist'),
('1179100f', '@craft/commerce/web/assets/editproduct/dist'),
('15b23e60', '@lib/selectize'),
('187d8eb7', '@app/web/assets/login/dist'),
('1fde7aea', '@lib/xregexp'),
('2021229f', '@lib/timepicker'),
('2fe1ac15', '@app/web/assets/updater/dist'),
('3e57e420', '@craft/commerce/web/assets/variantmatrix/dist'),
('3fb4fe2a', '@app/web/assets/updateswidget/dist'),
('40f68a0b', '@craft/commerce/web/assets/productindex/dist'),
('41cc13e4', '@lib/picturefill'),
('46682f26', '@lib/jquery-touch-events'),
('4f6933b5', '@lib/d3'),
('58d6c94a', '@app/web/assets/dashboard/dist'),
('5924121a', '@lib/fileupload'),
('6992f00d', '@lib/fabric'),
('77bd6e2', '@app/web/assets/pluginstore/dist'),
('7cd42433', '@lib/garnishjs'),
('7e38d958', '@app/web/assets/utilities/dist'),
('924043bb', '@lib/jquery-ui'),
('989703f2', '@lib/axios'),
('9bdb8706', '@app/web/assets/cp/dist'),
('9d859896', '@app/web/assets/plugins/dist'),
('a835a0f9', '@craft/commerce/web/assets/commercecp/dist'),
('aa324d52', '@app/web/assets/graphiql/dist'),
('ac888ef4', '@app/web/assets/generalsettings/dist'),
('ae2ea68b', '@app/web/assets/installer/dist'),
('b57ca087', '@lib/vue'),
('b6be4e24', '@app/web/assets/craftsupport/dist'),
('b93710ac', '@craft/commerce/web/assets/orderswidget/dist'),
('c0ce77f6', '@lib/jquery.payment'),
('cd662f63', '@bower/jquery/dist'),
('dce9d81e', '@lib/velocity'),
('e2c0ccb8', '@app/web/assets/feed/dist'),
('e2f68496', '@lib/element-resize-detector');

-- --------------------------------------------------------

--
-- Table structure for table `revisions`
--

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `searchindex`
--

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `searchindex`
--

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`) VALUES
(1, 'username', 0, 1, ' dale '),
(1, 'firstname', 0, 1, ''),
(1, 'lastname', 0, 1, ''),
(1, 'fullname', 0, 1, ''),
(1, 'email', 0, 1, ' dale depotise com '),
(1, 'slug', 0, 1, ''),
(2, 'slug', 0, 1, ''),
(4, 'sku', 0, 1, ' ant 001 '),
(4, 'price', 0, 1, ' 20 0000 '),
(4, 'width', 0, 1, ''),
(4, 'height', 0, 1, ''),
(4, 'length', 0, 1, ''),
(4, 'weight', 0, 1, ''),
(4, 'stock', 0, 1, ' 0 '),
(4, 'hasunlimitedstock', 0, 1, ' 1 '),
(4, 'minqty', 0, 1, ''),
(4, 'maxqty', 0, 1, ''),
(4, 'producttitle', 0, 1, ' a new toga '),
(4, 'slug', 0, 1, ' ant 001 '),
(4, 'title', 0, 1, ' a new toga '),
(3, 'defaultsku', 0, 1, ' ant 001 '),
(3, 'sku', 0, 1, ' ant 001 '),
(3, 'slug', 0, 1, ' ant 001 '),
(3, 'title', 0, 1, ' a new toga '),
(6, 'sku', 0, 1, ' psb 001 '),
(6, 'price', 0, 1, ' 30 0000 '),
(6, 'width', 0, 1, ''),
(6, 'height', 0, 1, ''),
(6, 'length', 0, 1, ''),
(6, 'weight', 0, 1, ''),
(6, 'stock', 0, 1, ' 0 '),
(6, 'hasunlimitedstock', 0, 1, ' 1 '),
(6, 'minqty', 0, 1, ''),
(6, 'maxqty', 0, 1, ''),
(6, 'producttitle', 0, 1, ' parka with stripes on back '),
(6, 'slug', 0, 1, ' psb 001 '),
(6, 'title', 0, 1, ' parka with stripes on back '),
(5, 'defaultsku', 0, 1, ' psb 001 '),
(5, 'sku', 0, 1, ' psb 001 '),
(5, 'slug', 0, 1, ' psb 001 '),
(5, 'title', 0, 1, ' parka with stripes on back '),
(8, 'sku', 0, 1, ' rre 001 '),
(8, 'price', 0, 1, ' 40 0000 '),
(8, 'width', 0, 1, ''),
(8, 'height', 0, 1, ''),
(8, 'length', 0, 1, ''),
(8, 'weight', 0, 1, ''),
(8, 'stock', 0, 1, ' 0 '),
(8, 'hasunlimitedstock', 0, 1, ' 1 '),
(8, 'minqty', 0, 1, ''),
(8, 'maxqty', 0, 1, ''),
(8, 'producttitle', 0, 1, ' romper for a red eye '),
(8, 'slug', 0, 1, ' rre 001 '),
(8, 'title', 0, 1, ' romper for a red eye '),
(7, 'defaultsku', 0, 1, ' rre 001 '),
(7, 'sku', 0, 1, ' rre 001 '),
(7, 'slug', 0, 1, ' rre 001 '),
(7, 'title', 0, 1, ' romper for a red eye '),
(10, 'sku', 0, 1, ' tfa 001 '),
(10, 'price', 0, 1, ' 50 0000 '),
(10, 'width', 0, 1, ''),
(10, 'height', 0, 1, ''),
(10, 'length', 0, 1, ''),
(10, 'weight', 0, 1, ''),
(10, 'stock', 0, 1, ' 0 '),
(10, 'hasunlimitedstock', 0, 1, ' 1 '),
(10, 'minqty', 0, 1, ''),
(10, 'maxqty', 0, 1, ''),
(10, 'producttitle', 0, 1, ' the fleece awakens '),
(10, 'slug', 0, 1, ' tfa 001 '),
(10, 'title', 0, 1, ' the fleece awakens '),
(9, 'defaultsku', 0, 1, ' tfa 001 '),
(9, 'sku', 0, 1, ' tfa 001 '),
(9, 'slug', 0, 1, ' tfa 001 '),
(9, 'title', 0, 1, ' the fleece awakens '),
(12, 'sku', 0, 1, ' lkh 001 '),
(12, 'price', 0, 1, ' 60 0000 '),
(12, 'width', 0, 1, ''),
(12, 'height', 0, 1, ''),
(12, 'length', 0, 1, ''),
(12, 'weight', 0, 1, ''),
(12, 'stock', 0, 1, ' 0 '),
(12, 'hasunlimitedstock', 0, 1, ' 1 '),
(12, 'minqty', 0, 1, ''),
(12, 'maxqty', 0, 1, ''),
(12, 'producttitle', 0, 1, ' the last knee high '),
(12, 'slug', 0, 1, ' lkh 001 '),
(12, 'title', 0, 1, ' the last knee high '),
(11, 'defaultsku', 0, 1, ' lkh 001 '),
(11, 'sku', 0, 1, ' lkh 001 '),
(11, 'slug', 0, 1, ' lkh 001 '),
(11, 'title', 0, 1, ' the last knee high '),
(15, 'sku', 0, 1, ' plywood marin '),
(13, 'slug', 0, 1, ''),
(13, 'billingfirstname', 0, 1, ''),
(13, 'billinglastname', 0, 1, ''),
(13, 'billingfullname', 0, 1, ''),
(13, 'email', 0, 1, ' dale depotise com '),
(13, 'number', 0, 1, ' f99bb09f55c2819707b316c0ffa2e6bd '),
(13, 'shippingfirstname', 0, 1, ''),
(13, 'shippinglastname', 0, 1, ''),
(13, 'shippingfullname', 0, 1, ''),
(13, 'shortnumber', 0, 1, ' f99bb09 '),
(13, 'transactionreference', 0, 1, ''),
(13, 'username', 0, 1, ' dale '),
(13, 'reference', 0, 1, ''),
(15, 'price', 0, 1, ' 880 0000 '),
(15, 'width', 0, 1, ''),
(15, 'height', 0, 1, ''),
(15, 'length', 0, 1, ''),
(15, 'weight', 0, 1, ''),
(15, 'stock', 0, 1, ' 0 '),
(15, 'hasunlimitedstock', 0, 1, ' 1 '),
(15, 'minqty', 0, 1, ''),
(15, 'maxqty', 0, 1, ''),
(15, 'producttitle', 0, 1, ' plywood '),
(15, 'slug', 0, 1, ''),
(15, 'title', 0, 1, ' marine '),
(16, 'sku', 0, 1, ' plywood thin '),
(16, 'price', 0, 1, ' 600 0000 '),
(16, 'width', 0, 1, ''),
(16, 'height', 0, 1, ''),
(16, 'length', 0, 1, ''),
(16, 'weight', 0, 1, ''),
(16, 'stock', 0, 1, ' 0 '),
(16, 'hasunlimitedstock', 0, 1, ' 1 '),
(16, 'minqty', 0, 1, ''),
(16, 'maxqty', 0, 1, ''),
(16, 'producttitle', 0, 1, ' plywood '),
(16, 'slug', 0, 1, ''),
(16, 'title', 0, 1, ' thin '),
(14, 'defaultsku', 0, 1, ' plywood marin '),
(14, 'sku', 0, 1, ' plywood marin plywood thin '),
(14, 'slug', 0, 1, ' plywood '),
(14, 'title', 0, 1, ' plywood ');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` int(11) NOT NULL,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sections_sites`
--

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sequences`
--

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(3, 1, 'gUjz7PPf9TzKfqQS0WoZKnL16V5My_zLD-8QGN9o5Uh_5YwA-_cUGzPDxi7pWurFE1N27XI8UP3y01X0ASkbZuPYWoKfew-zEFYH', '2020-01-09 10:11:51', '2020-01-09 10:47:57', '0926ab2e-fd67-49e1-8b91-74cdf0b58dfc'),
(4, 1, 'NiJEqeLcIWOsBntfm1dAh0SBZ_gQ4nOFMNIs3MalodrOvdfGQjPt2_qakwzxAVYoDE5xWPDblw01JvA4OOp1cgfxGkYYlkHDjYaO', '2020-01-09 11:02:16', '2020-01-09 12:59:31', '26917c5b-893f-408d-8663-0fbd2fcb5414');

-- --------------------------------------------------------

--
-- Table structure for table `shunnedmessages`
--

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sitegroups`
--

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sitegroups`
--

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1, 'Depotise', '2020-01-08 14:43:37', '2020-01-08 14:43:37', NULL, '739b56be-7619-489b-a794-dfd68982bb63');

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sites`
--

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1, 1, 1, 'Depotise', 'default', 'en-US', 1, '$DEFAULT_SITE_URL', 1, '2020-01-08 14:43:37', '2020-01-08 14:43:37', NULL, '4aeceeb3-e412-4462-a9f8-246dcbfcf553');

-- --------------------------------------------------------

--
-- Table structure for table `structureelements`
--

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) UNSIGNED DEFAULT NULL,
  `lft` int(11) UNSIGNED NOT NULL,
  `rgt` int(11) UNSIGNED NOT NULL,
  `level` smallint(6) UNSIGNED NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `structures`
--

CREATE TABLE `structures` (
  `id` int(11) NOT NULL,
  `maxLevels` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `systemmessages`
--

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `taggroups`
--

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `templatecacheelements`
--

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `templatecachequeries`
--

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `templatecaches`
--

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) UNSIGNED DEFAULT NULL,
  `usageCount` tinyint(3) UNSIGNED DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usergroups`
--

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usergroups_users`
--

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userpermissions`
--

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userpermissions_usergroups`
--

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userpermissions_users`
--

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userpreferences`
--

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL,
  `preferences` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userpreferences`
--

INSERT INTO `userpreferences` (`userId`, `preferences`) VALUES
(1, '{\"language\":\"en-US\"}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) UNSIGNED DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 'dale', NULL, NULL, NULL, 'dale@depotise.com', '$2y$13$FOwZ9pHzz7VehmPchohIc.iJG9z.WFdcIko7xvx4YJ5Zb9jXI5u4e', 1, 0, 0, 0, '2020-01-09 11:02:16', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, '2020-01-08 14:43:38', '2020-01-08 14:43:38', '2020-01-09 11:02:16', 'c06a254f-eccc-4f43-9829-8dcae9c25b68');

-- --------------------------------------------------------

--
-- Table structure for table `volumefolders`
--

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `volumes`
--

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `widgets`
--

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) UNSIGNED DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `widgets`
--

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1, 1, 'craft\\widgets\\RecentEntries', 1, NULL, '{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}', 1, '2020-01-08 14:43:41', '2020-01-08 14:43:41', 'fef641ad-9968-43df-be66-f0853cf26c09'),
(2, 1, 'craft\\widgets\\CraftSupport', 2, NULL, '[]', 1, '2020-01-08 14:43:41', '2020-01-08 14:43:41', '61737d1d-0ea2-4cc3-a283-a02225153339'),
(3, 1, 'craft\\widgets\\Updates', 3, NULL, '[]', 1, '2020-01-08 14:43:41', '2020-01-08 14:43:41', 'fc985ba0-3438-4de6-9ea3-3212dd4b374a'),
(4, 1, 'craft\\widgets\\Feed', 4, NULL, '{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}', 1, '2020-01-08 14:43:41', '2020-01-08 14:43:41', 'ad3d7a7f-0aca-495e-8950-9c8aa469fb40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assetindexdata`
--
ALTER TABLE `assetindexdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  ADD KEY `assetindexdata_volumeId_idx` (`volumeId`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  ADD KEY `assets_folderId_idx` (`folderId`),
  ADD KEY `assets_volumeId_idx` (`volumeId`);

--
-- Indexes for table `assettransformindex`
--
ALTER TABLE `assettransformindex`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`);

--
-- Indexes for table `assettransforms`
--
ALTER TABLE `assettransforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  ADD UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_groupId_idx` (`groupId`),
  ADD KEY `categories_parentId_fk` (`parentId`);

--
-- Indexes for table `categorygroups`
--
ALTER TABLE `categorygroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorygroups_name_idx` (`name`),
  ADD KEY `categorygroups_handle_idx` (`handle`),
  ADD KEY `categorygroups_structureId_idx` (`structureId`),
  ADD KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  ADD KEY `categorygroups_dateDeleted_idx` (`dateDeleted`);

--
-- Indexes for table `categorygroups_sites`
--
ALTER TABLE `categorygroups_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  ADD KEY `categorygroups_sites_siteId_idx` (`siteId`);

--
-- Indexes for table `commerce_addresses`
--
ALTER TABLE `commerce_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_addresses_countryId_idx` (`countryId`),
  ADD KEY `commerce_addresses_stateId_idx` (`stateId`);

--
-- Indexes for table `commerce_countries`
--
ALTER TABLE `commerce_countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_countries_name_unq_idx` (`name`),
  ADD UNIQUE KEY `commerce_countries_iso_unq_idx` (`iso`);

--
-- Indexes for table `commerce_customers`
--
ALTER TABLE `commerce_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_customers_userId_idx` (`userId`),
  ADD KEY `commerce_customers_primaryBillingAddressId_idx` (`primaryBillingAddressId`),
  ADD KEY `commerce_customers_primaryShippingAddressId_idx` (`primaryShippingAddressId`);

--
-- Indexes for table `commerce_customers_addresses`
--
ALTER TABLE `commerce_customers_addresses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_customers_addresses_customerId_addressId_unq_idx` (`customerId`,`addressId`),
  ADD KEY `commerce_customers_addresses_addressId_fk` (`addressId`);

--
-- Indexes for table `commerce_customer_discountuses`
--
ALTER TABLE `commerce_customer_discountuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_customer_discountuses_customerId_discountId_unq_idx` (`customerId`,`discountId`),
  ADD KEY `commerce_customer_discountuses_discountId_idx` (`discountId`);

--
-- Indexes for table `commerce_discounts`
--
ALTER TABLE `commerce_discounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_discounts_code_unq_idx` (`code`),
  ADD KEY `commerce_discounts_dateFrom_idx` (`dateFrom`),
  ADD KEY `commerce_discounts_dateTo_idx` (`dateTo`);

--
-- Indexes for table `commerce_discount_categories`
--
ALTER TABLE `commerce_discount_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_discount_categories_discountId_categoryId_unq_idx` (`discountId`,`categoryId`),
  ADD KEY `commerce_discount_categories_categoryId_idx` (`categoryId`);

--
-- Indexes for table `commerce_discount_purchasables`
--
ALTER TABLE `commerce_discount_purchasables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_discount_purchasables_discountId_purchasableId_unq_idx` (`discountId`,`purchasableId`),
  ADD KEY `commerce_discount_purchasables_purchasableId_idx` (`purchasableId`);

--
-- Indexes for table `commerce_discount_usergroups`
--
ALTER TABLE `commerce_discount_usergroups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_discount_usergroups_discountId_userGroupId_unq_idx` (`discountId`,`userGroupId`),
  ADD KEY `commerce_discount_usergroups_userGroupId_idx` (`userGroupId`);

--
-- Indexes for table `commerce_donations`
--
ALTER TABLE `commerce_donations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commerce_emails`
--
ALTER TABLE `commerce_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commerce_email_discountuses`
--
ALTER TABLE `commerce_email_discountuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_email_discountuses_email_discountId_unq_idx` (`email`,`discountId`),
  ADD KEY `commerce_email_discountuses_discountId_idx` (`discountId`);

--
-- Indexes for table `commerce_gateways`
--
ALTER TABLE `commerce_gateways`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_gateways_handle_idx` (`handle`),
  ADD KEY `commerce_gateways_isArchived_idx` (`isArchived`);

--
-- Indexes for table `commerce_lineitems`
--
ALTER TABLE `commerce_lineitems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_lineitems_orderId_purchasableId_optionsSignature_unq_id` (`orderId`,`purchasableId`,`optionsSignature`),
  ADD KEY `commerce_lineitems_purchasableId_idx` (`purchasableId`),
  ADD KEY `commerce_lineitems_taxCategoryId_idx` (`taxCategoryId`),
  ADD KEY `commerce_lineitems_shippingCategoryId_idx` (`shippingCategoryId`);

--
-- Indexes for table `commerce_orderadjustments`
--
ALTER TABLE `commerce_orderadjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_orderadjustments_orderId_idx` (`orderId`);

--
-- Indexes for table `commerce_orderhistories`
--
ALTER TABLE `commerce_orderhistories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_orderhistories_orderId_idx` (`orderId`),
  ADD KEY `commerce_orderhistories_prevStatusId_idx` (`prevStatusId`),
  ADD KEY `commerce_orderhistories_newStatusId_idx` (`newStatusId`),
  ADD KEY `commerce_orderhistories_customerId_idx` (`customerId`);

--
-- Indexes for table `commerce_orders`
--
ALTER TABLE `commerce_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_orders_number_unq_idx` (`number`),
  ADD KEY `commerce_orders_reference_idx` (`reference`),
  ADD KEY `commerce_orders_billingAddressId_idx` (`billingAddressId`),
  ADD KEY `commerce_orders_shippingAddressId_idx` (`shippingAddressId`),
  ADD KEY `commerce_orders_gatewayId_idx` (`gatewayId`),
  ADD KEY `commerce_orders_customerId_idx` (`customerId`),
  ADD KEY `commerce_orders_orderStatusId_idx` (`orderStatusId`),
  ADD KEY `commerce_orders_paymentSourceId_fk` (`paymentSourceId`),
  ADD KEY `commerce_orders_estimatedShippingAddressId_fk` (`estimatedShippingAddressId`),
  ADD KEY `commerce_orders_estimatedBillingAddressId_fk` (`estimatedBillingAddressId`);

--
-- Indexes for table `commerce_orderstatuses`
--
ALTER TABLE `commerce_orderstatuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commerce_orderstatus_emails`
--
ALTER TABLE `commerce_orderstatus_emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_orderstatus_emails_orderStatusId_idx` (`orderStatusId`),
  ADD KEY `commerce_orderstatus_emails_emailId_idx` (`emailId`);

--
-- Indexes for table `commerce_paymentcurrencies`
--
ALTER TABLE `commerce_paymentcurrencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_paymentcurrencies_iso_unq_idx` (`iso`);

--
-- Indexes for table `commerce_paymentsources`
--
ALTER TABLE `commerce_paymentsources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_paymentsources_gatewayId_fk` (`gatewayId`),
  ADD KEY `commerce_paymentsources_userId_fk` (`userId`);

--
-- Indexes for table `commerce_plans`
--
ALTER TABLE `commerce_plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_plans_handle_unq_idx` (`handle`),
  ADD KEY `commerce_plans_gatewayId_idx` (`gatewayId`),
  ADD KEY `commerce_plans_reference_idx` (`reference`),
  ADD KEY `commerce_plans_planInformationId_fk` (`planInformationId`);

--
-- Indexes for table `commerce_products`
--
ALTER TABLE `commerce_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_products_typeId_idx` (`typeId`),
  ADD KEY `commerce_products_postDate_idx` (`postDate`),
  ADD KEY `commerce_products_expiryDate_idx` (`expiryDate`),
  ADD KEY `commerce_products_taxCategoryId_idx` (`taxCategoryId`),
  ADD KEY `commerce_products_shippingCategoryId_idx` (`shippingCategoryId`);

--
-- Indexes for table `commerce_producttypes`
--
ALTER TABLE `commerce_producttypes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_producttypes_handle_unq_idx` (`handle`),
  ADD KEY `commerce_producttypes_fieldLayoutId_idx` (`fieldLayoutId`),
  ADD KEY `commerce_producttypes_variantFieldLayoutId_idx` (`variantFieldLayoutId`);

--
-- Indexes for table `commerce_producttypes_shippingcategories`
--
ALTER TABLE `commerce_producttypes_shippingcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commer_productty_shippingcatego_productTyp_shippingCatego_un_id` (`productTypeId`,`shippingCategoryId`),
  ADD KEY `commerce_producttypes_shippingcategories_shippingCategoryId_idx` (`shippingCategoryId`);

--
-- Indexes for table `commerce_producttypes_sites`
--
ALTER TABLE `commerce_producttypes_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_producttypes_sites_productTypeId_siteId_unq_idx` (`productTypeId`,`siteId`),
  ADD KEY `commerce_producttypes_sites_siteId_idx` (`siteId`);

--
-- Indexes for table `commerce_producttypes_taxcategories`
--
ALTER TABLE `commerce_producttypes_taxcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerc_producttype_taxcategorie_productTypeI_taxCategoryI_unq_i` (`productTypeId`,`taxCategoryId`),
  ADD KEY `commerce_producttypes_taxcategories_taxCategoryId_idx` (`taxCategoryId`);

--
-- Indexes for table `commerce_purchasables`
--
ALTER TABLE `commerce_purchasables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_purchasables_sku_idx` (`sku`);

--
-- Indexes for table `commerce_sales`
--
ALTER TABLE `commerce_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commerce_sale_categories`
--
ALTER TABLE `commerce_sale_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_sale_categories_saleId_categoryId_unq_idx` (`saleId`,`categoryId`),
  ADD KEY `commerce_sale_categories_categoryId_idx` (`categoryId`);

--
-- Indexes for table `commerce_sale_purchasables`
--
ALTER TABLE `commerce_sale_purchasables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_sale_purchasables_saleId_purchasableId_unq_idx` (`saleId`,`purchasableId`),
  ADD KEY `commerce_sale_purchasables_purchasableId_idx` (`purchasableId`);

--
-- Indexes for table `commerce_sale_usergroups`
--
ALTER TABLE `commerce_sale_usergroups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_sale_usergroups_saleId_userGroupId_unq_idx` (`saleId`,`userGroupId`),
  ADD KEY `commerce_sale_usergroups_userGroupId_idx` (`userGroupId`);

--
-- Indexes for table `commerce_shippingcategories`
--
ALTER TABLE `commerce_shippingcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_shippingcategories_handle_unq_idx` (`handle`);

--
-- Indexes for table `commerce_shippingmethods`
--
ALTER TABLE `commerce_shippingmethods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_shippingmethods_name_unq_idx` (`name`);

--
-- Indexes for table `commerce_shippingrules`
--
ALTER TABLE `commerce_shippingrules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_shippingrules_name_idx` (`name`),
  ADD KEY `commerce_shippingrules_methodId_idx` (`methodId`),
  ADD KEY `commerce_shippingrules_shippingZoneId_idx` (`shippingZoneId`);

--
-- Indexes for table `commerce_shippingrule_categories`
--
ALTER TABLE `commerce_shippingrule_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_shippingrule_categories_shippingRuleId_idx` (`shippingRuleId`),
  ADD KEY `commerce_shippingrule_categories_shippingCategoryId_idx` (`shippingCategoryId`);

--
-- Indexes for table `commerce_shippingzones`
--
ALTER TABLE `commerce_shippingzones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_shippingzones_name_unq_idx` (`name`);

--
-- Indexes for table `commerce_shippingzone_countries`
--
ALTER TABLE `commerce_shippingzone_countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_shippingzone_countries_shippingZoneId_countryId_unq_idx` (`shippingZoneId`,`countryId`),
  ADD KEY `commerce_shippingzone_countries_shippingZoneId_idx` (`shippingZoneId`),
  ADD KEY `commerce_shippingzone_countries_countryId_idx` (`countryId`);

--
-- Indexes for table `commerce_shippingzone_states`
--
ALTER TABLE `commerce_shippingzone_states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_shippingzone_states_shippingZoneId_stateId_unq_idx` (`shippingZoneId`,`stateId`),
  ADD KEY `commerce_shippingzone_states_shippingZoneId_idx` (`shippingZoneId`),
  ADD KEY `commerce_shippingzone_states_stateId_idx` (`stateId`);

--
-- Indexes for table `commerce_states`
--
ALTER TABLE `commerce_states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_states_countryId_name_unq_idx` (`countryId`,`name`),
  ADD UNIQUE KEY `commerce_states_countryId_abbreviation_unq_idx` (`countryId`,`abbreviation`),
  ADD KEY `commerce_states_countryId_idx` (`countryId`);

--
-- Indexes for table `commerce_subscriptions`
--
ALTER TABLE `commerce_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_subscriptions_reference_unq_idx` (`reference`),
  ADD KEY `commerce_subscriptions_userId_idx` (`userId`),
  ADD KEY `commerce_subscriptions_planId_idx` (`planId`),
  ADD KEY `commerce_subscriptions_gatewayId_idx` (`gatewayId`),
  ADD KEY `commerce_subscriptions_nextPaymentDate_idx` (`nextPaymentDate`),
  ADD KEY `commerce_subscriptions_dateCreated_idx` (`dateCreated`),
  ADD KEY `commerce_subscriptions_dateExpired_idx` (`dateExpired`),
  ADD KEY `commerce_subscriptions_orderId_fk` (`orderId`);

--
-- Indexes for table `commerce_taxcategories`
--
ALTER TABLE `commerce_taxcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_taxcategories_handle_unq_idx` (`handle`);

--
-- Indexes for table `commerce_taxrates`
--
ALTER TABLE `commerce_taxrates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_taxrates_taxZoneId_idx` (`taxZoneId`),
  ADD KEY `commerce_taxrates_taxCategoryId_idx` (`taxCategoryId`);

--
-- Indexes for table `commerce_taxzones`
--
ALTER TABLE `commerce_taxzones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_taxzones_name_unq_idx` (`name`);

--
-- Indexes for table `commerce_taxzone_countries`
--
ALTER TABLE `commerce_taxzone_countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_taxzone_countries_taxZoneId_countryId_unq_idx` (`taxZoneId`,`countryId`),
  ADD KEY `commerce_taxzone_countries_taxZoneId_idx` (`taxZoneId`),
  ADD KEY `commerce_taxzone_countries_countryId_idx` (`countryId`);

--
-- Indexes for table `commerce_taxzone_states`
--
ALTER TABLE `commerce_taxzone_states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commerce_taxzone_states_taxZoneId_stateId_unq_idx` (`taxZoneId`,`stateId`),
  ADD KEY `commerce_taxzone_states_taxZoneId_idx` (`taxZoneId`),
  ADD KEY `commerce_taxzone_states_stateId_idx` (`stateId`);

--
-- Indexes for table `commerce_transactions`
--
ALTER TABLE `commerce_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_transactions_parentId_idx` (`parentId`),
  ADD KEY `commerce_transactions_gatewayId_idx` (`gatewayId`),
  ADD KEY `commerce_transactions_orderId_idx` (`orderId`),
  ADD KEY `commerce_transactions_userId_idx` (`userId`);

--
-- Indexes for table `commerce_variants`
--
ALTER TABLE `commerce_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commerce_variants_sku_idx` (`sku`),
  ADD KEY `commerce_variants_productId_idx` (`productId`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  ADD KEY `content_siteId_idx` (`siteId`),
  ADD KEY `content_title_idx` (`title`);

--
-- Indexes for table `craftidtokens`
--
ALTER TABLE `craftidtokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `craftidtokens_userId_fk` (`userId`);

--
-- Indexes for table `deprecationerrors`
--
ALTER TABLE `deprecationerrors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`);

--
-- Indexes for table `drafts`
--
ALTER TABLE `drafts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `drafts_creatorId_fk` (`creatorId`),
  ADD KEY `drafts_sourceId_fk` (`sourceId`);

--
-- Indexes for table `elementindexsettings`
--
ALTER TABLE `elementindexsettings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`);

--
-- Indexes for table `elements`
--
ALTER TABLE `elements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `elements_dateDeleted_idx` (`dateDeleted`),
  ADD KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  ADD KEY `elements_type_idx` (`type`),
  ADD KEY `elements_enabled_idx` (`enabled`),
  ADD KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  ADD KEY `elements_draftId_fk` (`draftId`),
  ADD KEY `elements_revisionId_fk` (`revisionId`);

--
-- Indexes for table `elements_sites`
--
ALTER TABLE `elements_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  ADD KEY `elements_sites_siteId_idx` (`siteId`),
  ADD KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  ADD KEY `elements_sites_enabled_idx` (`enabled`),
  ADD KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`);

--
-- Indexes for table `entries`
--
ALTER TABLE `entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entries_postDate_idx` (`postDate`),
  ADD KEY `entries_expiryDate_idx` (`expiryDate`),
  ADD KEY `entries_authorId_idx` (`authorId`),
  ADD KEY `entries_sectionId_idx` (`sectionId`),
  ADD KEY `entries_typeId_idx` (`typeId`),
  ADD KEY `entries_parentId_fk` (`parentId`);

--
-- Indexes for table `entrytypes`
--
ALTER TABLE `entrytypes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  ADD KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  ADD KEY `entrytypes_sectionId_idx` (`sectionId`),
  ADD KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  ADD KEY `entrytypes_dateDeleted_idx` (`dateDeleted`);

--
-- Indexes for table `fieldgroups`
--
ALTER TABLE `fieldgroups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fieldgroups_name_unq_idx` (`name`);

--
-- Indexes for table `fieldlayoutfields`
--
ALTER TABLE `fieldlayoutfields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  ADD KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  ADD KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  ADD KEY `fieldlayoutfields_fieldId_idx` (`fieldId`);

--
-- Indexes for table `fieldlayouts`
--
ALTER TABLE `fieldlayouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  ADD KEY `fieldlayouts_type_idx` (`type`);

--
-- Indexes for table `fieldlayouttabs`
--
ALTER TABLE `fieldlayouttabs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  ADD KEY `fieldlayouttabs_layoutId_idx` (`layoutId`);

--
-- Indexes for table `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  ADD KEY `fields_groupId_idx` (`groupId`),
  ADD KEY `fields_context_idx` (`context`);

--
-- Indexes for table `globalsets`
--
ALTER TABLE `globalsets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `globalsets_name_idx` (`name`),
  ADD KEY `globalsets_handle_idx` (`handle`),
  ADD KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`);

--
-- Indexes for table `gqlschemas`
--
ALTER TABLE `gqlschemas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gqlschemas_accessToken_unq_idx` (`accessToken`),
  ADD UNIQUE KEY `gqlschemas_name_unq_idx` (`name`);

--
-- Indexes for table `info`
--
ALTER TABLE `info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `matrixblocks`
--
ALTER TABLE `matrixblocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matrixblocks_ownerId_idx` (`ownerId`),
  ADD KEY `matrixblocks_fieldId_idx` (`fieldId`),
  ADD KEY `matrixblocks_typeId_idx` (`typeId`),
  ADD KEY `matrixblocks_sortOrder_idx` (`sortOrder`);

--
-- Indexes for table `matrixblocktypes`
--
ALTER TABLE `matrixblocktypes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  ADD UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  ADD KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  ADD KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `migrations_pluginId_idx` (`pluginId`),
  ADD KEY `migrations_type_pluginId_idx` (`type`,`pluginId`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plugins_handle_unq_idx` (`handle`);

--
-- Indexes for table `queue`
--
ALTER TABLE `queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  ADD KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`);

--
-- Indexes for table `relations`
--
ALTER TABLE `relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  ADD KEY `relations_sourceId_idx` (`sourceId`),
  ADD KEY `relations_targetId_idx` (`targetId`),
  ADD KEY `relations_sourceSiteId_idx` (`sourceSiteId`);

--
-- Indexes for table `resourcepaths`
--
ALTER TABLE `resourcepaths`
  ADD PRIMARY KEY (`hash`);

--
-- Indexes for table `revisions`
--
ALTER TABLE `revisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  ADD KEY `revisions_creatorId_fk` (`creatorId`);

--
-- Indexes for table `searchindex`
--
ALTER TABLE `searchindex`
  ADD PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`);
ALTER TABLE `searchindex` ADD FULLTEXT KEY `searchindex_keywords_idx` (`keywords`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sections_handle_idx` (`handle`),
  ADD KEY `sections_name_idx` (`name`),
  ADD KEY `sections_structureId_idx` (`structureId`),
  ADD KEY `sections_dateDeleted_idx` (`dateDeleted`);

--
-- Indexes for table `sections_sites`
--
ALTER TABLE `sections_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  ADD KEY `sections_sites_siteId_idx` (`siteId`);

--
-- Indexes for table `sequences`
--
ALTER TABLE `sequences`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_uid_idx` (`uid`),
  ADD KEY `sessions_token_idx` (`token`),
  ADD KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  ADD KEY `sessions_userId_idx` (`userId`);

--
-- Indexes for table `shunnedmessages`
--
ALTER TABLE `shunnedmessages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`);

--
-- Indexes for table `sitegroups`
--
ALTER TABLE `sitegroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sitegroups_name_idx` (`name`);

--
-- Indexes for table `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sites_dateDeleted_idx` (`dateDeleted`),
  ADD KEY `sites_handle_idx` (`handle`),
  ADD KEY `sites_sortOrder_idx` (`sortOrder`),
  ADD KEY `sites_groupId_fk` (`groupId`);

--
-- Indexes for table `structureelements`
--
ALTER TABLE `structureelements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  ADD KEY `structureelements_root_idx` (`root`),
  ADD KEY `structureelements_lft_idx` (`lft`),
  ADD KEY `structureelements_rgt_idx` (`rgt`),
  ADD KEY `structureelements_level_idx` (`level`),
  ADD KEY `structureelements_elementId_idx` (`elementId`);

--
-- Indexes for table `structures`
--
ALTER TABLE `structures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `structures_dateDeleted_idx` (`dateDeleted`);

--
-- Indexes for table `systemmessages`
--
ALTER TABLE `systemmessages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  ADD KEY `systemmessages_language_idx` (`language`);

--
-- Indexes for table `taggroups`
--
ALTER TABLE `taggroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taggroups_name_idx` (`name`),
  ADD KEY `taggroups_handle_idx` (`handle`),
  ADD KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  ADD KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tags_groupId_idx` (`groupId`);

--
-- Indexes for table `templatecacheelements`
--
ALTER TABLE `templatecacheelements`
  ADD KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  ADD KEY `templatecacheelements_elementId_idx` (`elementId`);

--
-- Indexes for table `templatecachequeries`
--
ALTER TABLE `templatecachequeries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  ADD KEY `templatecachequeries_type_idx` (`type`);

--
-- Indexes for table `templatecaches`
--
ALTER TABLE `templatecaches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  ADD KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  ADD KEY `templatecaches_siteId_idx` (`siteId`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_token_unq_idx` (`token`),
  ADD KEY `tokens_expiryDate_idx` (`expiryDate`);

--
-- Indexes for table `usergroups`
--
ALTER TABLE `usergroups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  ADD UNIQUE KEY `usergroups_name_unq_idx` (`name`);

--
-- Indexes for table `usergroups_users`
--
ALTER TABLE `usergroups_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  ADD KEY `usergroups_users_userId_idx` (`userId`);

--
-- Indexes for table `userpermissions`
--
ALTER TABLE `userpermissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userpermissions_name_unq_idx` (`name`);

--
-- Indexes for table `userpermissions_usergroups`
--
ALTER TABLE `userpermissions_usergroups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  ADD KEY `userpermissions_usergroups_groupId_idx` (`groupId`);

--
-- Indexes for table `userpermissions_users`
--
ALTER TABLE `userpermissions_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  ADD KEY `userpermissions_users_userId_idx` (`userId`);

--
-- Indexes for table `userpreferences`
--
ALTER TABLE `userpreferences`
  ADD PRIMARY KEY (`userId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_uid_idx` (`uid`),
  ADD KEY `users_verificationCode_idx` (`verificationCode`),
  ADD KEY `users_email_idx` (`email`),
  ADD KEY `users_username_idx` (`username`),
  ADD KEY `users_photoId_fk` (`photoId`);

--
-- Indexes for table `volumefolders`
--
ALTER TABLE `volumefolders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  ADD KEY `volumefolders_parentId_idx` (`parentId`),
  ADD KEY `volumefolders_volumeId_idx` (`volumeId`);

--
-- Indexes for table `volumes`
--
ALTER TABLE `volumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `volumes_name_idx` (`name`),
  ADD KEY `volumes_handle_idx` (`handle`),
  ADD KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  ADD KEY `volumes_dateDeleted_idx` (`dateDeleted`);

--
-- Indexes for table `widgets`
--
ALTER TABLE `widgets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `widgets_userId_idx` (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assetindexdata`
--
ALTER TABLE `assetindexdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assettransformindex`
--
ALTER TABLE `assettransformindex`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assettransforms`
--
ALTER TABLE `assettransforms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categorygroups`
--
ALTER TABLE `categorygroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categorygroups_sites`
--
ALTER TABLE `categorygroups_sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_addresses`
--
ALTER TABLE `commerce_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_countries`
--
ALTER TABLE `commerce_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT for table `commerce_customers`
--
ALTER TABLE `commerce_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_customers_addresses`
--
ALTER TABLE `commerce_customers_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_customer_discountuses`
--
ALTER TABLE `commerce_customer_discountuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_discounts`
--
ALTER TABLE `commerce_discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_discount_categories`
--
ALTER TABLE `commerce_discount_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_discount_purchasables`
--
ALTER TABLE `commerce_discount_purchasables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_discount_usergroups`
--
ALTER TABLE `commerce_discount_usergroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_donations`
--
ALTER TABLE `commerce_donations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commerce_emails`
--
ALTER TABLE `commerce_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_email_discountuses`
--
ALTER TABLE `commerce_email_discountuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_gateways`
--
ALTER TABLE `commerce_gateways`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_lineitems`
--
ALTER TABLE `commerce_lineitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_orderadjustments`
--
ALTER TABLE `commerce_orderadjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_orderhistories`
--
ALTER TABLE `commerce_orderhistories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_orderstatuses`
--
ALTER TABLE `commerce_orderstatuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commerce_orderstatus_emails`
--
ALTER TABLE `commerce_orderstatus_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_paymentcurrencies`
--
ALTER TABLE `commerce_paymentcurrencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commerce_paymentsources`
--
ALTER TABLE `commerce_paymentsources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_plans`
--
ALTER TABLE `commerce_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_producttypes`
--
ALTER TABLE `commerce_producttypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commerce_producttypes_shippingcategories`
--
ALTER TABLE `commerce_producttypes_shippingcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_producttypes_sites`
--
ALTER TABLE `commerce_producttypes_sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `commerce_producttypes_taxcategories`
--
ALTER TABLE `commerce_producttypes_taxcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_sales`
--
ALTER TABLE `commerce_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_sale_categories`
--
ALTER TABLE `commerce_sale_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_sale_purchasables`
--
ALTER TABLE `commerce_sale_purchasables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_sale_usergroups`
--
ALTER TABLE `commerce_sale_usergroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_shippingcategories`
--
ALTER TABLE `commerce_shippingcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_shippingmethods`
--
ALTER TABLE `commerce_shippingmethods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_shippingrules`
--
ALTER TABLE `commerce_shippingrules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_shippingrule_categories`
--
ALTER TABLE `commerce_shippingrule_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_shippingzones`
--
ALTER TABLE `commerce_shippingzones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_shippingzone_countries`
--
ALTER TABLE `commerce_shippingzone_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_shippingzone_states`
--
ALTER TABLE `commerce_shippingzone_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_states`
--
ALTER TABLE `commerce_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `commerce_subscriptions`
--
ALTER TABLE `commerce_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_taxcategories`
--
ALTER TABLE `commerce_taxcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commerce_taxrates`
--
ALTER TABLE `commerce_taxrates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_taxzones`
--
ALTER TABLE `commerce_taxzones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_taxzone_countries`
--
ALTER TABLE `commerce_taxzone_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_taxzone_states`
--
ALTER TABLE `commerce_taxzone_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commerce_transactions`
--
ALTER TABLE `commerce_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `craftidtokens`
--
ALTER TABLE `craftidtokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deprecationerrors`
--
ALTER TABLE `deprecationerrors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drafts`
--
ALTER TABLE `drafts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elementindexsettings`
--
ALTER TABLE `elementindexsettings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elements`
--
ALTER TABLE `elements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `elements_sites`
--
ALTER TABLE `elements_sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `entrytypes`
--
ALTER TABLE `entrytypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fieldgroups`
--
ALTER TABLE `fieldgroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `fieldlayoutfields`
--
ALTER TABLE `fieldlayoutfields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fieldlayouts`
--
ALTER TABLE `fieldlayouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fieldlayouttabs`
--
ALTER TABLE `fieldlayouttabs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `globalsets`
--
ALTER TABLE `globalsets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gqlschemas`
--
ALTER TABLE `gqlschemas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `info`
--
ALTER TABLE `info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `matrixblocktypes`
--
ALTER TABLE `matrixblocktypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `queue`
--
ALTER TABLE `queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `relations`
--
ALTER TABLE `relations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revisions`
--
ALTER TABLE `revisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections_sites`
--
ALTER TABLE `sections_sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shunnedmessages`
--
ALTER TABLE `shunnedmessages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sitegroups`
--
ALTER TABLE `sitegroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sites`
--
ALTER TABLE `sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `structureelements`
--
ALTER TABLE `structureelements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `structures`
--
ALTER TABLE `structures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `systemmessages`
--
ALTER TABLE `systemmessages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taggroups`
--
ALTER TABLE `taggroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `templatecachequeries`
--
ALTER TABLE `templatecachequeries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `templatecaches`
--
ALTER TABLE `templatecaches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usergroups`
--
ALTER TABLE `usergroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usergroups_users`
--
ALTER TABLE `usergroups_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpermissions`
--
ALTER TABLE `userpermissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpermissions_usergroups`
--
ALTER TABLE `userpermissions_usergroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpermissions_users`
--
ALTER TABLE `userpermissions_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpreferences`
--
ALTER TABLE `userpreferences`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `volumefolders`
--
ALTER TABLE `volumefolders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `volumes`
--
ALTER TABLE `volumes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `widgets`
--
ALTER TABLE `widgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assetindexdata`
--
ALTER TABLE `assetindexdata`
  ADD CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `categorygroups`
--
ALTER TABLE `categorygroups`
  ADD CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categorygroups_sites`
--
ALTER TABLE `categorygroups_sites`
  ADD CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_addresses`
--
ALTER TABLE `commerce_addresses`
  ADD CONSTRAINT `commerce_addresses_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_addresses_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_customers`
--
ALTER TABLE `commerce_customers`
  ADD CONSTRAINT `commerce_customers_primaryBillingAddressId_fk` FOREIGN KEY (`primaryBillingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_customers_primaryShippingAddressId_fk` FOREIGN KEY (`primaryShippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_customers_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_customers_addresses`
--
ALTER TABLE `commerce_customers_addresses`
  ADD CONSTRAINT `commerce_customers_addresses_addressId_fk` FOREIGN KEY (`addressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_customers_addresses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_customer_discountuses`
--
ALTER TABLE `commerce_customer_discountuses`
  ADD CONSTRAINT `commerce_customer_discountuses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_customer_discountuses_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_discount_categories`
--
ALTER TABLE `commerce_discount_categories`
  ADD CONSTRAINT `commerce_discount_categories_categoryId_fk` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_discount_categories_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_discount_purchasables`
--
ALTER TABLE `commerce_discount_purchasables`
  ADD CONSTRAINT `commerce_discount_purchasables_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_discount_purchasables_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_discount_usergroups`
--
ALTER TABLE `commerce_discount_usergroups`
  ADD CONSTRAINT `commerce_discount_usergroups_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_discount_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_donations`
--
ALTER TABLE `commerce_donations`
  ADD CONSTRAINT `commerce_donations_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_email_discountuses`
--
ALTER TABLE `commerce_email_discountuses`
  ADD CONSTRAINT `commerce_email_discountuses_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_lineitems`
--
ALTER TABLE `commerce_lineitems`
  ADD CONSTRAINT `commerce_lineitems_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_lineitems_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_lineitems_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_lineitems_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `commerce_orderadjustments`
--
ALTER TABLE `commerce_orderadjustments`
  ADD CONSTRAINT `commerce_orderadjustments_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_orderhistories`
--
ALTER TABLE `commerce_orderhistories`
  ADD CONSTRAINT `commerce_orderhistories_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_orderhistories_newStatusId_fk` FOREIGN KEY (`newStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_orderhistories_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_orderhistories_prevStatusId_fk` FOREIGN KEY (`prevStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `commerce_orders`
--
ALTER TABLE `commerce_orders`
  ADD CONSTRAINT `commerce_orders_billingAddressId_fk` FOREIGN KEY (`billingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_estimatedBillingAddressId_fk` FOREIGN KEY (`estimatedBillingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_estimatedShippingAddressId_fk` FOREIGN KEY (`estimatedShippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_orders_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_orders_paymentSourceId_fk` FOREIGN KEY (`paymentSourceId`) REFERENCES `commerce_paymentsources` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_orders_shippingAddressId_fk` FOREIGN KEY (`shippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_orderstatus_emails`
--
ALTER TABLE `commerce_orderstatus_emails`
  ADD CONSTRAINT `commerce_orderstatus_emails_emailId_fk` FOREIGN KEY (`emailId`) REFERENCES `commerce_emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_orderstatus_emails_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `commerce_paymentsources`
--
ALTER TABLE `commerce_paymentsources`
  ADD CONSTRAINT `commerce_paymentsources_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_paymentsources_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_plans`
--
ALTER TABLE `commerce_plans`
  ADD CONSTRAINT `commerce_plans_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_plans_planInformationId_fk` FOREIGN KEY (`planInformationId`) REFERENCES `elements` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_products`
--
ALTER TABLE `commerce_products`
  ADD CONSTRAINT `commerce_products_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_products_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`),
  ADD CONSTRAINT `commerce_products_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`),
  ADD CONSTRAINT `commerce_products_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_producttypes`
--
ALTER TABLE `commerce_producttypes`
  ADD CONSTRAINT `commerce_producttypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_producttypes_variantFieldLayoutId_fk` FOREIGN KEY (`variantFieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_producttypes_shippingcategories`
--
ALTER TABLE `commerce_producttypes_shippingcategories`
  ADD CONSTRAINT `commerce_producttypes_shippingcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_producttypes_shippingcategories_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_producttypes_sites`
--
ALTER TABLE `commerce_producttypes_sites`
  ADD CONSTRAINT `commerce_producttypes_sites_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_producttypes_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_producttypes_taxcategories`
--
ALTER TABLE `commerce_producttypes_taxcategories`
  ADD CONSTRAINT `commerce_producttypes_taxcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_producttypes_taxcategories_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_purchasables`
--
ALTER TABLE `commerce_purchasables`
  ADD CONSTRAINT `commerce_purchasables_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_sale_categories`
--
ALTER TABLE `commerce_sale_categories`
  ADD CONSTRAINT `commerce_sale_categories_categoryId_fk` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_sale_categories_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_sale_purchasables`
--
ALTER TABLE `commerce_sale_purchasables`
  ADD CONSTRAINT `commerce_sale_purchasables_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_sale_purchasables_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_sale_usergroups`
--
ALTER TABLE `commerce_sale_usergroups`
  ADD CONSTRAINT `commerce_sale_usergroups_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_sale_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_shippingrules`
--
ALTER TABLE `commerce_shippingrules`
  ADD CONSTRAINT `commerce_shippingrules_methodId_fk` FOREIGN KEY (`methodId`) REFERENCES `commerce_shippingmethods` (`id`),
  ADD CONSTRAINT `commerce_shippingrules_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_shippingrule_categories`
--
ALTER TABLE `commerce_shippingrule_categories`
  ADD CONSTRAINT `commerce_shippingrule_categories_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_shippingrule_categories_shippingRuleId_fk` FOREIGN KEY (`shippingRuleId`) REFERENCES `commerce_shippingrules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commerce_shippingzone_countries`
--
ALTER TABLE `commerce_shippingzone_countries`
  ADD CONSTRAINT `commerce_shippingzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_shippingzone_countries_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_shippingzone_states`
--
ALTER TABLE `commerce_shippingzone_states`
  ADD CONSTRAINT `commerce_shippingzone_states_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_shippingzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_states`
--
ALTER TABLE `commerce_states`
  ADD CONSTRAINT `commerce_states_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_subscriptions`
--
ALTER TABLE `commerce_subscriptions`
  ADD CONSTRAINT `commerce_subscriptions_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`),
  ADD CONSTRAINT `commerce_subscriptions_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commerce_subscriptions_planId_fk` FOREIGN KEY (`planId`) REFERENCES `commerce_plans` (`id`),
  ADD CONSTRAINT `commerce_subscriptions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `commerce_taxrates`
--
ALTER TABLE `commerce_taxrates`
  ADD CONSTRAINT `commerce_taxrates_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_taxrates_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `commerce_taxzone_countries`
--
ALTER TABLE `commerce_taxzone_countries`
  ADD CONSTRAINT `commerce_taxzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_taxzone_countries_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_taxzone_states`
--
ALTER TABLE `commerce_taxzone_states`
  ADD CONSTRAINT `commerce_taxzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_taxzone_states_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `commerce_transactions`
--
ALTER TABLE `commerce_transactions`
  ADD CONSTRAINT `commerce_transactions_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_transactions_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_transactions_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `commerce_transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commerce_transactions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commerce_variants`
--
ALTER TABLE `commerce_variants`
  ADD CONSTRAINT `commerce_variants_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commerce_variants_productId_fk` FOREIGN KEY (`productId`) REFERENCES `commerce_products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `craftidtokens`
--
ALTER TABLE `craftidtokens`
  ADD CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `drafts`
--
ALTER TABLE `drafts`
  ADD CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `elements`
--
ALTER TABLE `elements`
  ADD CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `elements_sites`
--
ALTER TABLE `elements_sites`
  ADD CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `entries`
--
ALTER TABLE `entries`
  ADD CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `entrytypes`
--
ALTER TABLE `entrytypes`
  ADD CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fieldlayoutfields`
--
ALTER TABLE `fieldlayoutfields`
  ADD CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fieldlayouttabs`
--
ALTER TABLE `fieldlayouttabs`
  ADD CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fields`
--
ALTER TABLE `fields`
  ADD CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `globalsets`
--
ALTER TABLE `globalsets`
  ADD CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `matrixblocks`
--
ALTER TABLE `matrixblocks`
  ADD CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `matrixblocktypes`
--
ALTER TABLE `matrixblocktypes`
  ADD CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `migrations`
--
ALTER TABLE `migrations`
  ADD CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `relations`
--
ALTER TABLE `relations`
  ADD CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `revisions`
--
ALTER TABLE `revisions`
  ADD CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sections_sites`
--
ALTER TABLE `sections_sites`
  ADD CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shunnedmessages`
--
ALTER TABLE `shunnedmessages`
  ADD CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `structureelements`
--
ALTER TABLE `structureelements`
  ADD CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `taggroups`
--
ALTER TABLE `taggroups`
  ADD CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `templatecacheelements`
--
ALTER TABLE `templatecacheelements`
  ADD CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `templatecachequeries`
--
ALTER TABLE `templatecachequeries`
  ADD CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `templatecaches`
--
ALTER TABLE `templatecaches`
  ADD CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usergroups_users`
--
ALTER TABLE `usergroups_users`
  ADD CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userpermissions_usergroups`
--
ALTER TABLE `userpermissions_usergroups`
  ADD CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userpermissions_users`
--
ALTER TABLE `userpermissions_users`
  ADD CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userpreferences`
--
ALTER TABLE `userpreferences`
  ADD CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `volumefolders`
--
ALTER TABLE `volumefolders`
  ADD CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `volumes`
--
ALTER TABLE `volumes`
  ADD CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `widgets`
--
ALTER TABLE `widgets`
  ADD CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
