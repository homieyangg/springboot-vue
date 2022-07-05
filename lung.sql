/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : lung

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 06/07/2022 02:19:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '標題',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '內容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `time` datetime NULL DEFAULT NULL COMMENT '發布時間',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告照片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (3, '123213', '<p>324234234</p>', NULL, NULL, 'http://localhost:8080/files/e67820acf3d9436f8c93bd2f3587cc5b');
INSERT INTO `news` VALUES (4, '123', '<p>324234234</p>', NULL, NULL, NULL);
INSERT INTO `news` VALUES (5, 'shina', '<p><img src=\"https://www3.nhk.or.jp/nhkworld/zt/ondemand/video/3004808/images/4kIebskuLh5rKpCQd8sMxCfuXJE0j1uTQioL7fS6.jpeg\" alt=\"shiba\" data-href=\"https://www3.nhk.or.jp/nhkworld/zt/ondemand/video/3004808/images/4kIebskuLh5rKpCQd8sMxCfuXJE0j1uTQioL7fS6.jpeg\" style=\"\"/></p>', NULL, NULL, 'http://localhost:8080/files/eb754ddb1e1e4282afa9d6f87ad5479e');
INSERT INTO `news` VALUES (6, '123', '<p>111</p><p>222</p><p>333</p><p>444</p><p><br></p>', NULL, NULL, NULL);
INSERT INTO `news` VALUES (8, '555', '<p>5555</p><p>555</p><p>55</p><p>55</p><p>555</p>', '管理員', '2022-07-06 00:41:15', NULL);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名稱',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '金額',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '內容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '建立日期',
  `amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '數量',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品照片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '貓罐頭', 100.00, '好吃唷', '2022-07-05 00:00:00', '5005', 'http://localhost:8080/files/df2b174609a34e81b3e92558589eed6c');
INSERT INTO `product` VALUES (2, '213', 123.00, '123', '2022-07-05 00:00:00', '123', 'http://localhost:8080/files/337a3e34b71842119a503c2d936f50b6');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用戶訊息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '11', '123456', '111', 1, '男', '111111');
INSERT INTO `user` VALUES (5, '1', '123456', '1', 1, '男', '1');
INSERT INTO `user` VALUES (6, 'sa', '123456', 'sa', 11, '男', '11');
INSERT INTO `user` VALUES (7, '3', '123456', '3', 3, '未知', '3');
INSERT INTO `user` VALUES (8, '3', '123456', '3', 33, '未知', '3');
INSERT INTO `user` VALUES (9, '1', '123456', '1', 1, '男', '1');
INSERT INTO `user` VALUES (10, '2', '123456', '2', 2, '男', '2');
INSERT INTO `user` VALUES (11, '3', '123456', '3', 3, '男', '3');
INSERT INTO `user` VALUES (12, '4', '123456', '4', 4, '男', '4');
INSERT INTO `user` VALUES (13, 'test', 'test', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (14, 'sa', 'sa', '管理員', 11, '女', '11');

SET FOREIGN_KEY_CHECKS = 1;
