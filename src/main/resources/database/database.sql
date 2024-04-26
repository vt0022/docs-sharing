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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Sách','2023-12-08 23:57:24.356000',_binary '\0',NULL),(2,'Bài hát','2023-12-08 23:57:25.356000',_binary '\0',NULL),(3,'Phim','2023-12-08 23:57:26.356000',_binary '\0',NULL),(4,'Món ăn','2023-12-08 23:57:24.356000',_binary '\0',NULL),(5,'Trò chơi','2023-12-08 23:57:27.356000',_binary '\0',NULL),(6,'Bài viết','2023-12-08 23:57:28.356000',_binary '\0',NULL),(7,'Bức tranh','2023-12-08 23:57:24.356000',_binary '\0',NULL),(8,'Tòa nhà','2023-12-08 23:57:29.356000',_binary '\0',NULL),(9,'Phương tiện','2023-12-08 23:57:30.356000',_binary '\0',NULL),(10,'Động vật','2023-12-08 23:57:24.356000',_binary '\0',NULL),(11,'Loài cây','2023-12-08 23:57:24.356000',_binary '\0',NULL),(12,'Phần mềm','2023-12-08 23:57:31.356000',_binary '\0',NULL),(13,'Phần cứng','2023-12-08 23:57:34.356000',_binary '\0',NULL),(14,'Loại vải','2023-12-08 23:57:44.356000',_binary '\0',NULL),(15,'Báo','2023-12-08 23:57:24.356000',_binary '\0',NULL),(16,'Tài liệu','2023-12-08 23:57:24.356000',_binary '\0',NULL),(17,'Dụng cụ thể thao','2023-12-08 23:57:24.356000',_binary '\0',NULL),(18,'Loại đá quý','2023-12-08 23:57:47.356000',_binary '\0',NULL),(19,'Nhà xuất bản','2023-12-08 23:57:46.356000',_binary '\0',NULL),(20,'Loại bệnh','2023-12-08 23:57:45.356000',_binary '\0',NULL),(21,'Loại nhạc cụ','2023-12-08 23:57:44.356000',_binary '\0',NULL),(24,'Loài nấm','2024-03-24 12:12:17.677000',_binary '\0','2024-03-24 12:12:17.677000'),(25,'Đề thi','2024-03-24 13:12:17.677000',_binary '\0','2024-03-24 13:12:17.677000'),(26,'Từ điển','2024-03-24 13:12:17.677000',_binary '\0','2024-03-24 13:12:17.677000');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,10,NULL,'Cho mình xin với','2023-12-13 23:58:24.356000',NULL),(2,1,6,1,'Bạn comment email cho mình nha bạn!','2023-12-14 00:57:24.356000','2024-03-18 14:21:29.818000'),(3,1,12,NULL,'Còn không bạn ơi!','2023-12-14 05:57:24.356000',NULL),(4,1,6,3,'Mình hỏi bạn mình thì bạn mình cũng có một cuốn, bạn cho mình xin email nha','2023-12-14 08:57:24.356000',NULL),(5,1,10,2,'thikieu1703@gmail.com, cảm ơn bạn nhiều','2023-12-14 09:57:24.356000',NULL),(6,1,12,4,'ngocphuc0808@gmail.com, cảm ơn bạn','2023-12-14 09:59:24.356000',NULL),(7,2,13,NULL,'Cho mình ké với ạ!','2023-12-14 23:58:25.183000',NULL),(8,2,15,NULL,'Cho mình ké nữa ạ!','2023-12-15 00:57:25.183000',NULL),(9,2,18,NULL,'Có ai có không ạ?','2023-12-15 05:57:25.183000',NULL),(10,2,6,NULL,'Nhiều người cùng câu hỏi quá','2023-12-15 08:57:25.183000',NULL),(11,3,15,NULL,'Mình bạn ơi!','2023-12-15 23:58:25.183000',NULL),(12,3,6,11,'Gửi email mình nha ','2023-12-16 00:57:25.183000',NULL),(14,1,21,6,'Không có gì nha bạn','2024-04-11 13:16:21.539000','2024-04-11 13:16:21.539000'),(15,1,21,4,'Ké, cảm ơn bạn','2024-04-11 13:27:02.769000','2024-04-11 13:27:02.769000');
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,'Đắc nhân tâm của Dale Carnegie là quyển sách của mọi thời đại và một hiện tượng đáng kinh ngạc trong ngành xuất bản Hoa Kỳ. Trong suốt nhiều thập kỷ tiếp theo và cho đến tận bây giờ, tác phẩm này vẫn chiếm vị trí số một trong danh mục sách bán chạy nhất và trở thành một sự kiện có một không hai trong lịch sử ngành xuất bản thế giới và được đánh giá là một quyển sách có tầm ảnh hưởng nhất mọi thời đại.\nĐây là cuốn sách độc nhất về thể loại self-help sở hữu một lượng lớn người hâm mộ. Ngoài ra cuốn sách có doanh số bán ra cao nhất được tờ báo The New York Times bình chọn trong nhiều năm. Cuốn sách này không còn là một tác phẩm về nghệ thuật đơn thuần nữa mà là một bước thay đổi lớn trong cuộc sống của mỗi người.\n\nNhờ có tầm hiểu biết rộng rãi và khả năng ‘ứng xử một cách nghệ thuật trong giao tiếp’ – Dale Carnegie đã viết ra một quyển sách với góc nhìn độc đáo và mới mẻ trong giao tiếp hàng ngày một cách vô cùng thú vị – Thông qua những mẫu truyện rời rạc nhưng lại đầy lý lẽ thuyết phục. Từ đó tìm ra những kinh nghiệm để đúc kết ra những nguyên tắc vô cùng ‘ngược ngạo’, nhưng cũng rất logic dưới cái nhìn vừa sâu sắc, vừa thực tế. \n\nHơn thế nữa, Đắc Nhân Tâm còn đưa ra những nghịch lý mà từ lâu con người ta đã hiểu lầm về phương hướng giao tiếp trong mạng lưới xã hội, thì ra, người giao tiếp thông minh không phải là người có thể phát biểu ra những lời hay nhất, mà là những người học được cách mỉm cười, luôn biết cách lắng nghe, và khích lệ câu chuyện của người khác. ','Đắc Nhân Tâm','https://play.google.com/store/books/details/Dale_Carnegie_%C4%90%E1%BA%AFc_Nh%C3%A2n_T%C3%A2m?id=eqjvDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/eqjvDwAAQBAJ?fife=w240-h345',0,NULL,'2023-12-13 23:57:24.356000','https://play.google.com/store/books/details/Dale_Carnegie_%C4%90%E1%BA%AFc_Nh%C3%A2n_T%C3%A2m?id=eqjvDwAAQBAJ',1,5,6),(2,'Dạy Con Làm Giàu là một bộ sách rất được yêu thích của tác giả Robert T. Kiyosaki. Hãy đọc nó nếu bạn muốn xây dựng con đường đến giàu có từ khi còn trẻ.\n\nTrong tác phẩm, Kiyosaki đã chỉ ra những yếu tố và thói quen khác biệt giữa cha của ông – một người có học thức cao nhưng vẫn nghèo khó và một người cha khác – tuy bỏ học nhưng lại trở thành một triệu phú tự thân.\n\nMột trong những nguyên nhân khiến người giàu ngày càng giàu, người nghèo ngày càng nghèo, còn giới trung lưu thì thường mắc nợ chính là vì chủ đề tiền bạc thường được dạy ở nhà chứ không phải ở trường.\n\nHầu hết chúng ta học cách xử lý tiền bạc từ cha mẹ mình, và thường thì người nghèo không dạy con về tiền bạc mà chỉ nói đơn giản là: “Hãy đến trường và học cho chăm chỉ.” Và rồi đứa trẻ có thể sẽ tốt nghiệp với một số điểm xuất sắc nhưng với một đầu óc nghèo nàn về cách quản lý tiền bạc, vì trường học không dạy về chuyện tiền nong mà chỉ tập trung vào việc giáo dục sách vở và những kỹ năng nghề nghiệp mà không nói gì về kỹ năng tài chính.\n\nĐó chính là lý do tại sao những nhân viên ngân hàng, bác sĩ, kế toán thông minh dù đạt được nhiều điểm số xuất sắc ở trường nhưng lại gặp nhiều rắc rối tài chính suốt đời. Và những món nợ quốc gia chóng mặt thường bắt nguồn từ những vị lãnh đạo có học vấn cao, nhưng chỉ được huấn luyện rất ít hoặc không có chút kỹ năng nào về vấn đề tài chính.\n\nMột quốc gia có thể tồn tại như thế nào nếu việc dạy trẻ con quản lý tiền bạc vẫn là trách nhiệm của phụ huynh, mà hầu hết họ không có nhiều kiến thức về vấn đề này? Chúng ta phải làm gì để thay đổi số phận tiền bạc lận đận của mình? Nhà giàu đã làm giàu như thế nào từ hai bàn tay trắng?...\n\nCó lẽ bạn sẽ tìm thấy cho mình những lời giải đáp về các vấn đề đó trong cuốnsách này. Tuy nhiên, do khác biệt về văn hoá, tập quán và chính thể, có thể một số phần nào đó của cuốn sách sẽ khiến bạn thấy lạ lẫm, thậm chí chưa đồng tình… dù rằng đây là một cuốn sách đã được đón nhận nồng nhiệt ở rất nhiều nước trên thế giới.\n\nChúng tôi giới thiệu cuốn sách này với mong muốn giúp bạn có thêm nguồn tham khảo về một trong những lĩnh vực cần dạy con trẻ biết trước khi vào đời, của các bậc phụ huynh ở các nước khác…\n\nTrọn bộ 13 cuốn: eBook Dạy con làm giàu định dạng pdf\n\n1. Dạy con làm giàu - Tập 1: Cha giàu cha nghèo\n\n2. Dạy con làm giàu - Tập 2: Sử dụng đồng vốn\n\n3. Dạy con làm giàu - Tập 3: Để trở thanh nhà đầu tư lão luyện\n\n4. Dạy con làm giàu - Tập 4: Để có khởi đầu thuận lợi về tài chính\n\n5. Dạy con làm giàu - Tập 5: Để có sức mạnh về tài chính\n\n6. Dạy con làm giàu - Tập 6: Những câu chuyện thành công\n\n7. Dạy con làm giàu - Tập 7: Ai đã lấy tiền của Tôi?\n\n8. Dạy con làm giàu - Tập 8: Để có những đồng tiền tích cực\n\n9. Dạy con làm giàu - Tập 9: Những bí mật về tiền bạc - Điều mà bạn không học ở nhà trường\n\n10. Dạy con làm giàu - Tập 10: Trước khi bạn thôi việc\n\n11. Dạy con làm giàu - Tập 11: Trường dạy kinh doanh cho những người thích giúp đỡ người khác\n\n12. Dạy con làm giàu - Tập 12: Xây dựng con thuyền tài chính của bạn\n\n13. Dạy con làm giàu - Tập 13: Nâng cao chỉ số IQ tài chính\n\nMời các bạn đón đọc Dạy Con Làm Giàu: Cha Giàu, Cha Nghèo của hai tác giả Robert T. Kiyosaki & Sharon L. Lechter.','Dạy con làm giàu - Tập 1: Để không có tiền vẫn tạo ra tiền','https://play.google.com/store/books/details/Robert_Kiyosaki_D%E1%BA%A1y_con_l%C3%A0m_gi%C3%A0u_T%E1%BA%ADp_1?id=hz-2EAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/hz-2EAAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:11:24.356000','https://play.google.com/store/books/details/Robert_Kiyosaki_D%E1%BA%A1y_con_l%C3%A0m_gi%C3%A0u_T%E1%BA%ADp_1?id=hz-2EAAAQBAJ',1,19,6),(3,'Tại sao một người đọc sách chậm với tốc độ đọc năm phút một trang lại có thể trở thành nhà bình luận sách với tốc độ đọc trên 700 cuốn sách mỗi năm?\nTốc độ đọc của tôi chậm đến cỡ nào?\n\n“Tôi thích sách. Tôi muốn đọc rất nhiều cuốn nhưng lại không có thời gian đọc...”\n\n“Có những cuốn tôi bắt buộc phải đọc để phục vụ công việc nhưng tốc độ đọc của tôi quá chậm...”\n\n“Lượng sách tôi đọc giảm rõ rệt. Dù đã quyết tâm ‘hôm nay nhất định mình phải đọc’ nhưng mà lại buồn ngủ quá...\n\nCó vẻ như có khá nhiều người cảm thấy “mình đọc sách chậm” và buồn phiền vì điều đó. Có lẽ là bởi họ thấy quanh mình có nhiều người đọc rất nhanh, hết cuốn này đến cuốn khác.\n\nTôi cũng đã từng muộn phiền vì điều đó nên tôi hiểu rõ cảm xúc ấy.\n\nHiện nay, với tư cách là nhà bình luận sách, mỗi tháng tôi đóng góp ý kiên về gần 60 cuốn sách cho nhiêu website thông tin như Lifehacker [bản tiếng Nhật] hay Newsweek Japan.\n\nSố lượng đầu sách thực tế tôi đọc trong một tháng là trên 60 cuốn. Tôi đọc sách gần như cà ngày.\n\n“Anh giỏi thật đấy! Tôi đọc sách chậm lắm nên không thể đọc 60 cuốn sách một tháng. Lại còn viết lời bình cho những cuốn sách ấy nữa. Thật không thể tưởng tượng được.”\n\nMọi người thường hay nói với tôi như thế, nhưng sự thật là, tôi cũng là một người đọc sách chậm.\n\nKhi tính thử thời gian đọc một cuốn sách dịch có nội dung về kinh doanh, tôi đã mất khoảng năm phút cho một trang sách. Còn nếu đọc lơ đãng thì phải mất 10 phút mới hết một trang sách.\n\nKhi đọc đến dòng cuối cùng thì tôi nhận ra, “mình chẳng có chút ký ức nào về 10 dòng vừa đọc cả”, khi đọc lại thì “không ổn rồi, cả phần trước đấy cũng hoàn toàn không vào đầu...” và tôi giở ngược lại những trang trước nữa, trước nữa...\n\nTôi cố tình lờ đi thì cứ vài bữa tình trạng ấy lại lặp lại.','Đọc nhanh hiểu sâu nhớ lâu trọn đời','https://play.google.com/store/books/details/Atsushi_Innami_%C4%90%E1%BB%8Dc_nhanh_hi%E1%BB%83u_s%C3%A2u_nh%E1%BB%9B_l%C3%A2u_tr%E1%BB%8Dn_%C4%91%E1%BB%9Di?id=SHS6EAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/SHS6EAAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:15:24.356000','https://play.google.com/store/books/details/Atsushi_Innami_%C4%90%E1%BB%8Dc_nhanh_hi%E1%BB%83u_s%C3%A2u_nh%E1%BB%9B_l%C3%A2u_tr%E1%BB%8Dn_%C4%91%E1%BB%9Di?id=SHS6EAAAQBAJ',1,5,6),(4,'Tổng hợp những kiến thức ngữ pháp tiếng Trung cơ bản thường gặp trong các kỳ thi HSK-3. Dành cho các bạn đang học các quyển giáo trình Hán ngữ 1 và Hán ngữ 2, nắm được những kiến thức ngữ pháp tiếng Trung cơ bản và đang ôn tập chuẩn bị bước vào kỳ thi lấy chứng chỉ HSK-3','Sổ tay ngữ pháp HSK-3','https://play.google.com/store/books/details/Nguy%E1%BB%85n_Thoan_S%E1%BB%95_tay_ng%E1%BB%AF_ph%C3%A1p_HSK_3?id=cpGZDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/cpGZDwAAQBAJ?fife=w240-h345',0,NULL,'2023-12-14 00:15:24.356000','https://play.google.com/store/books/details/Nguy%E1%BB%85n_Thoan_S%E1%BB%95_tay_ng%E1%BB%AF_ph%C3%A1p_HSK_3?id=cpGZDwAAQBAJ',1,20,9),(5,'\"Trò chuyện với vĩ nhân” tổng hợp những câu chuyện của thiền sư Osho về 20 triết gia, nhà tư tưởng, đạo sư lỗi lạc nhất lịch sử.\nDanh sách những bậc vĩ nhân Osho bàn đến rất đa dạng: Ở phương Đông có Lão Tử, Trang Tử; phương Tây có Socrates, Pythagoras, J. Krishnamurtri, Heraclitus, những nhà lãnh đạo tôn giáo như Phật Thích Ca Mâu Ni, Bồ Đề Đạt Ma, Jesus Christ ... \nDưới ngòi bút sắc sảo của Osho, cuộc đời, tư tưởng và hành trình giác ngộ của những bậc vĩ nhân hiển lên đầy sống động. Ông kể về thời thơ ấu bất hạnh của Krishnamurti, cái chết của Socrates, cuộc gặp gỡ giữa Khổng Tử với Lão Tử hay khoảnh khắc chứng ngộ của ni sư Chiyono.','Trò chuyện với vĩ nhân ',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/28710.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 02:15:24.356000','https://waka.vn/ebook/tro-chuyen-voi-vi-nhan-b4W1qW.html',1,21,9),(6,'Phụ Nữ Hiện Đại Nghĩ Giàu Và Làm Giàu - Cuốn Sách Mang Đến Kim Chỉ Nam Thành Công, Hạnh Phúc Cho Một Nửa Thế Giới\n\nRa mắt lần đầu tiên cách đây hơn 80 năm, những nguyên tắc trong “Nghĩ giàu và làm giàu” của Napoleon Hill đến nay vẫn giữ nguyên giá trị là kim chỉ nam cho bất kỳ ai muốn vươn tới một cuộc sống sung túc, thịnh vượng về mọi phương diện đời sống. Với phương pháp nghiên cứu phỏng vấn hàng ngàn người thuộc mọi giới tính và tầng lớp, để hiểu về câu chuyện thành công và thất bại của họ, nhằm rút ra nguyên tắc chung nhất về xây dựng và thúc đấy cá nhân, cuốn sách của Hill thật sự mang tính phổ quát, chân thật và có giá trị lâu bền. Tuy nhiên, ra đời trong giai đoạn mà vai trò xã hội giữa nam và nữ vẫn còn nhiều cách biệt, những điển hình thành đạt trình bày trong “Nghĩ giàu, làm giàu” của Napoleon Hill lại chủ yếu tập trung vào nam giới. Đó chính là lý do, tác phẩm được xem là gối đầu giường của doanh nhân toàn thế giới ấy, phần nào đó, vẫn không chạm được nửa còn lại của thế giới. Phần thiếu hụt ấy, sau nhiều năm, đã đươc Sharon Lechter bổ sung, bù đắp qua ấn phẩm Phụ nữ hiện đại nghĩ giàu và làm giàu.\n\n Sharon Lechter là một điển hình tiêu biểu của phụ nữ hiện đại, thành công, tạo dựng một cuộc đời giàu có không chỉ về tài chính mà còn về giá trị con người. Bà hiện là một chuyên gia quốc tế về tài chính được trọng vọng trong vai trò là thành viên hộ đồng Tư vấn Tài chính cho hai đời tổng thống Mỹ là G. W. Bush và Barack Obama. Bà đồng thời là một nhà từ thiện, nhà giáo dục, diễn giả quốc tế, và là tác giả của nhiều đầu sách bán chạy trên thế giới. Mang đến độc giả bước nối dài trong hành trình giúp đỡ doanh giới của Napoleon Hill, cuốn sách của Sharon tâp trung khai thác những hình mẫu thành công điển hình của doanh nhân nữ, trong môi trường kinh doanh quốc tế.\n\nCuốn sách có đề mục chương giống với nguyên tác Nghĩ giàu và làm giàu. Mỗi chương sẽ bắt đầu bằng việc tóm tắt ngắn gọn bài học của Napoleon Hill. Sau phần tóm tắt bài học sẽ là câu chuyện thành công của những nhà lãnh đạo nữ đã vận dụng nguyên tắc làm giàu ấy. Tuy nhiên, dựa trên những nguyên tắc thành công đã được chứng minh qua thực tế và thời gian của Napoleon Hill, Sharon Lechter phân tích thấu đáo, sâu sát con đường từ khởi nghiệp đến khi gõ của thành công của những bông hồng trên thương trường. Từ đó, bà vạch ra được 13 nguyên tắc – 13 bước đi chiến lược dẫn đến thành công dành cho phụ nữ thời hiện đại. Đó cũng là lý do, Sharon Lechter không những tôn vinh sự nghiệp của Napoleon Hill mà bà còn là hiện thân cho những triết lý của Napoleon Hill.','Phụ Nữ Hiện Đại Nghĩ Giàu Và Làm Giàu',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/1/32983.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 04:15:24.356000','https://waka.vn/ebook/phu-nu-hien-dai-nghi-giau-lam-giau-sharon-lechter-bMAEvW.html',1,19,9),(7,'“Trong đời người ai cũng có những giây phút thật tuyệt vọng. Lúc ấy, khi mà sự cô độc là nỗi bất hạnh lớn nhất thì hơn hết lúc nào hết, ta cần có một tình yêu thương và điểm tựa tinh thần.”\n\n“Cuộc sống vốn có nhiều khó khăn, thử thách, cả thất vọng, nỗi buồn. Vì thế, sự chia sẻ và động viên tinh thần mang một ý nghĩ quan trọng. Chính những trái tim nhân ái, vòng tay chia sẻ yêu thương sẽ nâng đỡ và giúp chúng ta dũng cảm vượt qua những nỗi đau thương, mất mát để hướng đến một ngày mai tươi đẹp với ước mơ và hoài bão to lớn, đồng thời giúp chúng ta cảm nhận cuộc sống một cách trọn vẹn hơn.”\n\nĐó chính là ý tưởng chính của tập sách Hạt Giống Tâm Hồn cho những trái tim rộng mở do First News vừa phát hành. Tập sách đặc biệt này tuyển chọn những bài viết hay, độc đáo, mang nhiều ý nghĩa sâu sắc, gần gũi với cuộc sống và mang tính tự nhận thức và giáo dục cao.\n\nCó ai sống trên đời này lại không khát khao nhận được sự quan tâm, quý mến của mọi người? Có mấy ai lại dám lớn tiếng tuyên bố rằng tôi có thể sống một mình trên cõi đời mà không cần bất kỳ lời chia sẻ, tình cảm yêu thương nào? Vậy chúng ta nên sống như thế nào để có được sự quan tâm và những tình cảm yêu thương ấy? Yêu thương là một cảm xúc thiêng liêng và gần gũi trong cuộc sống của chúng ta. Không một ai có thể sống trên đời mà thiếu tình yêu thương. Vì thế nếu muốn được yêu thương, trước hết bạn hãy yêu thương những người xung quanh. Hãy mở rộng trái tim và quan tâm đến mọi người, để họ nhận thấy sự tồn tại của bạn. Cũng như bạn, họ cũng là những con người khát khao tình yêu thương, sự quan tâm, và bạn hoàn toàn có thể trao tặng họ tất cả những điều ấy.\n\nCuộc sống của bạn sẽ ý nghĩa hơn nhiều khi bạn biết dành tình thương yêu, biết dùng trái tim nhân ái của mình để sưởi ấm và làm cho cuộc sống của những người xung quanh ấm áp, hạnh phúc hơn. Những câu chuyện về tình yêu thương, về sự chia sẻ, quan tâm trong tập sách Hạt Giống Tâm Hồn Cho Những Trái Tim Rộng Mở sẽ thôi thúc bạn dang rộng cánh tay chia sẻ đầy yêu thương với bạn bè và người thân, sẽ làm bạn bừng sáng với những thời khắc của sự vượt lên chính mình, sẽ là niềm an ủi, xoa dịu những khi bạn căng thẳng tinh thần. Chúng còn khơi dậy khát vọng trong bạn, khuyến khích bạn kiên trì nuôi dưỡng ước mơ, sẵn sàng vượt qua những khó khăn, thử thách mà bạn chắc chắn sẽ gặp phải trên cuộc hành trình để biến ước mơ thành hiện thực.\n\nThông qua những câu chuyện, bạn có thể tìm lại chính mình, có thêm niềm tin, nghị lực để thực hiện những ước mơ, khát vọng, biết chia sẻ và đồng cảm với nỗi đau của những người xung quanh, cảm nhận được giá trị đích thực của cuộc sống.','Hạt giống tâm hồn - Cho những trái tim rộng mở',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/31311.jpg?v=1&w=480&h=700',0,NULL,'2023-12-14 06:15:24.356000','https://waka.vn/ebook/hat-giong-tam-hon-cho-nhung-trai-tim-rong-mo-b3RErW.html',1,5,9),(8,'Bí Quyết Thành Công Dành Cho Bạn Trẻ\nBí quyết thành công dành cho bạn trẻ chính là kim chỉ nam cho các bạn thanh thiếu niên, những người vừa trưởng thành và bước vào đời cũng như ngay cả chính bản thân chúng ta bởi vì không bao giờ là quá muộn khi chúng ta nhận ra được ước mơ và sự thành công mà mình muốn vươn đến.\n\nBất kể mục tiêu của bạn là trở thành một học sinh xuất sắc hay một vận động viên vượt trội, bắt đầu kinh doanh, kiếm được hàng triệu đô-la hay đơn giản chỉ là tìm sự định hướng và chỉ dẫn để sống thành công và hạnh phúc ở hiện tại và tương lai thì đây chính là cuốn sách dành cho bạn.\n\nĐây không chỉ là một bộ sưu tập những “ý tưởng hay” mà cuốn sách này bao gồm 20 nguyên tắc thành công quan trọng nhất đã được hàng triệu bạn trẻ thành công áp dụng. Với những công cụ chính xác thì bất cứ ai cũng có thể nhắm trúng mục tiêu.\n\nCuốn sách này sẽ cho bạn lòng can đảm và nhiệt huyết để tiến về phía trước!','Bí quyết thành công dành cho bạn trẻ',NULL,'https://307a0e78.vws.vegacdn.vn/view/v2/image/img.book/0/0/0/11051.jpg?v=2&w=480&h=700',0,NULL,'2023-12-14 00:15:24.356000','https://waka.vn/ebook/bi-quyet-thanh-cong-danh-cho-ban-tre-jack-canfield-bZRQ4W.html',1,5,10),(9,'Đây là bộ đề thi TOEIC mới nhất do cơ quan khảo thí quốc tế ETS phát hành. Bộ sách này bao gồm 10 bộ đề thi TOEIC phần Listening (LC) đã được sử dụng trong các kỳ thi TOEIC trong quá khứ. Nó giúp người học làm quen với cấu trúc và định dạng của bài kiểm tra, rèn kỹ năng làm bài và cải thiện điểm số.','Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/tWQxbbUkR72G0T6hJ80s','https://haloenglish.edu.vn/wp-content/uploads/2024/01/Bo-tai-lieu-TOEIC-ETS-2024-LC-RC-Vol-4.jpg',10,NULL,'2023-12-14 02:15:24.356000','https://cdn.fs.teachablecdn.com/tWQxbbUkR72G0T6hJ80s',1,20,10),(10,'Đây là bộ đề thi TOEIC mới nhất do cơ quan khảo thí quốc tế ETS phát hành. Bộ sách này bao gồm 10 bộ đề thi TOEIC phần Reading (RC) đã được sử dụng trong các kỳ thi TOEIC trong quá khứ. Nó giúp người học làm quen với cấu trúc và định dạng của bài kiểm tra, rèn kỹ năng làm bài và cải thiện điểm số.','Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/IVmOuToRQkKIFNdiv2hm','https://haloenglish.edu.vn/wp-content/uploads/2024/01/Bo-tai-lieu-TOEIC-ETS-2024-LC-RC-Vol-4.jpg',11,NULL,'2023-12-14 04:15:24.356000','https://cdn.fs.teachablecdn.com/IVmOuToRQkKIFNdiv2hm',1,20,10),(11,'Bộ tài liệu “Transcript cuốn LC Full 10 Test cuốn ETS 2024 LC” là một nguồn quý báu cho những ai đang luyện tập và chuẩn bị cho kỳ thi TOEIC\nBao gồm transcript (lời thoại) cho 10 bài thi TOEIC phần Listening (LC).\nBạn có thể sử dụng transcript để luyện tập nghe, kiểm tra và cải thiện kỹ năng tiếng Anh của mình.\nHiểu rõ cấu trúc và nội dung của bài thi sẽ giúp bạn tự tin hơn khi tham gia kỳ thi TOEIC.','Transcript cuốn LC Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/80clz88rSnqsWIHqfxgw','https://imgbox.com/FmbQ7SH3',5,NULL,'2023-12-14 06:15:24.356000','https://cdn.fs.teachablecdn.com/80clz88rSnqsWIHqfxgw',1,20,10),(12,'Bộ tài liệu “File Audio từ Test 1 đến Test 10 Full 10 Test cuốn ETS 2024 LC” là một nguồn quý báu cho những ai đang luyện tập và chuẩn bị cho kỳ thi TOEIC.\nBao gồm file âm thanh (audio) cho 10 bài thi TOEIC phần Listening (LC) từ Test 1 đến Test 10.\nFile audio được tạo ra từ các bài thi thật, giúp bạn làm quen với cách diễn đạt, giọng điệu và từ vựng thường xuất hiện trong bài thi TOEIC.\nBạn có thể sử dụng file audio để luyện tập nghe, kiểm tra và cải thiện kỹ năng tiếng Anh của mình.\nHiểu rõ cấu trúc và nội dung của bài thi sẽ giúp bạn tự tin hơn khi tham gia kỳ thi TOEIC.',' File Audio từ Test 1 đến Test 10 Full 10 Test cuốn ETS 2024 LC','https://cdn.fs.teachablecdn.com/KHZRdFzQ0aU6or726Qtz','https://kimnhungtoeic.com/wp-content/uploads/2024/01/ETS-2024.jpg',5,NULL,'2023-12-14 08:15:24.356000',NULL,1,20,10),(15,'Năm đó, tại một ngôi làng xa xôi trên một ngọn núi hoang vu, người ta đón Tết trong sự kinh hãi tột độ, hoài nghi đau đáu và giận dữ khôn cùng trước sự ập tới của những bi kich tàn khốc.\nNgôi làng ấy vốn dĩ không có tên, nhưng những người nơi đây mặc định chốn này là địa ngục. Dân trong làng không ai dám tự ý băng rừng thoát khỏi làng, càng không biết thế giới bên ngoài rộng lớn như thế nào, bởi lẽ họ sợ người khác sẽ biết rằng bản thân mình vốn là hậu duệ của băng cướp khét tiếng ở truông nhà Hồ dưới thời chúa Nguyễn ở Đàng Trong.\n\nVào một đêm cuối năm rét buốt, ông Thập – người duy nhất có thể ra khỏi làng – được báo mộng bởi một âm hồn mặc quan phục màu đỏ rực. Làng Địa Ngục sắp gặp họa lớn!\n\nThành danh bằng những tác phẩm văn học kinh dị đậm chất Việt Nam được phát hành qua mạng, lần này tác giả Thảo Trang tiếp tục mang đến một câu chuyện hấp dẫn, mở ra một thế giới huyền bí với những sinh vật, thế lực siêu linh mà người đọc không bao giờ hết hứng thú, để lại những dư âm không phai khi gấp sách lại.','Tết Ở Làng Địa Ngục: Kẻ Ăn Hồn','https://play.google.com/store/books/details/Th%E1%BA%A3o_Trang_T%E1%BA%BFt_%E1%BB%9E_L%C3%A0ng_%C4%90%E1%BB%8Ba_Ng%E1%BB%A5c?id=hUnoEAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/hUnoEAAAQBAJ?fife=w240-h345',0,'2024-04-01 08:15:24.356000','2024-04-01 08:15:24.356000','https://play.google.com/store/books/details/Th%E1%BA%A3o_Trang_T%E1%BA%BFt_%E1%BB%9E_L%C3%A0ng_%C4%90%E1%BB%8Ba_Ng%E1%BB%A5c?id=hUnoEAAAQBAJ',1,1,19),(16,'NẾU MỘT NGÀY ANH THẤY TÔI ĐIÊN, THỰC RA CHÍNH LÀ ANH ĐIÊN ĐẤY!\nHỡi những con người đang oằn mình trong cuộc sống, bạn biết gì về thế giới của mình? Là vô vàn thứ lý thuyết được các bậc vĩ nhân kiểm chứng, là luật lệ, là cả nghìn thứ sự thật bọc trong cái lốt hiển nhiên, hay những triết lý cứng nhắc của cuộc đời?\n\nLại đây, vượt qua thứ nhận thức tẻ nhạt bị đóng kín bằng con mắt trần gian, khai mở toàn bộ suy nghĩ, để dòng máu trong bạn sục sôi trước những điều kỳ vĩ, phá vỡ mọi quy tắc. Thế giới sẽ gọi bạn là kẻ điên, nhưng vậy thì có sao? Ranh giới duy nhất giữa kẻ điên và thiên tài chẳng qua là một sợi chỉ mỏng manh: Thiên tài chứng minh được thế giới của mình, còn kẻ điên chưa kịp làm điều đó. Chọn trở thành một kẻ điên để vẫy vùng giữa nhân gian loạn thế hay khóa hết chúng lại, sống mãi một cuộc đời bình thường khiến bạn cảm thấy hạnh phúc hơn?\n\nThiên tài bên trái, kẻ điên bên phải là cuốn sách dành cho những người điên rồ, những kẻ gây rối, những người chống đối, những mảnh ghép hình tròn trong những ô vuông không vừa vặn… những người nhìn mọi thứ khác biệt, không quan tâm đến quy tắc. Bạn có thể đồng ý, có thể phản đối, có thể vinh danh hay lăng mạ họ, nhưng điều duy nhất bạn không thể làm là phủ nhận sự tồn tại của họ. Đó là những người luôn tạo ra sự thay đổi trong khi hầu hết con người chỉ sống rập khuôn như một cái máy. Đa số đều nghĩ họ thật điên rồ nhưng nếu nhìn ở góc khác, ta lại thấy họ thiên tài. Bởi chỉ những người đủ điên nghĩ rằng họ có thể thay đổi thế giới mới là những người làm được điều đó.\n\nChào mừng đến với thế giới của những kẻ điên.\n\n***\n\nTHIÊN TÀI BÊN TRÁI, KẺ ĐIÊN BÊN PHẢI, VẬY Ở GIỮA LÀ GÌ?\n\nCó thể bạn đã biết, thiên tài và bệnh nhân tâm thần chỉ cách nhau bởi một lằn ranh mỏng manh. Họ đều là những kẻ mang trong mình góc nhìn quái dị, ý tưởng lạ lùng, tư duy khác biệt và những hành động bị xem là “chả ra làm sao, chả hợp thời”. Sự khác nhau giữa thiên tài và người bệnh tâm thần ở chỗ, một bên chứng minh được thế giới quan của họ, bên còn lại thì chưa.\n\nDù vậy, ta không thể phủ nhận thế giới trong mắt của bệnh nhân tâm thần có nhiều điểm thú vị. Thế giới rất rộng lớn và ẩn chứa nhiều điều kỳ diệu mà cho đến giờ, con người vẫn chưa thể lý giải hết. Thế giới cũng đầy những quy tắc và hệ thống một cách nghiêm ngặt. Con người chúng ta, đa số chỉ có thể cảm nhận được một phần nhỏ trong đó. Hiểu biết của chúng ta về thế giới vô cùng hạn hẹp và phiến diện. Vậy nếu ta hiếu kỳ về thế giới này và muốn biết thêm nhiều góc nhìn mới lạ về nó thì sao?\n\nTác giả Cao Minh đã lựa chọn phương pháp tiếp xúc với những bệnh nhân tâm thần để khám phá những góc nhìn mới lạ ấy. Đó là lý do mà cuốn “Thiên tài bên trái, kẻ điên bên phải” ra đời. Cuốn sách là tập hợp các bài phỏng vấn giữa tác giả và những bệnh nhân tâm thần. Bằng cách đặt những câu hỏi hết sức khéo léo và thông minh, tác giả cố gắng thâm nhập vào thế giới của những bệnh nhân tâm thần, qua đó thể nghiệm thế giới quan của họ. Trong quá trình tiếp xúc, tác giả đã nhận ra một điều thú vị rằng “rất nhiều bệnh nhân tâm thần có đủ khả năng nhanh chóng tìm ra một cách giải thích. Không cần biết là quỷ, hồ, tiên, quái hay vật lý, sinh học, họ đều rất kiên định xác nhận.”\n\nChẳng hạn như lần tác giả phỏng vấn một bệnh nhân tâm thần là thiếu niên 17 tuổi. Cậu am hiểu vật lý lượng tử theo một cách kỳ dị đến mức, để giao lưu được với cậu, tác giả phải nhồi nhét các kiến thức về vật lý, sinh học; dẫn theo một người trợ giúp là giáo sư vật lý lượng tử trẻ để giải thích những lời cậu nói theo ngôn ngữ chuyên ngành thông thường. Vấn đề là những điều cậu biết, theo như lời cậu nói, là do một sinh vật bốn chiều bảo với cậu, có cả đọc trong sách. Sinh vật bốn chiều ấy, “một phần kết cấu của nó mang tính phi vật chất, chỉ có thể cảm nhận được”. Cậu không thể lý giải được cảm giác nó mang đến cho cậu. Đến đây thì tác giả bắt đầu chất vấn:\n\n“Tôi (tác giả): Nhưng sao cậu chứng thực được cảm giác của cậu là chính xác, đúng hơn là làm sao cậu chứng minh được có ai đó mang đến cho cậu cảm giác đó?\n\nCậu lạnh lùng nhìn tôi: Lùi lại hơn một trăm năm trước, nếu anh nói với một học giả vật lý hàng đầu thời đó rằng, anh chỉ cần cầm một vật không to bằng tay, không dày bằng cuốn sách là có thể nói chuyện với một người ở nơi xa, nhờ vệ tinh bay quanh địa cầu và một cái thẻ bé bằng móng tay nằm trong vật đó; anh có thể ngồi trước một màn hình nhỏ bé nói chuyện với người lạ cách xa hàng ngàn dặm mà không cần dùng bất cứ sợi dây liên kết nào; anh xem một trận bóng đá ở bên kia địa cầu chỉ nhờ ấn điều khiển tivi; người đó sẽ nghĩ thế nào? Ông ta sẽ nghĩ anh bị điên! Bởi chúng vượt quá phạm trù của bất cứ ngành khoa học nào thời đó, được liệt vào dạng những điều bất hợp lý, đúng không?\n\n[…]\n\nKhông lâu sau, cậu thiếu niên đồng ý làm một bài kiểm tra vật lý lượng tử được chuẩn bị riêng cho cậu ấy nhưng kết quả rất tệ. Không biết vì sao, sau khi nghe kết quả đó tôi có chút thất vọng. Nếu cậu ấy thật sự là một thiên tài, cậu ấy cũng chỉ có thể là thiên tài ở tương lai trăm năm sau, thậm chí xa hơn nữa, chứ không thuộc về thời đại của chúng ta. […] Viết đến đây, tôi bỗng nhớ đến một câu Goethe từng nói: ‘Chân lý thuộc về con người, sai lầm thuộc về thời đại.’”\n\nNgoài ra còn rất nhiều cuộc phỏng vấn với đủ kiểu bệnh nhân tâm thần mang trong mình các vấn đề khác nhau. Có cái hài hước thú vị, có cái làm tác giả và người đọc phải sững sờ đến đáng sợ. Nhiều bệnh nhân có hệ thống logic hoàn thiện đến mức tác giả phải tự hỏi mình, liệu người không đúng có phải là chính tác giả – những người được xem là “bình thường”? Liệu họ có đúng là bệnh nhân tâm thần không? Ở vài cuộc phỏng vấn, tác giả đặt câu hỏi để dẫn dắt câu chuyện nhưng cuối cùng, hóa ra người bị là dẫn dắt là tác giả. Kẻ đi săn bỗng chốc thành con mồi. :))\n\nThiên tài bên trái, kẻ điên bên phải, vậy ở giữa là gì?\n\nỞ giữa phải chăng là những con người bình thường, sống cuộc đời rập khuôn như một cái máy? Khi thấy những kẻ mang ý tưởng quái lạ, nếu nhìn bên phải, họ bị tâm thần. Nhưng nếu thay đổi góc nhìn, hướng mặt sang bên trái thì họ là thiên tài. Dù là tâm thần hay thiên tài thì ta không thể phủ nhận rằng, họ là những gã đầy bản lĩnh khi dám đập tan gông xiềng của quy tắc, đạp đổ mọi rào cản với mơ ước thay đổi thế giới.\n\nCuốn sách phù hợp với những bạn thích chiêm nghiệm về thế giới, mang tư duy mở, không ngại đón nhận những góc nhìn khác lạ.\n\n– Kim Ngân\n\nĐọc “Thiên tài bên trái, kẻ điên bên phải” là một trải nghiệm khá mới, vì trước giờ mình chỉ đọc tiểu thuyết lãng mạn, như Nguyễn Nhật Ánh hay Ichikawa Takuji ấy, đọc cuốn Thiên tài là vì dạo đây khá nhiều người giới thiệu nên cũng tò mò tìm đọc.\n\nCuốn “Thiên tài bên trái, kẻ điên bên phải”, nếu không kiên nhẫn sẽ không đọc được, vì muốn đọc, bạn sẽ phải từ bỏ lối suy nghĩ bình thường, những thường thức đã trở thành chân lý trong bạn. Mà từ bỏ rồi, đọc được rồi có hiểu hay không là do bạn. (Nhưng cuốn này hay thật, hấp dẫn thật đó.)\n\nNói cuốn sách này là truyện cũng không đúng lắm, nói nó là một tập hồi ký của những người tác giả đã tiếp xúc sẽ hợp hơn, vì toàn bộ cuốn sách là những cuộc đối thoại của tác giả và những bệnh nhân tâm thần tác giả có cơ hội tiếp xúc, tác giả là người dẫn dắt cho bệnh nhân trao đổi, chia sẻ về cách nghĩ, tư duy của họ.\n\nNgười khác nói, nghe người bệnh nói làm gì, họ không phải bị điên sao, bị điên mới vào viện tâm thần. Nhưng đọc cuốn sách này, mình lại thấy, họ không điên. Cách nghĩ của họ chỉ là khác với tư duy của đại chúng mà thôi. Vì họ là thiểu số, khác với đa số, nên họ là “người điên”.\n\nVà họ rất cô độc.\n\n“Tôi bây giờ không có bạn bè, bố mẹ đều qua đời rồi, không người nhà, không kết hôn, không con cái, bởi tôi đã không còn để tâm đến những điều đó. Tôi chỉ hy vọng có người đồng hành, thấu hiểu sự cô độc này, cho dù đó là ai. Có thể các anh sẽ nghĩ tôi mắc bệnh tâm thần, cứ cho là vậy đi, tôi cũng không quan tâm, chỉ hy vọng tìm được người có những trải nghiệm giống mình, hiểu được cảm giác của mình thôi.\n\n[…]\n\nCó thể… có thể tôi bị mắc bệnh tâm thần, chỉ là tôi có tiền, không ai cảm thấy tôi điên, những người không có tiền mới thành kẻ điên… Có thể tìm thấy một người giống mình thì tốt, dù chỉ là một người.”\n\nHọ cô độc vì không ai hiểu họ, họ cô độc vì trong thế giới của họ chỉ có một người. Có lẽ trong số họ có những người thực sự có tài năng thiên bẩm, nhưng vì khác với số đông, họ trở thành “kẻ điên”, “người tâm thần”. Và họ có lẽ luôn mong mỏi một người có thể hiểu được họ, để thế giới của họ không còn chỉ có mỗi họ.\n\n“Thiên tài bên trái, kẻ điên bên phải” là một cuốn sách đầy sự hack não, xoắn tư duy, vặn logic, nhưng cũng đầy sự cô đơn, dù không phải mỗi người trong mỗi câu truyện đều nói ra lời. Nếu có hứng thú với những điều kỳ lạ, khác với lẽ thường, đừng bỏ qua cuốn sách này, vì họ sẽ đưa bạn đến những thế giới quan vô cùng độc đáo, vô cùng thú vị. Nếu không, cũng đừng vội quay lưng, hãy cho cuốn sách này một cơ hội, cho bản thân một cơ hội, để thấy rằng họ cũng như bao người thôi, cũng có cảm xúc, cũng có hỉ nộ ai lạc. Vì dù là thiên tài hay kẻ điên, họ cũng đều là người.\n\n– Nguyễn Hà Chi\n\n“Probatio Diabolica” (Devil’s Proof)\n\n“Chứng minh cái gì đó không tồn tại là loại chứng minh bất khả, được gọi là ‘probatio diabolica’ (devil’s proof), hay ‘chứng minh sự tồn tại của ma quỷ’.”\n\nVí dụ đơn giản, bạn không thể chứng minh sự tồn tại của ma quỷ bằng chứng cứ xác thực, nhưng cũng không thể phủ nhận tuyệt đối sự tồn tại của ma quỷ, cũng bởi thiếu chứng cứ. Đó là một vấn đề tiến thoái lưỡng nan mà đến giờ câu trả lời vẫn bị bỏ ngỏ.\n\n“Chứng minh ma quỷ”, cũng chính là quan điểm của những người trong cuốn “Thiên tài bên trái kẻ điên bên phải” vậy. Nếu bạn muốn tìm một cuốn sách khoa học với chứng cớ xác thực, luận điểm rõ ràng, phân tích kĩ càng chặt chẽ, thì có lẽ cuốn sách này không phải ứng cử viên phù hợp cho bạn lắm. Nhưng nếu bạn muốn tìm kiếm sự mới lạ trong những nan đề không lời giải, trong những pha xoắn não vì những lời của những người mà xã hội gọi là kẻ điên, thì sao không dành chút thời gian tìm hiểu cuốn sách này nhỉ? Chỉ cần đọc qua một vài trang, bạn sẽ bị cuốn vào những quan điểm “tưởng vô lý mà lại hợp lý”, dù có phản đối, bạn cũng khó mà tìm được lý lẽ để hoàn toàn phủ nhận quan điểm của họ.\n\nThiên tài và kẻ điên, ngăn cách với phần đông xã hội bằng một ranh giới mang tên “bình thường”. Nhưng cái gọi là “bình thường” cũng có khi là một “chứng minh ma quỷ” đấy.\n\n“NẾU MỘT NGÀY ANH THẤY TÔI ĐIÊN, THẬT RA CHÍNH LÀ ANH ĐIÊN.”\n\n– Phương Nhuế Hân\n\nThế giới mới về tâm lý học và những câu chuyện đa sắc về những-người-đặc-biệt.\n\nJi Hae Soo trong bộ phim “It ok that’s love” từng nói: “Ai trong chúng ta cũng đều mắc bệnh tâm lý, điều kỳ diệu là chúng ta có thể vượt qua chúng bằng tình yêu thương của mọi người xung quanh!”.\n\nChọn cuốn sách này mặc dù đây là thể loại khá lạ trong số các thể loại sách hay truyện về tâm lý học mình từng đọc. Những mẩu chuyện, hay nói đúng hơn là những đoạn hội thoại giữa một bác sĩ tâm lý và những “ca bệnh” đặc biệt của anh. Nếu nghe đến đây mọi người có thể cho rằng, thế thì cuốn sách này tẻ nhạt và không hấp dẫn vì không có tình tiết và diễn biến kịch tính như các tác phẩm tâm lý tội phạm điều tra phá án. Nếu thế thì không cần đọc tiếp review và cũng bỏ qua luôn tác phẩm này đi. Vì giá trị của cuốn sách này nó không nằm ở việc câu kéo sự tò mò bằng những tình tiết tượng tượng, hoặc sao chép từ đâu đó, học hỏi từ đâu đó. Cuốn sách là một kho những kiến thức sâu rộng và cực kỳ cuốn hút về tâm lý học và những ai muốn hiểu rõ về phạm trù khó nhằn này.\n\nSẵn sàng chấp nhận dành tận 3 tháng chỉ để đọc đi đọc lại các mẩu chuyện nhỏ, “Thiên tài bên trái, kẻ điên bên phải” là cuốn sách mình đọc lâu xong nhất, có thể coi là kỷ lục lâu, nhưng lâu một cách xứng đáng. Một cuốn sách có giá trị thực tiễn sẽ tốn của người đọc nhiều thời gian hơn.\n\nThông qua những câu chuyện trong đó, muốn hiểu, phải đọc đi đọc lại nhiều lần, và phải rất tập trung, vì tác giả kết hợp rất hay ngôn ngữ kể chuyện lồng ghép với kiến thức uyên thâm về tâm lý học. Nhất là những thứ ở đây, những tình huống và những bệnh nhân mà tác giả gặp, bạn sẽ không thể gặp ở bất cứ đâu.\n\nMỗi một bệnh nhân tâm lý đều có một thế giới duy ngã của riêng mình, đó là một thế giới quan được nhìn dưới lăng kính cảm nhận của người đó.\n\nCó thể với những người-bình-thường khác thì họ là những kẻ lập dị, tư tưởng hoang đường và quan niệm khác về cuộc sống. Nhưng sự thật có phải như vậy không? Chỉ khi chúng ta thật sự bước vào thế giới của ai đó, chúng ta mới hiểu vì sao họ có lối sống như vậy, và chỉ khi chúng ta hiểu được cách tiếp nhận khác, chúng ta sẽ nhìn thấy một thế giới khác.\n\n“Thiên tài bên trái, kẻ điên bên phải” không phải là cuốn sách giải trí, đọc cho vui, càng không phải là cuốn sách màu mè tô vẽ để câu kéo sự chú ý của người đọc. Nó là cuốn sách giống cánh cửa đi vào một thế giới khác, với những góc nhìn khác về tâm lý học, và thực sự đã thuyết phục một người thích tìm hiểu về tâm lý học như mình.\n\nĐáng đọc, cũng đáng để đọc kỹ.\n\nMời các bạn đón đọc Thiên Tài Bên Trái, Kẻ Điên Bên Phải của tác giả Cao Minh.','Thiên Tài Bên Trái, Kẻ Điên Bên Phải','https://play.google.com/store/books/details/Cao_Minh_Thi%C3%AAn_T%C3%A0i_B%C3%AAn_Tr%C3%A1i_K%E1%BA%BB_%C4%90i%C3%AAn_B%C3%AAn_Ph%E1%BA%A3i?id=ViqkEAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/ViqkEAAAQBAJ?fife=w240-h345',0,'2024-04-01 08:16:24.356000','2024-04-01 08:16:24.356000','https://play.google.com/store/books/details/Cao_Minh_Thi%C3%AAn_T%C3%A0i_B%C3%AAn_Tr%C3%A1i_K%E1%BA%BB_%C4%90i%C3%AAn_B%C3%AAn_Ph%E1%BA%A3i?id=ViqkEAAAQBAJ',1,23,19),(17,'THẾ GIỚI NÀY CHỈ TOÀN GIẢ TẠO, CÒN CHÚNG TA LẠI SỐNG TRONG GIẢ TẠO\nNhà thôi miên, người thì thầm trong bóng tối\n\nThẳm sâu trong nội tâm bạn liệu có tồn tại một thế giới khác?\n\nHoang vu, tăm tối, kìm nén và không có ranh giới…\n\n“Sổ tay nhà thôi miên” sẽ đưa bạn bước vào thế giới bạn chưa từng hay biết.\n\n“Sổ tay nhà thôi miên” sẽ kéo bạn ra khỏi thế giới u tối bạn đang chìm đắm.\n\nĐó là…\n\nNgười lẩn trốn trong bóng tối, một cô gái phát cuồng màu đen, thậm chí còn định nhuộm đen làn da mình, có thói quen ẩn náu trong bóng tối. Tuổi thơ bị hắt hủi liệu có thật sự ảnh hưởng tới cả cuộc đời một con người?\n\nVườn hoa của cô ấy, một cô gái xinh đẹp, sở hữu trí tuệ, ngoại hình và cả khối tài sản khiến người ngưỡng mộ, nhưng luôn mơ thấy ngoài cửa sổ có một con mắt to đang rình trộm mình. Dưới áp lực nặng nề, nếu con người ta không thể tự giải thoát bản thân, hậu quả sẽ ra sao?\n\nQuan Âm nghìn tay, một sư thầy mơ thấy bị Quan Âm nghìn tay đuổi giết vô số lần, dáng vẻ Quan Âm như ma quỷ dưới địa ngục. Liệu đằng sau dáng vẻ thành tâm tu hành có đang chôn giấu bí mật đen tối nào?\n\nVụ mưu sát hoàn mỹ, một người đàn ông yêu thương gia đình nhưng luôn mơ thấy mình tự tay giết vợ. Hai mươi năm trước, anh ta đã tận mắt chứng kiến bố mình sát hại mẹ mình. Chẳng lẽ đó là số phận của huyết thống?\n\n{…}\n\nTất cả những con quái vật trong mơ đều đại diện cho chính chúng ta. Quan sát thế giới này, chỉ cần dùng một con mắt là đủ, một con mắt còn lại, hãy dùng để quan sát chính mình.\n\n***\n\nTác giả cuốn sách Sổ tay nhà thôi miên là Cao Minh. Ông là một tác gia người Trung Quốc. Các cuốn sách của ông viết chủ yếu về tâm lý con người thông qua cách gây dựng cốt truyện và kể chuyện theo hướng ly kỳ và xen lẫn yếu tố trinh thám trong đó. Có lẽ nhiều bạn đọc đã từng nghe qua tên Cao Minh thông qua cuốn sách Thiên tài bên trái, kẻ điên bên phải của ông.\n\n\n\nSự khác nhau giữa cuốn sách Thiên tài bên trái, kẻ điên bên phải và Sổ tay nhà thôi miên, được chính Cao Minh nhận xét rằng: Thiên tài bên trái, kẻ điên bên phải giống như một món Sushi, nguyên liệu chế biến tuy ít nhưng thực tế hơn và lược bớt nhiều chi tiết thì Sổ tay nhà thôi miên lại khá giống với một món ăn đã từng qua xào nấu. Ngoài các nguyên liệu cần thiết, chúng còn phải nêm nếm gia vị để mang đến nhiều dư vị cho người đọc hơn.\n\n\n\nBạn đọc tùy vào khẩu vị của mỗi người mà có thể sẽ thích cuốn này hoặc cuốn kia hơn. Tuy nhiên, nếu bạn đã “trót” mê cách viết của Cao Minh thì chắc chắn không thể bỏ lỡ một trong hai cuốn sách này phải không.\n\n\n\nKhi đọc cuốn sách tâm lý học này, chúng ta có thể thấy được cách mà tác giả giải mã những giấc mơ hay lục tìm lại những ký ức đã cũ thông qua thuật thôi miên và phân tích tâm lý. Những sai lệch méo mó về tâm lý hình thành ngay từ một bóng ma tuổi thơ, một cú sốc tinh thần nào đó hay đơn giản là một nỗi hổ thẹn được giấu kín từ lỗi lầm trong quá khứ.\n\n\n\nTất cả đã dần được hé lỗ thông qua tài phân tích và giải mã tuyệt vời của nhà phân tích tâm lý và nhà thôi miên – đây là hai nhân vật với hai tính cách khác nhau đã được tác giả gây dựng xuyên suốt cuốn sách của mình. Một người sẽ là tác giả và một người còn lại là nhà phân tích tâm lý với nhiều năm kinh nghiệm và được tác giả gọi với hai chữ “cộng sự”.....\n\nNhư vậy, chúng ta có thể thấy rằng những khuyết điểm, sự méo mó trong tâm lý của mỗi người đã được não bộ chuyển đổi, hình tượng hóa thông qua những hình ảnh liên quan đến giấc mơ. Vậy rốt cuộc tại sao những giấc mơ đó lại hình thành và lặp đi lặp lại thường xuyên. Đừng bỏ lỡ cuốn sách Sổ tay nhà thôi miên của tác giả Cao Minh để cùng nhau tìm được câu trả lời. Bên cạnh đó, khi đọc hết và gấp cuốn sách lại, bạn có thể sẽ học hỏi và biết thêm nhiều điều để ứng dụng vào cuộc sống hàng ngày của mình phải không nào.\n\n\n\nMời các bạn đón đọc Sổ Tay Nhà Thôi Miên Tập 1 của tác giả Cao Minh & Thu Hương (dịch).','Sổ Tay Nhà Thôi Miên: Tập 1','https://play.google.com/store/books/details/Cao_Minh_S%E1%BB%95_Tay_Nh%C3%A0_Th%C3%B4i_Mi%C3%AAn?id=rgzmEAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/rgzmEAAAQBAJ?fife=w240-h345',0,'2024-04-01 08:17:24.356000','2024-04-01 08:17:24.356000','https://play.google.com/store/books/details/Cao_Minh_S%E1%BB%95_Tay_Nh%C3%A0_Th%C3%B4i_Mi%C3%AAn?id=rgzmEAAAQBAJ',1,23,19),(18,'Những tác phẩm kinh điển của nền y học tự nhiên','Làm sạch Tâm hồn _ các bài tập thiền','https://play.google.com/store/books/details/Nishi_Katsuzo_L%C3%A0m_s%E1%BA%A1ch_T%C3%A2m_h%E1%BB%93n_c%C3%A1c_b%C3%A0i_t%E1%BA%ADp_thi%E1%BB%81n?id=gkWhDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/gkWhDwAAQBAJ?fife=w240-h345',0,'2024-04-01 08:20:24.356000','2024-04-01 08:20:24.356000','https://play.google.com/store/books/details/Nishi_Katsuzo_L%C3%A0m_s%E1%BA%A1ch_T%C3%A2m_h%E1%BB%93n_c%C3%A1c_b%C3%A0i_t%E1%BA%ADp_thi%E1%BB%81n?id=gkWhDwAAQBAJ',1,24,19),(19,'Những tác phẩm kinh điển của nền y học tự nhiên','Làm sạch mạch và máu','https://play.google.com/store/books/details/Nishi_Katsuzo_L%C3%A0m_s%E1%BA%A1ch_m%E1%BA%A1ch_v%C3%A0_m%C3%A1u?id=FkWhDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/FkWhDwAAQBAJ?fife=w240-h345',0,'2024-04-01 08:21:24.356000','2024-04-01 08:21:24.356000','https://play.google.com/store/books/details/Nishi_Katsuzo_L%C3%A0m_s%E1%BA%A1ch_m%E1%BA%A1ch_v%C3%A0_m%C3%A1u?id=FkWhDwAAQBAJ',1,24,23),(20,'Bạn thân mến, đây là những trang sách và các phương pháp giảng dạy đã được thử thách bằng thời gian.\nĐây là những nghiên cứu của những đại diện kiệt xuất của nền y học tự nhiên của tất cả các dân tộc từ thời đại cỗ xưa cho tới nay.\n\nĐây là những điều đã được khôi phục lại và những sự giải thích của các chuyên gia thời nay, những lời khuyên bảo hết sức cấp thiết của những nhà chuyên môn vĩ đại.\n\nNếu chúng ta tin vào bản thân mình và bắt đầu học cách khám phá nguồn dự trữ của cơ thể mình thì chẳng bao lâu nữa, cuộc sống của con người trên trái đất này có thể kéo dài tới 100 và thậm chí 120 -130 tuổi. Điều này là hoàn toàn thực tế chính bởi con người đã được lập trình bằng con đường sinh học cho thời hạn sống rất lớn.\n\nKhẳng định như vậy là của Nishi Katsuzo- người sáng lập nổi tiếng rộng khắp về phương thức làm khỏe mạnh mà nhờ đó hàng triệu triệu người trên khắp các lục địa đã có thể làm cho mình trở lại tráng kiện, trẻ trung và niềm tin vào khả năng không giới hạn của chính mình.','Những phương thức phục hồi sức khỏe theo tự nhiên','https://play.google.com/store/books/details/Nishi_Katsuzo_Nh%E1%BB%AFng_ph%C6%B0%C6%A1ng_th%E1%BB%A9c_ph%E1%BB%A5c_h%E1%BB%93i_s%E1%BB%A9c_kh%E1%BB%8Fe?id=4UOhDwAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/4UOhDwAAQBAJ?fife=w240-h345',10,'2024-04-01 08:22:24.356000','2024-04-01 08:22:24.356000','https://play.google.com/store/books/details/Nishi_Katsuzo_Nh%E1%BB%AFng_ph%C6%B0%C6%A1ng_th%E1%BB%A9c_ph%E1%BB%A5c_h%E1%BB%93i_s%E1%BB%A9c_kh%E1%BB%8Fe?id=4UOhDwAAQBAJ',1,24,23),(21,'Cuộc sống hàng ngày đầy rẫy lo toan, tất bật luôn khiến cho bạn có cảm giác như mình đang đối đầu với nhiều áp lực cuộc sống. Những nỗi đau, mâu thuẫn trong các mối quan hệ bạn bè, công việc, tình cảm luôn nảy sinh khiến cho bạn cảm thấy chán nản, mệt mỏi và không còn cảm nhận được ý nghĩa cuộc sống.\nThời gian bất tận, thế giới vô cùng, nhưng suy nghĩ của chúng ta còn rộng lớn và mạnh mẽ hơn nhiều. Chúng ta có thể kiến tạo ra cuộc sống theo ý mình vì chúng ta sinh ra để trao quyền làm việc đó. Mỗi người chúng ta là một ông hoàng, bà chúa cai quản các bộ phận của thể xác, hướng dẫn các hoạt động tinh thần, làm cho đời sống của mình thịnh vượng hơn lên. Nhưng nhiều người đã không ý thức được điều đó và đang phải chịu đựng một cuộc sống với buồn đau, bất hạnh và những vết thương không thể nào cứu chữa được.\n\nNếu bạn vẫn còn băn khoăn chưa biết nên bắt đầu từ đâu và nên sử dụng phương pháp nào tốt nhất để vực dậy chính mình, thì hãy thử đọc quyển sách Chữa Lành Nỗi Đau của tác giả Louise L. Hay. Cuốn sách này sẽ giúp bạn khơi dậy những năng lực thực sự đang tiềm ẩn bên trong mình. Sức mạnh đó sẽ tác động không chỉ đến suy nghĩ và cuộc sống của riêng bạn mà còn ảnh hưởng trực tiếp đến những người mà bạn tiếp xúc hàng ngày.\n\nCó thể trước đây bạn chưa nhận ra nhưng thật sự là bạn đang sở hữu một tinh thần mạnh mẽ, lạc quan đang cần được khám phá. Mỗi phút giây trong hiện tại này đã chứa đựng đầy đủ những gì bạn đang tìm kiếm để trả lời những câu hỏi của riêng mình. Chữa Lành Nỗi Đau không những có thể giúp bạn thoát khỏi những ám ảnh tiêu cực lâu nay trong cuộc sống, mà quyển sách này còn giúp bạn biết cách yêu thương chính mình để gieo những hạt giống hy vọng cho tương lai.\n\nHãy sống cuộc đời đích thực của chính mình, trở thành con người mà bạn mong muốn, vươn đến những ước mơ vẫn hằng ấp ủ và hướng tới những điều tốt đẹp trong mối quan hệ với người xung quanh. Khi đó bạn sẽ truyền nguồn cảm hướng cho rất nhiều người khác.','Chữa Lành Nỗi Đau','https://play.google.com/store/books/details/Louise_L_Hay_Ch%E1%BB%AFa_L%C3%A0nh_N%E1%BB%97i_%C4%90au?id=Bg0aEAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/Bg0aEAAAQBAJ?fife=w240-h345',10,'2024-04-01 08:23:24.356000','2024-04-01 08:23:24.356000','https://play.google.com/store/books/details/Louise_L_Hay_Ch%E1%BB%AFa_L%C3%A0nh_N%E1%BB%97i_%C4%90au?id=Bg0aEAAAQBAJ',1,24,23),(22,'Xin chào các bạn độc giả đang đọc cuốn sách này. Dù bạn là một nhà chuyên môn trong lĩnh vực chăm sóc sức khỏe tinh thần con người (bác sĩ chuyên khoa tâm thần, bác sĩ đa khoa, điều dưỡng, nhân viên y tế, chuyên gia tâm lý, người làm công tác xã hội, người tu hành,...) hay bạn là người đang chịu đựng những tổn thương mỗi ngày do những sang chấn trong quá khứ hay khổ đau trong hiện tại, thì cuốn sách này đều hữu ích cho bạn trong việc thấu hiểu tâm trí của con người và của chính mình.\nCuốn sách không chỉ đề cập đến vấn đề của người trưởng thành mà còn đề cập đến những tổn thương và sang chấn mà trẻ em phải chịu đựng nên sách cũng rất hữu ích cho các bậc phụ huynh muốn đồng hành cùng con trên bước đường phát triển.\n\nTác giả của cuốn sách sang chấn tâm lý – hiểu để chữa lành là Tiến sĩ Y khoa Bessel Van Der Kolk, Bác sĩ chuyên khoa tâm thần, Giáo sư Tâm thần học của Trường Y Đại Học Boston đồng thời là Nhà sáng lập Trung tâm Điều trị Sang chấn (Trauma Center) tại Brookline, Massachusetts. Ông có nhiều năm làm việc và nghiên cứu trong lĩnh vực điều trị bệnh tâm thần, đặc biệt là điều trị stress do sang chấn ở người lớn và trẻ em.\n\n\n\nSang chấn tâm lý – hiểu để chữa lành là một công trình khoa học công phu và nghiêm túc, trải rộng trên nhiều lĩnh vực – tâm lý học thần kinh, tâm lý học phát triển, tâm bệnh học, tâm lý trị liệu - được đúc kết sau nhiều năm kinh nghiệm làm việc của chính tác giả, và dựa trên những câu chuyện có thật của các bệnh nhân mà tác giả có dịp tiếp xúc hoặc chữa trị.\n\n\n\nCuốn sách được cấu trúc thành năm phần:\n\n\n\nPhần I – Tái khám phá sang chấn: Quá trình tìm hiểu và hình thành những hiểu biết khoa học về Stress do sang chấn nói riêng và Sức khỏe tâm thần nói chung, bắt nguồn từ những khám phá ban đầu về stress do sang chấn ở các cựu binh Mỹ tham chiến tại Việt Nam.\n\nPhần II - Khám phá bộ não bị sang chấn: Bao gồm những kết quả nghiên cứu của khoa học thần kinh và hình ảnh học thần kinh, giúp chúng ta hiểu được mối liên hệ giữa não bộ với tâm lý – tâm thần ở con người.\n\nPhần III - Tâm trí trẻ thơ và Phần IV - Dấu ấn của sang chấn: Mô tả những ảnh hưởng của sang chấn lên trẻ em và người trưởng thành.\n\nPhần V - Con đường hồi phục: Mô tả con đường hồi phục của những người bị stress do sang chấn, thông qua các phương pháp trị liệu và tự chữa lành.\n\n\n\nNgoài ra, trong phần phụ lục tác giả còn cung cấp nhiều thông tin hữu ích về những tiêu chí được cập nhật để chẩn đoán Rối loạn phát triển do sang chấn, và các tổ chức cung cấp nguồn thông tin hữu ích cũng như hỗ trợ việc điều trị stress do sang chấn.\n\nQua mười tám năm hành nghề bác sĩ chuyên khoa tâm thần trẻ em và người lớn, tôi học hỏi được rất nhiều từ thân chủ cũng như bệnh nhân của mình. Tôi may mắn khi có thể đồng hành cùng họ trong quá trình tự chữa lành, vượt qua tổn thương, tháo bỏ rào cản để có thể bộc lộ và phát triển những tiềm năng của bản thân. Khi đọc quyển sách này, tôi đã tìm được rất nhiều điểm tương đồng giữa mình với tác giả. Tôi trân trọng cách nhìn của ông về những người có nỗi đau tinh thần như là người cần được hỗ trợ chứ không phải con bệnh, bởi lẽ, ai trong chúng ta cũng có thể phải đối diện với những khổ đau đó trong kiếp nhân sinh.\n\n\n\nĐây là cuốn sách rất đáng đọc dành cho các bác sĩ tâm thần trẻ em và nhà trị liệu tâm lý trẻ em vì xuyên suốt quyển sách là những minh chứng khoa học cụ thể và chi tiết về Rối loạn phát triển do sang chấn, giúp cho nhà chuyên môn có thể có một tài liệu quý giá để tránh chẩn đoán sai sót.\n\n\n\nNhững ai thường xuyên làm việc với trẻ em cũng có thể tìm thấy thông tin hữu ích từ quyển sách này để hiểu thêm về tâm hồn trẻ thơ, và từ đó chúng ta có thể chung tay ngăn chặn Rối loạn phát triển do sang chấn ở trẻ em tại Việt Nam.\n\n\n\nCác kiến thức được cập nhật trong sách cũng là tiền đề cho những tiêu chuẩn chẩn đoán mới cho stress sau sang chấn.\n\n\n\nTôi xin trân trọng giới thiệu với quý độc giả cuốn sang chấn tâm lý – hiểu để chữa lành. Một quyển sách tuyệt vời để có thể thấu hiểu tâm hồn con người, hiểu được bản chất của sang chấn tâm lý và cách thức chữa lành.\n\n\n\n***\n\nTóm tắt\n\nCuốn sách \"Sang chấn tâm lý - Hiểu để chữa lành\" của tác giả Bessel Van Der Kolk là một công trình khoa học công phu và nghiêm túc, trải rộng trên nhiều lĩnh vực, bao gồm tâm lý học thần kinh, tâm lý học phát triển, tâm bệnh học, tâm lý trị liệu. Cuốn sách cung cấp cho người đọc những hiểu biết sâu sắc về bản chất của sang chấn tâm lý, những ảnh hưởng của sang chấn lên não bộ và tâm lý, cũng như những phương pháp chữa lành sang chấn hiệu quả.\n\nReview\n\nCuốn sách được chia thành năm phần:\n\nPhần I - Tái khám phá sang chấn: Khởi đầu từ những khám phá ban đầu về stress do sang chấn ở các cựu binh Mỹ tham chiến tại Việt Nam, tác giả đã đi sâu tìm hiểu bản chất của sang chấn tâm lý, những biểu hiện của sang chấn, cũng như những cách thức đối phó với sang chấn.\n\nPhần II - Khám phá bộ não bị sang chấn: Tác giả trình bày những kết quả nghiên cứu của khoa học thần kinh và hình ảnh học thần kinh, giúp chúng ta hiểu được mối liên hệ giữa não bộ với tâm lý - tâm thần ở con người. Theo tác giả, sang chấn có thể gây ra những thay đổi về cấu trúc và chức năng của não bộ, dẫn đến những rối loạn tâm lý và hành vi.\n\nPhần III - Tâm trí trẻ thơ: Tác giả nhấn mạnh rằng sang chấn có thể ảnh hưởng nghiêm trọng đến sự phát triển của trẻ em. Trẻ em bị sang chấn có thể gặp phải những khó khăn về cảm xúc, hành vi, học tập và tương tác xã hội.\n\nPhần IV - Dấu ấn của sang chấn: Tác giả phân tích những ảnh hưởng của sang chấn lên người trưởng thành. Sang chấn có thể dẫn đến những rối loạn tâm lý như rối loạn căng thẳng sau sang chấn (PTSD), rối loạn liên quan đến căng thẳng, rối loạn nhân cách.\n\nPhần V - Con đường hồi phục: Tác giả trình bày những phương pháp chữa lành sang chấn hiệu quả, bao gồm liệu pháp tâm lý, liệu pháp thân thể, liệu pháp kết hợp.\n\nCuốn sách được viết bằng một phong cách khoa học nhưng dễ hiểu, đi kèm với nhiều ví dụ thực tế. Cuốn sách là một tài liệu tham khảo quý giá cho các nhà chuyên môn trong lĩnh vực tâm lý học, tâm thần học, cũng như những người quan tâm đến vấn đề sang chấn tâm lý.\n\nĐánh giá\n\nCuốn sách \"Sang chấn tâm lý - Hiểu để chữa lành\" là một cuốn sách quan trọng và cần thiết cho những ai muốn hiểu rõ hơn về bản chất của sang chấn tâm lý và cách thức chữa lành sang chấn. Cuốn sách đã cung cấp cho tôi những hiểu biết sâu sắc về sang chấn tâm lý, giúp tôi có thể thấu hiểu hơn những người đã trải qua sang chấn.\n\nMặt mạnh\n\nCuốn sách được viết bởi một chuyên gia hàng đầu trong lĩnh vực tâm lý học thần kinh, tâm thần học.\n\nCuốn sách cung cấp những kiến thức khoa học mới nhất về sang chấn tâm lý.\n\nCuốn sách được viết bằng một phong cách khoa học nhưng dễ hiểu, đi kèm với nhiều ví dụ thực tế.\n\nMặt hạn chế\n\nCuốn sách có thể hơi khó đọc đối với những người không có kiến thức nền tảng về tâm lý học.\n\nKết luận\n\nCuốn sách \"Sang chấn tâm lý - Hiểu để chữa lành\" là một cuốn sách đáng đọc cho những ai quan tâm đến vấn đề sang chấn tâm lý.\n\nMời các bạn đọc sách Sang Chấn Tâm Lý - Hiểu Để Chữa Lành của tác giả M.D Bessel Van Der Kolk.','Sang Chấn Tâm Lý: Hiểu Để Chữa Lành','https://play.google.com/store/books/details/Bessel_Van_Der_Kolk_M_D_Sang_Ch%E1%BA%A5n_T%C3%A2m_L%C3%BD?id=rAnmEAAAQBAJ','https://books.google.com/books/publisher/content/images/frontcover/rAnmEAAAQBAJ?fife=w240-h345',10,'2024-04-01 08:25:24.356000','2024-04-01 08:25:24.356000','https://play.google.com/store/books/details/Bessel_Van_Der_Kolk_M_D_Sang_Ch%E1%BA%A5n_T%C3%A2m_L%C3%BD?id=rAnmEAAAQBAJ',1,24,18),(23,'Môn học này là môn học đầu tiên về lập trình, dành cho sinh viên chưa hề có kiến thức nào về lập trình trước đó. Môn học cung cấp những kiến thức và kỹ năng căn bản về lập trình bao gồm hai phương pháp lập trình: lập trình có cấu trúc và lập trình hướng đối tượng.\n* Nội dung tóm tắt môn học\n- Ngôn ngữ lập trình C++\n- Lập trình có cấu trúc: cấu trúc tuần tự, cấu trúc rẽ nhánh, cấu trúc lặp\n- Lập trình hàm và đệ quy\n- Lập trình hướng đối tượng','Kỹ Thuật Lập Trình - Đh Bách Khoa Hn - Ths Lương Mạnh Bá','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/luong-manh-ba/dh-bach-khoa-hn?src=subject','https://s2.cuuduongthancong.com/pdfimg/ky-thuat-lap-trinh/chuong-1.-tongquanvelt.pdf/chuong-1.-tongquanvelt.pdf-0.jpg',0,'2024-04-02 08:25:24.356000','2024-04-02 08:25:24.356000','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/luong-manh-ba/dh-bach-khoa-hn?src=subject',16,12,21),(24,'Môn học này là môn học đầu tiên về lập trình, dành cho sinh viên chưa hề có kiến thức nào về lập trình trước đó. Môn học cung cấp những kiến thức và kỹ năng căn bản về lập trình bao gồm hai phương pháp lập trình: lập trình có cấu trúc và lập trình hướng đối tượng.\n* Nội dung tóm tắt môn học\n- Ngôn ngữ lập trình C++\n- Lập trình có cấu trúc: cấu trúc tuần tự, cấu trúc rẽ nhánh, cấu trúc lặp\n- Lập trình hàm và đệ quy\n- Lập trình hướng đối tượng','Kỹ Thuật Lập Trình - Đh Bách Khoa Hcm - Trần Quang','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/tran-quang/dh-bach-khoa-hcm?src=subject','https://s2.cuuduongthancong.com/pdfimg/ky-thuat-lap-trinh/ch01---gioi-thieu-ve-may-tinh-va-lap-trinh.pdf/ch01---gioi-thieu-ve-may-tinh-va-lap-trinh.pdf-0.jpg',0,'2024-04-02 09:25:24.356000','2024-04-02 09:25:24.356000','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/tran-quang/dh-bach-khoa-hcm?src=subject',16,12,21),(25,'Môn học này là môn học đầu tiên về lập trình, dành cho sinh viên chưa hề có kiến thức nào về lập trình trước đó. Môn học cung cấp những kiến thức và kỹ năng căn bản về lập trình bao gồm hai phương pháp lập trình: lập trình có cấu trúc và lập trình hướng đối tượng.\n* Nội dung tóm tắt môn học\n- Ngôn ngữ lập trình C++\n- Lập trình có cấu trúc: cấu trúc tuần tự, cấu trúc rẽ nhánh, cấu trúc lặp\n- Lập trình hàm và đệ quy\n- Lập trình hướng đối tượng','Kỹ Thuật Lập Trình - Www.Cs.Princeton.Edu - Andrew Koenig','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/andrew-koenig/www.cs.princeton.edu?src=subject','https://s2.cuuduongthancong.com/pdfimg/ky-thuat-lap-trinh/01-introduction.pdf/01-introduction.pdf-0.jpg',0,'2024-04-02 10:25:24.356000','2024-04-02 10:25:24.356000','https://cuuduongthancong.com/sjdt/ky-thuat-lap-trinh/andrew-koenig/www.cs.princeton.edu?src=subject',16,12,18),(26,'TRƯỞNG CAO ĐẲNG CÔNG NGHIỆP HƯNG YÊN\nKHOA KHOA HỌC CƠ BẢN\n\nMã đề: 02\n\nĐỂ THI KẾT THÚC MÔN HỌC\nMH: Tin học','Đề thi tin học đại cương ','https://dethi.violet.vn/present/tin-hoc-dai-cuong-13686516.html','https://imgbox.com/npWljytB',0,'2024-04-02 11:25:24.356000','2024-04-02 11:25:24.356000','https://dethi.violet.vn/present/tin-hoc-dai-cuong-13686516.html',16,12,18),(27,'Tài liệu thực hành lập trình C/C++ có lời giải\nThực hành 1\nBài 1: (TH-CSLT-01). Vận tốc của phương tiện được tính bằng quãng đường đi\nđược S trong một khoảng thời gian là T. Hãy thực hiện nhập giá trị cho S và T, sau\nđó hiển thị vận tốc của phương tiện với độ chính xác là 02 chữ số của phần thập\nphân.','Tài liệu Thực hành cơ sở lập trình C++ có lời giải| Fithou','https://dethi.violet.vn/present/thuc-hanh-co-so-lap-trinh-c-fithou-13596222.html','https://imgbox.com/XJZAa8xp',0,'2024-04-02 12:25:24.356000','2024-04-02 12:25:24.356000','https://dethi.violet.vn/present/thuc-hanh-co-so-lap-trinh-c-fithou-13596222.html',25,12,18),(28,'Nó được thiết kế chủ yếu cho số lượng người học tiếng Việt ngày càng tăng cần một cuốn từ điển Việt-Anh tốt và đáng tin cậy. Mặc dù nó chủ yếu nhắm đến người nói tiếng Anh và những người dùng không phải bản xứ khác cần học tiếng Việt, nhưng nó cũng có thể được sử dụng bởi những người nói tiếng Việt đang học hoặc cần biết tiếng Anh. Cùng với 19.000 mục nhập—bao gồm các từ và cụm từ hiện đại được sử dụng trong môi trường giáo dục, kinh doanh và du lịch—bố cục hấp dẫn và thân thiện với người dùng được sắp xếp hiệu quả, giúp bạn dễ dàng xác định vị trí các từ và cụm từ một cách nhanh chóng. Nó cũng bao gồm nhiều gợi ý và thông tin có giá trị về tiếng Việt.\nĐược sửa đổi và cập nhật hoàn toàn với hơn 19.000 mục.\nVăn bản rõ ràng, thân thiện với người dùng với các thành ngữ, cách diễn đạt và câu mẫu.\nTừ điển lý tưởng cho sinh viên và doanh nhân.','Từ điển Việt-Anh, Anh-Việt','https://dethi.violet.vn/present/tu-dien-viet-anh-anh-viet-13447841.html','https://imgv2-1-f.scribdassets.com/img/word_document/380800453/original/432x574/beb3080021/1707347406?v=1',0,'2024-03-24 14:12:17.677000','2024-03-24 14:12:17.677000','https://dethi.violet.vn/present/tu-dien-viet-anh-anh-viet-13447841.html',26,20,18),(29,'Truyện Kiều, kiệt tác của thi hào Nguyễn Du, một lần nữa lại vừa được dịch sang tiếng Anh qua bản dịch của Vladislav Zhukov. Cuốn sách, có tựa tiếng Anh The Kim Vân Kieu of Nguyen Du (1765-1820), được ấn hành năm 2004 bởi Pandanus Books, trực thuộc Trường Nghiên cứu châu Á - Thái Bình Dương của Đại học Quốc gia Úc.','Kim Van Kieu of Nguyen Du (Vladislav Zhukov)','https://dethi.violet.vn/present/kim-van-kieu-of-nguyen-du-vladislav-zhukov-13423183.html','https://imgbox.com/mZeMLv9Z',0,'2024-03-24 14:12:17.677000','2024-03-24 14:12:17.677000','https://dethi.violet.vn/present/kim-van-kieu-of-nguyen-du-vladislav-zhukov-13423183.html',1,1,43),(30,'Kể từ khi được xuất bản vào đầu thế kỷ 19, bài thơ tự sự dài này đã được coi là kiệt tác đỉnh cao của văn học Việt Nam. Bản dịch mới và dễ đọc của Thông (trên các trang đối diện với văn bản tiếng Việt) được minh họa bằng các ghi chú đưa ra các đoạn so sánh từ tiểu thuyết Trung Quốc mà bài thơ dựa trên, các chi tiết về ám chỉ tiếng Trung và các bản dịch nghĩa đen với thông tin cơ bản giải thích tục ngữ và ca dao Việt Nam.','The Tale of Kieu (Huynh Sanh Thong)','https://dethi.violet.vn/present/the-tale-of-kieu-huynh-sanh-thong-13423188.html','https://m.media-amazon.com/images/I/61Iyp+F-ydL._SY466_.jpg',0,'2024-03-24 15:12:17.677000','2024-03-24 15:12:17.677000','https://dethi.violet.vn/present/the-tale-of-kieu-huynh-sanh-thong-13423188.html',1,1,39),(31,'Cuốn sách \"Cách đánh dấu trọng âm và phát âm đúng tiếng Anh\" của tác giả Trần Mạnh Tường biên soạn nhằm giúp các em học sinh phương pháp học, nhận biết, nâng cao kĩ năng phát âm và nói tiếng anh chuẩn.\nPhần 1 cuốn sách giới thiệu các cách đánh đánh dấu trọng âm và phát âm đúng các trọng âm và nguyên âm trong tiếng Anh.\nPhần 2. Nguyên âm\nPhần 3. Ngữ điệu của một câu\nSách được trình bày ngắn gọn, dễ hiểu, giúp các bạn học và hiểu một cách nhanh chóng','Cách đánh dấu trọng âm và phát âm đúng tiếng Anh','https://dethi.violet.vn/present/cach-danh-dau-trong-am-va-phat-am-dung-tieng-13421347.html','https://sachhoc.com/image/cache/catalog/Sachtienganh/Luyen-nghe/Cach-danh-dau-trong-am-va-phat-am-dung-tieng-anh-500x554.jpg',0,'2024-03-24 15:14:17.677000','2024-03-24 15:14:17.677000','https://dethi.violet.vn/present/cach-danh-dau-trong-am-va-phat-am-dung-tieng-13421347.html',1,20,38),(32,'Những Từ Dễ Nhầm Lẫn Trong Tiếng Anh: Nhằm giúp các bạn khắc phục một trong những khâu khó nhất trong việc học tiếng anh,trong tiếng anh có một số từ thường gây ra một số nhầm lẫn cho người sử dụng . có nhiều lý do tại sao những từ đó dễ nhầm lẫn, chẳng hạn chúng có vẻ giống nhau khi viết nhưng lại mang nghĩa khác nhau.','Những từ dễ nhầm lẫn trong tiếng Anh','https://dethi.violet.vn/present/tu-de-nham-trong-tieng-anh-13421297.html','https://cdn0.fahasa.com/media/catalog/product/i/m/image_91461.jpg',0,'2024-03-24 15:16:17.677000','2024-03-24 15:16:17.677000','https://dethi.violet.vn/present/tu-de-nham-trong-tieng-anh-13421297.html',1,20,38),(33,'Published in 1988, this dictionary continues to be a favorite of many teachers.','Oxford Picture Dictionary 2008','https://dethi.violet.vn/present/oxford-picture-dictionary-2008-13420156.html','https://sachtienganhhanoi.com/wp-content/uploads/2023/06/image_2023-06-18_090138785.png',0,'2024-03-24 15:18:17.677000','2024-03-24 15:18:17.677000','https://dethi.violet.vn/present/oxford-picture-dictionary-2008-13420156.html',26,20,38),(34,'Cuốn sách này mang đến một cái nhìn mới mẻ về các cụm từ và câu thành ngữ làm cho tiếng Anh trở thành ngôn ngữ phong phú và hấp dẫn. Phiên bản mới quan trọng này bao gồm các mục cho hơn 5000 thành ngữ, bao gồm 350 mục hoàn toàn mới và hơn 500 câu trích dẫn mới.\n\nVăn bản đã được cập nhật để bao gồm nhiều thành ngữ mới sử dụng kết quả của Chương trình Đọc tiếng Anh Oxford, chương trình nghiên cứu ngôn ngữ lớn nhất thế giới. Các mục được hỗ trợ bởi vô số trích dẫn minh họa từ nhiều nguồn và thời kỳ khác nhau, đồng thời văn bản đã được thiết kế lại hoàn toàn sao cho vừa trang nhã vừa dễ sử dụng. Bất kỳ ai quan tâm đến khía cạnh đầy màu sắc của tiếng Anh sẽ có được nhiều giờ phút vui vẻ khi duyệt qua cuốn sách hấp dẫn và giàu thông tin này.','Oxford dictionary of idioms','https://dethi.violet.vn/present/oxford-dictionary-of-idioms-12895023.html','https://m.media-amazon.com/images/I/61q5XdeQtNL._AC_UF1000,1000_QL80_.jpg',0,'2024-03-24 15:20:17.677000','2024-03-24 15:20:17.677000','https://dethi.violet.vn/present/oxford-dictionary-of-idioms-12895023.html',26,20,38),(35,'Ngữ pháp tiếng anh cho người mất gốc','Ngữ pháp tiếng anh cho người mất gốc','https://dethi.violet.vn/present/ngu-phap-tieng-anh-cho-nguoi-mat-goc-12637999.html','https://imgbox.com/wxbLONTI',0,'2024-03-24 15:22:17.677000','2024-03-24 15:22:17.677000','https://dethi.violet.vn/present/ngu-phap-tieng-anh-cho-nguoi-mat-goc-12637999.html',16,20,38),(36,'Môn học nhằm cung cấp cho sinh viên khả năng sử dụng các cấu trúc dữ liệu nền tảng. Môn học cũng hướng dẫn sinh viên hiểu, phân tích và đánh giá được các giải thuật làm việc với các cấu trúc dữ liệu đó.\nÔn lại về lập trình, các kiểu dữ liệu trong C/C++, đặc biệt là cấu trúc và con trỏ.\nGiới thiệu về độ phức tạp tính toán và đệ qui.\nCác cấu trúc dữ liệu và sự phân tích chúng: danh sách; chồng và hàng; cây, cây nhị phân, cây nhị phân tìm kiếm, AVL và đa phân; heap; giải thuật sắp xếp; bảng băm; và đồ thị.','Cấu Trúc Dữ Liệu Và Giải Thuật - Đh Khoa Học Tự Nhiên Hcm - Phạm Thế Bảo','https://cuuduongthancong.com/sjdt/cau-truc-du-lieu-va-giai-thuat/pham-the-bao/dh-khoa-hoc-tu-nhien-hcm?src=subject','https://s2.cuuduongthancong.com/pdfimg/cau-truc-du-lieu-va-giai-thuat/01.pdf/01.pdf-0.jpg',0,'2024-03-24 15:24:17.677000','2024-03-24 15:24:17.677000','https://cuuduongthancong.com/sjdt/cau-truc-du-lieu-va-giai-thuat/pham-the-bao/dh-khoa-hoc-tu-nhien-hcm?src=subject',16,12,45),(37,'Môn học nhằm cung cấp cho sinh viên khả năng sử dụng các cấu trúc dữ liệu nền tảng. Môn học cũng hướng dẫn sinh viên hiểu, phân tích và đánh giá được các giải thuật làm việc với các cấu trúc dữ liệu đó.\nÔn lại về lập trình, các kiểu dữ liệu trong C/C++, đặc biệt là cấu trúc và con trỏ.\nGiới thiệu về độ phức tạp tính toán và đệ qui.\nCác cấu trúc dữ liệu và sự phân tích chúng: danh sách; chồng và hàng; cây, cây nhị phân, cây nhị phân tìm kiếm, AVL và đa phân; heap; giải thuật sắp xếp; bảng băm; và đồ thị.','Cấu Trúc Dữ Liệu Và Giải Thuật - Đh Công Nghệ Thông Tin','https://cuuduongthancong.com/sjdt/cau-truc-du-lieu-va-giai-thuat//dh-cong-nghe-thong-tin?src=subject','https://s2.cuuduongthancong.com/pdfimg/cau-truc-du-lieu-va-giai-thuat/buoi3.pdf/buoi3.pdf-0.jpg',0,'2024-03-24 15:26:17.677000','2024-03-24 15:26:17.677000','https://cuuduongthancong.com/sjdt/cau-truc-du-lieu-va-giai-thuat//dh-cong-nghe-thong-tin?src=subject',16,12,45);
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
-- Table structure for table `document_report`
--

DROP TABLE IF EXISTS `document_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `doc_id` int DEFAULT NULL,
  `reported_at` datetime(6) DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `type_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `FK1baca7vgifb67o0bjisnxcorm` (`doc_id`),
  KEY `FKgqwg45b36yuohklfx1ajbvsu7` (`type_id`),
  KEY `FK7h284866ps22uuvg846fqf1oc` (`user_id`),
  CONSTRAINT `FK1baca7vgifb67o0bjisnxcorm` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`),
  CONSTRAINT `FK7h284866ps22uuvg846fqf1oc` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKgqwg45b36yuohklfx1ajbvsu7` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_report`
--

LOCK TABLES `document_report` WRITE;
/*!40000 ALTER TABLE `document_report` DISABLE KEYS */;
INSERT INTO `document_report` VALUES (1,'Spam 2 tài liệu y hệt nhau',37,'2024-04-26 23:20:37.473000',_binary '\0',4,21);
/*!40000 ALTER TABLE `document_report` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
INSERT INTO `field` VALUES (1,'Văn học',_binary '\0','2023-12-08 23:57:24.356000',NULL),(2,'Âm nhạc',_binary '\0','2023-12-08 23:57:25.356000',NULL),(3,'Điện ảnh',_binary '\0','2023-12-08 23:57:26.356000',NULL),(4,'Ẩm thực',_binary '\0','2023-12-08 23:57:27.356000',NULL),(5,'Phát triển bản thân',_binary '\0','2023-12-08 23:57:28.356000',NULL),(6,'Báo chí',_binary '\0','2023-12-08 23:57:29.356000',NULL),(7,'Hội họa',_binary '\0','2023-12-08 23:57:30.356000',NULL),(8,'Kiến trúc',_binary '\0','2023-12-08 23:57:24.356000',NULL),(9,'Giao thông vận tải',_binary '\0','2023-12-08 23:57:34.356000',NULL),(10,'Sinh học',_binary '\0','2023-12-08 23:57:35.356000',NULL),(11,'Kỹ năng giao tiếp',_binary '\0','2023-12-08 23:57:36.356000',NULL),(12,'Công nghệ thông tin',_binary '\0','2023-12-08 23:57:37.356000',NULL),(13,'Thời trang',_binary '\0','2023-12-08 23:57:24.356000',NULL),(14,'Thể thao',_binary '\0','2023-12-08 23:57:38.356000',NULL),(15,'Địa chất',_binary '\0','2023-12-08 23:57:39.356000',NULL),(16,'Xuất bản',_binary '\0','2023-12-08 23:57:40.356000',NULL),(17,'Công nghiệp ô tô',_binary '\0','2023-12-08 23:57:24.356000',NULL),(18,'Y học',_binary '\0','2023-12-08 23:57:24.356000',NULL),(19,'Đầu tư - Kinh doanh',_binary '\0','2023-12-08 23:57:24.356000',NULL),(20,'Ngoại ngữ',_binary '\0','2023-12-08 23:57:24.356000',NULL),(21,'Tâm linh',_binary '\0','2023-12-08 23:57:24.356000',NULL),(23,'Tâm lý',_binary '\0','2024-04-01 08:15:24.356000','2024-04-01 08:15:24.356000'),(24,'Sức khỏe',_binary '\0','2023-12-14 08:15:24.356000','2023-12-14 08:15:24.356000');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,_binary '\0',1,'POST_LIKE',6,21),(2,_binary '\0',7,'POST_LIKE',21,5),(3,_binary '\0',5,'COMMENT_LIKE',10,21),(5,_binary '\0',1,'POST_LIKE',6,10),(13,_binary '\0',1,'DOC_LIKE',10,21),(14,_binary '\0',1,'DOC_LIKE',10,21),(15,_binary '\0',1,'POST_COMMENT',6,21),(16,_binary '\0',1,'POST_COMMENT',6,21);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Mình có dư một cuốn sách Nhập môn lập trình\nBạn nào muốn lấy thì bình luận phía dưới nha!','2023-12-13 23:57:24.356000','Sách Nhập môn lập trình',NULL,6),(2,'Ai có pdf môn Triết học không, cho mình ké với!\nMình cảm ơn!','2023-12-14 23:57:25.183000','PDF Triết học',NULL,6),(3,'Mình có tài liệu Tóm tắt công thức lớp Vật lý 1 \nAi cần bình luận nha!','2023-12-15 23:57:25.183000','Công thức Vật lý 1',NULL,6),(4,'Có bạn nào có nhiều bài báo nghiên cứu về ứng dụng của Triết học không nhỉ?','2023-12-16 23:57:25.183000','Bài báo ứng dụng Triết học ',NULL,7),(5,'Có bạn nào có tài liệu để nghiên cứu đề tài bên dưới không, cho mình xin với!\nHigh-cell-density fermentations using Bacillus subtilis','2023-12-17 23:57:25.183000','High-cell-density fermentations using Bacillus subtilis',NULL,7),(6,'Có ai có PDF Tư tưởng Hồ Chí Minh mới nhất không ạ?','2023-12-18 11:57:25.183000','Tư tưởng HCM mới nhất',NULL,7),(7,'Mình có kiếm được vài sách Triết học khá hay, bạn nào tò mò thì vào trang cá nhân mình coi nha','2023-12-18 12:57:25.183000','Sách Triết học',NULL,21),(8,'Mình có bản dịch tài liệu hướng dẫn sử dụng CSDL mySQL \nBạn nào muốn xem thì vào trang mình ','2023-12-18 13:57:25.183000','HDSD mySQL',NULL,9),(9,'Mình có vài tài liệu học AI, vào trang mình để xem ','2023-12-18 14:57:25.183000','Học AI',NULL,9),(10,'Tài liệu bản dịch hướng dẫn sử dụng Intellij','2023-12-18 16:57:25.183000','HDSD Intellij',NULL,9),(11,'Mình có sưu tầm những bài thơ hay nhất của Xuân Diệu, bạn nào muốn đọc thì qua trang mình','2023-12-18 17:57:25.183000','Thơ Xuân Diệu',NULL,6),(12,'Ai có sách An toàn thông tin nào giải thích chi tiết dễ hiểu không, cho mình xin với!','2023-12-18 18:57:25.183000','An toàn thông tin ',NULL,6),(15,'Có tài liệu nào hướng dẫn dùng Swagger UI không nhỉ? Tiếng Việt càng tốt ạ! Mình cảm ơn!','2024-03-09 19:50:58.721000','Có tài liệu nào hướng dẫn dùng Swagger UI không nhỉ? Tiếng Việt càng tốt ạ!','2024-03-09 19:51:44.280000',47),(17,'Bạn nào có tài liệu ôn trắc nghiệm Hệ điều hành không?','2024-04-01 08:15:24.356000','Tài liệu trắc nghiệm Hệ điều hành','2024-04-01 08:15:24.356000',19),(18,'Mình có sưu tầm những bài văn mẫu lớp 12 khá hay, bạn nào quan tâm thì liên hệ mình','2024-04-01 08:25:24.356000','Văn mẫu lớp 12','2024-04-01 08:25:24.356000',19),(19,'Bạn nào có các bài báo cáo Thí nghiệm vật lý 1 bên UTE không cho mình xin với?','2024-04-01 08:26:24.356000','Thí nghiệm vật lý 1 UTE','2024-04-01 08:26:24.356000',19),(20,'Bạn nào có đề và đáp án Kiến trúc máy tính SPKT không cho mình xin với','2024-04-01 08:27:24.356000','Kiến trúc máy tính SPKT','2024-04-01 08:27:24.356000',44),(21,'Bạn nào có cuốn Truyện Kiều bản nước ngoài không ạ?','2024-04-01 08:50:24.356000','Truyện Kiều bản dịch ','2024-04-01 08:50:24.356000',16),(22,'Bạn nào đã từng phân tích bản tiếng Anh của truyện Kiều chưa ạ, nếu có cho mình xin tham khảo với ạ!','2024-04-01 08:55:24.356000','Phân tích truyện Kiều bản dịch tiếng Anh ','2024-04-01 08:55:24.356000',16),(23,'Có ai có cuốn Kỹ thuật lập trình như trường SPKT dạy không ạ?','2024-04-01 09:15:24.356000','Sách Kỹ thuật lập trình SPKT','2024-04-01 09:15:24.356000',16),(24,'Cho em xin các bài tập để ôn Kỹ thuật lập trình UTE với ạ!','2024-04-01 09:25:24.356000','Bài tập ôn Kỹ thuật lập trình UTE ','2024-04-01 09:25:24.356000',19),(25,'Làm thế nào để giải nhanh các bài toán hình học không gian? Có tài liệu nào hướng dẫn mẹo này không?','2024-04-01 09:35:24.356000','Hình học không gian','2024-04-01 09:35:24.356000',39),(26,'Các phương pháp nào giúp giải quyết bài toán đạo hàm và tích phân phức tạp? Có ai có Giáo trình toán cao cấp không?','2024-04-01 09:45:24.356000','Toán cao cấp','2024-04-01 09:45:24.356000',39),(27,'Làm thế nào để hiểu sâu về các nguyên lý cơ bản của cơ học lượng tử? Có tài liệu nào giải thích vấn đề này dễ hiểu không ạ?','2024-04-02 09:55:24.356000','Cơ học lượng tử ','2024-04-02 09:55:24.356000',41),(28,'Những chiến lược nào giúp nhớ nhanh cấu trúc phân tử và phản ứng hóa học?','2024-04-02 10:05:24.356000','Những chiến lược nào giúp nhớ nhanh cấu trúc phân tử và phản ứng hóa học?','2024-04-02 10:05:24.356000',41),(29,'Làm sao để nắm vững các quy trình và cơ chế di truyền ở cấp độ phân tử?','2024-04-02 10:15:24.356000','Sinh học phân tử','2024-04-02 10:15:24.356000',42),(30,'Mình có vài link tải từ điển Anh Việt miễn phí, các bạn có thể qua trang cá nhân mình để xem ','2024-04-02 10:25:24.356000','Từ điển tiếng Anh ','2024-04-02 10:25:24.356000',38),(31,'Mình có chia sẻ vài tài liệu học Kỹ thuật lập trình khá dễ hiểu, ai quan tâm thì qua trang mình coi','2024-04-02 10:35:24.356000','Kỹ thuật lập trình ','2024-04-02 10:35:24.356000',21),(32,'Phương pháp nào giúp phân tích và đánh giá tác phẩm nghệ thuật từ góc độ lịch sử và văn hóa?','2024-04-02 10:45:24.356000','Nghệ thuật','2024-04-02 10:45:24.356000',12),(33,'Phương pháp nào giúp cải thiện kỹ năng nghe hiểu tiếng Anh?','2024-04-02 10:55:24.356000','Học tiếng Anh','2024-04-02 10:55:24.356000',18),(34,'string','2024-04-25 16:52:55.283000','string','2024-04-25 17:23:09.658000',21),(35,'Sách TOEIC của mình bán đảm bảo ôn thi trên 900 nha mấy bạn. Liên hệ qua mail 123@gmail.com','2024-04-26 16:52:55.283000','Tiếng anh TOEIC',NULL,15);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_image`
--

DROP TABLE IF EXISTS `post_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_image` (
  `post_image_id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  PRIMARY KEY (`post_image_id`),
  KEY `FKnloq4boxs4ewryyvvfnp5uf2e` (`post_id`),
  CONSTRAINT `FKnloq4boxs4ewryyvvfnp5uf2e` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;
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
-- Table structure for table `post_report`
--

DROP TABLE IF EXISTS `post_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `is_read` bit(1) NOT NULL,
  `reported_at` datetime(6) DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `FKmnpxqyrdbita9cgl2lwrc4ho4` (`post_id`),
  KEY `FKi2jfes1q50bbu0bjjk7qbebn0` (`type_id`),
  KEY `FKs92swr93jnboiaplg1hnkuwoh` (`user_id`),
  CONSTRAINT `FKi2jfes1q50bbu0bjjk7qbebn0` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`type_id`),
  CONSTRAINT `FKmnpxqyrdbita9cgl2lwrc4ho4` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `FKs92swr93jnboiaplg1hnkuwoh` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_report`
--

LOCK TABLES `post_report` WRITE;
/*!40000 ALTER TABLE `post_report` DISABLE KEYS */;
INSERT INTO `post_report` VALUES (1,_binary '\0','2024-04-26 23:18:56.756000',34,14,21,''),(2,_binary '\0','2024-04-26 23:19:44.011000',35,19,21,'Mua bán, có dấu hiệu lừa đảo');
/*!40000 ALTER TABLE `post_report` ENABLE KEYS */;
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
INSERT INTO `post_tag` VALUES (1,1),(23,1),(24,1),(31,1),(1,2),(2,3),(4,3),(7,3),(3,4),(27,4),(34,4),(34,5),(5,6),(6,7),(8,8),(9,9),(10,10),(11,11),(12,12),(18,14),(21,14),(19,15),(24,15),(20,16),(20,17),(23,17),(22,18),(30,18),(33,18),(25,19),(26,19),(28,20),(29,21),(32,22);
/*!40000 ALTER TABLE `post_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_type`
--

DROP TABLE IF EXISTS `report_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `type` int NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_type`
--

LOCK TABLES `report_type` WRITE;
/*!40000 ALTER TABLE `report_type` DISABLE KEYS */;
INSERT INTO `report_type` VALUES (1,'Giả mạo',0),(2,'Chứa nội dung đồi truỵ',0),(3,'Chứa nội dung thù địch, gây nguy hiểm',0),(4,'Spam',0),(5,'Thông tin sai lệch',0),(6,'Vi phạm bản quyền',0),(7,'Nội dung gây hiểu lầm',0),(8,'Nội dung phản động, chống phá',0),(9,'Chất lượng kém',0),(10,'Khác',0),(11,'Chứa ảnh đồi truỵ',1),(12,'Chứa ảnh bạo lực, nguy hiểm',1),(13,'Ngôn từ gây thù ghét',1),(14,'Spam',1),(15,'Bán hàng',1),(16,'Tin giả',1),(17,'Bạo lực ngôn từ, xúc phạm',1),(18,'Quấy rối',1),(19,'Lừa đảo',1),(20,'Nội dung gây kích động, chia rẽ',1),(21,'Khác',1);
/*!40000 ALTER TABLE `report_type` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'2023-12-08 23:57:24.356000','CNTT',NULL),(2,'2023-12-08 23:57:25.356000','IT',NULL),(3,'2023-12-08 23:57:24.356000','Triết học',NULL),(4,'2023-12-08 23:57:26.356000','Vật lý',NULL),(5,'2023-12-08 23:57:24.356000','Đại học',NULL),(6,'2023-12-08 23:57:27.356000','Hóa sinh',NULL),(7,'2023-12-08 23:57:24.356000','Tư tưởng Hồ Chí Minh',NULL),(8,'2023-12-08 23:57:28.356000','CSDL',NULL),(9,'2023-12-08 23:57:24.356000','AI',NULL),(10,'2023-12-08 23:57:29.356000','IDE',NULL),(11,'2023-12-08 23:57:24.356000','Xuân Diệu',NULL),(12,'2023-12-08 23:57:30.356000','An toàn thông tin',NULL),(14,'2024-04-01 08:15:24.356000','Văn học','2024-04-01 08:15:24.356000'),(15,'2024-04-01 08:15:24.356000','UTE','2024-04-01 08:15:24.356000'),(16,'2024-04-01 08:15:24.356000','Kiến trúc máy tính','2024-04-01 08:15:24.356000'),(17,'2024-04-01 08:15:24.356000','SPKT','2024-04-01 08:15:24.356000'),(18,'2024-04-01 08:15:24.356000','Tiếng Anh','2024-04-01 08:15:24.356000'),(19,'2024-04-01 08:15:24.356000','Toán học','2024-04-01 08:15:24.356000'),(20,'2024-04-01 08:15:24.356000','Hóa học','2024-04-01 08:15:24.356000'),(21,'2024-04-01 08:15:24.356000','Sinh học','2024-04-01 08:15:24.356000'),(22,'2024-04-01 08:15:24.356000','Nghệ thuật','2024-04-01 08:15:24.356000');
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

-- Dump completed on 2024-04-26 23:29:35
