-- MySQL dump 10.13  Distrib 5.7.38, for Linux (x86_64)
--
-- Host: localhost    Database: calendar
-- ------------------------------------------------------
-- Server version	5.7.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT '0',
  `semester` int(10) unsigned DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1999-12-31 00:00:00',
  `total_week` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
INSERT INTO `calendar` VALUES (1,1,1,'2022-03-20 16:00:00',18);
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coursename` varchar(255) NOT NULL DEFAULT '',
  `total_period` int(10) unsigned NOT NULL DEFAULT '0',
  `theoretical_period` int(10) unsigned NOT NULL DEFAULT '0',
  `experimental_period` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_coursename` (`coursename`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'离散数学',64,64,0),(2,'面向对象程序设计',32,24,8),(3,'机器学习',60,46,14),(4,'模式识别',48,36,12),(5,'智能导论',48,36,12),(8,'自然语言理解',48,36,12),(9,'人工智能导论',32,32,0);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessonplan`
--

DROP TABLE IF EXISTS `lessonplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessonplan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `semester` varchar(255) NOT NULL DEFAULT '',
  `start_time` timestamp NOT NULL DEFAULT '1999-12-31 08:00:00',
  `total_week` int(10) unsigned NOT NULL DEFAULT '0',
  `coursename` varchar(255) NOT NULL DEFAULT '',
  `teachername` varchar(255) NOT NULL DEFAULT '',
  `classname` varchar(255) NOT NULL DEFAULT '',
  `state` int(11) NOT NULL DEFAULT '0',
  `syllabus` varchar(255) NOT NULL DEFAULT '',
  `textbook` varchar(255) NOT NULL DEFAULT '',
  `remark` varchar(3000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessonplan`
--

LOCK TABLES `lessonplan` WRITE;
/*!40000 ALTER TABLE `lessonplan` DISABLE KEYS */;
INSERT INTO `lessonplan` VALUES (1,'2021-2022-第一学期','2022-02-20 16:00:00',18,'数学','admin','18计算机科学与技术2班',0,'','',''),(2,'2021-2022-第一学期','2022-02-20 16:00:00',18,'数学','管理员李工','18物联网1班',0,'','',''),(4,'2021-2022-第一学期','2022-02-20 16:00:00',18,'机器学习','董力','18计算机科学与技术4班',2,'全日制本科教学大纲','自然语言理解','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。\n\n'),(5,'2022-2023-第一学期','2022-02-20 16:00:00',18,'自然语言理解','赵刚','18计算机科学与技术4班',2,'全日制本科教学大纲',' 涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。'),(6,'2021-2022-第一学期','2022-02-20 16:00:00',8,'智能导论','管理员李工','18计算机科学与技术3班',1,'','',''),(8,'2021-2022-第一学期','2022-02-20 16:00:00',18,'智能导论','董力','18计算机科学与技术1班',1,'全日制本科教学大纲','涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。\n'),(9,'2021-2022-第一学期','2022-02-20 16:00:00',18,'模式识别','董力','18计算机科学与技术1班',1,'全日制本科教学大纲','涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。\n\n'),(10,'2021-2022-第一学期','2022-02-20 16:00:00',18,'自然语言理解','董力','18计算机科学与技术1班',2,'全日制本科教学大纲','涂铭,等.《Python自然语言处理实战》','1. 课程使用教材\n涂铭，刘祥，刘树春．Python自然语言处理实战：核心技术与算法．北京：机械工业出版社．2018年4月．\n2. 教学参考书\n[1] 郑捷．NLP汉语自然语言处理：原理与实践．北京：电子工业出版社．2017年1月．\n[2] 程显毅，朱倩，王进．中文信息抽取原理及应用．北京：科学出版社，2010年2月．\n[3] Steven Bird等著，陈涛等译．Python自然语言处理．北京：机械工业出版社，2014年7月．\n[4] 宗成庆．统计自然语言处理（第2版）．北京：清华大学出版社，20013年8月．\n3. 说明\n(1) 课程教学将结合教学网站和QQ群进行，学习资源将通过网络提供给学生。\n'),(11,'2021-2022-第一学期','2022-02-27 16:00:00',19,'面向对象程序设计','陈荟慧','2021级智能科学与技术1、2班',1,'全日制本科教学大纲','张引等译.C++大学基础教程.北京：机械工业出版社，2021.','1、课程使用的教材\nH.M.Deitel等著，张印等译．C++大学基础教程（第5版）．北京：电子工业出版社，2011年．\n2、参考书\n[1] Stanley B. Lippman等著，王刚，杨巨峰等译，C++ Primer（第5版）．北京：电子工业出版社，2013年．\n3、说明\n（1）该课程的教学将使用QQ群和自建网络教学平台进行，C++教学和实验学习资源将通过网络提供给学生。\n'),(13,'2021-2022-第一学期','2022-03-27 16:00:00',18,'人工智能导论','董力','18计算机科学与技术2班',0,'','',''),(14,'2022-2023-第一学期','2022-03-27 16:00:00',18,'面向对象程序设计','赵刚','18计算机科学与技术1班',0,'','',''),(15,'2022-2023-第一学期','2022-03-27 16:00:00',18,'人工智能导论','赵刚','18计算机科学与技术2班',0,'','','');
/*!40000 ALTER TABLE `lessonplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lessonplan_id` int(10) unsigned DEFAULT '0',
  `week` int(10) unsigned NOT NULL DEFAULT '0',
  `content` varchar(5000) NOT NULL DEFAULT '',
  `lecture_period` int(10) unsigned NOT NULL DEFAULT '0',
  `experiment_period` int(10) unsigned NOT NULL DEFAULT '0',
  `exercise_period` int(10) unsigned NOT NULL DEFAULT '0',
  `disscussion_period` int(10) unsigned NOT NULL DEFAULT '0',
  `other_period` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,2,1,'',0,0,0,0,0),(2,4,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(3,4,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具',3,0,0,0,0),(4,4,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(5,4,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(6,4,5,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(7,4,6,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(8,4,7,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(9,4,8,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(10,4,9,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(11,4,10,'实验一：文章关键词自动提取',0,2,0,0,0),(12,4,11,'实验二：计算网页内容相似度',0,2,0,0,0),(13,4,13,'实验三：电影评论情感分析',0,2,0,0,0),(14,4,14,'复习',0,0,0,0,0),(15,4,15,'复习',0,0,0,0,0),(16,4,17,'',0,0,0,0,0),(17,4,16,'考试',0,0,0,0,0),(18,5,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(19,5,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具',3,0,0,0,0),(20,5,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(21,5,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词',3,0,0,0,0),(22,5,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(23,5,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(24,5,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(25,5,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(26,5,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(27,5,10,'',0,0,0,0,0),(28,5,11,'实验二：计算网页内容相似度',0,2,0,0,0),(29,5,12,'实验三：电影评论情感分析',0,2,0,0,0),(30,5,13,'复习',0,0,0,0,0),(31,5,14,'复习',0,0,0,0,0),(32,5,15,'考试',0,0,0,0,0),(33,3,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(34,3,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具\n',3,0,0,0,0),(35,3,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(36,3,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(37,3,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(38,3,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(39,3,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,3,0,0,0),(40,3,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(41,3,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(42,3,10,'实验一：文章关键词自动提取',0,2,0,0,0),(43,3,12,'实验三：电影评论情感分析',0,2,0,0,0),(44,3,11,'实验二：计算网页内容相似度',0,2,0,0,0),(45,3,13,'复习',0,0,0,0,0),(46,3,14,'复习',0,0,0,0,0),(47,3,15,'考试',0,0,0,0,0),(48,8,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(49,8,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具\n',3,0,0,0,0),(50,8,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(51,8,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n',3,0,0,0,0),(52,8,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(53,8,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(54,8,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(55,8,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(56,8,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(57,8,10,'实验一：文章关键词自动提取',0,2,0,0,0),(58,8,11,'实验二：计算网页内容相似度',0,2,0,0,0),(59,8,12,'实验三：电影评论情感分析',0,2,0,0,0),(60,8,13,'复习',0,0,0,0,0),(61,8,14,'复习',0,0,0,0,0),(62,8,15,'复习',0,0,0,0,0),(63,9,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(64,9,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具\n',3,0,0,0,0),(65,9,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(66,9,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n5.5　实战提取文本关键词\n',3,0,0,0,0),(67,9,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(68,9,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(69,9,7,'第8章　情感分析技术\n8.1　情感分析的应用\n8.2　情感分析的基本方法\n8.3　实战电影评论情感分析 \n',3,0,0,0,0),(70,9,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(71,9,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(72,9,10,'实验一：文章关键词自动提取',0,2,0,0,0),(73,9,11,'实验二：计算网页内容相似度',0,2,0,0,0),(74,9,12,'实验三：电影评论情感分析',0,2,0,0,0),(75,9,13,'复习',0,0,0,0,0),(76,9,14,'复习',0,0,0,0,0),(77,9,15,'考试',0,0,0,0,0),(78,10,1,'第1章　NLP基础\n1.1　什么是NLP\n1.2　NLP的发展历程\n1.3　NLP相关知识的构成\n1.4　语料库\n1.5　探讨NLP的几个层面\n1.6　NLP与人工智能\n',3,0,0,0,0),(79,11,1,'第2章 C++编程入门\n2.1 简介    2.2 第一个C++程序：打印一行文本\n2.3 修改第一个C++程序    \n2.4 另一个C++程序：整数相加\n第3章 类和对象介绍\n3.1 简介                \n3.2 类、对象、成员函数和数据成员',2,2,0,0,0),(80,11,2,'3.3 本章范例综述    \n3.4 定义具有成员函数的类\n3.5 定义具有形参的成员函数 \n3.6 数据成员、设置函数和获取函数 63\n实验1：C++中的类与对象的定义与使用',2,2,0,0,0),(81,11,4,'第9章 类的深入剖析（第I部分）\n9.1 简介                9.2 Time类实例研究   \n9.3 类的作用域和类成员的访问\n9.4 接口与实现的分离    9.5 访问函数和工具函数\n9.6 Time类实例研究：默认实参的构造函数\n实验2：封装与消息（1）',2,2,0,0,0),(82,11,3,'3.7 用构造函数初始化对象\n3.8 一个类对应一个独立文件的可重用性\n3.9 接口与实现的分离\n3.10 用设置函数确认数据的有效性\n第4章 控制语句（第I部分）\n第5章 控制语句（第II部分）\n第6章 函数和递归入门\n仅选讲第4、5、6章各小节中有关面向对象程序设计的部分内容',4,0,0,0,0),(83,11,5,'9.7 析构函数            9.8 何时调用构造函数和析构函数\n9.9 Time 类实例研究     9.10 默认的逐个成员赋值   \n9.11 软件重用\n第10章 类的深入剖析（第II部分）\n10.1 简介              10.2 const对象和const成员函数\n10.3 组成：对象作为类的成员   10.4 friend函数和friend类  \n',4,0,0,0,0),(84,11,6,'10.5 使用this指针 \n10.6 使用new和delete运算符进行内存的动态管理 \n10.7 static类成员        10.8 数据抽象和信息隐藏 \n10.9 容器类和迭代器\n实验2：封装与消息（2）',2,2,0,0,0),(85,11,7,'第11章 运算符重载：字符串和数组对象\n11.1 简介              11.2 运算符重载的基础知识 \n11.3 运算符重载的限制 \n11.4 作为类成员函数和全局函数的运算符函数之比较 \n11.5 重载流插入运算符和流提取运算符 \n11.6 重载一元运算符   11.7 重载二元运算符 \n11.8 实例研究：Array类\n第12章 面向对象编程：继承 \n12.1 简介             12.2 基类和派生类 \n12.3 Protected成员     12.4 基类和派生类之间的关系 \n12.5 派生类中的构造函数和析构函数 \n12.6 public、protected和private继承 ',4,0,0,0,0),(86,11,8,'第13章 面向对象编程：多态性 \n13.1 简介             13.2 多态性实例  \n13.3 类继承层次中对象之间的关系\n13.4 类型域和switch语句    13.5 抽象类和纯virtual函数 \n13.6 实例研究：应用多态性的工资发放系统 \n实验4：重载、继承与多态\n',2,2,0,0,0),(87,11,9,'复习',0,0,0,0,0),(88,11,10,'复习',0,0,0,0,0),(89,11,11,'复习',0,0,0,0,0),(90,11,12,'考试',0,0,0,0,0),(91,10,2,'第2章　NLP前置技术解析\n2.1　搭建Python开发环境\n2.2　正则表达式在NLP的基本应用\n2.3　Numpy使用详解\n第3章　中文分词技术\n3.1　中文分词简介\n3.2　规则分词\n3.3　统计分词\n3.4　混合分词\n3.5　中文分词工具',3,0,0,0,0),(92,10,4,'第5章　关键词提取算法\n5.1　关键词提取技术概述\n5.2　关键词提取算法TF/IDF算法\n5.3　TextRank算法\n5.4　LSA/LSI/LDA算法\n',3,0,0,0,0),(93,10,3,'第4章　词性标注与命名实体识别\n4.1　词性标注\n4.2　命名实体识别\n',3,0,0,0,0),(94,10,5,'第6章　句法分析\n6.1　句法分析概述\n6.2　句法分析的数据集与评测方法\n6.3　句法分析的常用方法\n6.4　使用Stanford Parser的PCFG算法进行句法分析\n',3,0,0,0,0),(95,10,6,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(96,10,7,'第7章　文本向量化\n7.1　文本向量化概述\n7.2　向量化算法word2vec\n7.3　向量化算法doc2vec/str2vec\n7.4　案例：将网页文本向量化\n',3,0,0,0,0),(97,10,8,'第9章　NLP中用到的机器学习算法\n9.1　简介\n9.2　几种常用的机器学习方法\n9.3　分类器方法\n9.4　无监督学习的文本聚类\n9.5　文本分类实战：中文垃圾邮件分类\n9.6　文本聚类实战：用K-means对豆瓣读书数据聚类\n',3,0,0,0,0),(98,10,9,'第10章　基于深度学习的NLP算法\n10.1　深度学习概述\n10.2　神经网络模型\n10.3　多输出层模型\n10.8　实现BP算法\n10.9　词嵌入算法\n10.14　Seq2Seq模型\n10.17　实战Seq2Seq问答机器人\n',2,0,0,0,0),(99,10,10,'实验一：文章关键词自动提取',0,2,0,0,0),(100,10,11,'实验二：计算网页内容相似度',0,2,0,0,0),(101,10,12,'实验三：电影评论情感分析',0,2,0,0,0),(102,10,14,'复习',0,0,0,0,0),(103,10,13,'复习',0,0,0,0,0),(104,10,15,'考试',0,0,0,0,0),(105,8,16,'考试',0,0,0,0,0),(106,10,16,'',0,0,0,0,0);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semester` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `semester_time` timestamp NOT NULL DEFAULT '1999-12-31 08:00:00',
  `teacher_id` int(11) NOT NULL DEFAULT '0',
  `course_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `teachername` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(500) NOT NULL DEFAULT '' COMMENT '头像',
  `position` varchar(100) NOT NULL DEFAULT '',
  `is_admin` int(11) DEFAULT '0' COMMENT '1管理员，0教师',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`),
  UNIQUE KEY `unique_teachername` (`teachername`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','8a09ae7efb396f1a949ac95f88cd2c97fdb89e9682462bfa99f1d85005ddf077','fdf44c2f-7207-41bc-94a6-a89b718f62c6.jpg','教工',1,'2021-12-19 08:08:00','我爱工作','260886429@qq.com'),(2,'teacher1','赵刚','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','38b7dddd-d0d5-42f5-b36f-aa644bcf1406.png','教工',0,'2022-04-21 09:25:16','','无'),(3,'teacher2','董力','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','2e8583b9-e79b-47b7-8f50-5ca9f4d0123a.jpg','教工',0,'2022-04-21 10:04:34','I ❤ 工 作','dongli@163.com'),(4,'admin2','管理员李工','8a09ae7efb396f1a949ac95f88cd2c97fdb89e9682462bfa99f1d85005ddf077','a.png','教导主任',1,'2022-04-21 10:16:05','','jiaodao@163.com'),(6,'teacher5','李明','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教师',0,'2022-04-22 03:21:25','','zhaogang@163.com'),(7,'teacher6','赵力','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教工',1,'2022-04-22 03:22:38','','zhaoli@163.com'),(9,'teacher01','陈名','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教导主任',0,'2022-05-06 09:40:36','','chenming@163.com'),(10,'79084','陈荟慧','905eb8aa9f22d8ddf3f170102991ab2398ea7e74c6c26ede3bbcef978aca0234','7.png','教授',0,'2022-05-07 03:09:29','','ddchh@163.com'),(12,'teacher02','王刚','2d39682dbb53e8b7df86581b0e48a5f8a4f2815617360c4d9607945b5cdde4c5','t.png','教师',0,'2022-05-11 03:36:45','','wanggang@163.com');
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

-- Dump completed on 2022-05-17 16:41:31
