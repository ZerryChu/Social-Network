/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50624
 Source Host           : localhost
 Source Database       : social network

 Target Server Type    : MySQL
 Target Server Version : 50624
 File Encoding         : utf-8

 Date: 10/15/2015 00:22:47 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `comment_inf`
-- ----------------------------
DROP TABLE IF EXISTS `comment_inf`;
CREATE TABLE `comment_inf` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `friend`
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`friend_id`),
  KEY `user_id` (`user_id`),
  KEY `user_id_2` (`user_id`,`friend_id`),
  KEY `user_id_3` (`user_id`,`friend_id`),
  KEY `user_id_4` (`user_id`,`friend_id`),
  KEY `user_id_5` (`user_id`,`friend_id`),
  KEY `user_id_6` (`user_id`,`friend_id`),
  KEY `user_id_7` (`user_id`,`friend_id`),
  KEY `user_id_8` (`user_id`,`friend_id`),
  KEY `user_id_9` (`user_id`,`friend_id`),
  KEY `user_id_10` (`user_id`,`friend_id`),
  KEY `user_id_11` (`user_id`,`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `message_inf`
-- ----------------------------
DROP TABLE IF EXISTS `message_inf`;
CREATE TABLE `message_inf` (
  `id` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `repost_times` int(11) DEFAULT NULL,
  `comment_times` int(11) DEFAULT NULL,
  `support_times` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_inf`
-- ----------------------------
DROP TABLE IF EXISTS `user_inf`;
CREATE TABLE `user_inf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `habit` varchar(255) DEFAULT NULL,
  `friend_num` int(11) DEFAULT NULL,
  `message_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
