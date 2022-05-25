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
-- Table structure for table `imgboard`
--

DROP TABLE IF EXISTS `imgboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imgboard` (
  `no` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `board_no` int NOT NULL COMMENT '게시판 번호',
  `original_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '원본 파일명',
  `save_path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일 저장 경로',
  `size` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일 크기',
  `delete_yn` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
  `delete_time` timestamp NULL DEFAULT NULL COMMENT '삭제 시간',
  PRIMARY KEY (`no`),
  KEY `fk_imgboard_threadboard1_idx` (`board_no`),
  CONSTRAINT `fk_imgboard_threadboard1` FOREIGN KEY (`board_no`) REFERENCES `threadboard` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imgboard`
--

LOCK TABLES `imgboard` WRITE;
/*!40000 ALTER TABLE `imgboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `imgboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-25 22:16:09
