/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 16/07/2022 21:57:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `activityId` int(12) NOT NULL AUTO_INCREMENT,
  `activityName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityDes` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `discount` float NULL DEFAULT 1,
  `fullPrice` int(12) NULL DEFAULT NULL,
  `reducePrice` int(12) NULL DEFAULT NULL,
  `fullNum` int(12) NULL DEFAULT NULL,
  `reduceNum` int(12) NULL DEFAULT NULL,
  PRIMARY KEY (`activityId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (1, '无活动', '无', 1, NULL, NULL, NULL, NULL);
INSERT INTO `activity` VALUES (2, '节日大放送', '情人节 折扣慢慢', 1, 200, 180, 300, 280);
INSERT INTO `activity` VALUES (3, '开业大酬宾', '开业大酬宾，全场9折。', 9.2, 100, 8, 200, 20);

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `addressID` int(12) NOT NULL AUTO_INCREMENT,
  `userId` int(12) NOT NULL,
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `county` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detailAddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `conName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `conTel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`addressID`) USING BTREE,
  INDEX `addressID`(`addressID`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (17, 9, '北京市', '北京市市辖区', '东城区', '1', '2', '3');
INSERT INTO `address` VALUES (18, 10, '北京市', '北京市市辖区', '东城区', '123', '张三', '13859123456');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `adminId` int(12) NOT NULL AUTO_INCREMENT,
  `adminName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`adminId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `cateId` int(12) NOT NULL AUTO_INCREMENT,
  `cateName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`cateId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (2, '玫瑰');
INSERT INTO `category` VALUES (3, '百合');
INSERT INTO `category` VALUES (4, '康乃馨');
INSERT INTO `category` VALUES (5, '满天星');
INSERT INTO `category` VALUES (6, '向日葵');

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `userId` int(12) NOT NULL COMMENT '收藏',
  `goodsId` int(12) NOT NULL,
  `collectTime` datetime(0) NOT NULL,
  PRIMARY KEY (`userId`, `goodsId`) USING BTREE,
  INDEX `collection_ibfk_2`(`goodsId`) USING BTREE,
  CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `commentId` int(12) NOT NULL AUTO_INCREMENT,
  `userId` int(12) NOT NULL,
  `goodsId` int(12) NOT NULL,
  `point` int(8) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `commentTime` datetime(0) NOT NULL,
  PRIMARY KEY (`commentId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `goodsId`(`goodsId`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for deliver
-- ----------------------------
DROP TABLE IF EXISTS `deliver`;
CREATE TABLE `deliver`  (
  `deliverId` int(12) NOT NULL AUTO_INCREMENT,
  `orderId` int(12) NOT NULL,
  `sendId` int(12) NOT NULL,
  PRIMARY KEY (`deliverId`) USING BTREE,
  INDEX `orderId`(`orderId`) USING BTREE,
  CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `indent` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deliver
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goodsId` int(12) NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` int(12) NOT NULL,
  `num` int(12) NOT NULL,
  `upTime` datetime(0) NOT NULL,
  `category` int(12) NOT NULL,
  `detailCate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityId` int(12) NOT NULL DEFAULT 1,
  PRIMARY KEY (`goodsId`) USING BTREE,
  INDEX `activityId`(`activityId`) USING BTREE,
  INDEX `category`(`category`) USING BTREE,
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`cateId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 147 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (100, '蓝色妖姬', 166, 65, '2022-07-16 00:00:45', 2, '玫瑰', '清纯的爱和敦厚善良，奇迹与不可能的事情。', 2);
INSERT INTO `goods` VALUES (101, '蜜桃雪山', 236, 123, '2022-07-16 00:00:45', 2, '玫瑰', '爱你是最大的幸福，想你却是甜蜜的痛苦。', 2);
INSERT INTO `goods` VALUES (102, '香槟玫瑰', 199, 13, '2022-07-16 00:00:45', 2, '玫瑰', '爱上你是我今生最大的幸福。', 1);
INSERT INTO `goods` VALUES (103, '红袖', 256, 100, '2022-07-16 00:00:45', 2, '玫瑰', '红颜知己,知音难觅,知己难求。人生在世,得一知已足矣。', 2);
INSERT INTO `goods` VALUES (104, '金香玉', 129, 103, '2022-07-16 00:00:45', 2, '玫瑰', '纯洁的友谊和美好的祝福。', 3);
INSERT INTO `goods` VALUES (105, '紫皇后', 118, 134, '2022-07-16 00:00:45', 2, '玫瑰', '沉静,高贵,成熟的魅力。', 1);
INSERT INTO `goods` VALUES (106, '粉佳人', 278, 35, '2022-07-16 00:00:45', 2, '玫瑰', '心有灵犀、细声细语。', 1);
INSERT INTO `goods` VALUES (107, '塔尼克', 88, 78, '2022-07-16 00:00:45', 2, '玫瑰', '纯洁,高贵,集爱与美与一身。', 1);
INSERT INTO `goods` VALUES (108, '卡罗拉', 98, 145, '2022-07-16 00:00:45', 2, '玫瑰', '幸福而浪漫的爱情。', 1);

INSERT INTO `goods` VALUES (120, '麝香百合', 212, 250, '2022-07-16 00:00:45', 3, '百合', '高贵，纯正。', 3);
INSERT INTO `goods` VALUES (121, '东方百合', 148, 443, '2022-07-16 00:00:45', 3, '百合', '纯洁、庄严，心心相印。', 1);
INSERT INTO `goods` VALUES (122, '天香百合', 168, 55, '2022-07-16 00:00:45', 3, '百合', '顺利、心想事成、祝福、高贵、清纯。', 1);
INSERT INTO `goods` VALUES (123, '千叶百合', 155, 88, '2022-07-16 00:00:45', 3, '百合', '纯洁、热烈的爱和永远幸福。', 1);

INSERT INTO `goods` VALUES (140, '北极之火', 180, 40, '2022-07-16 00:00:45', 4, '康乃馨', '光明、活力、圆满、富贵、诚实和憨厚。', 1);
INSERT INTO `goods` VALUES (141, '红色少女', 68, 80, '2022-07-16 00:00:45', 4, '康乃馨', '象征着极大的奢侈、妩媚妖娆。', 1);
INSERT INTO `goods` VALUES (142, '理想紫罗兰', 199, 78, '2022-07-16 00:00:45', 4, '康乃馨', '永恒的美与爱；质朴，美德，盛夏的清凉。', 3);
INSERT INTO `goods` VALUES (143, '奈木奶油', 324, 88, '2022-07-16 00:00:45', 4, '康乃馨', '寓意一种不屈服的精神品质。', 3);
INSERT INTO `goods` VALUES (144, '棉花糖', 118, 59, '2022-07-16 00:00:45', 4, '康乃馨', '棉花糖的花语是你是我的唯一。', 1);

INSERT INTO `goods` VALUES (160, '金色洛唐', 98, 45, '2022-07-16 00:00:45', 6, '向日葵', '敬爱、天生的幸运儿、幸福。', 2);
INSERT INTO `goods` VALUES (161, '千瓣葵', 78, 124, '2022-07-16 00:00:45', 6, '向日葵', '秘密恋情,有着爱还没说出来的象征意义。', 1);

INSERT INTO `goods` VALUES (180, '吉普赛', 198, 56, '2022-07-16 00:00:45', 5, '满天星', '幸福、美满,与你相伴很幸福 。', 1);
INSERT INTO `goods` VALUES (181, '宿根', 128, 65, '2022-07-16 00:00:45', 5, '满天星', '信者之福、爱的音讯、信任、气质高雅。', 2);
INSERT INTO `goods` VALUES (182, '花园新娘', 189, 98, '2022-07-16 00:00:45', 5, '满天星', '守望爱情、纯洁美好的心灵、不可缺失的配角。', 1);
INSERT INTO `goods` VALUES (183, '大花原生', 208, 21, '2022-07-16 00:00:45', 5, '满天星', '单纯美好、高贵雍容、丰盈祥和。', 3);
-- ----------------------------
-- Table structure for imagepath
-- ----------------------------
DROP TABLE IF EXISTS `imagepath`;
CREATE TABLE `imagepath`  (
  `pathId` int(12) NOT NULL AUTO_INCREMENT,
  `goodId` int(12) NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`pathId`) USING BTREE,
  INDEX `goodid`(`goodId`) USING BTREE,
  CONSTRAINT `imagepath_ibfk_1` FOREIGN KEY (`goodId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 179 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of imagepath
-- ----------------------------
INSERT INTO `imagepath` VALUES (140, 100, '蓝色妖姬.jpg');
INSERT INTO `imagepath` VALUES (141, 101, '蜜桃雪山.jpg');
INSERT INTO `imagepath` VALUES (142, 102, '香槟玫瑰.jpg');
INSERT INTO `imagepath` VALUES (143, 103, '红袖.jpg');
INSERT INTO `imagepath` VALUES (144, 104, '金香玉.jpg');
INSERT INTO `imagepath` VALUES (145, 105, '紫皇后.jpg');
INSERT INTO `imagepath` VALUES (146, 106, '粉佳人.jpg');
INSERT INTO `imagepath` VALUES (147, 107, '塔尼克.jpg');
INSERT INTO `imagepath` VALUES (148, 108, '卡罗拉.jpg');

INSERT INTO `imagepath` VALUES (160, 120, '麝香百合.jpg');
INSERT INTO `imagepath` VALUES (161, 121, '东方百合.jpg');
INSERT INTO `imagepath` VALUES (162, 122, '天香百合.jpg');
INSERT INTO `imagepath` VALUES (163, 123, '千叶百合.jpg');

INSERT INTO `imagepath` VALUES (180, 140, '北极之火.jpg');
INSERT INTO `imagepath` VALUES (181, 141, '红色少女.jpg');
INSERT INTO `imagepath` VALUES (182, 142, '理想紫罗兰.jpg');
INSERT INTO `imagepath` VALUES (183, 143, '奈木奶油.jpg');
INSERT INTO `imagepath` VALUES (184, 144, '棉花糖.jpg');

INSERT INTO `imagepath` VALUES (200, 160, '金色洛唐.jpg');
INSERT INTO `imagepath` VALUES (201, 161, '千瓣葵.jpg');

INSERT INTO `imagepath` VALUES (220, 180, '吉普赛.jpg');
INSERT INTO `imagepath` VALUES (221, 181, '宿根.jpg');
INSERT INTO `imagepath` VALUES (222, 182, '花园新娘.jpg');
INSERT INTO `imagepath` VALUES (223, 183, '大花原生.jpg');

-- ----------------------------
-- Table structure for indent
-- ----------------------------
DROP TABLE IF EXISTS `indent`;
CREATE TABLE `indent`  (
  `orderId` int(12) NOT NULL AUTO_INCREMENT,
  `userId` int(12) NOT NULL,
  `orderTime` datetime(0) NOT NULL,
  `oldPrice` float NOT NULL,
  `newPrice` float NOT NULL,
  `isPay` tinyint(1) NOT NULL,
  `isSend` tinyint(1) NOT NULL,
  `isReceive` tinyint(1) NOT NULL,
  `isComplete` tinyint(1) NOT NULL,
  `addressId` int(12) NOT NULL,
  `addres` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `orderGoods`(`orderTime`) USING BTREE,
  INDEX `addressId`(`addressId`) USING BTREE,
  CONSTRAINT `indent_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `indent_ibfk_2` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of indent
-- ----------------------------
INSERT INTO `indent` VALUES (49, 9, '2022-07-16 21:20:22', 666, 666, 1, 0, 0, 0, 17, NULL);
INSERT INTO `indent` VALUES (50, 9, '2022-07-16 21:26:32', 196, 196, 1, 1, 0, 0, 17, NULL);
INSERT INTO `indent` VALUES (51, 10, '2022-07-16 21:41:27', 294, 294, 1, 1, 0, 0, 18, NULL);

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem`  (
  `itemId` int(12) NOT NULL AUTO_INCREMENT,
  `orderId` int(12) NOT NULL,
  `goodsId` int(12) NOT NULL,
  `num` int(12) NOT NULL,
  PRIMARY KEY (`itemId`) USING BTREE,
  INDEX `orderId`(`orderId`) USING BTREE,
  INDEX `goodsId`(`goodsId`) USING BTREE,
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `indent` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES (37, 49, 108, 1);
INSERT INTO `orderitem` VALUES (38, 50, 125, 2);
INSERT INTO `orderitem` VALUES (39, 51, 126, 3);

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`  (
  `goodsId` int(11) NOT NULL,
  `goodsName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `num` int(11) NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`goodsId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales
-- ----------------------------

-- ----------------------------
-- Table structure for shopcart
-- ----------------------------
DROP TABLE IF EXISTS `shopcart`;
CREATE TABLE `shopcart`  (
  `userId` int(12) NOT NULL,
  `goodsid` int(12) NOT NULL,
  `cateDate` datetime(0) NOT NULL,
  `goodsNum` int(12) NOT NULL,
  PRIMARY KEY (`userId`, `goodsid`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `goodsid`(`goodsid`) USING BTREE,
  CONSTRAINT `shopcart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shopcart_ibfk_2` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopcart
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(12) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `regTime` datetime(0) NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`userId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (9, '用户2', 'e10adc3949ba59abbe56e057f20f883e', '2022-07-16 20:06:56', '925980032@qq.com', '13859123456');
INSERT INTO `user` VALUES (10, '用户1', 'e10adc3949ba59abbe56e057f20f883e', '2022-07-16 21:40:10', '925980032@qq.com', '13859123456');

SET FOREIGN_KEY_CHECKS = 1;
