-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: job_platform
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$1000000$5XzOLnKDwPO2zdKKEthwoZ$AkKSlaZn3KgFKBO04GpwfOg5iDO/cWH3jzyCwCawBBg=','2025-06-16 08:58:36.176828',1,'Kevin','','','23307130031@m.fudan.edu.cn',1,1,'2025-06-16 08:58:18.555484','admin'),(10,'pbkdf2_sha256$1000000$ie7tQLyLqsswrQv7NWdj3I$pI/Pm9bVYNERBhuN/kCtDaQs82o8TzDN6//ROfkJLHI=','2025-06-20 11:58:10.600820',0,'美特斯邦威','','','',0,1,'2025-06-20 11:10:23.000000','employer'),(11,'pbkdf2_sha256$1000000$qw5ot7quJZWQqaJGoyfPq2$pHkcNUbm0fCE6/zfU1zMRZO+IKi2W3viNz6fhfJm2xg=','2025-06-20 11:50:34.056366',0,'复旦微','','','',0,1,'2025-06-20 11:10:41.000000','employer'),(12,'pbkdf2_sha256$1000000$pdaEJAbIBxlozS7fTszHNt$A1VjAnGT4o9MgMb0e7MfyjkiAYEJpPWi9ZGXQ9OxabY=','2025-06-20 11:54:26.554303',0,'摩根士丹利','','','',0,1,'2025-06-20 11:11:25.000000','employer'),(13,'pbkdf2_sha256$1000000$C85Ak3T2ahOshBwWEEgZxS$bXJLCEU7eTpxu3JPOm+/U4jymFJ52r8WRuHeMMQmqec=','2025-06-20 11:20:48.401826',0,'DeepSeek','','','',0,1,'2025-06-20 11:12:02.000000','employer'),(14,'pbkdf2_sha256$1000000$LMVoyCPXaopbpfRJAd573K$SpXdUFr5TqZZ43zXBZiIX6b/aLE4EZOh1FUxmDvHk/M=','2025-06-20 11:46:03.380710',0,'哔哩哔哩','','','',0,1,'2025-06-20 11:12:41.000000','employer'),(15,'pbkdf2_sha256$1000000$aZ2xWAPBF4CKJWNY0HdQoM$P6hmOa9oMA45qV2ssHlzOeWxGOtbWqG92LgooNmki+Y=','2025-06-20 11:41:48.199222',0,'中国石化','','','',0,1,'2025-06-20 11:13:08.000000','employer'),(16,'pbkdf2_sha256$1000000$NIDkBMiICVTCnMOr2e71B5$xETIEc/rVdtiYAuiJnlzfV1btOghiQbPabieaoWokjI=','2025-06-20 12:01:09.858332',0,'链家','','','',0,1,'2025-06-20 11:14:03.000000','employer'),(17,'pbkdf2_sha256$1000000$JGY2ePRQwUsILOV2vE1D3B$SAyq6PCzE2XQyFJvlqcG2xvDTm5ShhKKBQQbEdHWX8o=','2025-06-20 12:40:32.036526',0,'罗2凡','','','23307130031@m.fudan.edu.cn',0,1,'2025-06-20 12:04:01.878881','jobseeker'),(18,'pbkdf2_sha256$1000000$evxgCm14w3Kj4gjjyOjuMC$Q1eJCqECB8ngyiNLG4cBup/oN7bG9wlAqCT558UJtSE=','2025-06-20 12:25:56.250665',0,'F1sherman','','','123@qq.com',0,1,'2025-06-20 12:15:01.979800','jobseeker'),(19,'pbkdf2_sha256$1000000$8dXugSnqxTPwRrhL7KQ4H6$Onba+Ki1DyAgKXV+mt+5oXC9vwHhMqDw3TeiU2yZwnU=','2025-06-20 12:19:23.180857',0,'Lyh','','','12320111831@163.com',0,1,'2025-06-20 12:18:36.245564','jobseeker'),(20,'pbkdf2_sha256$1000000$QAsR3Z9ME8NYfzG8lhyjj7$95EuoI/AoY2gSeEALNyicYTbDUuALbzI64MWuSuwqw4=','2025-06-20 12:24:48.506849',0,'陈qp','','','',0,1,'2025-06-20 12:22:31.732702','jobseeker'),(21,'pbkdf2_sha256$1000000$lhfFmWSnHlm0tQG8dSJuX8$9GlXEwgVi02yus+wTwxd7l130R3elp3dzudNweLbFGc=','2025-06-20 15:45:23.772587',0,'testjobseeker','','','1234@shanda.edu.cn',0,1,'2025-06-20 12:26:55.088454','jobseeker'),(22,'pbkdf2_sha256$1000000$HYvPFEcT7Z3uVt8m9jVBkw$BCwQanxODBsT6fnfmsQRxR7NwrOPoQKC9E0ND5/aspE=','2025-06-20 12:34:27.935535',1,'testsuperuser','','','123@123.com',1,1,'2025-06-20 12:34:10.419011','admin'),(23,'pbkdf2_sha256$1000000$dxKDZP7AmrYQw5tW8awUBn$IS12OGrohaeeGWucx6UqpwoC2HZGRsPWarcMNRG/zwE=','2025-06-20 15:41:10.732184',0,'testcompany','','','',0,1,'2025-06-20 12:35:13.507914','employer'),(24,'pbkdf2_sha256$1000000$51uekXWYnBDGqsfc0kyjkq$sd8oACLrJMSdpxc5F/AHLgDcgr40OOIA1QVAEweOgZg=','2025-06-20 15:40:52.093451',0,'Logan','','','',0,1,'2025-06-20 14:46:01.429259','jobseeker');
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_user`
--

DROP TABLE IF EXISTS `api_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `join_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_user`
--

LOCK TABLES `api_user` WRITE;
/*!40000 ALTER TABLE `api_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add 企业',7,'add_company'),(26,'Can change 企业',7,'change_company'),(27,'Can delete 企业',7,'delete_company'),(28,'Can view 企业',7,'view_company'),(29,'Can add 行业',8,'add_industry'),(30,'Can change 行业',8,'change_industry'),(31,'Can delete 行业',8,'delete_industry'),(32,'Can view 行业',8,'view_industry'),(33,'Can add 求职者',9,'add_jobseeker'),(34,'Can change 求职者',9,'change_jobseeker'),(35,'Can delete 求职者',9,'delete_jobseeker'),(36,'Can view 求职者',9,'view_jobseeker'),(37,'Can add 职位',10,'add_jobtitle'),(38,'Can change 职位',10,'change_jobtitle'),(39,'Can delete 职位',10,'delete_jobtitle'),(40,'Can view 职位',10,'view_jobtitle'),(41,'Can add 语言能力',11,'add_language'),(42,'Can change 语言能力',11,'change_language'),(43,'Can delete 语言能力',11,'delete_language'),(44,'Can view 语言能力',11,'view_language'),(45,'Can add 学校',12,'add_school'),(46,'Can change 学校',12,'change_school'),(47,'Can delete 学校',12,'delete_school'),(48,'Can view 学校',12,'view_school'),(49,'Can add 标签',13,'add_tag'),(50,'Can change 标签',13,'change_tag'),(51,'Can delete 标签',13,'delete_tag'),(52,'Can view 标签',13,'view_tag'),(53,'Can add 城市',14,'add_city'),(54,'Can change 城市',14,'change_city'),(55,'Can delete 城市',14,'delete_city'),(56,'Can view 城市',14,'view_city'),(57,'Can add 岗位',15,'add_position'),(58,'Can change 岗位',15,'change_position'),(59,'Can delete 岗位',15,'delete_position'),(60,'Can view 岗位',15,'view_position'),(61,'Can add 企业_位于_城市',16,'add_companylocation'),(62,'Can change 企业_位于_城市',16,'change_companylocation'),(63,'Can delete 企业_位于_城市',16,'delete_companylocation'),(64,'Can view 企业_位于_城市',16,'view_companylocation'),(65,'Can add 求职者_期望_行业',17,'add_desiredindustry'),(66,'Can change 求职者_期望_行业',17,'change_desiredindustry'),(67,'Can delete 求职者_期望_行业',17,'delete_desiredindustry'),(68,'Can view 求职者_期望_行业',17,'view_desiredindustry'),(69,'Can add 求职者_期望_城市',18,'add_desiredcity'),(70,'Can change 求职者_期望_城市',18,'change_desiredcity'),(71,'Can delete 求职者_期望_城市',18,'delete_desiredcity'),(72,'Can view 求职者_期望_城市',18,'view_desiredcity'),(73,'Can add 企业用户_收藏_求职者',19,'add_companyfavoritejobseeker'),(74,'Can change 企业用户_收藏_求职者',19,'change_companyfavoritejobseeker'),(75,'Can delete 企业用户_收藏_求职者',19,'delete_companyfavoritejobseeker'),(76,'Can view 企业用户_收藏_求职者',19,'view_companyfavoritejobseeker'),(77,'Can add 求职者_期望_职位',20,'add_desiredjobtitle'),(78,'Can change 求职者_期望_职位',20,'change_desiredjobtitle'),(79,'Can delete 求职者_期望_职位',20,'delete_desiredjobtitle'),(80,'Can view 求职者_期望_职位',20,'view_desiredjobtitle'),(81,'Can add 求职者_掌握_语言',21,'add_jobseekerlanguage'),(82,'Can change 求职者_掌握_语言',21,'change_jobseekerlanguage'),(83,'Can delete 求职者_掌握_语言',21,'delete_jobseekerlanguage'),(84,'Can view 求职者_掌握_语言',21,'view_jobseekerlanguage'),(85,'Can add 求职者_收藏_岗位',22,'add_favoriteposition'),(86,'Can change 求职者_收藏_岗位',22,'change_favoriteposition'),(87,'Can delete 求职者_收藏_岗位',22,'delete_favoriteposition'),(88,'Can view 求职者_收藏_岗位',22,'view_favoriteposition'),(89,'Can add 岗位_要求_语言',23,'add_positionlanguagerequirement'),(90,'Can change 岗位_要求_语言',23,'change_positionlanguagerequirement'),(91,'Can delete 岗位_要求_语言',23,'delete_positionlanguagerequirement'),(92,'Can view 岗位_要求_语言',23,'view_positionlanguagerequirement'),(93,'Can add 教育经历',24,'add_educationexperience'),(94,'Can change 教育经历',24,'change_educationexperience'),(95,'Can delete 教育经历',24,'delete_educationexperience'),(96,'Can view 教育经历',24,'view_educationexperience'),(97,'Can add 企业_标签',25,'add_companytag'),(98,'Can change 企业_标签',25,'change_companytag'),(99,'Can delete 企业_标签',25,'delete_companytag'),(100,'Can view 企业_标签',25,'view_companytag'),(101,'Can add Token',26,'add_token'),(102,'Can change Token',26,'change_token'),(103,'Can delete Token',26,'delete_token'),(104,'Can view Token',26,'view_token'),(105,'Can add Token',27,'add_tokenproxy'),(106,'Can change Token',27,'change_tokenproxy'),(107,'Can delete Token',27,'delete_tokenproxy'),(108,'Can view Token',27,'view_tokenproxy'),(109,'Can add user',28,'add_user'),(110,'Can change user',28,'change_user'),(111,'Can delete user',28,'delete_user'),(112,'Can view user',28,'view_user');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('9a0cf02dae65fdd1388e66541c6f70ea0130049f','2025-06-20 15:45:23.768749',21),('b954df7cbda894a9a7779bee398b7d658195c4ec','2025-06-20 12:40:32.029017',17);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-06-16 08:58:55.796465','2','罗一凡',1,'[{\"added\": {}}]',28,1),(2,'2025-06-16 08:59:58.900344','1','上海 - 上海',1,'[{\"added\": {}}]',14,1),(3,'2025-06-16 09:00:03.516533','1','互联网',1,'[{\"added\": {}}]',8,1),(4,'2025-06-16 09:00:10.569907','1','复旦大学',1,'[{\"added\": {}}]',12,1),(5,'2025-06-16 09:00:23.822457','1','普通话',1,'[{\"added\": {}}]',11,1),(6,'2025-06-16 09:00:31.595020','1','数据分析师',1,'[{\"added\": {}}]',10,1),(7,'2025-06-16 09:00:32.574207','2','罗一凡',1,'[{\"added\": {}}, {\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u671f\\u671b_\\u57ce\\u5e02\", \"object\": \"DesiredCity object (1)\"}}, {\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u671f\\u671b_\\u884c\\u4e1a\", \"object\": \"DesiredIndustry object (1)\"}}, {\"added\": {\"name\": \"\\u6559\\u80b2\\u7ecf\\u5386\", \"object\": \"EducationExperience object (1)\"}}, {\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u638c\\u63e1_\\u8bed\\u8a00\", \"object\": \"JobSeekerLanguage object (1)\"}}, {\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u671f\\u671b_\\u804c\\u4f4d\", \"object\": \"DesiredJobTitle object (1)\"}}]',9,1),(8,'2025-06-16 09:30:28.569472','3','复旦微',1,'[{\"added\": {}}]',28,1),(9,'2025-06-16 09:31:16.152813','3','复旦微',1,'[{\"added\": {}}, {\"added\": {\"name\": \"\\u4f01\\u4e1a_\\u4f4d\\u4e8e_\\u57ce\\u5e02\", \"object\": \"CompanyLocation object (1)\"}}]',7,1),(10,'2025-06-16 09:49:46.177997','4','罗2凡',1,'[{\"added\": {}}]',28,1),(11,'2025-06-16 09:58:18.343429','4','罗2凡',3,'',9,1),(12,'2025-06-16 10:07:36.836670','5','美特斯邦威',1,'[{\"added\": {}}]',28,1),(13,'2025-06-16 11:24:14.363806','1','中国500强',1,'[{\"added\": {}}]',13,1),(14,'2025-06-16 11:36:43.789326','2','工程师',1,'[{\"added\": {}}]',10,1),(15,'2025-06-16 12:43:51.272377','1','数据分析师',2,'[{\"changed\": {\"fields\": [\"Description\"]}}]',15,1),(16,'2025-06-16 14:49:09.873929','5','美特斯邦威',2,'[{\"changed\": {\"name\": \"\\u5c97\\u4f4d\", \"object\": \"\\u6570\\u636e\\u5206\\u6790\\u5e08\", \"fields\": [\"Description\"]}}, {\"changed\": {\"name\": \"\\u5c97\\u4f4d\", \"object\": \"\\u6570\\u636e\\u5206\\u6790\\u5e08\", \"fields\": [\"Description\"]}}, {\"added\": {\"name\": \"\\u4f01\\u4e1a_\\u6807\\u7b7e\", \"object\": \"CompanyTag object (2)\"}}]',7,1),(17,'2025-06-17 13:46:00.284834','4','罗2凡',2,'[{\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u671f\\u671b_\\u884c\\u4e1a\", \"object\": \"DesiredIndustry object (2)\"}}]',9,1),(18,'2025-06-17 14:37:39.875255','2','游戏',1,'[{\"added\": {}}]',8,1),(19,'2025-06-20 02:33:18.148214','4','罗2凡',2,'[{\"added\": {\"name\": \"\\u6559\\u80b2\\u7ecf\\u5386\", \"object\": \"EducationExperience object (2)\"}}]',9,1),(20,'2025-06-20 05:08:32.988267','4','罗2凡',2,'[{\"added\": {\"name\": \"\\u6c42\\u804c\\u8005_\\u638c\\u63e1_\\u8bed\\u8a00\", \"object\": \"JobSeekerLanguage object (2)\"}}]',9,1),(21,'2025-06-20 05:48:48.787337','2','日语',1,'[{\"added\": {}}]',11,1),(22,'2025-06-20 05:48:51.612101','3','英语',1,'[{\"added\": {}}]',11,1),(23,'2025-06-20 06:02:05.680064','2','上海交通大学',1,'[{\"added\": {}}]',12,1),(24,'2025-06-20 06:23:18.425730','2','四川 - 内江',1,'[{\"added\": {}}]',14,1),(25,'2025-06-20 06:23:23.712429','3','浙江 - 杭州',1,'[{\"added\": {}}]',14,1),(26,'2025-06-20 10:54:37.379571','4','俄语',1,'[{\"added\": {}}]',11,1),(27,'2025-06-20 10:54:41.649619','5','德语',1,'[{\"added\": {}}]',11,1),(28,'2025-06-20 10:54:48.605856','6','西班牙天涯',1,'[{\"added\": {}}]',11,1),(29,'2025-06-20 10:54:53.707520','6','西班牙语',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',11,1),(30,'2025-06-20 10:54:59.494862','7','法语',1,'[{\"added\": {}}]',11,1),(31,'2025-06-20 10:55:06.142586','8','粤语',1,'[{\"added\": {}}]',11,1),(32,'2025-06-20 10:55:16.736758','9','葡萄牙语',1,'[{\"added\": {}}]',11,1),(33,'2025-06-20 10:55:26.969731','10','意大利语',1,'[{\"added\": {}}]',11,1),(34,'2025-06-20 10:55:31.989930','3','金融',1,'[{\"added\": {}}]',8,1),(35,'2025-06-20 10:55:36.531576','4','汽车',1,'[{\"added\": {}}]',8,1),(36,'2025-06-20 10:56:11.676851','5','半导体',1,'[{\"added\": {}}]',8,1),(37,'2025-06-20 10:56:23.918177','6','医疗',1,'[{\"added\": {}}]',8,1),(38,'2025-06-20 10:56:33.090466','7','房地产',1,'[{\"added\": {}}]',8,1),(39,'2025-06-20 10:56:44.514306','8','交通',1,'[{\"added\": {}}]',8,1),(40,'2025-06-20 10:56:47.025867','9','能源',1,'[{\"added\": {}}]',8,1),(41,'2025-06-20 10:57:04.526531','10','服装',1,'[{\"added\": {}}]',8,1),(42,'2025-06-20 10:57:14.990118','3','机械师',1,'[{\"added\": {}}]',10,1),(43,'2025-06-20 10:57:19.838041','4','设计师',1,'[{\"added\": {}}]',10,1),(44,'2025-06-20 10:57:42.914750','5','前端工程师',1,'[{\"added\": {}}]',10,1),(45,'2025-06-20 10:57:48.796491','2','工程师',3,'',10,1),(46,'2025-06-20 10:57:58.558401','3','机械工程师',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',10,1),(47,'2025-06-20 10:58:09.298745','6','数据库管理人员',1,'[{\"added\": {}}]',10,1),(48,'2025-06-20 10:58:16.322902','7','后端工程师',1,'[{\"added\": {}}]',10,1),(49,'2025-06-20 10:58:30.429475','8','算法工程师',1,'[{\"added\": {}}]',10,1),(50,'2025-06-20 10:59:01.325273','9','项目经理',1,'[{\"added\": {}}]',10,1),(51,'2025-06-20 10:59:04.082736','10','财务经理',1,'[{\"added\": {}}]',10,1),(52,'2025-06-20 10:59:13.302990','11','产品经理',1,'[{\"added\": {}}]',10,1),(53,'2025-06-20 10:59:31.219130','12','软件开发',1,'[{\"added\": {}}]',10,1),(54,'2025-06-20 11:00:50.135534','13','客服',1,'[{\"added\": {}}]',10,1),(55,'2025-06-20 11:01:13.026508','14','半导体工程师',1,'[{\"added\": {}}]',10,1),(56,'2025-06-20 11:01:27.746359','15','医疗器械开发',1,'[{\"added\": {}}]',10,1),(57,'2025-06-20 11:01:53.445546','16','市场运营专员',1,'[{\"added\": {}}]',10,1),(58,'2025-06-20 11:02:21.774824','17','房地产中介',1,'[{\"added\": {}}]',10,1),(59,'2025-06-20 11:03:07.045012','18','电气研究工程师',1,'[{\"added\": {}}]',10,1),(60,'2025-06-20 11:03:15.433927','19','平面设计师',1,'[{\"added\": {}}]',10,1),(61,'2025-06-20 11:03:32.319914','4','罗2凡',3,'',9,1),(62,'2025-06-20 11:03:37.619362','2','罗一凡',3,'',9,1),(63,'2025-06-20 11:03:49.858947','5','美特斯邦威',3,'',7,1),(64,'2025-06-20 11:03:55.343059','3','复旦微',3,'',7,1),(65,'2025-06-20 11:03:58.773816','4','a2c381d89ffae93df57f6c71b49363f614ce7423',3,'',27,1),(66,'2025-06-20 11:04:15.071219','4','四川 - 成都',1,'[{\"added\": {}}]',14,1),(67,'2025-06-20 11:04:54.975474','5','江苏 - 宿迁',1,'[{\"added\": {}}]',14,1),(68,'2025-06-20 11:05:03.929567','6','北京 - 北京',1,'[{\"added\": {}}]',14,1),(69,'2025-06-20 11:05:15.618332','7','安徽 - 芜湖',1,'[{\"added\": {}}]',14,1),(70,'2025-06-20 11:05:23.429891','8','浙江 - 温州',1,'[{\"added\": {}}]',14,1),(71,'2025-06-20 11:05:56.665818','9','黑龙江 - 哈尔滨',1,'[{\"added\": {}}]',14,1),(72,'2025-06-20 11:06:17.477274','10','广东 - 深圳',1,'[{\"added\": {}}]',14,1),(73,'2025-06-20 11:06:24.484378','11','广东 - 广州',1,'[{\"added\": {}}]',14,1),(74,'2025-06-20 11:06:48.609749','12','香港 - 香港',1,'[{\"added\": {}}]',14,1),(75,'2025-06-20 11:07:13.900837','3','复旦微',3,'',28,1),(76,'2025-06-20 11:07:18.084855','4','罗2凡',3,'',28,1),(77,'2025-06-20 11:07:21.616958','2','罗一凡',3,'',28,1),(78,'2025-06-20 11:07:25.616830','5','美特斯邦威',3,'',28,1),(79,'2025-06-20 11:07:56.369049','6','罗2凡',1,'[{\"added\": {}}]',28,1),(80,'2025-06-20 11:08:17.635983','6','罗2凡',3,'',28,1),(81,'2025-06-20 11:08:33.266830','7','罗2凡',1,'[{\"added\": {}}]',28,1),(82,'2025-06-20 11:08:54.669274','8','F1sherman',1,'[{\"added\": {}}]',28,1),(83,'2025-06-20 11:08:58.689239','8','F1sherman',2,'[]',28,1),(84,'2025-06-20 11:09:19.176081','9','李Yh',1,'[{\"added\": {}}]',28,1),(85,'2025-06-20 11:09:21.739908','9','李Yh',2,'[]',28,1),(86,'2025-06-20 11:10:02.031507','8','F1sherman',3,'',28,1),(87,'2025-06-20 11:10:05.722956','9','李Yh',3,'',28,1),(88,'2025-06-20 11:10:08.705481','7','罗2凡',3,'',28,1),(89,'2025-06-20 11:10:25.014564','10','美特斯邦威',1,'[{\"added\": {}}]',28,1),(90,'2025-06-20 11:10:28.337792','10','美特斯邦威',2,'[]',28,1),(91,'2025-06-20 11:10:43.385405','11','复旦微',1,'[{\"added\": {}}]',28,1),(92,'2025-06-20 11:10:47.183844','11','复旦微',2,'[]',28,1),(93,'2025-06-20 11:11:27.046920','12','摩根士丹利',1,'[{\"added\": {}}]',28,1),(94,'2025-06-20 11:11:30.203317','12','摩根士丹利',2,'[]',28,1),(95,'2025-06-20 11:11:35.849071','11','复旦微',2,'[{\"changed\": {\"fields\": [\"User type\"]}}]',28,1),(96,'2025-06-20 11:12:04.503876','13','DeepSeek',1,'[{\"added\": {}}]',28,1),(97,'2025-06-20 11:12:06.786084','13','DeepSeek',2,'[]',28,1),(98,'2025-06-20 11:12:43.282621','14','哔哩哔哩',1,'[{\"added\": {}}]',28,1),(99,'2025-06-20 11:12:45.668994','14','哔哩哔哩',2,'[]',28,1),(100,'2025-06-20 11:13:10.011321','15','中国石化',1,'[{\"added\": {}}]',28,1),(101,'2025-06-20 11:13:12.582220','15','中国石化',2,'[]',28,1),(102,'2025-06-20 11:14:05.453751','16','链家',1,'[{\"added\": {}}]',28,1),(103,'2025-06-20 11:14:10.274239','16','链家',2,'[]',28,1),(104,'2025-06-20 11:20:27.031255','13','DeepSeek',1,'[{\"added\": {}}]',7,1),(105,'2025-06-20 11:32:01.270879','11','人工智能',1,'[{\"added\": {}}]',8,1),(106,'2025-06-20 11:39:13.006427','15','中国石化',1,'[{\"added\": {}}]',7,1),(107,'2025-06-20 11:45:51.709784','14','哔哩哔哩',1,'[{\"added\": {}}]',7,1),(108,'2025-06-20 11:50:01.114139','11','复旦微',1,'[{\"added\": {}}]',7,1),(109,'2025-06-20 11:54:04.866278','12','摩根士丹利',1,'[{\"added\": {}}]',7,1),(110,'2025-06-20 11:57:51.855584','10','美特斯邦威',1,'[{\"added\": {}}]',7,1),(111,'2025-06-20 12:00:51.669387','16','链家',1,'[{\"added\": {}}]',7,1),(112,'2025-06-20 12:29:25.064283','3','杉达大学',1,'[{\"added\": {}}]',12,1),(113,'2025-06-20 12:29:31.520349','4','上海建桥学院',1,'[{\"added\": {}}]',12,1),(114,'2025-06-20 12:29:36.052682','5','北京大学',1,'[{\"added\": {}}]',12,1),(115,'2025-06-20 12:29:39.602286','6','清华大学',1,'[{\"added\": {}}]',12,1),(116,'2025-06-20 12:29:43.243029','7','北京理工大学',1,'[{\"added\": {}}]',12,1),(117,'2025-06-20 12:29:50.938715','8','北京航空航天大学',1,'[{\"added\": {}}]',12,1),(118,'2025-06-20 12:29:54.782169','9','南京大学',1,'[{\"added\": {}}]',12,1),(119,'2025-06-20 12:30:24.247590','10','上海大学',1,'[{\"added\": {}}]',12,1),(120,'2025-06-20 12:30:26.920959','3','杉达大学',2,'[]',12,1),(121,'2025-06-20 12:30:30.054277','5','北京大学',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',12,1),(122,'2025-06-20 12:30:32.941561','6','清华大学',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',12,1),(123,'2025-06-20 12:30:35.735123','7','北京理工大学',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',12,1),(124,'2025-06-20 12:30:38.294686','8','北京航空航天大学',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',12,1),(125,'2025-06-20 12:30:40.657416','9','南京大学',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',12,1),(126,'2025-06-20 12:35:15.271156','23','testcompany',1,'[{\"added\": {}}]',28,22),(127,'2025-06-20 12:35:32.628233','23','testcompany',1,'[{\"added\": {}}]',7,22),(128,'2025-06-20 14:51:58.607766','11','上海财经大学',1,'[{\"added\": {}}]',12,22);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (28,'accounts','user'),(1,'admin','logentry'),(6,'api','user'),(3,'auth','group'),(2,'auth','permission'),(26,'authtoken','token'),(27,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(14,'resume','city'),(7,'resume','company'),(19,'resume','companyfavoritejobseeker'),(16,'resume','companylocation'),(25,'resume','companytag'),(18,'resume','desiredcity'),(17,'resume','desiredindustry'),(20,'resume','desiredjobtitle'),(24,'resume','educationexperience'),(22,'resume','favoriteposition'),(8,'resume','industry'),(9,'resume','jobseeker'),(21,'resume','jobseekerlanguage'),(10,'resume','jobtitle'),(11,'resume','language'),(15,'resume','position'),(23,'resume','positionlanguagerequirement'),(12,'resume','school'),(13,'resume','tag'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-16 08:57:47.932243'),(2,'contenttypes','0002_remove_content_type_name','2025-06-16 08:57:48.008230'),(3,'auth','0001_initial','2025-06-16 08:57:48.279247'),(4,'auth','0002_alter_permission_name_max_length','2025-06-16 08:57:48.331252'),(5,'auth','0003_alter_user_email_max_length','2025-06-16 08:57:48.336251'),(6,'auth','0004_alter_user_username_opts','2025-06-16 08:57:48.340251'),(7,'auth','0005_alter_user_last_login_null','2025-06-16 08:57:48.346246'),(8,'auth','0006_require_contenttypes_0002','2025-06-16 08:57:48.347246'),(9,'auth','0007_alter_validators_add_error_messages','2025-06-16 08:57:48.352251'),(10,'auth','0008_alter_user_username_max_length','2025-06-16 08:57:48.357245'),(11,'auth','0009_alter_user_last_name_max_length','2025-06-16 08:57:48.361254'),(12,'auth','0010_alter_group_name_max_length','2025-06-16 08:57:48.373255'),(13,'auth','0011_update_proxy_permissions','2025-06-16 08:57:48.379245'),(14,'auth','0012_alter_user_first_name_max_length','2025-06-16 08:57:48.384245'),(15,'accounts','0001_initial','2025-06-16 08:57:48.649552'),(16,'admin','0001_initial','2025-06-16 08:57:48.782553'),(17,'admin','0002_logentry_remove_auto_add','2025-06-16 08:57:48.788553'),(18,'admin','0003_logentry_add_action_flag_choices','2025-06-16 08:57:48.794558'),(19,'api','0001_initial','2025-06-16 08:57:48.809879'),(20,'authtoken','0001_initial','2025-06-16 08:57:48.901939'),(21,'authtoken','0002_auto_20160226_1747','2025-06-16 08:57:48.923015'),(22,'authtoken','0003_tokenproxy','2025-06-16 08:57:48.925940'),(23,'authtoken','0004_alter_tokenproxy_options','2025-06-16 08:57:48.929939'),(24,'resume','0001_initial','2025-06-16 08:57:51.173270'),(25,'sessions','0001_initial','2025-06-16 08:57:51.203189');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8qbyhnz5vs0nmsa6ana59rnwpepdj7ek','.eJxVjEEOwiAQRe_C2hAcWsq4dN8zkGEGbNVAUtqV8e7apAvd_vfef6lA2zqFraUlzKIuCkCdfsdI_EhlJ3Kncquaa1mXOepd0QdteqySntfD_TuYqE3f2lnKaAG9ePYkHaE1QBh7QwMwiAPAFPucI58HdF2yHNklNMDUkbB6fwANcDjD:1uSawt:v-u6NnmANxQB-uE0F6Le1KW1YktrSMhNXb7Y9nxLgn0','2025-07-04 12:34:27.941052');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_city`
--

DROP TABLE IF EXISTS `resume_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_city` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `province` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_city_name_province_d01d9e03_uniq` (`name`,`province`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_city`
--

LOCK TABLES `resume_city` WRITE;
/*!40000 ALTER TABLE `resume_city` DISABLE KEYS */;
INSERT INTO `resume_city` VALUES (1,'上海','上海'),(2,'内江','四川'),(6,'北京','北京'),(9,'哈尔滨','黑龙江'),(5,'宿迁','江苏'),(11,'广州','广东'),(4,'成都','四川'),(3,'杭州','浙江'),(10,'深圳','广东'),(8,'温州','浙江'),(7,'芜湖','安徽'),(12,'香港','香港');
/*!40000 ALTER TABLE `resume_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_company`
--

DROP TABLE IF EXISTS `resume_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_company` (
  `user_id` bigint NOT NULL,
  `size` varchar(20) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `description` json DEFAULT NULL,
  `license_period` varchar(20) NOT NULL,
  `registered_capital` int unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `resume_company_user_id_e6dc6b30_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `resume_company_chk_1` CHECK ((`registered_capital` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_company`
--

LOCK TABLES `resume_company` WRITE;
/*!40000 ALTER TABLE `resume_company` DISABLE KEYS */;
INSERT INTO `resume_company` VALUES (10,'500+人',0,'\"“美特斯·邦威”是美特斯邦威集团自主创立的本土休闲服品牌。美特斯邦威集团公司于1995年创建于中国浙江省温州市，主要研发、生产、销售美特斯·邦威品牌休闲系列服饰。\"','2090',2000),(11,'20-99人',1,'\"上海复旦微电子集团股份有限公司(以下简称“复旦微电子”)成立于1998年7月16日，由上海市商业投资（集团）有限公司与复旦大学联合发起成立，公司于2000年8月4日在香港创业板上市，是国内第一家发起式股份制集成电路设计公司，也是国内集成电路设计业中最早的上市公司，现已形成了安全与识别、非挥发存储器（NVM）、智能电表、专用模拟电路四大产品和技术发展系列。复旦微电子采用国际先进的“无工厂化（fabless）”的模式，专注于发展集成电路设计的核心能力，以提供顾客满意的产品和服务为公司生存的基础；以顾客的发展为公司发展的基础；以维护公司和顾客赖以生存的环境为公司永续经营的基本理念为质量管理宗旨，实行严格的质量管理，现已通过ISO9001:2008质量体系认证。复旦微电子建立了完整的产品开发与质量管理体系，为产品的市场推广奠定坚实的基础。二十二年的奋斗历程，复旦微电子已成为我国设计能力、产品能力和市场拓展能力极具优势的集成电路设计公司之一。期间，复旦微电子实现了多个第一：在集成电路设计行业成为我国第一家发起式的股份公司；是国内第一家上市的集成电路设计公司；中国第一个进行集成电路布图保护登记的公司，目前公司已成为上海市知识产权示范企业。\"','2050',100),(12,'500+人',1,'\"摩根士丹利期货（中国）有限公司是摩根士丹利在中国设立的公司，注册资本10亿元，法定代表人为白欣潼，董事长为沈黎，公司经营范围为期货业务。\"','2090',10000),(13,'20-99人',1,'\"DeepSeek凭借自然语言处理、机器学习与深度学习、大数据分析等核心技术优势，在推理、自然语言理解与生成、图像与视频分析、语音识别与合成、个性化推荐、大数据处理与分析、跨模态学习以及实时交互与响应等八大领域表现出色。它能进行逻辑推理、解决复杂问题，理解和生成高质量文本，精准分析图像和视频内容，准确识别和合成语音，根据用户偏好提供个性化推荐，高效处理大规模数据并挖掘有价值信息，实现多模态数据融合与学习，以及通过智能助手和聊天机器人实现快速的自然语言交互。\"','2028',200),(14,'500+人',1,'\"哔哩哔哩 (゜-゜)つロ 干杯~-bilibili\\n哔哩哔哩（bilibili.com)是国内知名的视频弹幕网站，这里有及时的动漫新番，活跃的ACG氛围，有创意的Up主。大家可以在这里找到许多欢乐。\"','2077',2000),(15,'500+人',0,'\"中国石油化工集团有限公司的前身是成立于1983年7月的中国石油化工总公司。1998年7月，按照党中央关于实施石油石化行业战略性重组的部署，在原中国石油化工总公司基础上重组成立中国石油化工集团公司，2018年8月，经公司制改制为中国石油化工集团有限公司。公司是上下游、产供销、内外贸一体化特大型能源化工集团公司，注册资本3265亿元人民币，董事长为法定代表人，总部设在北京。公司对其全资企业、控股企业、参股企业的有关国有资产行使资产受益、重大决策和选择管理者等出资人的权利，对国有资产依法进行经营、管理和监督，并相应承担保值增值责任。\"','2050',10000),(16,'500+人',1,'\"链家网是集房源信息搜索、产品研发、大数据处理、服务标准建立为一体的国内领先且重度垂直的全产业链房产服务平台。链家网的前身为链家在线，成立于2010年并于2014年正式更名为链家网。\"','2090',300),(23,'20-99人',0,'\"这是我的简介！！\"','2050',10000);
/*!40000 ALTER TABLE `resume_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_companyfavoritejobseeker`
--

DROP TABLE IF EXISTS `resume_companyfavoritejobseeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_companyfavoritejobseeker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `favorite_time` datetime(6) NOT NULL,
  `company_id` bigint NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_companyfavoritejo_company_id_job_seeker_id_b6482449_uniq` (`company_id`,`job_seeker_id`),
  KEY `resume_companyfavori_job_seeker_id_d5690c3e_fk_resume_jo` (`job_seeker_id`),
  CONSTRAINT `resume_companyfavori_company_id_e609b200_fk_resume_co` FOREIGN KEY (`company_id`) REFERENCES `resume_company` (`user_id`),
  CONSTRAINT `resume_companyfavori_job_seeker_id_d5690c3e_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_companyfavoritejobseeker`
--

LOCK TABLES `resume_companyfavoritejobseeker` WRITE;
/*!40000 ALTER TABLE `resume_companyfavoritejobseeker` DISABLE KEYS */;
INSERT INTO `resume_companyfavoritejobseeker` VALUES (1,'2025-06-20 12:38:40.042874',23,17),(2,'2025-06-20 12:38:48.680177',23,19);
/*!40000 ALTER TABLE `resume_companyfavoritejobseeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_companylocation`
--

DROP TABLE IF EXISTS `resume_companylocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_companylocation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(200) NOT NULL,
  `city_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_companylocation_company_id_city_id_bdc45c7c_uniq` (`company_id`,`city_id`),
  KEY `resume_companylocation_city_id_3446a446_fk_resume_city_id` (`city_id`),
  CONSTRAINT `resume_companylocati_company_id_76e19cd8_fk_resume_co` FOREIGN KEY (`company_id`) REFERENCES `resume_company` (`user_id`),
  CONSTRAINT `resume_companylocation_city_id_3446a446_fk_resume_city_id` FOREIGN KEY (`city_id`) REFERENCES `resume_city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_companylocation`
--

LOCK TABLES `resume_companylocation` WRITE;
/*!40000 ALTER TABLE `resume_companylocation` DISABLE KEYS */;
INSERT INTO `resume_companylocation` VALUES (2,'浙江省杭州市拱墅区环城北路169号汇金国际大厦西1幢1201室',3,13),(3,'北京市朝阳区朝阳门北大街22号',6,15),(4,'上海市杨浦区新江湾城街道政立路499号国正中心2号楼10楼',1,14),(5,'上海市邯郸路220号',1,11),(6,'北京市东城区安定门外大街208号院1号楼12层1208单元',6,12),(7,'无',8,10),(8,'北京海淀区上地五街',6,16),(9,'芜湖起飞',7,23);
/*!40000 ALTER TABLE `resume_companylocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_companytag`
--

DROP TABLE IF EXISTS `resume_companytag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_companytag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_companytag_company_id_tag_id_2f9abf47_uniq` (`company_id`,`tag_id`),
  KEY `resume_companytag_tag_id_a1de707c_fk_resume_tag_id` (`tag_id`),
  CONSTRAINT `resume_companytag_company_id_570e701b_fk_resume_company_user_id` FOREIGN KEY (`company_id`) REFERENCES `resume_company` (`user_id`),
  CONSTRAINT `resume_companytag_tag_id_a1de707c_fk_resume_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `resume_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_companytag`
--

LOCK TABLES `resume_companytag` WRITE;
/*!40000 ALTER TABLE `resume_companytag` DISABLE KEYS */;
/*!40000 ALTER TABLE `resume_companytag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_desiredcity`
--

DROP TABLE IF EXISTS `resume_desiredcity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_desiredcity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city_id` bigint NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_desiredcity_job_seeker_id_city_id_dab326fd_uniq` (`job_seeker_id`,`city_id`),
  KEY `resume_desiredcity_city_id_042eedd6_fk_resume_city_id` (`city_id`),
  CONSTRAINT `resume_desiredcity_city_id_042eedd6_fk_resume_city_id` FOREIGN KEY (`city_id`) REFERENCES `resume_city` (`id`),
  CONSTRAINT `resume_desiredcity_job_seeker_id_29c2e3cd_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_desiredcity`
--

LOCK TABLES `resume_desiredcity` WRITE;
/*!40000 ALTER TABLE `resume_desiredcity` DISABLE KEYS */;
INSERT INTO `resume_desiredcity` VALUES (6,1,17),(7,6,17),(8,7,18),(9,12,19),(10,1,21),(11,5,21);
/*!40000 ALTER TABLE `resume_desiredcity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_desiredindustry`
--

DROP TABLE IF EXISTS `resume_desiredindustry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_desiredindustry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `industry_id` bigint NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_desiredindustry_job_seeker_id_industry_id_8be761d1_uniq` (`job_seeker_id`,`industry_id`),
  KEY `resume_desiredindust_industry_id_61358df4_fk_resume_in` (`industry_id`),
  CONSTRAINT `resume_desiredindust_industry_id_61358df4_fk_resume_in` FOREIGN KEY (`industry_id`) REFERENCES `resume_industry` (`id`),
  CONSTRAINT `resume_desiredindust_job_seeker_id_25340f19_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_desiredindustry`
--

LOCK TABLES `resume_desiredindustry` WRITE;
/*!40000 ALTER TABLE `resume_desiredindustry` DISABLE KEYS */;
INSERT INTO `resume_desiredindustry` VALUES (5,1,17),(7,8,17),(6,11,17),(8,1,18),(9,11,18),(10,11,19),(11,3,21);
/*!40000 ALTER TABLE `resume_desiredindustry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_desiredjobtitle`
--

DROP TABLE IF EXISTS `resume_desiredjobtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_desiredjobtitle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_seeker_id` bigint NOT NULL,
  `job_title_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_desiredjobtitle_job_seeker_id_job_title_id_b7bfab47_uniq` (`job_seeker_id`,`job_title_id`),
  KEY `resume_desiredjobtit_job_title_id_bb79317e_fk_resume_jo` (`job_title_id`),
  CONSTRAINT `resume_desiredjobtit_job_seeker_id_c9967e45_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`),
  CONSTRAINT `resume_desiredjobtit_job_title_id_bb79317e_fk_resume_jo` FOREIGN KEY (`job_title_id`) REFERENCES `resume_jobtitle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_desiredjobtitle`
--

LOCK TABLES `resume_desiredjobtitle` WRITE;
/*!40000 ALTER TABLE `resume_desiredjobtitle` DISABLE KEYS */;
INSERT INTO `resume_desiredjobtitle` VALUES (8,17,1),(7,17,5),(6,17,8),(5,17,12),(9,18,5),(10,18,9),(11,19,11),(12,19,12),(13,21,11);
/*!40000 ALTER TABLE `resume_desiredjobtitle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_educationexperience`
--

DROP TABLE IF EXISTS `resume_educationexperience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_educationexperience` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `degree` varchar(10) NOT NULL,
  `major` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  `school_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_educationexperien_job_seeker_id_school_id__c5b519c0_uniq` (`job_seeker_id`,`school_id`,`degree`,`major`),
  KEY `resume_educationexpe_school_id_c05be324_fk_resume_sc` (`school_id`),
  CONSTRAINT `resume_educationexpe_job_seeker_id_bebc65f9_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`),
  CONSTRAINT `resume_educationexpe_school_id_c05be324_fk_resume_sc` FOREIGN KEY (`school_id`) REFERENCES `resume_school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_educationexperience`
--

LOCK TABLES `resume_educationexperience` WRITE;
/*!40000 ALTER TABLE `resume_educationexperience` DISABLE KEYS */;
INSERT INTO `resume_educationexperience` VALUES (15,'学士','数据科学与大数据技术','2023-09-01','2027-06-30',17,1),(16,'学士','数据科学与大数据技术','2023-09-01','2027-06-30',18,1),(17,'博士','数据科学与大数据技术','2025-09-01','2025-06-30',19,1),(18,'硕士','数学','2025-06-20','2025-06-20',20,1),(19,'专科','工商管理','2025-06-20','2025-06-20',21,3),(20,'硕士','会计','1998-09-01','2001-03-31',24,11);
/*!40000 ALTER TABLE `resume_educationexperience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_favoriteposition`
--

DROP TABLE IF EXISTS `resume_favoriteposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_favoriteposition` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `favorite_time` datetime(6) NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  `position_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_favoriteposition_job_seeker_id_position_id_38354160_uniq` (`job_seeker_id`,`position_id`),
  KEY `resume_favoriteposit_position_id_4c8abd16_fk_resume_po` (`position_id`),
  CONSTRAINT `resume_favoriteposit_job_seeker_id_67fb1b8a_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`),
  CONSTRAINT `resume_favoriteposit_position_id_4c8abd16_fk_resume_po` FOREIGN KEY (`position_id`) REFERENCES `resume_position` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_favoriteposition`
--

LOCK TABLES `resume_favoriteposition` WRITE;
/*!40000 ALTER TABLE `resume_favoriteposition` DISABLE KEYS */;
INSERT INTO `resume_favoriteposition` VALUES (2,'2025-06-20 12:14:31.440467',17,8),(3,'2025-06-20 12:14:40.302867',17,7),(4,'2025-06-20 12:28:43.165019',21,11),(5,'2025-06-20 12:32:57.003007',21,12);
/*!40000 ALTER TABLE `resume_favoriteposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_industry`
--

DROP TABLE IF EXISTS `resume_industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_industry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_industry`
--

LOCK TABLES `resume_industry` WRITE;
/*!40000 ALTER TABLE `resume_industry` DISABLE KEYS */;
INSERT INTO `resume_industry` VALUES (1,'互联网'),(8,'交通'),(11,'人工智能'),(6,'医疗'),(5,'半导体'),(7,'房地产'),(10,'服装'),(4,'汽车'),(2,'游戏'),(9,'能源'),(3,'金融');
/*!40000 ALTER TABLE `resume_industry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_jobseeker`
--

DROP TABLE IF EXISTS `resume_jobseeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_jobseeker` (
  `user_id` bigint NOT NULL,
  `gender` varchar(5) NOT NULL,
  `birth_date` date NOT NULL,
  `phone` varchar(11) NOT NULL,
  `expected_work_type` varchar(10) NOT NULL,
  `expected_min_salary` smallint unsigned NOT NULL,
  `expected_max_salary` smallint unsigned NOT NULL,
  `current_status` varchar(10) NOT NULL,
  `resume_pdf` varchar(255) DEFAULT NULL,
  `work_experience` json DEFAULT NULL,
  `education` varchar(10) NOT NULL,
  `project_experience` json DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `phone` (`phone`),
  CONSTRAINT `resume_jobseeker_user_id_c58ba3f8_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `resume_jobseeker_chk_1` CHECK ((`expected_min_salary` >= 0)),
  CONSTRAINT `resume_jobseeker_chk_2` CHECK ((`expected_max_salary` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_jobseeker`
--

LOCK TABLES `resume_jobseeker` WRITE;
/*!40000 ALTER TABLE `resume_jobseeker` DISABLE KEYS */;
INSERT INTO `resume_jobseeker` VALUES (17,'女','2005-01-12','18917633753','全职',40,100,'应届生',NULL,NULL,'本科','[{\"role\": \"后端设计\", \"end_date\": \"2025-06-20\", \"start_date\": \"2025-06-14\", \"description\": \"完成后端代码设计和前后端通信，设计部分前端页面\", \"achievements\": [\"建立数据库\"], \"project_name\": \"数据库课程项目\", \"technologies\": [\"Django\", \"Vue(Vite)\", \"Axios\"], \"responsibilities\": [\"后端设计\"]}]','2025-06-20 12:26:29.026672'),(18,'男','2004-09-01','13600000000','全职',100,300,'应届生',NULL,NULL,'博士',NULL,'2025-06-20 12:26:06.271839'),(19,'其他','2005-01-01','17300000000','全职',200,400,'应届生',NULL,'[{\"end_date\": \"2025-01-01\", \"job_title\": \"CEO\", \"start_date\": \"2023-01-01\", \"company_name\": \"复旦微\", \"responsibilities\": []}]','博士',NULL,'2025-06-20 12:22:08.330136'),(20,'男','1990-01-01','19800000000','全职',300,500,'在职',NULL,NULL,'博士',NULL,'2025-06-20 12:25:18.758562'),(21,'女','2005-01-01','13916665555','全职',30,50,'离职',NULL,NULL,'专科',NULL,'2025-06-20 15:45:33.992419'),(24,'其他','2008-05-12','13916618742','全职',20,100,'离职',NULL,NULL,'博士',NULL,'2025-06-20 14:47:42.696511');
/*!40000 ALTER TABLE `resume_jobseeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_jobseekerlanguage`
--

DROP TABLE IF EXISTS `resume_jobseekerlanguage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_jobseekerlanguage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proficiency` varchar(50) NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  `language_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_jobseekerlanguage_job_seeker_id_language_id_4943a7d1_uniq` (`job_seeker_id`,`language_id`),
  KEY `resume_jobseekerlang_language_id_fe3741f9_fk_resume_la` (`language_id`),
  CONSTRAINT `resume_jobseekerlang_job_seeker_id_10e51083_fk_resume_jo` FOREIGN KEY (`job_seeker_id`) REFERENCES `resume_jobseeker` (`user_id`),
  CONSTRAINT `resume_jobseekerlang_language_id_fe3741f9_fk_resume_la` FOREIGN KEY (`language_id`) REFERENCES `resume_language` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_jobseekerlanguage`
--

LOCK TABLES `resume_jobseekerlanguage` WRITE;
/*!40000 ALTER TABLE `resume_jobseekerlanguage` DISABLE KEYS */;
INSERT INTO `resume_jobseekerlanguage` VALUES (9,'母语',17,1),(10,'熟练',17,3),(11,'日常交流',17,5),(12,'日常交流',17,6),(13,'母语',18,1),(14,'比一般日本人说得好',18,2),(15,'神中神',18,3),(16,'母语',19,7),(17,'六级',21,4),(18,'母语',21,1);
/*!40000 ALTER TABLE `resume_jobseekerlanguage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_jobtitle`
--

DROP TABLE IF EXISTS `resume_jobtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_jobtitle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_jobtitle`
--

LOCK TABLES `resume_jobtitle` WRITE;
/*!40000 ALTER TABLE `resume_jobtitle` DISABLE KEYS */;
INSERT INTO `resume_jobtitle` VALUES (11,'产品经理'),(5,'前端工程师'),(15,'医疗器械开发'),(14,'半导体工程师'),(7,'后端工程师'),(13,'客服'),(16,'市场运营专员'),(19,'平面设计师'),(17,'房地产中介'),(1,'数据分析师'),(6,'数据库管理人员'),(3,'机械工程师'),(18,'电气研究工程师'),(8,'算法工程师'),(4,'设计师'),(10,'财务经理'),(12,'软件开发'),(9,'项目经理');
/*!40000 ALTER TABLE `resume_jobtitle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_language`
--

DROP TABLE IF EXISTS `resume_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_language` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_language`
--

LOCK TABLES `resume_language` WRITE;
/*!40000 ALTER TABLE `resume_language` DISABLE KEYS */;
INSERT INTO `resume_language` VALUES (4,'俄语'),(5,'德语'),(10,'意大利语'),(2,'日语'),(1,'普通话'),(7,'法语'),(8,'粤语'),(3,'英语'),(9,'葡萄牙语'),(6,'西班牙语');
/*!40000 ALTER TABLE `resume_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_position`
--

DROP TABLE IF EXISTS `resume_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_position` (
  `id` int NOT NULL AUTO_INCREMENT,
  `min_salary` smallint unsigned NOT NULL,
  `max_salary` smallint unsigned NOT NULL,
  `min_age` smallint unsigned DEFAULT NULL,
  `max_age` smallint unsigned DEFAULT NULL,
  `experience_required` varchar(10) NOT NULL,
  `education_required` varchar(10) NOT NULL,
  `description` json NOT NULL,
  `city_id` bigint DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `industry_id` bigint DEFAULT NULL,
  `job_title_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resume_position_city_id_ec85b13a_fk_resume_city_id` (`city_id`),
  KEY `resume_position_company_id_13a3f31c_fk_resume_company_user_id` (`company_id`),
  KEY `resume_position_industry_id_b0ae1862_fk_resume_industry_id` (`industry_id`),
  KEY `resume_position_job_title_id_f265b4ae_fk_resume_jobtitle_id` (`job_title_id`),
  CONSTRAINT `resume_position_city_id_ec85b13a_fk_resume_city_id` FOREIGN KEY (`city_id`) REFERENCES `resume_city` (`id`),
  CONSTRAINT `resume_position_company_id_13a3f31c_fk_resume_company_user_id` FOREIGN KEY (`company_id`) REFERENCES `resume_company` (`user_id`),
  CONSTRAINT `resume_position_industry_id_b0ae1862_fk_resume_industry_id` FOREIGN KEY (`industry_id`) REFERENCES `resume_industry` (`id`),
  CONSTRAINT `resume_position_job_title_id_f265b4ae_fk_resume_jobtitle_id` FOREIGN KEY (`job_title_id`) REFERENCES `resume_jobtitle` (`id`),
  CONSTRAINT `resume_position_chk_1` CHECK ((`min_salary` >= 0)),
  CONSTRAINT `resume_position_chk_2` CHECK ((`max_salary` >= 0)),
  CONSTRAINT `resume_position_chk_3` CHECK ((`min_age` >= 0)),
  CONSTRAINT `resume_position_chk_4` CHECK ((`max_age` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_position`
--

LOCK TABLES `resume_position` WRITE;
/*!40000 ALTER TABLE `resume_position` DISABLE KEYS */;
INSERT INTO `resume_position` VALUES (7,40,60,NULL,NULL,'3-5年','硕士','{\"requirements\": \"1、学历要求:统招全日制本科及以上学历;主修计算机相关专业或者统计学。\\n2、精通Python语言是必需的。具有Java等其他编程语言的经验是加分项。\\n3、生成式AI知识：熟悉生成式AI技术，包括大型语言模型/基础模型、向量数据库和编排技术栈等。\\n4、AI编排经验：具有AI编排框架的实际经验，如LangChain。\\n5、熟悉数据库，如ORACLE, SqlServer, MySQL等。\\n6、良好的分析和解决问题的能力，良好的团队合作和沟通能力。\\n7、表现出色的员工将得到特别的晋升。\\n\", \"job_description\": \"nlp算法工程师\", \"work_conditions\": \"30天年假\"}',3,13,11,8),(8,50,70,NULL,NULL,'5年+','博士','{\"requirements\": \"至少精通下面一项专业知识：\\n1、 计算机、电子、通信、自动化或软件相关专业；\\n2、 具有嵌入式相关开发经验，熟悉C/C++编程语言（不局限）；\\n3、 熟悉Linux或者某一款RTOS，了解其操作系统原理，有驱动开发或者应用开发经验优先；\\n\\n至少拥有下面一项技能：\\n1、拥有跨界融合能力，如电子、光学、物理、精密制造、精密机械、软件工程等多学科综合技术能力；\\n2、有嵌入式软件系统设计经验，能熟练使用嵌入式软件开发工具；\\n3、对于C/C++、python等语言理解深刻, 能独立完成上位机软件、算法方案设计及开发；\\n4、有较好的需求分析、方案设计、测试设计及DFX设计能力。\", \"job_description\": \"软件开发\", \"work_conditions\": \"无\"}',3,13,11,12),(9,10,20,NULL,NULL,'不限','本科','{\"requirements\": \"1.市场营销、管理相关专业本科以上学历;\\n2.具备相关的市场营销知识，熟悉企业产品市场动态，有4S店销售经验优先;\\n3.3年以上相关工作经验;\\n4.具备较强的业务开拓能力以及公关能力;\\n5.具备敏锐的市场洞察力以及市场分析能力。\", \"job_description\": \"1.负责管辖区域内推广和计划的执行；\\n2.负责管辖区域内招商蓄客、客户维护及业务洽谈;\\n3.负责管辖区域内合同台账管理工作；\\n4.负责管辖区域内运营监管及服务管理工作;\\n5.协助领导开展部门内管理工作，指导、监察、控制本部各项工作的实施情况，对重大投诉、舆情及时处理管控;\\n6.完成领导安排的其他任务。\", \"work_conditions\": \"五险一金+年假\"}',9,15,9,16),(10,30,50,NULL,NULL,'1-3年','本科','{\"requirements\": \"1. 统招本科及以上学历，专业不限，计算机相关专业优先，应届生或 2 年以内工作经验；不要求必须有相关工作经历；\\n2. 精通 HTML/CSS 的功能，熟练掌握前端响应式布局；熟练运用 JavaScript；\\n3. 熟悉 Vue，Flutter 等技术优先；熟悉计算机、网络相关的基础知识，熟悉后端语言优先；\\n4. 善于团队协作，能独立自主地解决问题；\\n5. 对 Web 前端工作有热情，喜欢挑战自己，不断优化已有工作，乐于学习新技术；\\n\", \"job_description\": \"1. 完成网站的前端开发工作，配合产品团队，完成相关功能搭建；\\n2. 维护和优化现有代码，提高前端页面的速度和性能，保证代码规范性和准确性；\\n3. 和设计师合作，优化网站的视觉和易用性设计；\", \"work_conditions\": \"免费参加B站各类活动\"}',1,14,1,5),(11,100,200,NULL,NULL,'5年+','博士','{\"requirements\": \"1. 微电子/物理博士学位\\n\\n2. 半导体行业制程工程师或应用工程师\\n\\n3. 熟悉半导体生产流程与质量控制，熟悉精密测量原理。能够使用仿真工具对微观结构量测进行仿真分析与优化。\\n\\n4. 具备良好的沟通与表达能力，思路清晰，逻辑分析能力、学习能力强\\n\", \"job_description\": \"1. 产品配置及功能改进：根据现有产品设计、客户需求、项目复杂性和风险水平等因素，向客户提供测量方案与产品功能配置，最大限度的发挥产品测量能力。在产品配置过程中，能够明确产品现有功能不足或设计缺陷，并独立提出系统改进与升级方案，并为功能实现和测试提供支持。\\n\\n2. 产品开发与升级支持：结合客户需求、工程原理与仿真分析，提出提高产品测量能力与适应能力的方案。具有对产品性能、可维护性、可靠性、质量分析及故障诊断等方面的知识，能够通过对产品设计、产品配置、实验结果的分析，为产品或产品子系统的设计审查提供支持。\\n\\n3. 现场沟通：能够与客户、同行、产品设计团队及供应商进行有效沟通，充分了解客户的需求，并将客户需求向产品设计团队进行传达。能够分解当前的问题并根据现有资源提出解决方案，将方案与客户进行良好的传达。\\n\\n4. 产品问题分析与解决：作为团队成员，具备分析产品复杂缺陷及集成问题的能力。能够设计测试方案以发现问题根本原因，并与产品设计团队合作提供复杂问题的解决方案。\\n\", \"work_conditions\": \"无\"}',1,11,5,14),(12,60,100,NULL,NULL,'5年+','本科','{\"requirements\": \"1、\\t会计、财务等相关专业本科以上学历。\\n2、\\t4年以上财会相关岗位工作经验，有比较扎实的财会业务知识。有一年以上财务主管岗位工作经验优先考虑。有软件行业财会工作经验优先。\\n3、\\t有中级会计证书，或通过CPA考试会计、税法等科目优先。\\n4、\\t善于处理流程性事务、良好的学习能力、独立工作能力和财务分析能力。\\n5、\\t工作细致，责任感强，拥有较强的自驱力，良好的沟通能力、团队精神及抗压能力。\\n6、\\t有熟练的英语能力\", \"job_description\": \"1、\\t负责公司全面财务会计工作。\\n2、\\t负责制定并完成公司的财务会计制度、规定和办法。\\n3、\\t负责制定公司财务收支和资金管理计划，并分析执行情况。\\n4、\\t根据会计核算要求，审核会计科目、凭证入账的正确性，审核财务报表、科目余额表及纳税申报表等。\\n5、\\t负责编制合并财务报表，报送各项统计资料，分析财务成果和计划完成情况，总结经验，提出改进意见。\\n6、\\t负责对子分公司的账务做整体把控及审核。\\n7、\\t负责配合审计工作、项目申报、财务尽调，按要求提供资料。\\n8、\\t负责对接高新复审、研发费加计扣除、出口报关、政府补助申请等工作。\\n9、\\t领导交办的其他事项。\\n\", \"work_conditions\": \"无\"}',1,12,3,10),(13,10,30,NULL,NULL,'应届生','本科','{\"requirements\": \"1、本科及以上学历，服装设计类专业，做服装设计开发8年以上；\\n2、对色彩、搭配、潮流元素有一定敏锐度，富有创造力和执行力，对数据反映敏锐，并有良好的货品分析能力；\\n3、熟练运用电脑绘图软件。\\n\", \"job_description\": \"1、根据公司品牌风格定位，结合市场分析、设计企划，进行款式的开发和设计；\\n2、根据产品开发计划制定具体工作计划，确保在规定的时间内按时完成产品开发设计工作；\\n3、定期进行市场调研、竞品分析、及时了解市场流行趋势，为产品设计积累素材；\\n4、根据样板制作，按设计要求与版师进行沟通，确保样衣的准时完成。\\n\", \"work_conditions\": \"无\"}',10,10,10,4),(14,10,30,NULL,NULL,'应届生','本科','{\"requirements\": \"无\", \"job_description\": \"约看、带看:给客户匹配他有意向的房屋，并带客户看房,与业主的沟通协调。客户、业主维护:跟进维护好客户、维护好业主，跟进房源信息;\", \"work_conditions\": \"无责底薪+高提成+奖金，带薪培训+各种福利待遇\"}',4,16,7,17),(15,10,20,NULL,NULL,'不限','不限','{\"requirements\": \"这是我的要求！\", \"job_description\": \"这是我的职位描述！\", \"work_conditions\": \"福利，想得美\"}',7,23,6,11),(16,20,30,NULL,NULL,'5年+','本科','{\"requirements\": \"要求222\", \"job_description\": \"描述111\", \"work_conditions\": \"福利333\"}',10,23,4,16);
/*!40000 ALTER TABLE `resume_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_positionlanguagerequirement`
--

DROP TABLE IF EXISTS `resume_positionlanguagerequirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_positionlanguagerequirement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `language_id` bigint NOT NULL,
  `position_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resume_positionlanguager_position_id_language_id_faf4a7a0_uniq` (`position_id`,`language_id`),
  KEY `resume_positionlangu_language_id_16a62240_fk_resume_la` (`language_id`),
  CONSTRAINT `resume_positionlangu_language_id_16a62240_fk_resume_la` FOREIGN KEY (`language_id`) REFERENCES `resume_language` (`id`),
  CONSTRAINT `resume_positionlangu_position_id_ba36841b_fk_resume_po` FOREIGN KEY (`position_id`) REFERENCES `resume_position` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_positionlanguagerequirement`
--

LOCK TABLES `resume_positionlanguagerequirement` WRITE;
/*!40000 ALTER TABLE `resume_positionlanguagerequirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `resume_positionlanguagerequirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_school`
--

DROP TABLE IF EXISTS `resume_school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_school` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_school`
--

LOCK TABLES `resume_school` WRITE;
/*!40000 ALTER TABLE `resume_school` DISABLE KEYS */;
INSERT INTO `resume_school` VALUES (1,'复旦大学','985'),(2,'上海交通大学','985'),(3,'杉达大学','普通'),(4,'上海建桥学院','普通'),(5,'北京大学','985'),(6,'清华大学','985'),(7,'北京理工大学','985'),(8,'北京航空航天大学','985'),(9,'南京大学','985'),(10,'上海大学','211'),(11,'上海财经大学','211');
/*!40000 ALTER TABLE `resume_school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_tag`
--

DROP TABLE IF EXISTS `resume_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_tag`
--

LOCK TABLES `resume_tag` WRITE;
/*!40000 ALTER TABLE `resume_tag` DISABLE KEYS */;
INSERT INTO `resume_tag` VALUES (1,'中国500强');
/*!40000 ALTER TABLE `resume_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-20 23:51:45
