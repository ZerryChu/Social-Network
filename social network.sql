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

 Date: 10/30/2015 17:56:18 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
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
INSERT INTO `comment_inf` VALUES ('15', '7', 'zerrychu', 'aaa', '2015-10-30 16:49:34'), ('16', '2', 'zerrychu', 'haha', '2015-10-30 16:49:47'), ('18', '2', 'zerrychu', 'aaa', '2015-10-30 17:01:18');
COMMIT;

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
--  Records of `friend`
-- ----------------------------
BEGIN;
INSERT INTO `friend` VALUES ('1', '2', 'normal'), ('1', '3', 'normal'), ('2', '1', 'normal'), ('2', '3', 'normal'), ('3', '1', 'normal'), ('3', '2', 'normal');
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
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
INSERT INTO `message_inf` VALUES ('2', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '2', '1'), ('5', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-03 22:15:13', '0', '0', '1'), ('6', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '0'), ('7', '1', '周周', '今天爬了泰山', '2015-10-21 09:27:22', '0', '1', '1'), ('8', '1', '周周', '考试100分！', '2015-10-20 09:28:29', '0', '0', '0'), ('9', '1', 'admin', '请大家随意测试', '2015-10-21 23:48:27', '0', '0', '0'), ('10', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '1'), ('11', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-03 22:15:13', '0', '0', '1'), ('12', '1', 'lucy', '今天去爬了二龙山，好累啊', '2015-10-05 22:15:13', '0', '0', '0'), ('79', '1', 'zerrychu', 'df', '2015-10-29 21:50:30', '0', '0', '0');
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
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
INSERT INTO `support_inf` VALUES ('3', '5', 'zerry'), ('60', '11', 'zerry'), ('62', '2', 'zerry'), ('65', '7', 'zerry'), ('67', '10', 'zerry');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_inf`
-- ----------------------------
BEGIN;
INSERT INTO `user_inf` VALUES ('1', 'zerrychu', 'zerry', 'b93ee7cfd6e4e886ac6b4bb8f3f080619f2c', '20', '1', '旅游、打各种球、编程', '2', '1'), ('2', 'lucy', 'lucy', '123456', '20', '1', '打打杀杀的电子游戏', '1', '1'), ('3', '周周', 'zhouzhou', '123456', '19', '1', '发呆，看书', '1', '2'), ('4', 'admin', 'admin', 'admin', '0', '2', '(空）', '0', '0');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
