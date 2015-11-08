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

 Date: 11/08/2015 15:19:57 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `after_insertComment` AFTER INSERT ON `comment_inf` FOR EACH ROW begin 
	update message_inf set comment_times = comment_times + 1 where id = NEW.message_id;
end;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `after_deleteComment` AFTER DELETE ON `comment_inf` FOR EACH ROW begin 
	update message_inf set comment_times = comment_times - 1 where id = OLD.message_id;
end;
 ;;
delimiter ;

-- ----------------------------
--  Records of `comment_inf`
-- ----------------------------
BEGIN;
INSERT INTO `comment_inf` VALUES ('16', '2', 'zerrychu', 'haha', '2015-10-30 16:49:47'), ('18', '2', 'zerrychu', 'aaa', '2015-10-30 17:01:18'), ('22', '7', 'zerrychu', 'aaa', '2015-11-02 21:25:04'), ('30', '8', 'zerrychu', '111', '2015-11-04 20:12:27'), ('31', '84', 'zerrychu', 'aaa', '2015-11-04 20:49:44'), ('32', '8', 'zerrychu', 'aaa', '2015-11-04 23:36:31'), ('33', '93', 'zerrychu', '666', '2015-11-04 23:50:08'), ('34', '94', 'zerrychu', '666', '2015-11-05 22:04:05'), ('35', '8', 'zerrychu', 'a', '2015-11-06 09:27:19'), ('36', '8', 'zerrychu', '11', '2015-11-06 09:27:24'), ('37', '8', 'zerrychu', 'da', '2015-11-06 09:27:26');
COMMIT;

-- ----------------------------
--  Table structure for `friend`
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `groupname` varchar(255) DEFAULT NULL,
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
--  Records of `friend`
-- ----------------------------
BEGIN;
INSERT INTO `friend` VALUES ('1', '2', 'normal'), ('1', '3', 'normal'), ('1', '5', '逗比'), ('1', '6', 'normal'), ('2', '1', 'normal'), ('2', '3', 'normal'), ('2', '6', 'normal'), ('3', '1', 'normal'), ('3', '2', 'normal'), ('5', '1', 'normal'), ('6', '1', 'normal'), ('6', '2', 'normal');
COMMIT;

-- ----------------------------
--  Table structure for `message_inf`
-- ----------------------------
DROP TABLE IF EXISTS `message_inf`;
CREATE TABLE `message_inf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `repost_times` int(11) DEFAULT NULL,
  `comment_times` int(11) DEFAULT NULL,
  `support_times` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `after_insertMessage` AFTER INSERT ON `message_inf` FOR EACH ROW BEGIN
	update user_inf set message_num = message_num + 1 where nickname = NEW.author;
END;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `after_deleteMessage` AFTER DELETE ON `message_inf` FOR EACH ROW BEGIN
	update user_inf set message_num = message_num - 1 where nickname = OLD.author;
END;
 ;;
delimiter ;

-- ----------------------------
--  Records of `message_inf`
-- ----------------------------
BEGIN;
INSERT INTO `message_inf` VALUES ('2', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '2', '1'), ('5', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-03 22:15:13', '0', '0', '1'), ('6', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '0'), ('7', '1', '周周', '今天爬了泰山', '2015-10-21 09:27:22', '0', '1', '0'), ('8', '1', '周周', '考试100分！', '2015-11-03 09:55:49', '2', '5', '0'), ('9', '1', 'admin', '请大家随意测试', '2015-10-21 23:48:27', '0', '0', '0'), ('10', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '1'), ('11', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-03 22:15:13', '0', '0', '1'), ('12', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '0'), ('79', '1', 'zerrychu', 'df', '2015-10-29 21:50:30', '0', '0', '0'), ('80', '1', 'zerrychu', 'aa', '2015-11-03 09:06:28', '0', '0', '0'), ('83', '1', 'lucy', '真伤心！今天', '2015-11-03 09:51:07', '0', '0', '0'), ('84', '1', '周周', 'jfsljfsjl', '2015-11-04 00:21:30', '4', '1', '1'), ('88', '1', 'zerrychu', 'aaa', '2015-11-04 18:37:22', '0', '0', '0'), ('92', '2', 'lucy', '干的漂亮！;8', '2015-11-04 21:03:33', '2', '0', '1'), ('93', '2', 'lucy', 'haha!;83', '2015-11-04 23:46:22', '2', '1', '0'), ('94', '2', '周周', '666 || lucy:干的漂亮！;8', '2015-11-05 00:00:01', '6', '1', '1'), ('102', '2', 'zerrychu', 'hahah || lucy:haha!;83', '2015-11-05 20:58:40', '0', '0', '0'), ('103', '2', 'zerrychu', ';84', '2015-11-05 21:42:23', '0', '0', '1'), ('104', '2', 'zerrychu', 'zz || 周周:666 || lucy:干的漂亮！;8', '2015-11-05 23:35:36', '0', '0', '1'), ('110', '2', 'zerrychu', '666 || 周周:666 || lucy:干的漂亮！;8', '2015-11-08 00:02:46', '0', '0', '0'), ('112', '1', '张星星', 'hahaha ,first time to be here~', '2015-11-08 14:40:24', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `support_inf`
-- ----------------------------
DROP TABLE IF EXISTS `support_inf`;
CREATE TABLE `support_inf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
delimiter ;;
CREATE TRIGGER `after_insertSupport` AFTER INSERT ON `support_inf` FOR EACH ROW begin 
	update message_inf set support_times = support_times + 1 where id = NEW.message_id;
end;
 ;;
delimiter ;
delimiter ;;
CREATE TRIGGER `after_deleteSupport` AFTER DELETE ON `support_inf` FOR EACH ROW begin 
	update message_inf set support_times = support_times - 1 where id = OLD.message_id;
end;
 ;;
delimiter ;

-- ----------------------------
--  Records of `support_inf`
-- ----------------------------
BEGIN;
INSERT INTO `support_inf` VALUES ('3', '5', 'zerry'), ('60', '11', 'zerry'), ('67', '10', 'zerry'), ('93', '2', 'zerry'), ('130', '84', 'zerry'), ('153', '94', 'zerry'), ('155', '104', 'zhangsan'), ('156', '103', 'zhangsan'), ('157', '92', 'zhangsan');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_inf`
-- ----------------------------
BEGIN;
INSERT INTO `user_inf` VALUES ('1', 'zerrychu', 'zerry', 'b93ee7cfd6e4e886ac6b4bb8f3f080619f2c', '20', '1', '旅游、打各种球、编程', '3', '7'), ('2', 'lucy', 'lucy', '123456', '20', '1', '打打杀杀的电子游戏', '2', '8'), ('3', '周周', 'zhouzhou', '123456', '19', '1', '发呆，看书', '1', '3'), ('4', 'admin', 'admin', 'admin', '0', '2', '(空）', '0', '0'), ('5', '李白', 'libai', 'libai', '0', '1', '(空）', '0', '0'), ('6', '张星星', 'zhangsan', '96c6c804d071bbd031b45673cc23f7bca7ea', '0', '1', '', '2', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
