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
-- Table structure for table `tradeboard`
--

DROP TABLE IF EXISTS `tradeboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tradeboard` (
  `boardNo` int NOT NULL,
  `contractOpt` int NOT NULL,
  `deposit` int NOT NULL,
  `monthlyFee` int NOT NULL,
  `commonMaintainFee` int NOT NULL,
  `loan` tinyint(1) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `detail` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roadnameAddress` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detailAddress` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`boardNo`),
  KEY `fk_tradeboard_threadboard1_idx` (`boardNo`),
  CONSTRAINT `fk_oncascade` FOREIGN KEY (`boardNo`) REFERENCES `threadboard` (`no`) ON DELETE CASCADE,
  CONSTRAINT `fk_tradeboard_threadboard1` FOREIGN KEY (`boardNo`) REFERENCES `threadboard` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tradeboard`
--

LOCK TABLES `tradeboard` WRITE;
/*!40000 ALTER TABLE `tradeboard` DISABLE KEYS */;
INSERT INTO `tradeboard` VALUES (71,2,500,39,10,0,'2022-05-26 04:17:46','● 애플부동산중개사무소 소속공인중개사 김수환 과장<br>100% 실매물 100%실가격<br><br>● 카톡 ID : asd0737<br><br>● 주변 상권이 잘 형성되있으며 마트, 편의점 성서산업단지역 도보5분 이곡동거리에 위치해있습니다.<br><br>● 내관,외관 모두 굉장히 깨끗하고 단열재 우수한 방으로 겨울엔 따뜻하고 여름엔 시원합니다.<br>혹시나 보수가 필요한 부분이있으면 실시간으로 도와드립니다.<br><br>● 방을 보시고 괜찮으시면 최대한 보증금/월세 절충해보겠습니다.<br><br>● 풀옵션으로 갖춰진 매물이라 이사하실때 몸만 편히 오시면됩니다<br><br>● 1층은 필로티구조로 되어있어서 주차도 편리하게 사용가능합니다.<br>건물 입구쪽 CCTV 도어락 ,각 호실별 도어락이 갖춰져서 보안적으로도 우수합니다.<br><br>● 방 매물은 제가 직접 촬영한 사진으로서 항상 질좋은 방을 보여드리도록 노력하겠습니다.<br><br>● 실시간으로 공실확인후 바로 안내해드립니다.<br><br>● 보시다가 궁금하신거 있으시면 언제든지 질문하셔도됩니다.<br>부재중일경우 카카오톡 ID: asd0737 로 남겨주시거나 문자남겨주시면 연중무휴 24시간 상담가능합니다.<br><br>● 지원해드릴 수 있는 부분은 최대한 도와드리겠습니다.','대구 달서구 이곡동 810-3','현대모비스 근처'),(72,2,300,28,10,0,'2022-05-26 06:08:17','【【해당 이미지 사진은 직접 찍은 100% 실 사진입니다.】】<br><br><br>【 좋은집! 좋은자리! 】<br><br><br>?[ 매물정보 ]?<br><br>✔ 구조:방1,분리형거실1,욕실1,베란다<br><br>✔ 현재 보시는 매물 사진은 제가 직접 현장에서 촬영한 사진입니다<br><br>✔ 방은 전체적으로 깔끔한 인테리어와 화이트톤이 되어있습니다.<br><br>✔ 현관도어문, 전자도어락 , CCTV, 비디오폰 되어있습니다.<br><br><br><br>⚡ 위치 및 대중교통 안내<br><br>✔ 중앙로역 도보10분 거리라 교통이 용이합니다.<br><br>✔ 바로 대로변 인근으로 버스타시기도 용이합니다.<br><br><br><br>?[ 주변환경 ]?<br><br>✔ 주변에 은행,시장,편의점,약국,병원,대형마트,세탁소,셀프빨래방등 편의시설이 있습니다.<br><br>✔ 대로변이라 치안에 안전하고 근처에 학교와 CCTV가 많아서 여성분들에게 안전한 위치에 있습니다.<br><br>✔ 주변에 24시간 마트가 있어서 장보시기에도 불편함이 없습니다 ^ ^<br><br>✔ 조용한동네라 스트레스 소음 스트레스 없이 지내실 수 있습니다.<br><br><br>─────────────────────────────────────────<br><br><br>⭐ ⭐ 항상 정직하고 친절한 응대 약속합니다 ⭐ ⭐<br><br>⭐ 100% 실사진 / 실매물 / 실가격 으로 중개합니다 :)<br><br>⭐ 애완동물/보증금분납/단기임대 는 미리얘기해주시면 최대한 조정해드리겠습니다.<br><br>⭐ 보증금 / 월세 최대한 원하시는대로 맞춰드립니다.<br><br>⭐ 가격대비 최고의 방만 보여드림을 약속합니다.<br><br>⭐ 안내부터 입주, 사후 관리까지 책임지고 끝까지 최선을 다 해드리겠습니다.<br><br>⭐ 밤,낮,휴일 상관없이 언제든 문의가능하니 연락주세요 ^^<br><br><< 카카오톡 문의 rich5252 >>','대구 중구 서성로1가 40-12','중앙로 근처'),(74,1,300,30,10,0,'2022-05-26 07:51:46','❗ 위치 : 곽병원 뒷쪽라인<br>❗ 구조 : 분리형 , 방 1 , 화장실 1<br>❗ 옵션 : 에어컨 , 세탁기 , 냉장고 , 가스레인지 , 인터넷 , 유선 , 붙박이 , TV<br>❗ 난방 : 도시가스<br>❗ 방범 : CCTV 24시간촬영<br>❗ 주변시설 : 곽병원 , 동산병원 , 만경관 , 중앙로역 , 서문시장<br>❗ 입주시기 : 즉시입주<br><br>✔️ 5일에 한 번씩 공실 체크 및 실매물 유지 !<br>✔️ 대구 전지역 최다매물 보유 !<br>✔️ 가능한선에서 최대한 조건 맞춰드림 !<br>✔️ 퍼온사진 X , 직접 찍은사진 O !<br>✔️ 위 방이 계약이 되었더라도 원하시는 조건내에 가장 좋은방만 보여드립니다 !<br>✔️ 안좋은방부터 보여주고 서서히 눈높이 맞춰가는 얄팍한 방법 쓰지 않습니다 !<br>✔️ 시간을 아끼기위해 방 컨디션 상관없이 가까운 순서대로 이동 합니다 !<br>✔️ 당장의 수익을위한 계약강요는 절대 없습니다 !<br>✔️ 원하시면 귀가동선 , 버스노선 , 지하철 다 봐드립니다 !<br><br>❤️ 연락이 안될시 매물번호 메모 및 화면 캡쳐만 해주셔도 신속한 응대가 가능합니다 !<br>❤️ 매물번호를 알려주시면 신속하게 응대가 가능합니다 !<br>❤️ 궁금하신집 알려주시면 직접가서 찍어다 드립니다 !<br>❤️ 366일 25시간 편안하게 문의주세요 !','대구 중구 북성로 39','어'),(75,1,400,40,10,0,'2022-05-26 07:54:11','❗ 위치 : 곽병원 뒷쪽라인<br>❗ 구조 : 분리형 , 방 1 , 화장실 1<br>❗ 옵션 : 에어컨 , 세탁기 , 냉장고 , 가스레인지 , 인터넷 , 유선 , 붙박이 , TV<br>❗ 난방 : 도시가스<br>❗ 방범 : CCTV 24시간촬영<br>❗ 주변시설 : 곽병원 , 동산병원 , 만경관 , 중앙로역 , 서문시장<br>❗ 입주시기 : 즉시입주<br><br>✔️ 5일에 한 번씩 공실 체크 및 실매물 유지 !<br>✔️ 대구 전지역 최다매물 보유 !<br>✔️ 가능한선에서 최대한 조건 맞춰드림 !<br>✔️ 퍼온사진 X , 직접 찍은사진 O !<br>✔️ 위 방이 계약이 되었더라도 원하시는 조건내에 가장 좋은방만 보여드립니다 !<br>✔️ 안좋은방부터 보여주고 서서히 눈높이 맞춰가는 얄팍한 방법 쓰지 않습니다 !<br>✔️ 시간을 아끼기위해 방 컨디션 상관없이 가까운 순서대로 이동 합니다 !<br>✔️ 당장의 수익을위한 계약강요는 절대 없습니다 !<br>✔️ 원하시면 귀가동선 , 버스노선 , 지하철 다 봐드립니다 !<br><br>❤️ 연락이 안될시 매물번호 메모 및 화면 캡쳐만 해주셔도 신속한 응대가 가능합니다 !<br>❤️ 매물번호를 알려주시면 신속하게 응대가 가능합니다 !<br>❤️ 궁금하신집 알려주시면 직접가서 찍어다 드립니다 !<br>❤️ 366일 25시간 편안하게 문의주세요 !','대구 중구 북성로 39','아아');
/*!40000 ALTER TABLE `tradeboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-27  6:01:00
