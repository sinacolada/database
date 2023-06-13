CREATE DATABASE  IF NOT EXISTS `playlist` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `playlist`;
-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: playlist
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `album_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `num_tracks` int NOT NULL DEFAULT '0',
  `num_likes` int NOT NULL DEFAULT '0',
  `duration` int NOT NULL DEFAULT '0',
  `artist_id` int NOT NULL,
  PRIMARY KEY (`album_id`),
  KEY `a_fk_ar` (`artist_id`),
  CONSTRAINT `a_fk_ar` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bio` text,
  `num_followers` int NOT NULL DEFAULT '0',
  `num_songs` int NOT NULL DEFAULT '0',
  `num_albums` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Young Thug','Slatt',0,0,0),(2,'Artist 1','hello',0,0,0),(3,'Young Thugger','Slatt',0,0,0),(4,'Young Thugger','Slatt',0,0,0),(5,'Young Thugger','Slatt',0,0,0),(6,'Beyonce','pop star!',0,0,0),(7,'Drake','legend',0,0,0);
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concert_artists`
--

DROP TABLE IF EXISTS `concert_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concert_artists` (
  `concert_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`concert_id`,`artist_id`),
  KEY `ca_fk_a` (`artist_id`),
  CONSTRAINT `ca_fk_a` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ca_fk_c` FOREIGN KEY (`concert_id`) REFERENCES `concerts` (`concert_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concert_artists`
--

LOCK TABLES `concert_artists` WRITE;
/*!40000 ALTER TABLE `concert_artists` DISABLE KEYS */;
/*!40000 ALTER TABLE `concert_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concerts`
--

DROP TABLE IF EXISTS `concerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concerts` (
  `concert_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concerts`
--

LOCK TABLES `concerts` WRITE;
/*!40000 ALTER TABLE `concerts` DISABLE KEYS */;
INSERT INTO `concerts` VALUES (1,'2021-04-20','Las Vegas Festival Grounds','Las Vegas','NV');
/*!40000 ALTER TABLE `concerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Rap');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_songs`
--

DROP TABLE IF EXISTS `playlist_songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_songs` (
  `playlist_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`playlist_id`,`song_id`),
  KEY `ps_fk_s` (`song_id`),
  CONSTRAINT `ps_fk_p` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ps_fk_s` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_songs`
--

LOCK TABLES `playlist_songs` WRITE;
/*!40000 ALTER TABLE `playlist_songs` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_songs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `playlist_songs_after_insert` AFTER INSERT ON `playlist_songs` FOR EACH ROW begin
	DECLARE song_duration int;
	SELECT duration FROM songs WHERE song_id = new.song_id INTO song_duration;
	UPDATE playlists 
	SET 
		duration = duration + song_duration
	WHERE
		playlist_id = new.playlist_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlists` (
  `playlist_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `num_followers` int NOT NULL DEFAULT '0',
  `num_songs` int NOT NULL DEFAULT '0',
  `duration` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL,
  PRIMARY KEY (`playlist_id`),
  KEY `up_fk_u` (`user_id`),
  CONSTRAINT `up_fk_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists`
--

LOCK TABLES `playlists` WRITE;
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `duration` int NOT NULL,
  `num_likes` int NOT NULL DEFAULT '0',
  `artist_id` int NOT NULL,
  `genre_id` int DEFAULT NULL,
  `album_id` int DEFAULT NULL,
  PRIMARY KEY (`song_id`),
  KEY `s_fk_a` (`artist_id`),
  KEY `s_fk_g` (`genre_id`),
  KEY `as_fk_a` (`album_id`),
  CONSTRAINT `as_fk_a` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `s_fk_a` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `s_fk_g` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES (1,'Slatty',186,0,1,1,NULL),(2,'Slatty',186,0,3,NULL,NULL),(3,'halo',180,0,6,NULL,NULL),(4,'one dance',210,0,7,NULL,NULL);
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_followed_artists`
--

DROP TABLE IF EXISTS `user_followed_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_followed_artists` (
  `user_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`artist_id`),
  KEY `ufa_fk_fa` (`artist_id`),
  CONSTRAINT `ufa_fk_fa` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ufa_fk_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_followed_artists`
--

LOCK TABLES `user_followed_artists` WRITE;
/*!40000 ALTER TABLE `user_followed_artists` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_followed_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_followed_playlists`
--

DROP TABLE IF EXISTS `user_followed_playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_followed_playlists` (
  `user_id` int NOT NULL,
  `playlist_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`playlist_id`),
  KEY `ufp_fk_fp` (`playlist_id`),
  CONSTRAINT `ufp_fk_fp` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ufp_fk_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_followed_playlists`
--

LOCK TABLES `user_followed_playlists` WRITE;
/*!40000 ALTER TABLE `user_followed_playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_followed_playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_followed_users`
--

DROP TABLE IF EXISTS `user_followed_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_followed_users` (
  `user_id` int NOT NULL,
  `followed_user_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`followed_user_id`),
  KEY `ufu_fk_fu` (`followed_user_id`),
  CONSTRAINT `ufu_fk_fu` FOREIGN KEY (`followed_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ufu_fk_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_followed_users`
--

LOCK TABLES `user_followed_users` WRITE;
/*!40000 ALTER TABLE `user_followed_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_followed_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_liked_albums`
--

DROP TABLE IF EXISTS `user_liked_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_liked_albums` (
  `user_id` int NOT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`album_id`),
  KEY `uls_fk_la` (`album_id`),
  CONSTRAINT `uls_fk_la` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uls_fk_ui` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_liked_albums`
--

LOCK TABLES `user_liked_albums` WRITE;
/*!40000 ALTER TABLE `user_liked_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_liked_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_liked_songs`
--

DROP TABLE IF EXISTS `user_liked_songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_liked_songs` (
  `user_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`song_id`),
  KEY `uls_fk_ls` (`song_id`),
  CONSTRAINT `uls_fk_ls` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uls_fk_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_liked_songs`
--

LOCK TABLES `user_liked_songs` WRITE;
/*!40000 ALTER TABLE `user_liked_songs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_liked_songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `num_followers` int NOT NULL DEFAULT '0',
  `num_playlists` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'sina','abcd',0,0),(4,'sina1','abcd',0,0),(6,'sina123','abcd',0,0),(7,'sina1234','abcd',0,0),(8,'sina12345','abcd',0,0),(9,'sina124345','abcd',0,0),(11,'sina1243456','abcd',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'playlist'
--

--
-- Dumping routines for database 'playlist'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-20 22:42:17
