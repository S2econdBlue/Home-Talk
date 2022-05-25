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
-- Table structure for table `chat_history`
--

DROP TABLE IF EXISTS `chat_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_history` (
  `no` int NOT NULL AUTO_INCREMENT,
  `room_no` int NOT NULL,
  `id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`no`),
  KEY `fk_chat_history_chat_alert1_idx` (`room_no`),
  KEY `fk_chat_history_userinfo1_idx` (`id`),
  CONSTRAINT `fk_chat_history_chat_alert1` FOREIGN KEY (`room_no`) REFERENCES `chat_room` (`no`),
  CONSTRAINT `fk_chat_history_userinfo1` FOREIGN KEY (`id`) REFERENCES `userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_history`
--

LOCK TABLES `chat_history` WRITE;
/*!40000 ALTER TABLE `chat_history` DISABLE KEYS */;
INSERT INTO `chat_history` VALUES (1,4,'buyer','구매자입니다. 안녕하세요','2022-05-23 00:40:00'),(2,4,'seller','판매자입니다. 안녕하세요.','2022-05-23 00:40:00'),(3,4,'buyer','ㅎㅇㅎㅇ','2022-05-23 05:13:37'),(4,4,'buyer','안녕하세요.','2022-05-23 05:20:27'),(5,4,'buyer','뮻ㅇ','2022-05-23 05:21:04'),(6,4,'buyer','답장부탁드립니다.','2022-05-23 05:23:00'),(7,4,'buyer','답장해주세요옹','2022-05-23 05:23:57'),(8,4,'buyer','안녕하세요.','2022-05-23 06:43:40'),(9,4,'buyer','무시하냐??','2022-05-23 06:49:32'),(10,4,'buyer','무시하지말아주세요.','2022-05-23 06:57:38'),(11,4,'buyer','abcd','2022-05-23 07:00:19'),(12,4,'buyer','객체를 추가했읍니다..','2022-05-23 07:02:16'),(13,4,'buyer','확인용','2022-05-23 07:03:34'),(14,4,'buyer','한번 더 확인용','2022-05-23 07:04:30'),(15,4,'seller','이제 봤습니다. 휴','2022-05-23 07:22:50'),(16,4,'seller','다시보내봅니다.','2022-05-23 07:24:41'),(17,4,'seller','아이디 제대로 확인될까요?','2022-05-23 07:30:23'),(18,4,'buyer','네. 제 쪽에서도 잘 보이네요.','2022-05-23 07:30:31'),(19,4,'buyer','그런데 중복된 키가 존재한다고하네요.','2022-05-23 07:31:30'),(20,4,'seller','아 그렇군요.','2022-05-23 07:31:42'),(21,4,'buyer','어허. 어떻하죠?','2022-05-23 07:31:53'),(22,4,'buyer','안녕하세요.','2022-05-23 07:33:34'),(23,4,'buyer','중복키 확인작업','2022-05-23 07:34:25'),(24,4,'buyer','non computed 배열 사용','2022-05-23 07:35:32'),(25,4,'seller','아 이걸 사용해도 잘 되는것같은데요?','2022-05-23 07:35:41'),(26,4,'buyer','아아','2022-05-23 07:35:58'),(27,4,'buyer','아닌가요?','2022-05-23 07:36:36'),(28,4,'seller','ㅎㅇㅎㅇ','2022-05-23 07:37:18'),(29,4,'buyer','중복키 문제를 해결됬나요?','2022-05-23 07:39:42'),(30,4,'buyer','??? 안되나','2022-05-23 07:41:04'),(31,4,'buyer','아이고난','2022-05-23 07:41:31'),(32,4,'buyer','채팅 다시해봐요~','2022-05-23 07:43:21'),(33,4,'buyer','채팅다시해봐요','2022-05-23 07:43:40'),(34,4,'buyer','채팅 다시 해봅시다.','2022-05-23 07:44:49'),(35,4,'buyer','으음... 뭐가문제일까요','2022-05-23 07:44:59'),(36,4,'buyer','수정수정','2022-05-23 08:07:39'),(37,4,'buyer','이제 중복문제 발생안하겠죠?','2022-05-23 08:07:54'),(38,4,'seller','와~ 다행이다 휴','2022-05-23 08:08:03'),(39,4,'seller','스크롤기능 추가','2022-05-23 08:34:37'),(40,4,'buyer','aa','2022-05-23 10:47:56'),(41,4,'buyer','aa','2022-05-23 10:48:13'),(42,4,'seller','보내집니까?','2022-05-23 10:49:31'),(43,4,'buyer','안보내지네요','2022-05-23 10:50:10'),(44,4,'buyer','되니?','2022-05-23 10:57:08'),(45,4,'buyer','ㅎㅇㅎㅇ','2022-05-23 11:20:59'),(46,4,'buyer','ㅎㅇㅎㅇ','2022-05-23 11:21:29'),(47,4,'buyer','ㅎㅇㅎㅇ','2022-05-23 11:32:34'),(48,4,'buyer','안녕하세요.','2022-05-23 11:34:52'),(49,4,'buyer','안녕하세요.','2022-05-23 11:35:18'),(50,4,'seller','네. 안녕하세요.','2022-05-23 11:35:26'),(51,4,'buyer','ㅎㅇㅎㅇ','2022-05-23 11:38:23'),(52,4,'buyer','안녕하세요.','2022-05-23 11:40:12'),(53,4,'seller','또 뵙네요.','2022-05-23 14:16:48'),(54,4,'buyer','네 안녕하세요~','2022-05-23 14:20:28'),(55,4,'buyer','테스트','2022-05-23 14:22:45'),(56,4,'seller','받아와지나요','2022-05-23 14:23:59'),(57,4,'seller','왜 렉이 있죠??','2022-05-23 14:24:06'),(58,4,'buyer','채팅 시작','2022-05-23 14:26:35'),(59,4,'seller','네넵','2022-05-23 14:26:41'),(60,4,'buyer','다시 연결','2022-05-23 14:26:56'),(61,5,'seller','안녕하세요.','2022-05-23 14:30:52'),(62,5,'buyer2','앗 안녕하세요.','2022-05-23 14:31:05'),(63,5,'seller','어떤 매물을 보고 싶으시죠?','2022-05-23 14:34:57'),(64,5,'buyer2','네 ~~요','2022-05-23 14:35:09'),(65,5,'seller','아 그렇군요.','2022-05-23 14:35:15'),(66,5,'seller','??','2022-05-23 14:35:26'),(67,5,'seller','??','2022-05-23 14:36:02'),(68,5,'seller','??','2022-05-23 14:36:11'),(69,5,'seller','??','2022-05-23 14:36:20'),(70,4,'buyer','안녕하세요.','2022-05-23 14:46:09'),(71,4,'seller','네 안녕하세요.','2022-05-23 14:46:15'),(72,4,'seller','안녕하세요.','2022-05-23 15:06:09'),(73,4,'buyer','네 안녕하세요.','2022-05-23 15:06:27'),(74,4,'seller','ㅎㅇ','2022-05-23 15:12:36'),(75,4,'buyer','ㅎㅇ','2022-05-23 15:12:49'),(76,4,'buyer','안녕','2022-05-23 15:18:15'),(77,4,'seller','안녕','2022-05-23 15:19:49'),(78,4,'buyer','안녕','2022-05-23 15:19:55'),(79,4,'buyer','안녕','2022-05-23 15:20:40'),(80,4,'buyer','안녕','2022-05-23 15:20:53'),(81,4,'seller','안녕','2022-05-23 15:20:55'),(82,5,'seller','ㅎㅇ','2022-05-23 15:30:15'),(83,4,'seller','안녕','2022-05-23 16:43:50'),(84,4,'buyer','안녕하세요! 알람이 갈까요?','2022-05-23 17:05:17'),(85,4,'buyer','알람 테스트','2022-05-23 17:10:01'),(86,4,'seller','알람 테스트 seller to buyer','2022-05-23 17:10:27'),(87,4,'buyer','테스트','2022-05-23 17:13:04'),(88,4,'seller','oj','2022-05-23 17:13:10'),(89,4,'seller','보내봅니다.','2022-05-23 18:53:29'),(90,4,'seller','안녕하세요.','2022-05-23 19:02:44'),(91,4,'seller','ㅎㅇㅎㅇ','2022-05-23 19:05:04'),(92,4,'seller','입력해봅니다.','2022-05-23 19:06:25'),(93,4,'seller','시간 테스트입니다.','2022-05-23 19:07:30'),(94,4,'seller','렉이 조금 심하네요.','2022-05-23 19:07:49');
/*!40000 ALTER TABLE `chat_history` ENABLE KEYS */;
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
