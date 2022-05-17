-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: calendar
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

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
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `coursename` varchar(255) NOT NULL DEFAULT '',
  `total_period` int unsigned NOT NULL DEFAULT '0',
  `theoretical_period` int unsigned NOT NULL DEFAULT '0',
  `experimental_period` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_coursename` (`coursename`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'数学',64,60,4),(2,'英语',64,60,4),(3,'机器学习',60,46,14),(4,'模式识别',48,36,12),(5,'智能导论',48,36,12);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessonplan`
--

DROP TABLE IF EXISTS `lessonplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessonplan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `semester` varchar(255) NOT NULL DEFAULT '',
  `start_time` timestamp NOT NULL DEFAULT '1999-12-31 08:00:00',
  `total_week` int unsigned NOT NULL DEFAULT '0',
  `coursename` varchar(255) NOT NULL DEFAULT '',
  `teachername` varchar(255) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `state` int NOT NULL DEFAULT '0',
  `syllabus` varchar(255) NOT NULL DEFAULT '',
  `textbook` varchar(255) NOT NULL DEFAULT '',
  `remark` varchar(3000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessonplan`
--

LOCK TABLES `lessonplan` WRITE;
/*!40000 ALTER TABLE `lessonplan` DISABLE KEYS */;
INSERT INTO `lessonplan` VALUES (1,'2021-2022-第一学期','2022-02-20 16:00:00',18,'数学','admin','18计算机科学与技术2班',0,'','',''),(2,'2021-2022-第一学期','2022-02-20 16:00:00',18,'数学','管理员李工','18物联网1班',2,'','',''),(3,'2021-2022-第一学期','2022-02-20 16:00:00',18,'英语','董力','18计算机科学与技术2班',1,'全日制本科教学大纲 ','涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。'),(4,'2021-2022-第一学期','2022-02-20 16:00:00',18,'机器学习','董力','18计算机科学与技术4班',0,'全日制本科教学大纲','自然语言理解','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。\n\n'),(5,'2022-2023-第一学期','2022-02-20 16:00:00',18,'自然语言理解','赵刚','18计算机科学与技术4班',2,'全日制本科教学大纲',' 涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。'),(6,'2021-2022-第一学期','2022-02-20 16:00:00',8,'智能导论','李明','18计算机科学与技术3班',0,'','','');
/*!40000 ALTER TABLE `lessonplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `lessonplan_id` int unsigned DEFAULT '0',
  `week` int unsigned NOT NULL DEFAULT '0',
  `content` varchar(5000) NOT NULL DEFAULT '',
  `lecture_period` int unsigned NOT NULL DEFAULT '0',
  `experiment_period` int unsigned NOT NULL DEFAULT '0',
  `exercise_period` int unsigned NOT NULL DEFAULT '0',
  `disscussion_period` int unsigned NOT NULL DEFAULT '0',
  `other_period` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,2,1,'',0,0,0,0,0),(2,4,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(3,4,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具',3,0,0,0,0),(4,4,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(5,4,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(6,4,5,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(7,4,6,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(8,4,7,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(9,4,8,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(10,4,9,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(11,4,10,'实验一：文章关键词自动提取',0,2,0,0,0),(12,4,11,'实验二：计算网页内容相似度',0,2,0,0,0),(13,4,13,'实验三：电影评论情感分析',0,2,0,0,0),(14,4,14,'复习',0,0,0,0,0),(15,4,15,'复习',0,0,0,0,0),(16,4,17,'',0,0,0,0,0),(17,4,16,'考试',0,0,0,0,0),(18,5,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(19,5,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具',3,0,0,0,0),(20,5,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(21,5,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词',3,0,0,0,0),(22,5,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(23,5,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(24,5,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(25,5,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(26,5,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(27,5,10,'',0,0,0,0,0),(28,5,11,'实验二：计算网页内容相似度',0,2,0,0,0),(29,5,12,'实验三：电影评论情感分析',0,2,0,0,0),(30,5,13,'复习',0,0,0,0,0),(31,5,14,'复习',0,0,0,0,0),(32,5,15,'考试',0,0,0,0,0),(33,3,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(34,3,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具\n',3,0,0,0,0),(35,3,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(36,3,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(37,3,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(38,3,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(39,3,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,3,0,0,0),(40,3,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(41,3,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(42,3,10,'实验一：文章关键词自动提取',0,2,0,0,0),(43,3,12,'实验三：电影评论情感分析',0,2,0,0,0),(44,3,11,'实验二：计算网页内容相似度',0,2,0,0,0),(45,3,13,'复习',0,0,0,0,0),(46,3,14,'复习',0,0,0,0,0),(47,3,15,'考试',0,0,0,0,0);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `semester_time` timestamp NOT NULL DEFAULT '1999-12-31 08:00:00',
  `teacher_id` int NOT NULL DEFAULT '0',
  `course_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `teachername` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(500) NOT NULL DEFAULT '' COMMENT '头像',
  `position` varchar(100) NOT NULL DEFAULT '',
  `is_admin` int DEFAULT '0' COMMENT '1管理员，0教师',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`),
  UNIQUE KEY `unique_teachername` (`teachername`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','8a09ae7efb396f1a949ac95f88cd2c97fdb89e9682462bfa99f1d85005ddf077','2.png','教工',1,'2021-12-19 08:08:00','我爱工作','260886429@qq.com'),(2,'teacher1','赵刚','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','38b7dddd-d0d5-42f5-b36f-aa644bcf1406.png','教工',0,'2022-04-21 09:25:16','','无'),(3,'teacher2','董力','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教工',0,'2022-04-21 10:04:34','','无'),(4,'admin2','管理员李工','8a09ae7efb396f1a949ac95f88cd2c97fdb89e9682462bfa99f1d85005ddf077','a.png','教导主任',1,'2022-04-21 10:16:05','','jiaodao@163.com'),(6,'teacher5','李明','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教师',1,'2022-04-22 03:21:25','','zhaogang@163.com'),(7,'teacher6','赵力','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教工',1,'2022-04-22 03:22:38','','zhaoli@163.com'),(9,'teacher01','陈名','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教导主任',0,'2022-05-06 09:40:36','','chenming@163.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-06 18:18:06



DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT '0',
  `semester` int unsigned DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1999-12-31 08:00:00',
  `total_week` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;