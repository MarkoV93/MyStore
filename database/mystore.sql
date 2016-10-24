-- MySQL dump 10.13  Distrib 5.7.11, for Win64 (x86_64)
--
-- Host: localhost    Database: mystore
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_status` bit(1) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'','Phones'),(2,'','Computers'),(3,'','watches');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_status` bit(1) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'','Kiev'),(2,'','Ivano-Frankivsk'),(3,'','Lviv');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_status` bit(1) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `image` varchar(20) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rlaghtegr0yx2c1q1s6nkqjlh` (`category_id`),
  KEY `FK_hj2lu2fi3l72lsi32ypargnba` (`city_id`),
  CONSTRAINT `FK_hj2lu2fi3l72lsi32ypargnba` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`),
  CONSTRAINT `FK_rlaghtegr0yx2c1q1s6nkqjlh` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'','Ultrathin. Ultralight. Ultratough. For the average Ultrabook™ these attributes may sound like a contradiction. But the new X1 Carbon is far above average. It features a carbon-fiber reinforced chassis and passes durability tests in extreme environments. Plus, it delivers more than all-day battery life, includes faster, more powerful storage performance, and has innovative docking options available, including wireless.','1.png','Lenovo 666',655.99,2,1),(2,'','15.6-inch HD display The 15.6','2.png','lenovo800',354.50,2,2),(3,'','The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc. The devices are part of the iPhone series and were announced on September 9, 2014, and released on September 19, 2014.[16] The iPhone 6 and iPhone 6 Plus jointly serve as successors to the iPhone 5S and were themselves replaced as flagship devices of the iPhone series by the iPhone 6S and iPhone 6S Plus on September 9, 2015.\n\nThe iPhone 6 and iPhone 6 Plus include larger 4.7 and 5.5 inches (120 and 140 mm) displays, a faster processor, upgraded cameras, improved LTE and Wi-Fi connectivity and support for a near field communications-based mobile payments offering.[17][18]','3.png','iphone 6',325.25,1,3),(4,'','An elegant ladies Michael Kors watch in stainless steel. This glitzy model is set around a silver multi-dial clock face with chronograph and date function. Further features include a gem-studded case border and sparking stone hour markers. It fastens with a slender silver metal bracelet.','4.png','Michael Kors watch',755.99,3,3),(5,'','The Nokia 3310 is a GSM mobile phone announced on September 1, 2000,[2] and released in the fourth quarter of the year, replacing the popular Nokia 3210. The phone sold extremely well, being one of the most successful phones with 126 million units sold worldwide.[3] The phone is still widely acclaimed today.[1] The phone has gained a Cult status due to its durability.\n\nSeveral variants of the 3310 have been released, including the Nokia 3315, 3320, 3330, 3350, 3360, 3390 and 3395.','5.png','nokia 3310',45.00,1,3),(6,'','Hewlett-Packard Development Company has expanded the HP 3125 small business laptop line up with HP 3125 D3H53UT. Comes with a durable design and weighing just 3.52 lbs that make it comfortable to carry around plus good office tasks power from new AMD E1-1500 Accelerated Processor that released on this year, HP D3H53UT 3125 laptop is one of the best alternative for small and medium business users who need a new laptop for daily activities at home, office or wherever they go.\n\nBasically, HP 3125 D3H53UT laptop looks identical to HP 3125 D3H55UT laptop, expect the Random Access Memory. Powered by AMD E1-1500 dual core Accelerated Processor that integrated with AMD Radeon HD 7310 as graphics engine and incorporated with 4GB 1333 MHz DDR3 SDRAM (instead of a 2GB 1333 MHz DDR3 SDRAM on the previous model), the D3H53UT portable business laptop delivers faster and smoother office multitasking performance than its predecessor. For office and multimedia file storage, the budget friendly laptop brings a 320GB Serial ATA disk drive which has a speed of 5400 rotate per minutes.','6.png','HP 3125 D3H53UT 11.6',855.00,2,1),(7,'','An elegant ladies Michael Kors watch in stainless steel. This glitzy model is set around a silver multi-dial clock face with chronograph and date function. Further features include a gem-studded case border and sparking stone hour markers. It fastens with a slender silver metal bracelet.','7.png','Часы OMEGA: Globemaster',56.50,3,1),(8,'','The iPhone 4 and iPhone 4 Plus are smartphones designed and marketed by Apple Inc. The devices are part of the iPhone series and were announced on September 9, 2014, and released on September 19, 2014.[16] The iPhone 6 and iPhone 6 Plus jointly serve as successors to the iPhone 5S and were themselves replaced as flagship devices of the iPhone series by the iPhone 6S and iPhone 6S Plus on September 9, 2015. The iPhone 6 and iPhone 6 Plus include larger 4.7 and 5.5 inches (120 and 140 mm) displays, a faster processor, upgraded cameras, improved LTE and Wi-Fi connectivity and support for a near field communications-based mobile payments offering.[17][18]','8.png','iphone 4',255.00,1,1),(9,'','rademarks:\nLenovo, ThinkPad, ThinkCentre and the Lenovo logo are trademarks of Lenovo. Microsoft, Windows, Windows NT, and the Windows logo are trademarks of Microsoft Corporation. Ultrabook, Celeron, Celeron Inside, Core Inside, Intel, Intel Logo, Intel Atom, Intel Atom Inside, Intel Core, Intel Inside, Intel Inside Logo, Intel vPro, Itanium, Itanium Inside, Pentium, Pentium Inside, vPro Inside, Xeon, Xeon Phi, and Xeon Inside are trademarks of Intel Corporation in the U.S. and/or other countries. Other company, product or service names may be trademarks or service marks of others.','9.png','Lenovo G2h',450.50,2,2),(10,'','“The iPhone and Apple Watch versions of Evernote work together beautifully,” Andrew Sinkov, Evernote’s vice president of marketing, wrote in the blog post. “Dictate notes, perform searches, and see recent content on your watch when you need it. Set reminders and check items off your list without ever taking out your phone. Start reading a note on Apple Watch, then continue reading it on your iPhone with a swipe of the lock screen. It’s one app that moves with you from wrist to hand and back again.”','10.png','Apple Watch',150.30,3,1),(11,'','Just a touch of shine! This semi-transparent, champagne sparkled band makes it easy to add a little elegance to any look. Finished with our signature logo-engraved clasp, it\'s an on trend must-have for your Apple Watch.\nFlexible elastomer band for 38mm Apple Watch\nSignature logo-engraved clasp\nFits wrist sizes: 145mm - 190mm\nCompatible with Apple Watch Series 1 and Series 2','11.png','Apple Watch 38mm',65.99,3,3),(12,'','This clearly protective, dual-layered case for Samsung Galaxy S6 offers a smooth transparent finish and ultra slim design. Its lightweight, minimalist design delivers a stylish profile, while the impact resistant hard shell and coordinating bumper protects against impacts and falls. Metallic chrome buttons accent and complete the polished look of your Samsung Galaxy S6.\nUltra slim, dual-layer design with protective bumper\nEnhanced impact resistance and shock dispersion\nTransparent smooth finish with anti-scratch technology\nMetal button accents for a refined finish','12.png','Samsung Galaxy S6',65.50,1,1),(13,'','Samsung mobile phone figures solemnly in a large universe of mobile phones with some of the most sophisticated gadgets with multitasking and advanced features embedded in it. Design wise Samsung mobile phones have an age long reputation for providing the finest phones surpasses all its competitors, including major players such as Nokia, LG, BlackBerry, Motorola, Sony Ericsson, etc.\n\nThe Samsung Mobile phones, undoubtedly, will make your eyes bulging with astonishment and appeal of its exceptional beauty and functionality. There is no doubt that some of them are very expensive.','13.png','Samsung S6',65.00,1,3),(14,'','Samsung may have recently killed off the Galaxy Alpha smartphone, but that doesn’t mean it’s giving up on devices with a premium metallic build. After replacing it with the similar, but cheaper Galaxy A5 and A3, the company is now following up with a bigger and more capable variant in the Galaxy A7.\nThe device retains the full aluminum, unibody construction of its siblings but packs more computing power thanks to a Snapdragon 64-bit octa-core SoC, which itself consists of two separate quad core processors, clocked at 1.8GHz and 1.3GHz, or 1.5GHz and 1GHz for the dual SIM version.','14.png','Samsung Galaxy A7',165.00,1,1),(15,'','The Samsung Galaxy S7 is runnning Android 6.0 (Marshmallow), comes with a 5.1 inches (12.95 cm) touchscreen display with a resolution of 2560×1440, and is powered by Qualcomm MSM8996 Snapdragon 820/ Exynos 8890 Octa. The RAM measures at 4 GB. The Samsung Galaxy S7 packs 32 GB, 64 GB or 128 GB of internal storage and supports expendable storage of up to 200 GB (microSD).\n\nIt came with a 12 megapixel primary camera on the rear and a 8 megapixel front shooter for selfies.','15.png','Samsung Galaxy S7',125.65,1,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserve`
--

DROP TABLE IF EXISTS `reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accepted` bit(1) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_c6aomv9ualwbfgcugly86q2nb` (`product_id`),
  KEY `FK_ruqt8fuynix1fq5q4lnufnpth` (`user_id`),
  CONSTRAINT `FK_c6aomv9ualwbfgcugly86q2nb` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_ruqt8fuynix1fq5q4lnufnpth` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserve`
--

LOCK TABLES `reserve` WRITE;
/*!40000 ALTER TABLE `reserve` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_status` bit(1) DEFAULT NULL,
  `admin_status` bit(1) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `login` varchar(30) NOT NULL,
  `name` varchar(25) NOT NULL,
  `password` varchar(30) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `surname` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ew1hvam8uwaknuaellwhqchhb` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'','','admin@ukr.net','admin','admin','admin','80968716011','admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-12 22:49:20
