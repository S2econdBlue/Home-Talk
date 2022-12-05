-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: happyhouse
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userinfo` (
  `id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pw` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `grade` int DEFAULT NULL,
  `delete_yn` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES ('4NoticeAccnt','1','4NoticeAccnt@test.com','1','테스트용 계정','2022-05-26 15:26:10',9999,0),('admin','admin','admin@naver.com','444','관리자','2022-05-04 10:19:27',9999,0),('buyer','1','1','1','1','2022-05-22 09:41:50',1,1),('buyer2','1','1@1','1','1','2022-05-23 14:29:11',1,1),('new','1','new@ssafy.,com','22','new','2022-05-08 10:09:14',1,0),('seller','seller','1','1','1','2022-05-22 09:40:00',2,0),('ssafy1',NULL,'ssafy@ssafy','23','아싸피','2022-05-22 09:11:16',1,0),('일반회원1','1','one@ssafy.com','23','일회원','2022-05-26 04:40:25',1,0);
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-27  6:00:59
