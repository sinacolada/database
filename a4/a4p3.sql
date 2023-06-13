CREATE DATABASE  IF NOT EXISTS `cleaningcompany` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cleaningcompany`;
-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: cleaningcompany
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
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrators` (
  `administrator_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaners`
--

DROP TABLE IF EXISTS `cleaners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaners` (
  `cleaner_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cleaner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaners`
--

LOCK TABLES `cleaners` WRITE;
/*!40000 ALTER TABLE `cleaners` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `requirements` text NOT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commercial_clients`
--

DROP TABLE IF EXISTS `commercial_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commercial_clients` (
  `client_id` int NOT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_commercial_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commercial_clients`
--

LOCK TABLES `commercial_clients` WRITE;
/*!40000 ALTER TABLE `commercial_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `commercial_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domestic_clients`
--

DROP TABLE IF EXISTS `domestic_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domestic_clients` (
  `client_id` int NOT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_domestic_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domestic_clients`
--

LOCK TABLES `domestic_clients` WRITE;
/*!40000 ALTER TABLE `domestic_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `domestic_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_occasions`
--

DROP TABLE IF EXISTS `job_occasions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_occasions` (
  `occasion_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int DEFAULT NULL,
  `hours` int NOT NULL,
  PRIMARY KEY (`occasion_id`),
  KEY `fk_occasion_job` (`job_id`),
  CONSTRAINT `fk_occasion_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_occasions`
--

LOCK TABLES `job_occasions` WRITE;
/*!40000 ALTER TABLE `job_occasions` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_occasions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `administrator_id` int DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `fk_job_client` (`client_id`),
  KEY `fk_job_admin` (`administrator_id`),
  CONSTRAINT `fk_job_admin` FOREIGN KEY (`administrator_id`) REFERENCES `administrators` (`administrator_id`),
  CONSTRAINT `fk_job_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occasion_cleaners`
--

DROP TABLE IF EXISTS `occasion_cleaners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occasion_cleaners` (
  `occasion_id` int DEFAULT NULL,
  `cleaner_id` int DEFAULT NULL,
  KEY `fk_oc_occasion` (`occasion_id`),
  KEY `fk_oc_cleaner` (`cleaner_id`),
  CONSTRAINT `fk_oc_cleaner` FOREIGN KEY (`cleaner_id`) REFERENCES `cleaners` (`cleaner_id`),
  CONSTRAINT `fk_oc_occasion` FOREIGN KEY (`occasion_id`) REFERENCES `job_occasions` (`occasion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occasion_cleaners`
--

LOCK TABLES `occasion_cleaners` WRITE;
/*!40000 ALTER TABLE `occasion_cleaners` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_cleaners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occasion_equipment`
--

DROP TABLE IF EXISTS `occasion_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occasion_equipment` (
  `occasion_id` int DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  `number_needed` int NOT NULL,
  KEY `fk_oe_occasion` (`occasion_id`),
  KEY `fk_oe_equipment` (`equipment_id`),
  CONSTRAINT `fk_oe_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`),
  CONSTRAINT `fk_oe_occasion` FOREIGN KEY (`occasion_id`) REFERENCES `job_occasions` (`occasion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occasion_equipment`
--

LOCK TABLES `occasion_equipment` WRITE;
/*!40000 ALTER TABLE `occasion_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_equipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-14 22:33:38
