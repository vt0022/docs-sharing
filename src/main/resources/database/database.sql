-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: docs_sharing
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_disabled` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Sách','2023-12-08 23:57:24.356000',_binary '\0',NULL),(2,'Bài hát','2023-12-08 23:57:25.356000',_binary '\0',NULL),(3,'Phim','2023-12-08 23:57:26.356000',_binary '\0',NULL),(4,'Món ăn','2023-12-08 23:57:24.356000',_binary '\0',NULL),(5,'Trò chơi','2023-12-08 23:57:27.356000',_binary '\0',NULL),(6,'Bài viết','2023-12-08 23:57:28.356000',_binary '\0',NULL),(7,'Bức tranh','2023-12-08 23:57:24.356000',_binary '\0',NULL),(8,'Tòa nhà','2023-12-08 23:57:29.356000',_binary '\0',NULL),(9,'Phương tiện','2023-12-08 23:57:30.356000',_binary '\0',NULL),(10,'Động vật','2023-12-08 23:57:24.356000',_binary '\0',NULL),(11,'Loài cây','2023-12-08 23:57:24.356000',_binary '\0',NULL),(12,'Phần mềm','2023-12-08 23:57:31.356000',_binary '\0',NULL),(13,'Phần cứng','2023-12-08 23:57:34.356000',_binary '\0',NULL),(14,'Loại vải','2023-12-08 23:57:44.356000',_binary '\0',NULL),(15,'Báo','2023-12-08 23:57:24.356000',_binary '\0',NULL),(16,'Tài liệu','2023-12-08 23:57:24.356000',_binary '\0',NULL),(17,'Dụng cụ thể thao','2023-12-08 23:57:24.356000',_binary '\0',NULL),(18,'Loại đá quý','2023-12-08 23:57:47.356000',_binary '\0',NULL),(19,'Nhà xuất bản','2023-12-08 23:57:46.356000',_binary '\0',NULL),(20,'Loại bệnh','2023-12-08 23:57:45.356000',_binary '\0',NULL),(21,'Loại nhạc cụ','2023-12-08 23:57:44.356000',_binary '\0',NULL),(24,'Loài nấm','2024-03-24 12:12:17.677000',_binary '\0','2024-03-24 12:12:17.677000');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int DEFAULT NULL,
  `commented_by` int DEFAULT NULL,
  `parent_comment_id` int DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_ibfk_1_idx` (`post_id`),
  KEY `comment_ibfk_2_idx` (`commented_by`),
  KEY `comment_ibfk_3_idx` (`parent_comment_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`commented_by`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,10,NULL,'Cho mình xin với','2023-12-13 23:58:24.356000',NULL),(2,1,6,1,'Bạn comment email cho mình nha bạn!','2023-12-14 00:57:24.356000','2024-03-18 14:21:29.818000'),(3,1,12,NULL,'Còn không bạn ơi!','2023-12-14 05:57:24.356000',NULL),(4,1,6,3,'Mình hỏi bạn mình thì bạn mình cũng có một cuốn, bạn cho mình xin email nha','2023-12-14 08:57:24.356000',NULL),(5,1,10,2,'thikieu1703@gmail.com, cảm ơn bạn nhiều','2023-12-14 09:57:24.356000',NULL),(6,1,12,4,'ngocphuc0808@gmail.com, cảm ơn bạn','2023-12-14 09:59:24.356000',NULL),(7,2,13,NULL,'Cho mình ké với ạ!','2023-12-14 23:58:25.183000',NULL),(8,2,15,NULL,'Cho mình ké nữa ạ!','2023-12-15 00:57:25.183000',NULL),(9,2,18,NULL,'Có ai có không ạ?','2023-12-15 05:57:25.183000',NULL),(10,2,6,NULL,'Nhiều người cùng câu hỏi quá','2023-12-15 08:57:25.183000',NULL),(11,3,15,NULL,'Mình bạn ơi!','2023-12-15 23:58:25.183000',NULL),(12,3,6,11,'Gửi email mình nha ','2023-12-16 00:57:25.183000',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_like` (
  `comment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `liked_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`comment_id`,`user_id`),
  KEY `comment_like_ibfk_2_idx` (`user_id`),
  CONSTRAINT `comment_like_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_like_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES (1,6,'2023-12-14 00:57:24.356000'),(1,7,'2023-12-14 00:58:24.356000'),(1,9,'2023-12-14 00:59:24.356000'),(1,10,'2023-12-14 01:00:24.356000'),(1,12,'2023-12-14 01:01:24.356000'),(1,13,'2023-12-14 01:02:24.356000'),(1,15,'2023-12-14 01:03:24.356000'),(1,29,'2023-12-14 01:04:24.356000'),(1,30,'2023-12-14 01:05:24.356000'),(2,10,'2023-12-14 01:06:24.356000'),(2,32,'2023-12-14 01:07:24.356000'),(2,33,'2023-12-14 01:08:24.356000'),(2,34,'2023-12-14 01:09:24.356000'),(5,6,'2023-12-14 09:58:24.356000'),(5,21,'2024-04-02 16:34:44.089000'),(7,6,'2023-12-14 23:59:25.183000');
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `doc_id` int NOT NULL AUTO_INCREMENT,
  `doc_introduction` text NOT NULL,
  `doc_name` varchar(255) NOT NULL,
  `download_url` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `total_view` int NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `uploaded_at` datetime(6) DEFAULT NULL,
  `view_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `document_ibfk_1_idx` (`category_id`),
  KEY `document_ibfk_2_idx` (`field_id`),
  KEY `document_ibfk_3_idx` (`uploaded_by`),
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `document_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `document_ibfk_3` FOREIGN KEY (`uploaded_by`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,'Đắc nhân tâm của Dale Carnegie là quyển sách của mọi thời đại và một hiện tượng đáng kinh ngạc trong ngành xuất bản Hoa Kỳ. Trong suốt nhiều thập kỷ tiếp theo và cho đến tận bây giờ, tác phẩm này vẫn chiếm vị trí số một trong danh mục sách bán chạy nhất và trở thành một sự kiện có một không hai trong lịch sử ngành xuất bản thế giới và được đánh giá là một quyển sách có tầm ảnh hưởng nhất mọi thời đại.\nĐây là cuốn sách độc nhất về thể loại self-help sở hữu một lượng lớn người hâm mộ. Ngoài ra cuốn sách có doanh số bán ra cao nhất được tờ báo The New York Times bình chọn trong nhiều năm. Cuốn sách này không còn là một tác phẩm về nghệ thuật đơn thuần nữa mà là một bước thay đổi lớn trong cuộc sống của mỗi người.\n\nNhờ có tầm hiểu biết rộng rãi và khả năng ‘ứng xử một cách nghệ thuật trong giao tiếp’ – Dale Carnegie đã viết ra một quyển sách với góc nhìn độc đáo và mới mẻ trong giao tiếp hàng ngày một cách vô cùng thú vị – Thông qua những mẫu truyện rời rạc nhưng lại đầy lý lẽ thuyết phục. Từ đó tìm ra những kinh nghiệm để đúc kết ra những nguyên tắc vô cùng ‘ngược ngạo’, nhưng cũng rất logic dưới cái nhìn vừa sâu sắc, vừa thực tế. \n\nHơn thế nữa, Đắc Nhân Tâm còn đưa ra những nghịch lý mà từ lâu con người ta đã hiểu lầm về phương hướng giao tiếp trong mạng lưới xã hội, thì ra, người giao tiếp thông minh không phải là người có thể phát biểu ra những lời hay nhất, mà là những người học được cách mỉm cười, luôn biết cách lắng nghe, và khích lệ câu chuyện của người khác. ','Đắc Nhân Tâm','https://play.google.com/store/books/details/Dale_Carnegie_%C4%90%E1%BA%AFc_Nh%C3%A2n_T%C3%A2m?id=eqjvDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/eqjvDwAAQBAJ?fife=w240-h345',0,NULL,'2023-12-13 23:57:24.356000','https://play.google.com/store/books/details/Dale_Carnegie_%C4%90%E1%BA%AFc_Nh%C3%A2n_T%C3%A2m?id=eqjvDwAAQBAJ',1,5,6),(2,'Dạy Con Làm Giàu là một bộ sách rất được yêu thích của tác giả Robert T. Kiyosaki. Hãy đọc nó nếu bạn muốn xây dựng con đường đến giàu có từ khi còn trẻ.\n\nTrong tác phẩm, Kiyosaki đã chỉ ra những yếu tố và thói quen khác biệt giữa cha của ông – một người có học thức cao nhưng vẫn nghèo khó và một người cha khác – tuy bỏ học nhưng lại trở thành một triệu phú tự thân.\n\nMột trong những nguyên nhân khiến người giàu ngày càng giàu, người nghèo ngày càng nghèo, còn giới trung lưu thì thường mắc nợ chính là vì chủ đề tiền bạc thường được dạy ở nhà chứ không phải ở trường.\n\nHầu hết chúng ta học cách xử lý tiền bạc từ cha mẹ mình, và thường thì người nghèo không dạy con về tiền bạc mà chỉ nói đơn giản là: “Hãy đến trường và học cho chăm chỉ.” Và rồi đứa trẻ có thể sẽ tốt nghiệp với một số điểm xuất sắc nhưng với một đầu óc nghèo nàn về cách quản lý tiền bạc, vì trường học không dạy về chuyện tiền nong mà chỉ tập trung vào việc giáo dục sách vở và những kỹ năng nghề nghiệp mà không nói gì về kỹ năng tài chính.\n\nĐó chính là lý do tại sao những nhân viên ngân hàng, bác sĩ, kế toán thông minh dù đạt được nhiều điểm số xuất sắc ở trường nhưng lại gặp nhiều rắc rối tài chính suốt đời. Và những món nợ quốc gia chóng mặt thường bắt nguồn từ những vị lãnh đạo có học vấn cao, nhưng chỉ được huấn luyện rất ít hoặc không có chút kỹ năng nào về vấn đề tài chính.\n\nMột quốc gia có thể tồn tại như thế nào nếu việc dạy trẻ con quản lý tiền bạc vẫn là trách nhiệm của phụ huynh, mà hầu hết họ không có nhiều kiến thức về vấn đề này? Chúng ta phải làm gì để thay đổi số phận tiền bạc lận đận của mình? Nhà giàu đã làm giàu như thế nào từ hai bàn tay trắng?...\n\nCó lẽ bạn sẽ tìm thấy cho mình những lời giải đáp về các vấn đề đó trong cuốnsách này. Tuy nhiên, do khác biệt về văn hoá, tập quán và chính thể, có thể một số phần nào đó của cuốn sách sẽ khiến bạn thấy lạ lẫm, thậm chí chưa đồng tình… dù rằng đây là một cuốn sách đã được đón nhận nồng nhiệt ở rất nhiều nước trên thế giới.\n\nChúng tôi giới thiệu cuốn sách này với mong muốn giúp bạn có thêm nguồn tham khảo về một trong những lĩnh vực cần dạy con trẻ biết trước khi vào đời, của các bậc phụ huynh ở các nước khác…\n\nTrọn bộ 13 cuốn: eBook Dạy con làm giàu định dạng pdf\n\n1. Dạy con làm giàu - Tập 1: Cha giàu cha nghèo\n\n2. Dạy con làm giàu - Tập 2: Sử dụng đồng vốn\n\n3. Dạy con làm giàu - Tập 3: Để trở thanh nhà đầu tư lão luyện\n\n4. Dạy con làm giàu - Tập 4: Để có khởi đầu thuận lợi về tài chính\n\n5. Dạy con làm giàu - Tập 5: Để có sức mạnh về tài chính\n\n6. Dạy con làm giàu - Tập 6: Những câu chuyện thành công\n\n7. Dạy con làm giàu - Tập 7: Ai đã lấy tiền của Tôi?\n\n8. Dạy con làm giàu - Tập 8: Để có những đồng tiền tích cực\n\n9. Dạy con làm giàu - Tập 9: Những bí mật về tiền bạc - Điều mà bạn không học ở nhà trường\n\n10. Dạy con làm giàu - Tập 10: Trước khi bạn thôi việc\n\n11. Dạy con làm giàu - Tập 11: Trường dạy kinh doanh cho những người thích giúp đỡ người khác\n\n12. Dạy con làm giàu - Tập 12: Xây dựng con thuyền tài chính của bạn\n\n13. Dạy con làm giàu - Tập 13: Nâng cao chỉ số IQ tài chính\n\nMời các bạn đón đọc Dạy Con Làm Giàu: Cha Giàu, Cha Nghèo của hai tác giả Robert T. Kiyosaki & Sharon L. Lechter.','Dạy con làm giàu - Tập 1: Để không có tiền vẫn tạo ra tiền','https://play.google.com/store/books/details/Robert_Kiyosaki_D%E1%BA%A1y_con_l%C3%A0m_gi%C3%A0u_T%E1%BA%ADp_1?id=hz-2EAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/hz-2EAAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:11:24.356000','https://play.google.com/store/books/details/Robert_Kiyosaki_D%E1%BA%A1y_con_l%C3%A0m_gi%C3%A0u_T%E1%BA%ADp_1?id=hz-2EAAAQBAJ',1,19,6),(3,'Tại sao một người đọc sách chậm với tốc độ đọc năm phút một trang lại có thể trở thành nhà bình luận sách với tốc độ đọc trên 700 cuốn sách mỗi năm?\nTốc độ đọc của tôi chậm đến cỡ nào?\n\n“Tôi thích sách. Tôi muốn đọc rất nhiều cuốn nhưng lại không có thời gian đọc...”\n\n“Có những cuốn tôi bắt buộc phải đọc để phục vụ công việc nhưng tốc độ đọc của tôi quá chậm...”\n\n“Lượng sách tôi đọc giảm rõ rệt. Dù đã quyết tâm ‘hôm nay nhất định mình phải đọc’ nhưng mà lại buồn ngủ quá...\n\nCó vẻ như có khá nhiều người cảm thấy “mình đọc sách chậm” và buồn phiền vì điều đó. Có lẽ là bởi họ thấy quanh mình có nhiều người đọc rất nhanh, hết cuốn này đến cuốn khác.\n\nTôi cũng đã từng muộn phiền vì điều đó nên tôi hiểu rõ cảm xúc ấy.\n\nHiện nay, với tư cách là nhà bình luận sách, mỗi tháng tôi đóng góp ý kiên về gần 60 cuốn sách cho nhiêu website thông tin như Lifehacker [bản tiếng Nhật] hay Newsweek Japan.\n\nSố lượng đầu sách thực tế tôi đọc trong một tháng là trên 60 cuốn. Tôi đọc sách gần như cà ngày.\n\n“Anh giỏi thật đấy! Tôi đọc sách chậm lắm nên không thể đọc 60 cuốn sách một tháng. Lại còn viết lời bình cho những cuốn sách ấy nữa. Thật không thể tưởng tượng được.”\n\nMọi người thường hay nói với tôi như thế, nhưng sự thật là, tôi cũng là một người đọc sách chậm.\n\nKhi tính thử thời gian đọc một cuốn sách dịch có nội dung về kinh doanh, tôi đã mất khoảng năm phút cho một trang sách. Còn nếu đọc lơ đãng thì phải mất 10 phút mới hết một trang sách.\n\nKhi đọc đến dòng cuối cùng thì tôi nhận ra, “mình chẳng có chút ký ức nào về 10 dòng vừa đọc cả”, khi đọc lại thì “không ổn rồi, cả phần trước đấy cũng hoàn toàn không vào đầu...” và tôi giở ngược lại những trang trước nữa, trước nữa...\n\nTôi cố tình lờ đi thì cứ vài bữa tình trạng ấy lại lặp lại.','Đọc nhanh hiểu sâu nhớ lâu trọn đời','https://play.google.com/store/books/details/Atsushi_Innami_%C4%90%E1%BB%8Dc_nhanh_hi%E1%BB%83u_s%C3%A2u_nh%E1%BB%9B_l%C3%A2u_tr%E1%BB%8Dn_%C4%91%E1%BB%9Di?id=SHS6EAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/SHS6EAAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:15:24.356000','https://play.google.com/store/books/details/Atsushi_Innami_%C4%90%E1%BB%8Dc_nhanh_hi%E1%BB%83u_s%C3%A2u_nh%E1%BB%9B_l%C3%A2u_tr%E1%BB%8Dn_%C4%91%E1%BB%9Di?id=SHS6EAAAQBAJ',1,5,6),(4,'Tổng hợp những kiến thức ngữ pháp tiếng Trung cơ bản thường gặp trong các kỳ thi HSK-3. Dành cho các bạn đang học các quyển giáo trình Hán ngữ 1 và Hán ngữ 2, nắm được những kiến thức ngữ pháp tiếng Trung cơ bản và đang ôn tập chuẩn bị bước vào kỳ thi lấy chứng chỉ HSK-3','Sổ tay ngữ pháp HSK-3','https://play.google.com/store/books/details/Nguy%E1%BB%85n_Thoan_S%E1%BB%95_tay_ng%E1%BB%AF_ph%C3%A1p_HSK_3?id=cpGZDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/cpGZDwAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:15:24.356000','https://play.google.com/store/books/details/Nguy%E1%BB%85n_Thoan_S%E1%BB%95_tay_ng%E1%BB%AF_ph%C3%A1p_HSK_3?id=cpGZDwAAQBAJ',1,20,9),(5,'\"Trò chuyện với vĩ nhân” tổng hợp những câu chuyện của thiền sư Osho về 20 triết gia, nhà tư tưởng, đạo sư lỗi lạc nhất lịch sử.\nDanh sách những bậc vĩ nhân Osho bàn đến rất đa dạng: Ở phương Đông có Lão Tử, Trang Tử; phương Tây có Socrates, Pythagoras, J. Krishnamurtri, Heraclitus, những nhà lãnh đạo tôn giáo như Phật Thích Ca Mâu Ni, Bồ Đề Đạt Ma, Jesus Christ ... \nDưới ngòi bút sắc sảo của Osho, cuộc đời, tư tưởng và hành trình giác ngộ của những bậc vĩ nhân hiển lên đầy sống động. Ông kể về thời thơ ấu bất hạnh của Krishnamurti, cái chết của Socrates, cuộc gặp gỡ giữa Khổng Tử với Lão Tử hay khoảnh khắc chứng ngộ của ni sư Chiyono.','Trò chuyện với vĩ nhân ',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/28710.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 02:15:24.356000','https://waka.vn/ebook/tro-chuyen-voi-vi-nhan-b4W1qW.html',1,21,9),(6,'Phụ Nữ Hiện Đại Nghĩ Giàu Và Làm Giàu - Cuốn Sách Mang Đến Kim Chỉ Nam Thành Công, Hạnh Phúc Cho Một Nửa Thế Giới\n\nRa mắt lần đầu tiên cách đây hơn 80 năm, những nguyên tắc trong “Nghĩ giàu và làm giàu” của Napoleon Hill đến nay vẫn giữ nguyên giá trị là kim chỉ nam cho bất kỳ ai muốn vươn tới một cuộc sống sung túc, thịnh vượng về mọi phương diện đời sống. Với phương pháp nghiên cứu phỏng vấn hàng ngàn người thuộc mọi giới tính và tầng lớp, để hiểu về câu chuyện thành công và thất bại của họ, nhằm rút ra nguyên tắc chung nhất về xây dựng và thúc đấy cá nhân, cuốn sách của Hill thật sự mang tính phổ quát, chân thật và có giá trị lâu bền. Tuy nhiên, ra đời trong giai đoạn mà vai trò xã hội giữa nam và nữ vẫn còn nhiều cách biệt, những điển hình thành đạt trình bày trong “Nghĩ giàu, làm giàu” của Napoleon Hill lại chủ yếu tập trung vào nam giới. Đó chính là lý do, tác phẩm được xem là gối đầu giường của doanh nhân toàn thế giới ấy, phần nào đó, vẫn không chạm được nửa còn lại của thế giới. Phần thiếu hụt ấy, sau nhiều năm, đã đươc Sharon Lechter bổ sung, bù đắp qua ấn phẩm Phụ nữ hiện đại nghĩ giàu và làm giàu.\n\n Sharon Lechter là một điển hình tiêu biểu của phụ nữ hiện đại, thành công, tạo dựng một cuộc đời giàu có không chỉ về tài chính mà còn về giá trị con người. Bà hiện là một chuyên gia quốc tế về tài chính được trọng vọng trong vai trò là thành viên hộ đồng Tư vấn Tài chính cho hai đời tổng thống Mỹ là G. W. Bush và Barack Obama. Bà đồng thời là một nhà từ thiện, nhà giáo dục, diễn giả quốc tế, và là tác giả của nhiều đầu sách bán chạy trên thế giới. Mang đến độc giả bước nối dài trong hành trình giúp đỡ doanh giới của Napoleon Hill, cuốn sách của Sharon tâp trung khai thác những hình mẫu thành công điển hình của doanh nhân nữ, trong môi trường kinh doanh quốc tế.\n\nCuốn sách có đề mục chương giống với nguyên tác Nghĩ giàu và làm giàu. Mỗi chương sẽ bắt đầu bằng việc tóm tắt ngắn gọn bài học của Napoleon Hill. Sau phần tóm tắt bài học sẽ là câu chuyện thành công của những nhà lãnh đạo nữ đã vận dụng nguyên tắc làm giàu ấy. Tuy nhiên, dựa trên những nguyên tắc thành công đã được chứng minh qua thực tế và thời gian của Napoleon Hill, Sharon Lechter phân tích thấu đáo, sâu sát con đường từ khởi nghiệp đến khi gõ của thành công của những bông hồng trên thương trường. Từ đó, bà vạch ra được 13 nguyên tắc – 13 bước đi chiến lược dẫn đến thành công dành cho phụ nữ thời hiện đại. Đó cũng là lý do, Sharon Lechter không những tôn vinh sự nghiệp của Napoleon Hill mà bà còn là hiện thân cho những triết lý của Napoleon Hill.','Phụ Nữ Hiện Đại Nghĩ Giàu Và Làm Giàu',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/1/32983.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 04:15:24.356000','https://waka.vn/ebook/phu-nu-hien-dai-nghi-giau-lam-giau-sharon-lechter-bMAEvW.html',1,19,9),(7,'“Trong đời người ai cũng có những giây phút thật tuyệt vọng. Lúc ấy, khi mà sự cô độc là nỗi bất hạnh lớn nhất thì hơn hết lúc nào hết, ta cần có một tình yêu thương và điểm tựa tinh thần.”\n\n“Cuộc sống vốn có nhiều khó khăn, thử thách, cả thất vọng, nỗi buồn. Vì thế, sự chia sẻ và động viên tinh thần mang một ý nghĩ quan trọng. Chính những trái tim nhân ái, vòng tay chia sẻ yêu thương sẽ nâng đỡ và giúp chúng ta dũng cảm vượt qua những nỗi đau thương, mất mát để hướng đến một ngày mai tươi đẹp với ước mơ và hoài bão to lớn, đồng thời giúp chúng ta cảm nhận cuộc sống một cách trọn vẹn hơn.”\n\nĐó chính là ý tưởng chính của tập sách Hạt Giống Tâm Hồn cho những trái tim rộng mở do First News vừa phát hành. Tập sách đặc biệt này tuyển chọn những bài viết hay, độc đáo, mang nhiều ý nghĩa sâu sắc, gần gũi với cuộc sống và mang tính tự nhận thức và giáo dục cao.\n\nCó ai sống trên đời này lại không khát khao nhận được sự quan tâm, quý mến của mọi người? Có mấy ai lại dám lớn tiếng tuyên bố rằng tôi có thể sống một mình trên cõi đời mà không cần bất kỳ lời chia sẻ, tình cảm yêu thương nào? Vậy chúng ta nên sống như thế nào để có được sự quan tâm và những tình cảm yêu thương ấy? Yêu thương là một cảm xúc thiêng liêng và gần gũi trong cuộc sống của chúng ta. Không một ai có thể sống trên đời mà thiếu tình yêu thương. Vì thế nếu muốn được yêu thương, trước hết bạn hãy yêu thương những người xung quanh. Hãy mở rộng trái tim và quan tâm đến mọi người, để họ nhận thấy sự tồn tại của bạn. Cũng như bạn, họ cũng là những con người khát khao tình yêu thương, sự quan tâm, và bạn hoàn toàn có thể trao tặng họ tất cả những điều ấy.\n\nCuộc sống của bạn sẽ ý nghĩa hơn nhiều khi bạn biết dành tình thương yêu, biết dùng trái tim nhân ái của mình để sưởi ấm và làm cho cuộc sống của những người xung quanh ấm áp, hạnh phúc hơn. Những câu chuyện về tình yêu thương, về sự chia sẻ, quan tâm trong tập sách Hạt Giống Tâm Hồn Cho Những Trái Tim Rộng Mở sẽ thôi thúc bạn dang rộng cánh tay chia sẻ đầy yêu thương với bạn bè và người thân, sẽ làm bạn bừng sáng với những thời khắc của sự vượt lên chính mình, sẽ là niềm an ủi, xoa dịu những khi bạn căng thẳng tinh thần. Chúng còn khơi dậy khát vọng trong bạn, khuyến khích bạn kiên trì nuôi dưỡng ước mơ, sẵn sàng vượt qua những khó khăn, thử thách mà bạn chắc chắn sẽ gặp phải trên cuộc hành trình để biến ước mơ thành hiện thực.\n\nThông qua những câu chuyện, bạn có thể tìm lại chính mình, có thêm niềm tin, nghị lực để thực hiện những ước mơ, khát vọng, biết chia sẻ và đồng cảm với nỗi đau của những người xung quanh, cảm nhận được giá trị đích thực của cuộc sống.','Hạt giống tâm hồn - Cho những trái tim rộng mở',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/31311.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 06:15:24.356000','https://waka.vn/ebook/hat-giong-tam-hon-cho-nhung-trai-tim-rong-mo-b3RErW.html',1,5,9),(8,'Bí Quyết Thành Công Dành Cho Bạn Trẻ\nBí quyết thành công dành cho bạn trẻ chính là kim chỉ nam cho các bạn thanh thiếu niên, những người vừa trưởng thành và bước vào đời cũng như ngay cả chính bản thân chúng ta bởi vì không bao giờ là quá muộn khi chúng ta nhận ra được ước mơ và sự thành công mà mình muốn vươn đến.\n\nBất kể mục tiêu của bạn là trở thành một học sinh xuất sắc hay một vận động viên vượt trội, bắt đầu kinh doanh, kiếm được hàng triệu đô-la hay đơn giản chỉ là tìm sự định hướng và chỉ dẫn để sống thành công và hạnh phúc ở hiện tại và tương lai thì đây chính là cuốn sách dành cho bạn.\n\nĐây không chỉ là một bộ sưu tập những “ý tưởng hay” mà cuốn sách này bao gồm 20 nguyên tắc thành công quan trọng nhất đã được hàng triệu bạn trẻ thành công áp dụng. Với những công cụ chính xác thì bất cứ ai cũng có thể nhắm trúng mục tiêu.\n\nCuốn sách này sẽ cho bạn lòng can đảm và nhiệt huyết để tiến về phía trước!','Bí quyết thành công dành cho bạn trẻ',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/11051.jpg?v=2&w=480&h=700',0,NULL,'2023-12-14 00:15:24.356000','https://waka.vn/ebook/bi-quyet-thanh-cong-danh-cho-ban-tre-jack-canfield-bZRQ4W.html',1,5,10),(9,'Đây là bộ đề thi TOEIC mới nhất do cơ quan khảo thí quốc tế ETS phát hành. Bộ sách này bao gồm 10 bộ đề thi TOEIC phần Listening (LC) đã được sử dụng trong các kỳ thi TOEIC trong quá khứ. Nó giúp người học làm quen với cấu trúc và định dạng của bài kiểm tra, rèn kỹ năng làm bài và cải thiện điểm số.','Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/tWQxbbUkR72G0T6hJ80s','https://haloenglish.edu.vn/wp-content/uploads/2024/01/Bo-tai-lieu-TOEIC-ETS-2024-LC-RC-Vol-4.jpg',10,NULL,'2023-12-14 02:15:24.356000','https://cdn.fs.teachablecdn.com/tWQxbbUkR72G0T6hJ80s',1,20,10),(10,'Đây là bộ đề thi TOEIC mới nhất do cơ quan khảo thí quốc tế ETS phát hành. Bộ sách này bao gồm 10 bộ đề thi TOEIC phần Reading (RC) đã được sử dụng trong các kỳ thi TOEIC trong quá khứ. Nó giúp người học làm quen với cấu trúc và định dạng của bài kiểm tra, rèn kỹ năng làm bài và cải thiện điểm số.','Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/IVmOuToRQkKIFNdiv2hm','https://haloenglish.edu.vn/wp-content/uploads/2024/01/Bo-tai-lieu-TOEIC-ETS-2024-LC-RC-Vol-4.jpg',11,NULL,'2023-12-14 04:15:24.356000','https://cdn.fs.teachablecdn.com/IVmOuToRQkKIFNdiv2hm',1,20,10),(11,'Bộ tài liệu “Transcript cuốn LC Full 10 Test cuốn ETS 2024 LC” là một nguồn quý báu cho những ai đang luyện tập và chuẩn bị cho kỳ thi TOEIC\nBao gồm transcript (lời thoại) cho 10 bài thi TOEIC phần Listening (LC).\nBạn có thể sử dụng transcript để luyện tập nghe, kiểm tra và cải thiện kỹ năng tiếng Anh của mình.\nHiểu rõ cấu trúc và nội dung của bài thi sẽ giúp bạn tự tin hơn khi tham gia kỳ thi TOEIC.','Transcript cuốn LC Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/80clz88rSnqsWIHqfxgw','https://imgbox.com/FmbQ7SH3',5,NULL,'2023-12-14 06:15:24.356000','https://cdn.fs.teachablecdn.com/80clz88rSnqsWIHqfxgw',1,20,10),(12,'Bộ tài liệu “File Audio từ Test 1 đến Test 10 Full 10 Test cuốn ETS 2024 LC” là một nguồn quý báu cho những ai đang luyện tập và chuẩn bị cho kỳ thi TOEIC.\nBao gồm file âm thanh (audio) cho 10 bài thi TOEIC phần Listening (LC) từ Test 1 đến Test 10.\nFile audio được tạo ra từ các bài thi thật, giúp bạn làm quen với cách diễn đạt, giọng điệu và từ vựng thường xuất hiện trong bài thi TOEIC.\nBạn có thể sử dụng file audio để luyện tập nghe, kiểm tra và cải thiện kỹ năng tiếng Anh của mình.\nHiểu rõ cấu trúc và nội dung của bài thi sẽ giúp bạn tự tin hơn khi tham gia kỳ thi TOEIC.',' File Audio từ Test 1 đến Test 10 Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/KHZRdFzQ0aU6or726Qtz','https://kimnhungtoeic.com/wp-content/uploads/2024/01/ETS-2024.jpg',5,NULL,'2023-12-14 08:15:24.356000',NULL,1,20,10),(15,'Ôn tập TOEIC mức 650+','Tài liệu TOEIC','https://drive.google.com/uc?id=1HhJ9fozkpJ4BggUS_rR-Ln4iaaxz_oTW&export=download',NULL,0,'2024-03-27 21:32:11.503000','2024-03-27 21:29:53.261000','https://drive.google.com/file/d/1HhJ9fozkpJ4BggUS_rR-Ln4iaaxz_oTW/preview',1,5,19);
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_like`
--

DROP TABLE IF EXISTS `document_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_like` (
  `doc_id` int NOT NULL,
  `user_id` int NOT NULL,
  `is_liked` bit(1) NOT NULL,
  `liked_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`doc_id`,`user_id`),
  KEY `document_like_ibfk_2_idx` (`user_id`),
  CONSTRAINT `document_like_ibfk_1` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `document_like_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_like`
--

LOCK TABLES `document_like` WRITE;
/*!40000 ALTER TABLE `document_like` DISABLE KEYS */;
INSERT INTO `document_like` VALUES (1,6,_binary '','2023-12-14 08:57:24.356000'),(1,12,_binary '','2023-12-14 08:58:24.356000'),(1,13,_binary '','2023-12-14 08:59:24.356000'),(1,15,_binary '','2023-12-14 09:01:24.356000'),(1,19,_binary '','2023-12-14 09:30:24.356000'),(1,21,_binary '','2023-12-14 09:31:24.356000'),(1,30,_binary '','2023-12-14 09:32:24.356000'),(2,6,_binary '','2023-12-14 01:11:24.356000'),(2,41,_binary '','2023-12-14 02:11:24.356000'),(2,42,_binary '','2023-12-14 03:11:24.356000'),(2,43,_binary '','2023-12-14 04:11:24.356000'),(2,44,_binary '','2023-12-14 05:11:24.356000'),(2,45,_binary '','2023-12-14 06:11:24.356000');
/*!40000 ALTER TABLE `document_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field` (
  `field_id` int NOT NULL AUTO_INCREMENT,
  `field_name` varchar(100) NOT NULL,
  `is_disabled` bit(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
INSERT INTO `field` VALUES (1,'Văn học',_binary '\0','2023-12-08 23:57:24.356000',NULL),(2,'Âm nhạc',_binary '\0','2023-12-08 23:57:25.356000',NULL),(3,'Điện ảnh',_binary '\0','2023-12-08 23:57:26.356000',NULL),(4,'Ẩm thực',_binary '\0','2023-12-08 23:57:27.356000',NULL),(5,'Phát triển bản thân',_binary '\0','2023-12-08 23:57:28.356000',NULL),(6,'Báo chí',_binary '\0','2023-12-08 23:57:29.356000',NULL),(7,'Hội họa',_binary '\0','2023-12-08 23:57:30.356000',NULL),(8,'Kiến trúc',_binary '\0','2023-12-08 23:57:24.356000',NULL),(9,'Giao thông vận tải',_binary '\0','2023-12-08 23:57:34.356000',NULL),(10,'Sinh học',_binary '\0','2023-12-08 23:57:35.356000',NULL),(11,'Kỹ năng giao tiếp',_binary '\0','2023-12-08 23:57:36.356000',NULL),(12,'Công nghệ thông tin',_binary '\0','2023-12-08 23:57:37.356000',NULL),(13,'Thời trang',_binary '\0','2023-12-08 23:57:24.356000',NULL),(14,'Thể thao',_binary '\0','2023-12-08 23:57:38.356000',NULL),(15,'Địa chất',_binary '\0','2023-12-08 23:57:39.356000',NULL),(16,'Xuất bản',_binary '\0','2023-12-08 23:57:40.356000',NULL),(17,'Công nghiệp ô tô',_binary '\0','2023-12-08 23:57:24.356000',NULL),(18,'Y học',_binary '\0','2023-12-08 23:57:24.356000',NULL),(19,'Đầu tư - Kinh doanh',_binary '\0','2023-12-08 23:57:24.356000',NULL),(20,'Ngoại ngữ',_binary '\0','2023-12-08 23:57:24.356000',NULL),(21,'Tâm linh',_binary '\0','2023-12-08 23:57:24.356000',NULL);
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `noti_id` int NOT NULL AUTO_INCREMENT,
  `is_read` bit(1) NOT NULL,
  `referred_id` int NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `user_received_id` int DEFAULT NULL,
  `user_triggered_id` int DEFAULT NULL,
  PRIMARY KEY (`noti_id`),
  KEY `FK8hqcsrdk18hh77oos0cii496w` (`user_received_id`),
  KEY `FK26hcgm32f8ash543133vqtah6` (`user_triggered_id`),
  CONSTRAINT `FK26hcgm32f8ash543133vqtah6` FOREIGN KEY (`user_triggered_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK8hqcsrdk18hh77oos0cii496w` FOREIGN KEY (`user_received_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,_binary '\0',1,'POST_LIKE',6,21),(2,_binary '\0',7,'POST_LIKE',21,5),(3,_binary '\0',5,'COMMENT_LIKE',10,21),(5,_binary '\0',1,'POST_LIKE',6,10),(13,_binary '\0',1,'DOC_LIKE',10,21),(14,_binary '\0',1,'DOC_LIKE',10,21);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `posted_by` int DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_ibfk_1_idx` (`posted_by`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Mình có dư một cuốn sách Nhập môn lập trình\nBạn nào muốn lấy thì bình luận phía dưới nha!','2023-12-13 23:57:24.356000','Sách Nhập môn lập trình',NULL,6),(2,'Ai có pdf môn Triết học không, cho mình ké với!\nMình cảm ơn!','2023-12-14 23:57:25.183000','PDF Triết học',NULL,6),(3,'Mình có tài liệu Tóm tắt công thức lớp Vật lý 1 \nAi cần bình luận nha!','2023-12-15 23:57:25.183000','Công thức Vật lý 1',NULL,6),(4,'Có bạn nào có nhiều bài báo nghiên cứu về ứng dụng của Triết học không nhỉ?','2023-12-16 23:57:25.183000','Bài báo ứng dụng Triết học ',NULL,7),(5,'Có bạn nào có tài liệu để nghiên cứu đề tài bên dưới không, cho mình xin với!\nHigh-cell-density fermentations using Bacillus subtilis','2023-12-17 23:57:25.183000','High-cell-density fermentations using Bacillus subtilis',NULL,7),(6,'Có ai có PDF Tư tưởng Hồ Chí Minh mới nhất không ạ?','2023-12-18 11:57:25.183000','Tư tưởng HCM mới nhất',NULL,7),(7,'Mình có kiếm được vài sách Triết học khá hay, bạn nào tò mò thì vào trang cá nhân mình coi nha','2023-12-18 12:57:25.183000','Sách Triết học',NULL,21),(8,'Mình có bản dịch tài liệu hướng dẫn sử dụng CSDL mySQL \nBạn nào muốn xem thì vào trang mình ','2023-12-18 13:57:25.183000','HDSD mySQL',NULL,9),(9,'Mình có vài tài liệu học AI, vào trang mình để xem ','2023-12-18 14:57:25.183000','Học AI',NULL,9),(10,'Tài liệu bản dịch hướng dẫn sử dụng Intellij','2023-12-18 16:57:25.183000','HDSD Intellij',NULL,9),(11,'Mình có sưu tầm những bài thơ hay nhất của Xuân Diệu, bạn nào muốn đọc thì qua trang mình','2023-12-18 17:57:25.183000','Thơ Xuân Diệu',NULL,6),(12,'Ai có sách An toàn thông tin nào giải thích chi tiết dễ hiểu không, cho mình xin với!','2023-12-18 18:57:25.183000','An toàn thông tin ',NULL,6),(15,'Có tài liệu nào hướng dẫn dùng Swagger UI không nhỉ? Tiếng Việt càng tốt ạ! Mình cảm ơn!','2024-03-09 19:50:58.721000','Có tài liệu nào hướng dẫn dùng Swagger UI không nhỉ? Tiếng Việt càng tốt ạ!','2024-03-09 19:51:44.280000',47);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_like`
--

DROP TABLE IF EXISTS `post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_like` (
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `liked_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_like_ibfk_1_idx` (`user_id`),
  CONSTRAINT `post_like_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_like_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_like`
--

LOCK TABLES `post_like` WRITE;
/*!40000 ALTER TABLE `post_like` DISABLE KEYS */;
INSERT INTO `post_like` VALUES (1,10,'2023-12-14 08:57:24.356000'),(1,12,'2023-12-14 08:57:24.356000'),(1,13,'2023-12-14 08:57:24.356000'),(1,21,'2023-12-14 08:57:24.356000'),(1,23,'2023-12-14 08:57:24.356000'),(1,28,'2023-12-14 08:57:24.356000'),(2,13,'2023-12-15 08:57:25.183000'),(2,15,'2023-12-15 08:57:25.183000'),(2,18,'2023-12-15 08:57:25.183000'),(3,13,'2023-12-16 08:57:25.183000'),(3,15,'2023-12-16 08:57:25.183000'),(3,18,'2023-12-16 08:57:25.183000'),(4,28,'2023-12-17 08:57:25.183000'),(4,29,'2023-12-17 08:57:25.183000'),(4,30,'2023-12-17 08:57:25.183000');
/*!40000 ALTER TABLE `post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tag` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `post_tag_ibfk_2_idx` (`tag_id`),
  CONSTRAINT `post_tag_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tag`
--

LOCK TABLES `post_tag` WRITE;
/*!40000 ALTER TABLE `post_tag` DISABLE KEYS */;
INSERT INTO `post_tag` VALUES (1,1),(1,2),(2,3),(4,3),(7,3),(3,4),(5,6),(6,7),(8,8),(9,9),(10,10),(11,11),(12,12);
/*!40000 ALTER TABLE `post_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name_UNIQUE` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_MANAGER'),(3,'ROLE_STUDENT');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'2023-12-08 23:57:24.356000','CNTT',NULL),(2,'2023-12-08 23:57:25.356000','IT',NULL),(3,'2023-12-08 23:57:24.356000','Triết học',NULL),(4,'2023-12-08 23:57:26.356000','Vật lý',NULL),(5,'2023-12-08 23:57:24.356000','Đại học',NULL),(6,'2023-12-08 23:57:27.356000','Hóa sinh',NULL),(7,'2023-12-08 23:57:24.356000','Tư tưởng Hồ Chí Minh',NULL),(8,'2023-12-08 23:57:28.356000','CSDL',NULL),(9,'2023-12-08 23:57:24.356000','AI',NULL),(10,'2023-12-08 23:57:29.356000','IDE',NULL),(11,'2023-12-08 23:57:24.356000','Xuân Diệu',NULL),(12,'2023-12-08 23:57:30.356000','An toàn thông tin',NULL);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `date_of_birth` datetime(6) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `gender` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_disabled` bit(1) NOT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `is_authenticated` bit(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `user_ibfk_1_idx` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2023-12-12 23:57:24.356000','1995-02-12 00:00:00.000000','thanhminh1203@gmail.com','Thành Minh',0,NULL,_binary '\0','Lê','$2a$10$THPrBzBUMyI2ospNwy4nleGkuG3CiDNpVbrN8Tdq8jylXvnGWouhi','2023-12-13 12:33:29.004000',1,_binary ''),(2,'2023-12-12 23:57:24.511000','1992-06-05 00:00:00.000000','anhtu0506@gmail.com','Anh Tú',0,NULL,_binary '\0','Văn','$2a$10$BGBoIoU5gCBdBTNU62prQOoA.vGqwXljwqnaaOeNrzc2ZecFxaI1m','2023-12-13 12:33:29.157000',1,_binary ''),(3,'2023-12-12 23:57:24.711000','1997-11-17 00:00:00.000000','ngocngan1711@gmail.com','Ngọc Ngân',1,NULL,_binary '\0','Trần Lê','$2a$10$GD8/tJEJLXktd61ew0ynl.5dJASdzCPQ8gknAHfyV8L1W3yLZ38dK','2023-12-13 12:33:29.296000',1,_binary ''),(4,'2023-12-12 23:57:24.875000','1995-10-12 00:00:00.000000','ynhi1210@gmail.com','Ý Nhi',1,NULL,_binary '\0','Phan','$2a$10$9zN5kHVfuTSJl5YHLRlsGOQdtVVMtEfzauc4f3WOI4omqQwK.4cDW','2023-12-13 12:33:29.513000',1,_binary ''),(5,'2023-12-12 23:57:25.029000','1995-06-04 00:00:00.000000','minhdang0406@gmail.com','Minh Đăng',0,NULL,_binary '\0','Lê','$2a$10$HCTocTLPk7CQZvFwcSK.ke7Cs5752Y4szajZrfJ7k997cY7Q9MhTe','2023-12-13 12:33:29.801000',2,_binary ''),(6,'2023-12-12 23:57:25.183000','1980-01-01 00:00:00.000000','hoangphuc0101@gmail.com','Hoàng Phúc',0,NULL,_binary '\0','Phạm','$2a$10$.NkgGr1CcEPyzGn9yV7po.nXebChdMlwwuTmz6CUZmO9tschaeDMK','2023-12-13 12:33:30.058000',3,_binary ''),(7,'2023-12-12 23:57:25.357000','2005-05-19 00:00:00.000000','vantu1905@gmail.com','Văn Tú',0,NULL,_binary '\0','Hoàng','$2a$10$2YC/iiWlVKi./BhUxCCCfehA5PUUqfB0MsrBUH/eTElxZ.Zw8i8Ue','2023-12-13 12:33:30.212000',3,_binary ''),(8,'2023-12-12 23:57:25.529000','1994-05-12 00:00:00.000000','thienthanh1205@gmail.com','Thiên Thành',0,NULL,_binary '\0','Vũ','$2a$10$oJWggU3G3PIPN7KDOiQNPuedLH1667jhrMXPjVyiSTjzFOYS6BSNK','2023-12-13 12:33:30.363000',2,_binary ''),(9,'2023-12-12 23:57:25.737000','1990-08-26 00:00:00.000000','ngochan2608@gmail.com','Ngọc Hân',1,NULL,_binary '\0','Ngô','$2a$10$1rVp/LDy25LMV20a4mYPRe/PnbbhhgUkeKVuw274iHHHlkzQZs6Uu','2023-12-13 12:33:30.510000',3,_binary ''),(10,'2023-12-12 23:57:25.885000','2001-02-17 00:00:00.000000','thikieu1703@gmail.com','Thị Kiều',1,NULL,_binary '\0','Đinh','$2a$10$Mdv3Vibgsvmc7qRhQMktA.zZOt.SFVvfbJ96Hr1d/pvQkaaP37q9y','2023-12-13 12:33:30.649000',3,_binary ''),(11,'2023-12-12 23:57:26.034000','1990-11-30 00:00:00.000000','tantho3011@gmail.com','Tấn Thọ',0,NULL,_binary '\0','Lý','$2a$10$F5KLexFwvCACB7lTlxoSyejpj3LYu6vxhbNPI8eqH3J2QdBvuAi4e','2023-12-13 12:33:30.788000',2,_binary ''),(12,'2023-12-12 23:57:26.184000','1986-08-08 00:00:00.000000','ngocphuc0808@gmail.com','Ngọc Phúc',0,NULL,_binary '\0','Phan','$2a$10$2Y2Y.FsH354WlAU7bbZE5OLbAICQO.La28LqFuzlYsBYdfGQH3aES','2023-12-13 12:33:30.920000',3,_binary ''),(13,'2023-12-12 23:57:26.407000','2002-01-19 00:00:00.000000','thinga1901@gmail.com','Thị Nga',1,NULL,_binary '\0','Nguyễn','$2a$10$7COMF9a5RxlW9Eo0vlSxluiAH.CCk6nCilRrWHWU7suiYkq4xyE.S','2023-12-13 12:33:31.065000',3,_binary ''),(14,'2023-12-12 23:57:26.542000','1992-07-17 00:00:00.000000','duyphuc1707@gmail.com','Duy Phúc',0,NULL,_binary '\0','Đặng','$2a$10$wrVvWK1/orWr4sl12O2JDe/NzXG3hQ0E8zHI0AOH3Such6XsAFVLC','2023-12-13 12:33:31.201000',2,_binary ''),(15,'2023-12-12 23:57:26.682000','1988-05-10 00:00:00.000000','tanhai1005@gmail.com','Tấn Hải',0,NULL,_binary '\0','Nguyễn','$2a$10$4bn.y/d6EUy4pgrvoCaINOpZ5Vdgk9.fc5s/XR.yGiSqfqOeUJLc.','2023-12-13 12:33:31.334000',3,_binary ''),(16,'2023-12-12 23:57:26.814000','1999-02-16 00:00:00.000000','phucan1602@gmail.com','Phúc An',0,NULL,_binary '\0','Trần','$2a$10$o5kqinB37PAuPaYCbCtO5.GXYfHU1OmF/zaAmtsnqf5/fGyCR4KO6','2023-12-13 12:33:31.469000',3,_binary ''),(17,'2023-12-12 23:57:27.102000','1993-02-20 00:00:00.000000','vananh2002@gmail.com','Văn Anh',0,NULL,_binary '\0','Phạm','$2a$10$1QwKJDu8ZNvAO.I.sObx2u33MXNsUNTz4G9q16dGB7MR9TRxDPVTe','2023-12-13 12:33:31.603000',2,_binary ''),(18,'2023-12-12 23:57:27.268000','2004-09-17 00:00:00.000000','tranminh1709@gmail.com','Trần Minh',0,NULL,_binary '\0','Lê','$2a$10$WQgBf0W319EZW8Z.Dt/tMul/kFapXEbD0qJc51km8eyCKjgPhW7ZC','2023-12-13 12:33:31.738000',3,_binary ''),(19,'2023-12-12 23:57:27.661000','2000-03-27 21:36:10.187000','ngocduyen2704@gmail.com','Ngọc Duyên',1,'https://drive.google.com/thumbnail?id=1k7DYdEY68RFnnuypq_kkNUeiuBXLYT_V',_binary '\0','Nguyễn','$2a$10$S6Am3l7DFHifSAbiMB945.9vvkFRJjd6xg/cUL3N0X7XLvq7vFg5q','2024-03-27 21:39:56.611000',3,_binary ''),(20,'2023-12-12 23:57:27.961000','1997-01-14 00:00:00.000000','minhanh1401@gmail.com','Minh Anh',0,NULL,_binary '\0','Trần','$2a$10$XogLg36S4eF9Ca4ZkVxDkupOdUqvpahfNHlk/t.tFDMOEUHZwPNe2','2023-12-13 12:33:32.013000',2,_binary ''),(21,'2023-12-12 23:57:28.205000','2003-08-30 00:00:00.000000','tuantu3008@gmail.com','Tuấn Tú',0,NULL,_binary '\0','Phan','$2a$10$.X.crtgrBw9/cV2cOUW2HOXydh0ELnE7F4aql5PSae2Oa27oQWXl.','2023-12-13 12:33:32.149000',3,_binary ''),(22,'2023-12-12 23:57:28.378000','1992-05-05 00:00:00.000000','quoctuan0505@gmail.com','Quốc Tuấn',0,NULL,_binary '\0','Nguyễn','$2a$10$CAVgg8rYqz5mRPkDCKYV9u2GnxT/sTE1EqDNx.egaXbo/5imHP41C','2023-12-13 12:33:32.291000',2,_binary ''),(23,'2023-12-12 23:57:28.529000','2001-09-10 00:00:00.000000','tutrinh1009@gmail.com','Tú Trình',0,NULL,_binary '\0','Võ Lê','$2a$10$7LeISovxlvwHrGFnijx4oOjxVNIAbCTPqjNZcK15GSjYJnOm89NAy','2023-12-13 12:33:32.423000',3,_binary ''),(24,'2023-10-01 23:11:00.749000','2002-11-10 00:00:00.000000','lephananh16@gmail.com','Anh',1,NULL,_binary '\0','Lê','$2a$10$d.3D4QSnCj4se3hMlu.Vn.XeGRdoxq3Sin4PCpUoCkGIfTfHRq5Ze','2023-10-01 23:11:00.749000',1,_binary ''),(25,'2023-12-02 22:53:03.846000','1990-10-09 00:00:00.000000','thuannguyen1012@gmail.com','Thuận',0,'https://drive.google.com/uc?id=194PCQEYVau6TMi79H0EJR9YAimsx1gBc',_binary '\0','Nguyễn Văn','$2a$10$oLwgKKJyDl33GMeuSuddF.bEui/A7XU5kfAmEmogmI4qTvzVvpL5K','2023-12-14 01:39:35.978000',2,_binary ''),(26,'2023-12-14 11:50:35.593000','2002-06-11 00:00:00.000000','20110732@student.hcmute.edu.vn','Van Thuan',0,'https://drive.google.com/uc?id=1S2_YwA8uzZTHWubzptbrCtd9OAXYLiv-',_binary '\0','Nguyen','$2a$10$R5aq9soSvR8ID7nXNtXUQ.lx/qPZ1uwIyzV8XrLahoqDp29Qxtrfm','2023-12-14 11:50:35.593000',1,_binary ''),(27,'2023-09-24 10:17:30.586000','2002-12-10 00:00:00.000000','vanthuan2724@gmail.com','Trường Thuận',0,'https://drive.google.com/uc?id=1hKCUQJjbVFWl3bfFr7VMauWedTX2hivM',_binary '\0','Nguyễn Văn','$2a$10$ZOZ3i1uTPW1pepuM3JW7TO2NSESuorh.XNEoFc6TjSj3CnpY5mzcy','2023-12-14 11:25:20.876000',1,_binary ''),(28,'2023-09-24 10:17:30.782000','2005-12-20 00:00:00.000000','thuhang2012@gmail.com','Thu Hằng',1,'https://drive.google.com/uc?id=1XwFb2p0v7RYMNC1Kcjh2fqT2hxnPzAoM',_binary '\0','Trần','$2a$10$A4zZFA4USlqW/b1Y.BXaUOACBR.L/yBZFbeQgZLoNobYSw/HEDaj.','2023-12-14 10:29:11.535000',3,_binary ''),(29,'2023-09-24 10:17:30.907000','1999-01-06 00:00:00.000000','phantu0601@gmail.com','Phan Tú',0,NULL,_binary '\0','Lê','$2a$10$VEUZsVux1OnKIWG4RSBfKeXeDo.3Lz/a3NG81/hbNJAUvcV9CM9Y2','2023-12-14 11:37:39.839000',3,_binary ''),(30,'2023-09-24 10:17:31.030000','1999-01-05 00:00:00.000000','quocnam0501@gmail.com','Quốc Nam',0,NULL,_binary '\0','Lê','$2a$10$0jPdtCcdVRWLyE0WSig8TOYfmxhR4R2gBDlr0H7xjxd04Cs153oty','2023-12-14 10:27:46.320000',3,_binary ''),(31,'2023-09-24 10:17:31.152000','1995-09-27 00:00:00.000000','lelinh2709@gmail.com','Lê Linh',2,NULL,_binary '\0','Hoàng','$2a$10$sOBLA6Ab0wp/BPBvQsHnA.ZO4Nm.mW2DL3Qrk./vGqQvwd062N6Dm','2023-12-14 11:42:02.728000',2,_binary ''),(32,'2023-09-24 10:17:31.280000','1999-06-02 00:00:00.000000','viethuy0206@gmail.com','Việt Huy',0,NULL,_binary '\0','Vũ','$2a$10$SFyrrdRpYNaVB.xe67eleOIP2Gynkr7wJxjYPgCJKAJdDgQ7qSdyO','2023-12-14 10:26:04.269000',3,_binary ''),(33,'2023-12-24 10:17:31.413000','2002-05-10 00:00:00.000000','thanhdung1005@gmail.com','Tiến Dũng',0,NULL,_binary '\0','Ngô','$2a$10$0uC76JPGICqIQpySWplSlubsfI3NSKKtc0wpWUo6LC8PIf2uF0.4G','2023-12-14 10:25:20.039000',3,_binary ''),(34,'2023-09-24 10:17:31.539000','2002-08-15 00:00:00.000000','quanhuy1508@gmail.com','Quan Huy',0,NULL,_binary '\0','Phan','$2a$10$HlUzNfvvMSZm08aZkzXb0eZMdE5ViehvWQhaBPt5MsPqKkZ5WX.Lq','2023-12-14 10:24:02.877000',3,_binary ''),(35,'2023-12-24 10:17:31.660000','2000-01-05 00:00:00.000000','phuoctuan0501@example.com','Thanh Phước Tuấn',0,'https://drive.google.com/uc?id=1r3-bwzttqOv3zeA9V0AtPSL-aZkOCTsz',_binary '\0','Lê','$2a$10$rNlGugDXBLa.wnr39UrO/.Fw6SQWG.hq0H55kWtdJTzl67UnyUzu.','2023-12-14 10:18:35.294000',3,_binary ''),(36,'2023-09-24 10:17:31.788000','1997-07-09 00:00:00.000000','thanhha0907@gmail.com','Thanh Hà',1,NULL,_binary '\0','Hoàng ','$2a$10$evqtrZNn7Yzv/gCGok/gpO5XFAaF.jGK8U87L/B5wE44EPIqIG9AC','2023-12-14 10:21:00.915000',3,_binary ''),(37,'2023-09-24 10:17:31.908000','2023-09-24 10:17:31.797000','thuhuong2409@gmail.com','Thu Hương',1,NULL,_binary '\0','Võ','$2a$10$jMJ5PJ8ikfTYKftE.ittZeifSLnYoqmG1DBtgL2hRF8NT.L.m.uR2','2023-12-14 11:38:44.467000',3,_binary ''),(38,'2023-09-24 10:17:32.032000','2023-09-24 10:17:31.916000','dang.khanh@example.com','Khánh',1,NULL,_binary '\0','Đặng','$2a$10$cAsDLBIUYQGgvbaEEb4Po.dp4/rv3P0zOB6E4yl5diNR5RvxTyNtW','2023-09-24 10:17:32.032000',3,_binary ''),(39,'2023-09-24 10:17:32.157000','2000-06-06 00:00:00.000000','thutrang0606@gmail.com','Thị Thu Trang',2,'https://drive.google.com/uc?id=1sZscjC023yRey8O2RInVd3NImm48qtYc',_binary '\0','Võ','$2a$10$cLg66dpuw.ds9UzHaq4wiuXlnBbvKrr66ECQKOq0M1hYPVCkbyH0m','2023-12-14 11:54:45.532000',3,_binary ''),(40,'2023-09-24 10:17:32.284000','2023-09-24 10:17:32.165000','tran.hai@example.com','Hải',1,NULL,_binary '\0','Trần','$2a$10$NMnr.pLKsI/LNismnFm2veBykoOyAHHQ65H1n.D62NQV9KT6ipxZW','2023-09-24 10:17:32.284000',3,_binary ''),(41,'2023-12-24 10:17:32.401000','2023-09-24 10:17:32.292000','pham.loan@example.com','Loan',2,NULL,_binary '\0','Phạm','$2a$10$ElQYgKlNLYbKYl2ZTiLZYu0jDhP23sV2wNwh4XlTlKhFC941lZVRm','2023-09-24 10:17:32.401000',3,_binary ''),(42,'2023-09-24 10:17:32.522000','2023-09-24 10:17:32.410000','ho.thao@example.com','Thảo',2,NULL,_binary '\0','Hồ','$2a$10$WadEcKy/l0.BnW6kTdWJO.elNFz.XRWLsjvEVe35oDWD5YUwVX.AC','2023-09-24 10:17:32.522000',3,_binary ''),(43,'2023-09-24 10:17:32.641000','2023-09-24 10:17:32.530000','le.tuan@example.com','Tuấn',1,NULL,_binary '\0','Lê','$2a$10$HFNsxmGdRaahaz.InLyQD.Vm5nLFyfs4N1C4E2eEhL41VsQ4G02E6','2023-09-24 10:17:32.641000',3,_binary ''),(44,'2023-12-24 10:17:32.914000','2023-09-24 10:17:32.786000','tran.hang2@example.com','Hằng',2,NULL,_binary '\0','Trần','$2a$10$e80U4s5BZjBfrVa0IDrkJuD7xKq4iVTl67Z/T6OLTFLFsMzUIpc5C','2023-09-24 10:17:32.914000',3,_binary ''),(45,'2023-09-24 10:17:33.037000','2023-09-24 10:17:32.921000','le.tu2@example.com','Tú',1,NULL,_binary '\0','Lê','$2a$10$Xa7h0PS6AJRXXZLewG5fr.C9/KmmT.X136mSxKUtgfPTVDAjmDXui','2023-09-24 10:17:33.037000',3,_binary ''),(46,'2023-11-25 16:59:28.495000','2002-12-10 00:00:00.000000','vanthuan7810@outlook.com.vn','Trường Thuận',1,'https://drive.google.com/uc?id=1S8xAcj1xWTJjCb2-k9l-7lmpWKxLhC5-',_binary '\0','Nguyễn Văn','$2a$10$.3wAoXZ9vO4HSkljhgT1CexM0OiMop.oedh5hTGZd7hd09W.cBE1G','2023-11-25 16:59:28.495000',2,_binary ''),(47,'2024-03-07 08:32:04.740000',NULL,'nguyenvansang20110711@gmail.com','Sang',0,NULL,_binary '\0','Nguyen','$2a$10$5ANY4cva/tL5EOEleaV49.j3rLdu1ZWR8O545RxbhIZurC62Kd076','2024-03-07 08:47:53.475000',3,_binary ''),(49,'2024-03-27 21:44:00.935000','2002-12-10 21:32:58.292000','thuanmyhoa7a2@gmail.com','Thuận',0,'https://drive.google.com/thumbnail?id=1Q4fU3jLyiI6CBjwa4hCqa369_NQR6ZB0',_binary '\0','Văn','$2a$10$.X.crtgrBw9/cV2cOUW2HOXydh0ELnE7F4aql5PSae2Oa27oQWXl.','2024-03-27 21:44:00.935000',3,_binary '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_code`
--

DROP TABLE IF EXISTS `verification_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_code` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `is_expired` bit(1) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  CONSTRAINT `verification_code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_code`
--

LOCK TABLES `verification_code` WRITE;
/*!40000 ALTER TABLE `verification_code` DISABLE KEYS */;
INSERT INTO `verification_code` VALUES (1,635379,'2024-03-07 08:45:47.501000','2024-03-07 09:00:47.501000',_binary '',47);
/*!40000 ALTER TABLE `verification_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-02 16:35:37
