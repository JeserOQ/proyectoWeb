/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.19-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: canaco
-- ------------------------------------------------------
-- Server version	10.11.19-MariaDB-ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `archivo`
--

DROP TABLE IF EXISTS `archivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `nombre_temporal` varchar(255) NOT NULL,
  `ruta` varchar(100) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `tamano` int(10) unsigned NOT NULL CHECK (`tamano` >= 0),
  `createdat` datetime(6) NOT NULL,
  `fk_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `archivo_fk_user_id_fc89ca57_fk_auth_user_id` (`fk_user_id`),
  CONSTRAINT `archivo_fk_user_id_fc89ca57_fk_auth_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivo`
--

LOCK TABLES `archivo` WRITE;
/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
INSERT INTO `archivo` VALUES
(1,'Foto.png','uploads/Foto.png','uploads/Foto.png','image/png',1409282,'2026-10-16 01:51:02.741747',1),
(2,'Logo_casa2.png','uploads/Logo_casa2.png','uploads/Logo_casa2.png','image/png',216618,'2026-10-27 18:46:17.533421',1),
(3,'BanderaMexico.jpg','uploads/BanderaMexico.jpg','uploads/BanderaMexico.jpg','image/jpeg',22126,'2026-10-31 20:56:41.061354',1),
(4,'Tribunal.jpg','uploads/Tribunal.jpg','uploads/Tribunal.jpg','image/jpeg',54885,'2026-10-31 20:56:41.080692',1),
(5,'Mexico.jpg','uploads/Mexico.jpg','uploads/Mexico.jpg','image/jpeg',505547,'2026-10-31 20:56:41.095318',1),
(6,'contaminacion-del-aire.jpg','uploads/contaminacion-del-aire.jpg','uploads/contaminacion-del-aire.jpg','image/jpeg',44401,'2026-10-31 22:01:20.157418',1),
(7,'Digitalizacion.jpg','uploads/Digitalizacion.jpg','uploads/Digitalizacion.jpg','image/jpeg',19659,'2026-10-31 22:01:46.177056',1),
(8,'recetas-saludables.jpg','uploads/recetas-saludables.jpg','uploads/recetas-saludables.jpg','image/jpeg',146962,'2026-10-31 22:01:57.131057',1),
(9,'inteligencia_artificial.jpg','uploads/inteligencia_artificial.jpg','uploads/inteligencia_artificial.jpg','image/jpeg',83932,'2026-10-31 22:04:08.576944',1);
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add archivo',7,'add_archivo'),
(26,'Can change archivo',7,'change_archivo'),
(27,'Can delete archivo',7,'delete_archivo'),
(28,'Can view archivo',7,'view_archivo'),
(29,'Can add categoria',8,'add_categoria'),
(30,'Can change categoria',8,'change_categoria'),
(31,'Can delete categoria',8,'delete_categoria'),
(32,'Can view categoria',8,'view_categoria'),
(33,'Can add publicacion',9,'add_publicacion'),
(34,'Can change publicacion',9,'change_publicacion'),
(35,'Can delete publicacion',9,'delete_publicacion'),
(36,'Can view publicacion',9,'view_publicacion'),
(37,'Can add perfil',10,'add_perfil'),
(38,'Can change perfil',10,'change_perfil'),
(39,'Can delete perfil',10,'delete_perfil'),
(40,'Can view perfil',10,'view_perfil'),
(41,'Can add galeria publicacion',11,'add_galeriapublicacion'),
(42,'Can change galeria publicacion',11,'change_galeriapublicacion'),
(43,'Can delete galeria publicacion',11,'delete_galeriapublicacion'),
(44,'Can view galeria publicacion',11,'view_galeriapublicacion'),
(45,'Can add comentario',12,'add_comentario'),
(46,'Can change comentario',12,'change_comentario'),
(47,'Can delete comentario',12,'delete_comentario'),
(48,'Can view comentario',12,'view_comentario');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$600000$28y1SITfoBPZ17UzdKDCfM$jSqad/d21pT7PACJisdurkT5TJzBfhiqide5qn9VCaY=','2026-11-03 18:33:13.516772',1,'superadmin','','','superadmin@gmail.com',1,1,'2026-10-11 00:49:23.358144'),
(4,'pbkdf2_sha256$600000$wzFR3X6dDvjlPOBbiuClLE$4kphuub5De7Q3Ww5BKtL7k67AhHqoCEFpEjQLCbcQtE=','2026-10-26 19:49:56.236497',0,'editor1','editor','','editor1@gmail.com',1,1,'2026-10-19 19:39:32.013228'),
(5,'pbkdf2_sha256$600000$UGLiKjehxAsVXMcdyuZKyR$c8VkZgnAjkF0cUW/bKXOxn7cfK0OMICoqA0T3qMbRN0=','2026-10-31 22:28:36.664129',0,'userprueba','user','prueba','userprueba@gmail.com',0,1,'2026-10-27 19:12:27.933535');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `createdat` datetime(6) NOT NULL,
  `updatedat` datetime(6) DEFAULT NULL,
  `fk_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_fk_user_id_4ced16d2_fk_auth_user_id` (`fk_user_id`),
  CONSTRAINT `categoria_fk_user_id_4ced16d2_fk_auth_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES
(2,'cocina','2026-10-26 18:46:20.502365',NULL,1),
(3,'Tecnology','2026-10-26 19:05:01.043998',NULL,1),
(4,'Medio Ambiente','2026-10-27 18:38:19.160224',NULL,1),
(5,'Politica','2026-10-27 18:41:15.199209',NULL,1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contenido` longtext NOT NULL,
  `estado` varchar(20) NOT NULL,
  `createdat` datetime(6) NOT NULL,
  `updatedat` datetime(6) NOT NULL,
  `publicacion_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comentario_publicacion_id_17eead35_fk_publicacion_id` (`publicacion_id`),
  KEY `comentario_user_id_a50ac53c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `comentario_publicacion_id_17eead35_fk_publicacion_id` FOREIGN KEY (`publicacion_id`) REFERENCES `publicacion` (`id`),
  CONSTRAINT `comentario_user_id_a50ac53c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES
(1,'Muy bien','aprobado','2026-10-26 19:28:12.837544','2026-10-31 22:03:11.925424',1,1),
(2,'Esto es muy importante para no contaminar','aprobado','2026-10-27 19:14:08.674140','2026-10-31 22:03:10.973331',4,5),
(6,'Comentario de prueba','aprobado','2026-10-31 21:36:16.267283','2026-10-31 21:36:16.322426',1,5);
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(7,'home','archivo'),
(8,'home','categoria'),
(12,'home','comentario'),
(11,'home','galeriapublicacion'),
(10,'home','perfil'),
(9,'home','publicacion'),
(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2026-10-11 00:48:17.975594'),
(2,'auth','0001_initial','2026-10-11 00:48:18.465070'),
(3,'admin','0001_initial','2026-10-11 00:48:18.609863'),
(4,'admin','0002_logentry_remove_auto_add','2026-10-11 00:48:18.633002'),
(5,'admin','0003_logentry_add_action_flag_choices','2026-10-11 00:48:18.669544'),
(6,'contenttypes','0002_remove_content_type_name','2026-10-11 00:48:18.782313'),
(7,'auth','0002_alter_permission_name_max_length','2026-10-11 00:48:18.845672'),
(8,'auth','0003_alter_user_email_max_length','2026-10-11 00:48:18.895475'),
(9,'auth','0004_alter_user_username_opts','2026-10-11 00:48:18.922424'),
(10,'auth','0005_alter_user_last_login_null','2026-10-11 00:48:19.063808'),
(11,'auth','0006_require_contenttypes_0002','2026-10-11 00:48:19.097737'),
(12,'auth','0007_alter_validators_add_error_messages','2026-10-11 00:48:19.159529'),
(13,'auth','0008_alter_user_username_max_length','2026-10-11 00:48:19.299880'),
(14,'auth','0009_alter_user_last_name_max_length','2026-10-11 00:48:19.463099'),
(15,'auth','0010_alter_group_name_max_length','2026-10-11 00:48:19.895198'),
(16,'auth','0011_update_proxy_permissions','2026-10-11 00:48:20.109147'),
(17,'auth','0012_alter_user_first_name_max_length','2026-10-11 00:48:20.255531'),
(18,'home','0001_initial','2026-10-11 00:48:21.402043'),
(19,'sessions','0001_initial','2026-10-11 00:48:21.467870');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('7f89c6vjfpqarr4o034f2wj2t14znj67','.eJxVjMEOwiAQRP-FsyHgUhCP3vsNhF0WqRpISnsy_rtt0oMeZ96beYsQ16WEtfMcpiSuQovTb4eRnlx3kB6x3pukVpd5Qrkr8qBdji3x63a4fwcl9rKtjXHDhVxMHt2gFSA579FwOltto9LeoDXEDKApI6gEWRMjKbelDCw-X9qbOFc:1xMzEJ:g-nAi_cfrZtXqDbslhnRUN4dlPwMpveUlgkqJRmRboM','2026-11-14 02:54:03.602254'),
('7nfyf4ty4o0r5kthyhyiuimtzm55y4ky','.eJxVjMEOwiAQRP-FsyEgtIhH736BMWR32VrUQFKoF-O_2ya99Djz3sxX5NISJajhk2qDKs43fT-IAHMbw1x5CimKs9Bi1yHQi_MK4hPyo0gquU0J5arIjVZ5LZHfl83dHYxQx2VtretO5CB6dJ1WBsl5j5bjsdc9KO0t9paYjdE0oFHRDJoYSbklDYbF7w-EgUA9:1xMz1B:Jp0RcT5o6WBxMT194yEs-N0IcfmzW6N8zOSJgoiA5zA','2026-11-14 02:40:29.826383'),
('i0mhgmpzq09uoojfzknpzcbpug51a8u4','eyJub3RpY2lhc192aXN0YXMiOls1XX0:1xMyxY:GyIJfBNKVB7-kwvXB0N9Fuf56mvPzLivfZ8hZeE0VEQ','2026-11-14 02:36:44.935798'),
('joknxm367m3ftukbilffk2tkhksns4om','.eJxVjMEOwiAQRP-FsyHgUhCP3vsNhF0WqRpISnsy_rtt0oMeZ96beYsQ16WEtfMcpiSuQovTb4eRnlx3kB6x3pukVpd5Qrkr8qBdji3x63a4fwcl9rKtjXHDhVxMHt2gFSA579FwOltto9LeoDXEDKApI6gEWRMjKbelDCw-X9qbOFc:1xMzFB:WafZqpfW5pttkVXXZDQiiUqoZvm-AhHTUTpxvvtzJgc','2026-11-14 02:54:57.882327'),
('jztare19p5ceftj6p6tf6syn5rf8kir1','.eJxVjMEOwiAQRP-FsyEgtIhH736BMWR32VrUQFKoF-O_2ya99Djz3sxX5NISJajhk2qDKs43fT-IAHMbw1x5CimKs9Bi1yHQi_MK4hPyo0gquU0J5arIjVZ5LZHfl83dHYxQx2VtretO5CB6dJ1WBsl5j5bjsdc9KO0t9paYjdE0oFHRDJoYSbklDYbF7w-EgUA9:1xMz0B:iAgFx36xNcK-SIpBLBYWjDDJab7d2Trwwg--wpZXyvc','2026-11-14 02:39:27.565754'),
('nn82mwfyop6dy4ekc7qau5g8w622guyq','.eJxVjMEOwiAQRP-FsyHgUhCP3vsNhF0WqRpISnsy_rtt0oMeZ96beYsQ16WEtfMcpiSuQovTb4eRnlx3kB6x3pukVpd5Qrkr8qBdji3x63a4fwcl9rKtjXHDhVxMHt2gFSA579FwOltto9LeoDXEDKApI6gEWRMjKbelDCw-X9qbOFc:1xNGkK:xfNECA_gzAApup6-0Cl4cMG-0mXXqKFhLo3P5t1AFAU','2026-11-14 21:36:16.296697'),
('ttelleetucavgt25oi07nqu2a6hocp0i','.eJxVjMEOwiAQRP-FsyHgUhCP3vsNhF0WqRpISnsy_rtt0oMeZ96beYsQ16WEtfMcpiSuQovTb4eRnlx3kB6x3pukVpd5Qrkr8qBdji3x63a4fwcl9rKtjXHDhVxMHt2gFSA579FwOltto9LeoDXEDKApI6gEWRMjKbelDCw-X9qbOFc:1xMz2H:-b1BP-ehm3vysPrfZDbcqkSd16DlgM46XszwizMyKXM','2026-11-14 02:41:37.267421');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galeria_publicacion`
--

DROP TABLE IF EXISTS `galeria_publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `galeria_publicacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdat` datetime(6) NOT NULL,
  `archivo_id` bigint(20) NOT NULL,
  `publicacion_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `galeria_publicacion_archivo_id_db8fd022_fk_archivo_id` (`archivo_id`),
  KEY `galeria_publicacion_publicacion_id_dc6a52a6_fk_publicacion_id` (`publicacion_id`),
  CONSTRAINT `galeria_publicacion_archivo_id_db8fd022_fk_archivo_id` FOREIGN KEY (`archivo_id`) REFERENCES `archivo` (`id`),
  CONSTRAINT `galeria_publicacion_publicacion_id_dc6a52a6_fk_publicacion_id` FOREIGN KEY (`publicacion_id`) REFERENCES `publicacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galeria_publicacion`
--

LOCK TABLES `galeria_publicacion` WRITE;
/*!40000 ALTER TABLE `galeria_publicacion` DISABLE KEYS */;
INSERT INTO `galeria_publicacion` VALUES
(1,'2026-10-31 20:56:41.085675',4,5),
(2,'2026-10-31 20:56:41.100059',5,5);
/*!40000 ALTER TABLE `galeria_publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apellido_paterno` varchar(80) NOT NULL,
  `apellido_materno` varchar(80) NOT NULL,
  `foto_perfil_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `perfil_foto_perfil_id_a7b524a7_fk_archivo_id` (`foto_perfil_id`),
  CONSTRAINT `perfil_foto_perfil_id_a7b524a7_fk_archivo_id` FOREIGN KEY (`foto_perfil_id`) REFERENCES `archivo` (`id`),
  CONSTRAINT `perfil_user_id_f036cc95_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES
(3,'','',1,1),
(4,'','',NULL,4),
(5,'prueba','',NULL,5);
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion`
--

DROP TABLE IF EXISTS `publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(180) NOT NULL,
  `resumen` longtext NOT NULL,
  `contenido` longtext NOT NULL,
  `estado` varchar(20) NOT NULL,
  `visitas` int(10) unsigned NOT NULL CHECK (`visitas` >= 0),
  `createdat` datetime(6) NOT NULL,
  `updatedat` datetime(6) NOT NULL,
  `autor_id` int(11) DEFAULT NULL,
  `categoria_id` bigint(20) DEFAULT NULL,
  `imagen_portada_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `publicacion_autor_id_de0e71ad_fk_auth_user_id` (`autor_id`),
  KEY `publicacion_categoria_id_90b47ad9_fk_categoria_id` (`categoria_id`),
  KEY `publicacion_imagen_portada_id_72ac722d_fk_archivo_id` (`imagen_portada_id`),
  CONSTRAINT `publicacion_autor_id_de0e71ad_fk_auth_user_id` FOREIGN KEY (`autor_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `publicacion_categoria_id_90b47ad9_fk_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`),
  CONSTRAINT `publicacion_imagen_portada_id_72ac722d_fk_archivo_id` FOREIGN KEY (`imagen_portada_id`) REFERENCES `archivo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
INSERT INTO `publicacion` VALUES
(1,'La IA en la actualidad','La IA es una herramienta muy poderosa','<p>Vivir en la era de la IA significa navegar una paradoja: por un lado, disponemos de una capacidad de análisis y creación de información nunca antes vista; por el otro, enfrentamos retos críticos como la desinformación, la pérdida de habilidades mecánicas o el riesgo de sesgos automáticos. El verdadero reto actual no es evitar la tecnología, sino aprender a cohabitar con ella, exigiendo ética, veracidad y un uso centrado en el bienestar humano.</p>','publicado',24,'2026-10-26 19:03:18.741679','2026-10-31 22:04:08.580066',1,3,9),
(2,'Recetas saludables para tu familia','La salud de tu familia','<p>Una alimentación saludable en familia consiste en integrar una gran variedad de alimentos nutritivos como verduras, frutas frescas, cereales integrales y proteínas de calidad priorizando los productos naturales y reduciendo al máximo los ultraprocesados. Más allá de nutrir el cuerpo y prevenir enfermedades como la obesidad o la diabetes, sentarse a la mesa a compartir estos platillos fortalece los vínculos afectivos y ayuda a que los niños adopten hábitos positivos para toda su vida.</p>','publicado',1,'2026-10-27 18:34:35.468008','2026-10-31 22:01:57.133571',1,2,8),
(3,'Digitalización y automatización','¿Automatizar ayuda o perjudica al humano?','<p>La <strong>digitalización</strong> es la conversión de información y procesos físicos (como documentos en papel o tareas manuales) a formatos digitales que un ordenador puede leer y procesar.</p><p>La <strong>automatización</strong> es la ejecución de esas tareas o flujos de trabajo de forma autónoma mediante software, dispositivos o reglas programadas, sin necesidad de intervención humana continua.</p><p>Beneficios Principales</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Mayor velocidad:</strong> Reducción drástica del tiempo necesario para completar tareas repetitivas.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Menos errores humanos:</strong> Disminución de fallos al eliminar la transcripción manual de datos.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Acceso y análisis en tiempo real:</strong> Disponibilidad de información centralizada para tomar mejores decisiones (como el uso de <em>Big Data</em> o IA).</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Enfoque de valor:</strong> Los colaboradores dejan de hacer tareas mecánicas y se dedican a funciones estratégicas.</li></ol>','publicado',1,'2026-10-27 18:36:30.286485','2026-10-31 22:01:46.182467',1,3,7),
(4,'Contaminación del aire','El aire y sus contaminantes','<p>Principales causas</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Quema de combustibles fósiles:</strong> El uso de carbón, petróleo y gas en el transporte, la industria y las centrales eléctricas.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Actividades industriales y agrícolas:</strong> La emisión de óxidos de nitrógeno, dióxido de azufre, amoníaco y el uso de pesticidas.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Incendios forestales y quema de residuos:</strong> La combustión al aire libre de basura, biomasa o leña para cocinar.</li></ol><p><br></p><p>Contaminantes más dañinos</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Partículas finas:</strong> Pequeñas partículas que penetran al fondo de los pulmones y pasan al torrente sanguíneo.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Ozono troposférico (O₃):</strong> Se forma cuando los gases de los autos y fábricas reaccionan con la luz del sol.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Gases tóxicos:</strong> Monóxido de carbono (CO), dióxido de nitrógeno (NO₂) y dióxido de azufre (SO₂).</li></ol><p><br></p>','publicado',3,'2026-10-27 18:40:02.732856','2026-10-31 22:01:20.176794',1,4,6),
(5,'El gobierno de México','Lo mas importante de su gobierno','<p>El gobierno actual de México está encabezado por la presidenta Claudia Sheinbaum Pardo, quien asumió el cargo el 1 de octubre de 2024 para el periodo constitucional 2024-2030, convirtiéndose en la primera mujer en liderar el país</p><p><br></p><p>Características principales de la administración</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Partido y coalición en el poder:</strong> Gobierna con el respaldo de la coalición <em>Sigamos Haciendo Historia</em> (integrada por Morena, el Partido Verde Ecologista de México - PVEM y el Partido del Trabajo - PT).</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Continuidad política:</strong> Su gestión da continuidad al proyecto político conocido como la \"Cuarta Transformación\", iniciado por su predecesor, Andrés Manuel López Obrador.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Poder Legislativo:</strong> La coalición oficialista cuenta con una amplia mayoría en el Congreso de la Unión (en la Cámara de Diputados y el Senado), lo que ha facilitado la aprobación de reformas constitucionales y legales prioritarias para el Ejecutivo.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Estructura de gobierno:</strong> El gabinete está conformado por 21 secretarías de Estado con un enfoque técnico y político alineado con los objetivos del Plan Nacional de Desarrollo.</li></ol><p><br></p>','publicado',8,'2026-10-27 18:42:38.121884','2026-10-31 20:56:41.070136',1,5,3);
/*!40000 ALTER TABLE `publicacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-04  5:23:37
