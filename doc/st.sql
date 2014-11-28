/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : st

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2014-11-28 17:26:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tab_charge_detail`
-- ----------------------------
DROP TABLE IF EXISTS `tab_charge_detail`;
CREATE TABLE `tab_charge_detail` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Status` tinyint(4) DEFAULT '1' COMMENT '交易状态 1：成功、2：中间状态 3：失败',
  `CityCardNo` varchar(30) DEFAULT '' COMMENT 'å¸‚æ°‘å¡å·',
  `CardType` tinyint(255) DEFAULT NULL COMMENT 'å¡ç‰‡ç±»åž‹',
  `BankCardNo` varchar(30) DEFAULT '' COMMENT 'å……å€¼æ—¶é‡‡ç”¨çš„é“¶è¡Œå¡å¡å·æˆ–è€…å……å€¼å¡å¡å·',
  `ChargeTime` datetime DEFAULT NULL COMMENT 'å……å€¼æ—¶é—´',
  `ChargeType` tinyint(255) DEFAULT '0' COMMENT 'å……å€¼ç±»åž‹  0ï¼šçŽ°é‡‘  1ï¼šé“¶è”å¡  3ï¼šå……å€¼å¡',
  `ChargeAmount` int(255) DEFAULT NULL COMMENT 'å……å€¼é‡‘é¢ï¼Œå•ä½ï¼šåˆ†',
  `BalanceBeforeCharge` int(255) DEFAULT NULL COMMENT 'å……å€¼å‰ä½™é¢',
  `TAC` varchar(20) DEFAULT '' COMMENT 'åœˆå­˜è¿‡ç¨‹ä¸­äº§ç”Ÿçš„tac',
  `ASN` varchar(20) DEFAULT '' COMMENT 'ICå¡åº”ç”¨åºåˆ—å·',
  `TSN` varchar(20) DEFAULT '' COMMENT 'ICå¡äº¤æ˜“åºåˆ—å·',
  `ChargeSNo` bigint(12) DEFAULT NULL COMMENT 'å……å€¼äº¤æ˜“æµæ°´å·ï¼ˆç»ˆç«¯ç»´æŠ¤)',
  `TerminalID` int(20) DEFAULT NULL COMMENT 'å……å€¼æ‰€åœ¨ç»ˆç«¯',
  `POSID` varchar(20) DEFAULT '' COMMENT 'posç¼–å·',
  `SAMID` varchar(20) DEFAULT '' COMMENT 'samç¼–å·',
  `AgencyNo` varchar(20) DEFAULT '' COMMENT 'å……å€¼ç‚¹ç¼–å·',
  `SysTime` datetime DEFAULT NULL COMMENT 'æ•°æ®æ’å…¥æ—¶é—´',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='å……å€¼äº¤æ˜“æ˜Žç»†';

-- ----------------------------
-- Records of tab_charge_detail
-- ----------------------------
INSERT INTO `tab_charge_detail` VALUES ('3', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 17:37:20', '3', '5000', '5578', '19F06D1D', '86000091500084000133', '0001', '11', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('4', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 17:44:51', '3', '10000', '10578', '3354ACCD', '86000091500084000133', '0002', '12', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('5', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 17:46:05', '3', '85000', '20578', '4DA058A3', '86000091500084000133', '0003', '13', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('6', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 17:46:40', '3', '85000', '105578', 'EFD21B33', '86000091500084000133', '0004', '14', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('7', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 17:59:12', '3', '5000', '190578', '6A1B8A1E', '86000091500084000133', '0005', '15', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('8', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 18:14:51', '0', '10000', '195578', 'CBBF1A57', '86000091500084000133', '0006', '16', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('9', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-30 18:21:04', '0', '10000', '205578', 'AB3091F4', '86000091500084000133', '0007', '17', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('10', '1', '9150020184000133', '2', '2525075536531184\0', '2014-10-30 18:25:00', '2', '10000', '215578', '7DB73755', '86000091500084000133', '0008', '18', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('11', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 09:38:12', '0', '5000', '225578', '4E9669D8', '86000091500084000133', '0009', '19', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('12', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 09:39:15', '0', '20000', '230578', '7C457238', '86000091500084000133', '000A', '20', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('13', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 10:27:14', '3', '3000', '250578', '7B36E312', '86000091500084000133', '000B', '21', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('14', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 15:01:55', '0', '10000', '253458', '6BB02562', '86000091500084000133', '000C', '22', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('15', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 15:02:25', '0', '5000', '263458', 'C415A932', '86000091500084000133', '000D', '23', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('16', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-10-31 15:03:58', '3', '3000', '268458', '1FF601FD', '86000091500084000133', '000E', '24', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('17', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-03 17:05:12', '0', '5000', '271458', '84375439', '86000091500084000133', '000F', '25', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('18', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-03 17:16:27', '0', '5000', '276458', '2F47894C', '86000091500084000133', '0010', '26', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('19', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:23:49', '0', '10000', '281458', '60C352D3', '86000091500084000133', '0011', '27', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('20', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:25:34', '0', '10000', '291458', '7EF46653', '86000091500084000133', '0012', '28', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('21', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:26:41', '0', '10000', '301458', '40FD9493', '86000091500084000133', '0013', '29', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('22', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:30:25', '0', '10000', '311458', '8FEE8B91', '86000091500084000133', '0014', '30', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('23', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:31:04', '0', '10000', '321458', 'D0446D09', '86000091500084000133', '0015', '31', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('24', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:31:22', '0', '10000', '331458', '07E3D437', '86000091500084000133', '0016', '32', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('25', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:43:33', '3', '5000', '341458', 'BBD1AA98', '86000091500084000133', '0017', '33', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('26', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 15:43:52', '3', '10000', '346458', 'E367A351', '86000091500084000133', '0018', '34', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('27', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:18:54', '0', '10000', '356458', '84EC5E7C', '86000091500084000133', '0019', '35', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('28', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:19:17', '0', '10000', '366458', '0A967585', '86000091500084000133', '001A', '36', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('29', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:19:34', '3', '5000', '376458', 'AD20B09C', '86000091500084000133', '001B', '37', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('30', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:28:21', '3', '3000', '381458', '6BF99A7A', '86000091500084000133', '001C', '38', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('31', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:29:02', '3', '3000', '384458', 'F2CEAC93', '86000091500084000133', '001D', '39', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('32', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 16:54:54', '0', '10000', '387458', 'BEA885F5', '86000091500084000133', '001E', '40', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('33', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:11:02', '0', '10000', '397458', 'C16B8FE9', '86000091500084000133', '001F', '41', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('34', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:11:40', '0', '10000', '407458', '337F4A85', '86000091500084000133', '0020', '42', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('35', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:11:58', '3', '10000', '417458', 'BAEBAC0C', '86000091500084000133', '0021', '43', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('36', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:27:57', '0', '10000', '427458', '74008777', '86000091500084000133', '0022', '44', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('37', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:28:14', '0', '10000', '437458', 'FBD62EF2', '86000091500084000133', '0023', '45', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('38', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:34:38', '0', '10000', '447458', '8EDCCA4A', '86000091500084000133', '0024', '46', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('39', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-04 17:35:04', '0', '10000', '457458', 'E4DCA4A7', '86000091500084000133', '0025', '47', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('40', '1', '9150020184000133', '2', '6167655650516412\0', '2014-11-05 14:19:18', '2', '5000', '467458', '644B6DDF', '86000091500084000133', '0026', '48', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('41', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-05 16:34:25', '3', '3000', '472458', '8F2BE58D', '86000091500084000133', '0027', '49', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('42', '1', '9150020184000133', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-05 17:19:45', '0', '10000', '475458', '542241A9', '86000091500084000133', '0028', '264', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('43', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-05 17:21:21', '3', '5000', '485458', '4B2EE961', '86000091500084000133', '0029', '276', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('44', '1', '9150020184000133', '2', '6055570363888303\0', '2014-11-05 17:25:44', '2', '5000', '490458', 'C13F2138', '86000091500084000133', '002A', '278', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('45', '1', '9150020184000257', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-05 17:49:40', '3', '3000', '0', '5CCBC9BC', '86000091500084000257', '0000', '289', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('46', '1', '9150020184000258', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-05 17:49:54', '3', '3000', '0', 'D63550CC', '86000091500084000258', '0000', '291', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('47', '1', '9150020184000133', '2', '222222\0\0\0\0\0\0\0\0\0\0\0', '2014-11-07 10:12:53', '3', '5000', '495458', 'FAD764D1', '86000091500084000133', '002C', '297', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('48', '1', '9150020184000133', '2', '222222\0\0\0\0\0\0\0\0\0\0\0', '2014-11-07 10:13:08', '3', '10000', '500458', '9CE2D94C', '86000091500084000133', '002D', '305', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('49', '1', '9150020184000133', '2', '222222\0\0\0\0\0\0\0\0\0\0\0', '2014-11-07 10:51:37', '3', '3000', '510458', '0CEC7C30', '86000091500084000133', '002E', '307', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('50', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-07 11:07:19', '0', '10000', '7835', '389156D1', '86000091500084000132', '0003', '310', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('51', '1', '9150020184000133', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-10 17:44:21', '3', '3000', '513458', 'BB604E40', '86000091500084000133', '002F', '355', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('52', '1', '9150020184000134', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-11 13:34:27', '0', '10000', '95000', '0FE0DEF2', '86000091500084000134', '0002', '371', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('53', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-11 17:34:56', '0', '10000', '17835', '6A8CAF6A', '86000091500084000132', '0004', '529', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('54', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-11 17:35:26', '0', '10000', '27835', 'A148E2A2', '86000091500084000132', '0005', '532', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('55', '1', '9150020184000132', '2', '1682538222378718\0', '2014-11-11 17:35:50', '2', '10000', '37835', 'DBEDD767', '86000091500084000132', '0006', '535', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('56', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-11 17:37:35', '3', '10000', '47835', '168AD8A3', '86000091500084000132', '0007', '546', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('57', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-14 15:11:39', '0', '10000', '57835', '1B80B3E6', '86000091500084000132', '0008', '660', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('58', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-14 15:12:28', '3', '3000', '67835', '050741A1', '86000091500084000132', '0009', '663', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('59', '1', '9150020184000134', '2', '1700582555876064\0', '2014-11-14 17:39:55', '2', '5000', '95000', 'A614B041', '86000091500084000134', '0003', '776', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('60', '1', '9150020184000132', '2', '6358736113348311\0', '2014-11-17 09:20:11', '2', '10000', '70835', 'B8A44070', '86000091500084000132', '000A', '807', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('61', '1', '9150020184000132', '2', '7486855821303228\0', '2014-11-17 09:20:45', '2', '10000', '80835', '103778D1', '86000091500084000132', '000B', '816', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('62', '1', '9150020184000132', '2', '4643433228801641\0', '2014-11-17 09:28:58', '2', '10000', '90835', 'C920CCAD', '86000091500084000132', '000C', '819', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('63', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-17 10:08:26', '3', '3000', '100835', 'C4DC59B6', '86000091500084000132', '000D', '825', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('64', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-17 10:08:50', '3', '3000', '103835', 'C49FA278', '86000091500084000132', '000E', '834', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('65', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-17 14:57:07', '3', '5000', '106835', '0788EFE2', '86000091500084000132', '000F', '867', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('66', '1', '9150020184000132', '2', '0375631686434673\0', '2014-11-17 17:48:31', '2', '10000', '111835', 'B5780CAF', '86000091500084000132', '0010', '888', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('67', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 09:17:10', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '897', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('68', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 09:17:13', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '897', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('69', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 09:17:15', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '898', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('70', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 09:17:17', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '899', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('71', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 09:17:17', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '900', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('72', '3', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 10:06:46', '3', '5000', '121835', '00000000', '86000091500084000132', '0011', '905', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('73', '64', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 13:00:43', '3', '5000', '121835', '1395DF4F', '86000091500084000132', '0011', '915', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('74', '64', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 14:24:35', '0', '10000', '126835', '0088FFAD', '86000091500084000132', '0012', '919', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('75', '64', '9150020184000132', '2', '6034601076550677\0', '2014-11-18 14:25:32', '2', '10000', '136835', '704051D1', '86000091500084000132', '0013', '1024', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('76', '64', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 14:25:52', '3', '5000', '146835', '63ABDA42', '86000091500084000132', '0014', '1027', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('77', '64', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 14:29:42', '3', '5000', '151835', '00000000', '86000091500084000132', '0015', '1030', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('78', '3', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 14:42:34', '3', '10000', '151835', '00000000', '86000091500084000132', '0015', '1033', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('79', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 15:25:40', '3', '5000', '151835', '6DCD5E35', '86000091500084000132', '0015', '1042', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('80', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 15:55:15', '3', '5000', '156835', 'C7371AE7', '86000091500084000132', '0016', '1045', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('81', '3', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 15:55:30', '3', '5000', '161835', '00000000', '86000091500084000132', '0017', '1048', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('82', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-18 16:24:54', '0', '10000', '161835', '550AA57D', '86000091500084000132', '0017', '1056', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('83', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-19 17:04:34', '0', '5000', '171835', 'C520A1B4', '86000091500084000132', '0018', '1318', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('84', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-19 17:05:05', '0', '5000', '176835', '4E6F9588', '86000091500084000132', '0019', '1320', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('85', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-19 17:05:39', '0', '5000', '181835', '67FA98E3', '86000091500084000132', '001A', '1328', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('86', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-19 17:06:04', '0', '5000', '186835', '05F77219', '86000091500084000132', '001B', '1330', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('87', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-19 21:00:17', '3', '3000', '191835', 'AB6ADDE8', '86000091500084000132', '001C', '1336', '12345678', '', '', '', null);
INSERT INTO `tab_charge_detail` VALUES ('90', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-26 14:11:32', '3', '3000', '204835', '22A00421', '86000091500084000132', '001F', '141126000004', '12345678', '', '', '', '2014-11-26 14:53:08');
INSERT INTO `tab_charge_detail` VALUES ('91', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-26 14:11:54', '0', '10000', '207835', '00E0DAF8', '86000091500084000132', '0020', '141126000006', '12345678', '', '', '', '2014-11-26 14:53:08');
INSERT INTO `tab_charge_detail` VALUES ('92', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-26 15:33:40', '3', '3000', '217835', 'A6333531', '86000091500084000132', '0021', '141126000010', '12345678', '', '', '', '2014-11-26 15:28:31');
INSERT INTO `tab_charge_detail` VALUES ('93', '1', '9150020184000132', '2', '0482866416386465\0', '2014-11-26 15:34:17', '2', '10000', '220835', '30C06062', '86000091500084000132', '0022', '141126000013', '12345678', '', '', '', '2014-11-26 15:29:09');
INSERT INTO `tab_charge_detail` VALUES ('94', '1', '9150020184000132', '2', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2014-11-26 15:35:34', '0', '10000', '230835', '7EF9CA8B', '86000091500084000132', '0023', '141126000017', '12345678', '', '', '', '2014-11-26 15:30:25');
INSERT INTO `tab_charge_detail` VALUES ('95', '1', '9150020184000132', '2', '111111\0\0\0\0\0\0\0\0\0\0\0', '2014-11-26 15:39:27', '3', '3000', '240835', '6FFEECE5', '86000091500084000132', '0024', '141126000020', '12345678', '', '', '', '2014-11-26 15:34:19');

-- ----------------------------
-- Table structure for `tab_refund`
-- ----------------------------
DROP TABLE IF EXISTS `tab_refund`;
CREATE TABLE `tab_refund` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CardNo` varchar(30) DEFAULT NULL COMMENT 'å¡å·',
  `Amount` int(255) DEFAULT NULL COMMENT 'é€€æ¬¾é‡‘é¢',
  `RefundTime` datetime DEFAULT NULL COMMENT 'é€€æ¬¾æ—¶é—´ï¼Œç”±å®¢æˆ·ç«¯æä¾›',
  `Status` tinyint(255) DEFAULT NULL COMMENT 'çŠ¶æ€  0ï¼šæ–°å»ºæœªé€€å›ž  1ï¼šé€€å›ž',
  `InsertTime` datetime DEFAULT NULL,
  `TerminalID` int(11) DEFAULT NULL,
  `ChargeType` tinyint(4) DEFAULT '99' COMMENT '充值类型  0：现金 1：银行卡 2：充值卡 3：账户宝',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_refund
-- ----------------------------
INSERT INTO `tab_refund` VALUES ('9', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 14:35:31', null, '99');
INSERT INTO `tab_refund` VALUES ('10', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 14:36:23', null, '99');
INSERT INTO `tab_refund` VALUES ('11', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 16:25:43', null, '99');
INSERT INTO `tab_refund` VALUES ('12', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 16:26:38', null, '99');
INSERT INTO `tab_refund` VALUES ('13', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 16:27:38', null, '99');
INSERT INTO `tab_refund` VALUES ('14', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 16:28:38', null, '99');
INSERT INTO `tab_refund` VALUES ('15', '3030303030303030', '10000', '2014-08-12 13:50:20', '0', '2014-08-12 16:29:38', null, '99');
INSERT INTO `tab_refund` VALUES ('16', '9150020184000133', '1000000', '2014-10-30 17:29:55', '0', '2014-10-30 17:24:50', null, '99');
INSERT INTO `tab_refund` VALUES ('17', '9150020184000133', '1000000', '2014-10-30 17:38:13', '0', '2014-10-30 17:33:08', null, '99');
INSERT INTO `tab_refund` VALUES ('18', '9150020184000133', '1000000', '2014-10-30 17:47:25', '0', '2014-10-30 17:42:20', null, '99');
INSERT INTO `tab_refund` VALUES ('19', '9150020184000133', '1000000', '2014-10-30 17:55:30', '0', '2014-10-30 17:50:26', null, '99');
INSERT INTO `tab_refund` VALUES ('20', '9150020184000133', '1000000', '2014-10-30 17:56:40', '0', '2014-10-30 17:51:36', null, '99');
INSERT INTO `tab_refund` VALUES ('21', '9150020184000133', '1000000', '2014-10-30 18:15:44', '0', '2014-10-30 18:10:40', null, '99');
INSERT INTO `tab_refund` VALUES ('22', '9150020184000133', '1000000', '2014-10-30 18:18:22', '0', '2014-10-30 18:13:19', null, '99');
INSERT INTO `tab_refund` VALUES ('23', '9150020184000133', '1000000', '2014-10-30 18:20:35', '0', '2014-10-30 18:15:32', null, '99');
INSERT INTO `tab_refund` VALUES ('24', '9150020184000133', '1000000', '2014-11-05 14:04:30', '0', '2014-11-05 13:59:28', null, '99');
INSERT INTO `tab_refund` VALUES ('25', '9150020184000133', '2000000', '2014-11-06 14:15:38', '0', '2014-11-06 14:10:38', null, '99');
INSERT INTO `tab_refund` VALUES ('26', '9150020184000134', '1000000', '2014-11-07 11:03:19', '0', '2014-11-07 10:58:19', null, '99');
INSERT INTO `tab_refund` VALUES ('27', '9150020184000131', '1000000', '2014-11-07 13:36:39', '0', '2014-11-07 13:31:40', null, '99');
INSERT INTO `tab_refund` VALUES ('28', '9150020184000131', '1000000', '2014-11-07 13:39:03', '0', '2014-11-07 13:34:03', null, '99');
INSERT INTO `tab_refund` VALUES ('29', '9150020184000131', '1000000', '2014-11-07 13:40:00', '0', '2014-11-07 13:35:00', null, '99');
INSERT INTO `tab_refund` VALUES ('30', '9150020184000131', '1000000', '2014-11-07 13:40:23', '0', '2014-11-07 13:35:23', null, '99');
INSERT INTO `tab_refund` VALUES ('31', '9150020184000131', '1000000', '2014-11-07 14:44:18', '0', '2014-11-07 14:39:18', null, '99');
INSERT INTO `tab_refund` VALUES ('32', '9150020184000133', '1000000', '2014-11-07 14:44:59', '0', '2014-11-07 14:39:59', null, '99');
INSERT INTO `tab_refund` VALUES ('33', '9150020184000131', '10000', '2014-11-11 13:34:58', '0', '2014-11-11 13:29:59', null, '99');
INSERT INTO `tab_refund` VALUES ('34', '9150080186008040', '5000', '2014-11-14 15:11:05', '0', '2014-11-14 15:05:51', null, '99');
INSERT INTO `tab_refund` VALUES ('35', '9150080186008040', '5000', '2014-11-14 15:20:14', '0', '2014-11-14 15:15:00', null, '99');
INSERT INTO `tab_refund` VALUES ('36', '9150020184000134', '5000', '2014-11-14 17:40:01', '0', '2014-11-14 17:34:47', null, '99');
INSERT INTO `tab_refund` VALUES ('37', '9150020184000132', '3000', '2014-11-17 10:08:05', '0', '2014-11-17 10:02:52', null, '99');
INSERT INTO `tab_refund` VALUES ('38', '9150020184000132', '3000', '2014-11-17 10:09:13', '0', '2014-11-17 10:04:00', null, '99');
INSERT INTO `tab_refund` VALUES ('39', '9150020184000132', '5000', '2014-11-17 11:07:42', '0', '2014-11-17 11:02:29', null, '99');
INSERT INTO `tab_refund` VALUES ('40', '9150020184000132', '5000', '2014-11-17 11:09:03', '0', '2014-11-17 11:03:50', null, '99');
INSERT INTO `tab_refund` VALUES ('41', '9150020184000132', '5000', '2014-11-17 13:25:16', '0', '2014-11-17 13:20:03', null, '99');
INSERT INTO `tab_refund` VALUES ('42', '9150020184000132', '5000', '2014-11-17 14:37:16', '0', '2014-11-17 14:32:03', null, '99');
INSERT INTO `tab_refund` VALUES ('43', '9150020184000132', '5000', '2014-11-17 14:45:55', '0', '2014-11-17 14:40:42', null, '99');
INSERT INTO `tab_refund` VALUES ('44', '9150020184000132', '5000', '2014-11-17 15:19:46', '0', '2014-11-17 15:14:34', null, '99');
INSERT INTO `tab_refund` VALUES ('45', '9150020184000132', '5000', '2014-11-17 16:29:49', '0', '2014-11-17 16:24:36', null, '99');
INSERT INTO `tab_refund` VALUES ('46', '9150020184000132', '5000', '2014-11-17 17:45:12', '0', '2014-11-17 17:39:59', null, '99');
INSERT INTO `tab_refund` VALUES ('47', '9150020184000132', '5000', '2014-11-18 09:17:22', '0', '2014-11-18 09:12:09', null, '99');
INSERT INTO `tab_refund` VALUES ('48', '9150020184000132', '5000', '2014-11-18 10:06:53', '0', '2014-11-18 10:01:41', null, '99');
INSERT INTO `tab_refund` VALUES ('49', '9150020184000132', '5000', '2014-11-18 14:29:55', '0', '2014-11-18 14:24:42', null, '99');
INSERT INTO `tab_refund` VALUES ('50', '9150020184000132', '10000', '2014-11-18 14:43:11', '0', '2014-11-18 14:37:58', null, '99');
INSERT INTO `tab_refund` VALUES ('51', '9150020184000132', '5000', '2014-11-18 15:56:06', '1', '2014-11-18 15:50:54', null, '99');
INSERT INTO `tab_refund` VALUES ('52', '9150020184000132', '10000', '2014-11-26 14:11:21', '0', '2014-11-26 14:06:12', '12345678', '99');
INSERT INTO `tab_refund` VALUES ('53', '9150020184000132', '10000', '2014-11-26 15:33:30', '0', '2014-11-26 15:28:21', '12345678', '99');
INSERT INTO `tab_refund` VALUES ('54', '9150020184000132', '5000', '2014-11-26 16:43:58', '0', '2014-11-26 16:38:49', '12345678', '99');
INSERT INTO `tab_refund` VALUES ('55', '9150020184000132', '3000', '2014-11-27 15:17:37', '0', '2014-11-27 15:12:28', '12345678', '3');
INSERT INTO `tab_refund` VALUES ('56', '9150020184000132', '3000', '2014-11-27 16:22:22', '0', '2014-11-27 16:17:13', '12345678', '3');

-- ----------------------------
-- Table structure for `tab_terminal`
-- ----------------------------
DROP TABLE IF EXISTS `tab_terminal`;
CREATE TABLE `tab_terminal` (
  `id` int(19) NOT NULL COMMENT 'ç»ˆç«¯ID  12ä½',
  `typeId` smallint(6) DEFAULT '0' COMMENT 'ç»ˆç«¯ç±»åž‹ï¼Œé»˜è®¤0',
  `position` varchar(255) DEFAULT NULL COMMENT 'ç»ˆç«¯æŠ•æ”¾åœ°å€',
  `enabled` tinyint(2) DEFAULT '0' COMMENT 'å¯ç”¨çŠ¶æ€ 0ï¼šå¯ç”¨ 1ï¼šåœç”¨',
  `memo` varchar(255) DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_terminal
-- ----------------------------
INSERT INTO `tab_terminal` VALUES ('11223344', '0', '市政府2', '0', 'beiz');
INSERT INTO `tab_terminal` VALUES ('12345678', '1', 'a', '0', 'sfd');

-- ----------------------------
-- Table structure for `tab_terminal_status`
-- ----------------------------
DROP TABLE IF EXISTS `tab_terminal_status`;
CREATE TABLE `tab_terminal_status` (
  `TERMINALID` int(19) NOT NULL COMMENT 'ç»ˆç«¯ID  ä¸»é”®',
  `OnlineStatus` tinyint(2) DEFAULT NULL COMMENT 'è®¾å¤‡åœ¨çº¿çŠ¶æ€  0ï¼šæœªçŸ¥  1ï¼šåœ¨çº¿  2ï¼šç¦»çº¿',
  `LastOnlineTime` datetime DEFAULT NULL COMMENT 'æœ€è¿‘ä¸€æ¬¡çš„åœ¨çº¿æ—¶é—´',
  `M1STATUS` tinyint(2) DEFAULT '0' COMMENT 'å¸‚æ°‘å¡è¯»å†™æ¨¡å— (0:æœªçŸ¥ 1:æ­£å¸¸ 2:æ•…éšœ   ä¸‹åŒ)',
  `M2STATUS` tinyint(2) DEFAULT '0' COMMENT 'çŽ°é‡‘æ¨¡å—',
  `M3STATUS` tinyint(2) DEFAULT '0' COMMENT 'é“¶è”æ¨¡å—',
  `M4STATUS` tinyint(2) DEFAULT '0' COMMENT 'æ‰“å°æ¨¡å—',
  `M5STATUS` tinyint(2) DEFAULT '0' COMMENT 'èº«ä»½è¯è¯»å–æ¨¡å—',
  `M6STATUS` tinyint(2) DEFAULT '0' COMMENT 'å¯†ç é”®ç›˜æ¨¡å—',
  `M7STATUS` tinyint(2) DEFAULT '0',
  `M8STATUS` tinyint(2) DEFAULT '0',
  PRIMARY KEY (`TERMINALID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_terminal_status
-- ----------------------------
INSERT INTO `tab_terminal_status` VALUES ('12345678', '2', '2014-11-28 14:37:40', '1', '1', '0', '1', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `tab_terminal_type`
-- ----------------------------
DROP TABLE IF EXISTS `tab_terminal_type`;
CREATE TABLE `tab_terminal_type` (
  `id` int(11) NOT NULL COMMENT 'ç»ˆç«¯ç±»åž‹ID',
  `name` varchar(255) DEFAULT NULL COMMENT 'ç±»åž‹åç§°',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ç»ˆç«¯ç±»åž‹';

-- ----------------------------
-- Records of tab_terminal_type
-- ----------------------------

-- ----------------------------
-- Table structure for `tab_users`
-- ----------------------------
DROP TABLE IF EXISTS `tab_users`;
CREATE TABLE `tab_users` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ç”¨æˆ·ID',
  `name` varchar(50) NOT NULL COMMENT 'ç”¨æˆ·å',
  `pass` varchar(50) DEFAULT NULL COMMENT 'ç”¨æˆ·å¯†ç ',
  `memo` varchar(255) DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT=' åŽå°ç®¡ç†ç³»ç»Ÿç”¨æˆ·';

-- ----------------------------
-- Records of tab_users
-- ----------------------------
INSERT INTO `tab_users` VALUES ('1', 'admin', 'admin', 'admin');
