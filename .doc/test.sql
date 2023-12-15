/*
SQLyog v10.2 
MySQL - 5.7.9 : Database - test
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `test`;

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PID` bigint(20) DEFAULT '0' COMMENT '父部门ID',
  `PIDS` varchar(512) DEFAULT NULL COMMENT '父级ids',
  `SIMPLE_NAME` varchar(45) DEFAULT NULL COMMENT '简称',
  `FULL_NAME` varchar(255) DEFAULT NULL COMMENT '全称',
  `NOTES` varchar(255) DEFAULT NULL COMMENT '描述',
  `LEVEL` int(5) DEFAULT NULL COMMENT '层级',
  `VERSION` int(11) DEFAULT NULL COMMENT '版本（乐观锁保留字段）',
  `SORT` int(11) DEFAULT NULL COMMENT '排序',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门表';

/*Data for the table `sys_dept` */

LOCK TABLES `sys_dept` WRITE;

insert  into `sys_dept`(`ID`,`PID`,`PIDS`,`SIMPLE_NAME`,`FULL_NAME`,`NOTES`,`LEVEL`,`VERSION`,`SORT`,`CREATE_USER`,`CREATE_TIME`,`UPDATE_USER`,`UPDATE_TIME`) values (1,0,'-1','总公司','总公司','',NULL,NULL,1,NULL,'2019-04-01 00:00:00',NULL,NULL),(2,1,'1','开发部','开发部','',NULL,NULL,2,NULL,'2019-04-01 00:00:00',NULL,NULL),(3,1,'1','运营部','运营部','',NULL,NULL,3,NULL,'2019-04-01 00:00:00',NULL,NULL),(4,1,'1','战略部','战略部','',NULL,NULL,4,NULL,'2019-04-01 00:00:00',NULL,NULL),(5,0,NULL,'财务部','财务部','财务部',NULL,NULL,5,1,'2019-05-05 13:03:21',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `ID` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PID` bigint(30) NOT NULL DEFAULT '0' COMMENT '父ID',
  `NAME` varchar(100) DEFAULT NULL COMMENT '名称',
  `ICON` varchar(40) DEFAULT NULL COMMENT '图标',
  `MOLD` int(1) DEFAULT '0' COMMENT '类型,1:url 2:method',
  `URL` varchar(200) DEFAULT NULL COMMENT '链接',
  `SORT` int(10) DEFAULT NULL COMMENT '优先权',
  `NOTES` varchar(200) DEFAULT NULL COMMENT '描述',
  `LEVEL` int(1) DEFAULT '0' COMMENT '层级',
  `ENABLED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被禁用 0禁用1正常',
  `ISYS` int(1) NOT NULL DEFAULT '0' COMMENT '是否是超级权限 0非1是',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `sys_menu` */

LOCK TABLES `sys_menu` WRITE;

insert  into `sys_menu`(`ID`,`PID`,`NAME`,`ICON`,`MOLD`,`URL`,`SORT`,`NOTES`,`LEVEL`,`ENABLED`,`ISYS`,`CREATE_USER`,`CREATE_TIME`,`UPDATE_USER`,`UPDATE_TIME`) values (1,0,'后台管理',NULL,0,'#',1,'用户登陆后台跳转页',1,1,0,NULL,NULL,NULL,NULL),(2,1,'系统管理','glyphicon glyphicon-cog',0,'#',1,'系统管理',2,1,0,NULL,NULL,NULL,NULL),(3,2,'用户列表',NULL,1,'/admin/user/list',1,'用户管理列表页',3,1,0,NULL,NULL,NULL,NULL),(4,3,'用户保存',NULL,2,'/admin/user/save',1,'用户管理保存更新',4,1,0,NULL,NULL,NULL,NULL),(5,2,'角色列表',NULL,1,'/admin/role/list',2,'角色管理的列表',3,1,0,NULL,NULL,NULL,NULL),(6,5,'角色保存',NULL,2,'/admin/role/save',1,'角色保存与更新',4,1,0,NULL,NULL,NULL,NULL),(7,2,'资源列表',NULL,1,'/admin/menu/list',3,'资源管理列表',3,1,0,NULL,NULL,NULL,NULL),(8,7,'资源保存',NULL,2,'/admin/menu/save',1,'资源管理的保存',4,1,0,NULL,NULL,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `ID` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PID` bigint(30) DEFAULT NULL COMMENT '上级ID',
  `NAME` varchar(50) DEFAULT NULL COMMENT '角色名字',
  `NOTES` varchar(100) DEFAULT NULL COMMENT '角色说明',
  `ENABLED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被禁用 0禁用1正常',
  `ISYS` int(1) NOT NULL DEFAULT '0' COMMENT '是否是超级权限 0非1是',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `sys_role` */

LOCK TABLES `sys_role` WRITE;

insert  into `sys_role`(`ID`,`PID`,`NAME`,`NOTES`,`ENABLED`,`ISYS`,`CREATE_USER`,`CREATE_TIME`,`UPDATE_USER`,`UPDATE_TIME`) values (1,0,'ROLE_ROOT','拥有管理后台最高权限',1,1,NULL,'2017-11-11 00:00:00',NULL,NULL),(2,1,'ROLE_SYSTEM','拥有管理后台系统权限',1,1,NULL,'2017-11-11 00:00:00',NULL,NULL),(3,1,'ROLE_ADMIN','拥有管理后台操作权限',1,1,NULL,'2017-11-11 00:00:00',NULL,NULL),(4,0,'ROLE_USER','普通用户角色',1,0,NULL,'2017-11-11 00:00:00',NULL,NULL),(5,4,'ROLE_USER_TEST','用来测试的用户角色',1,0,NULL,'2017-11-11 00:00:00',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `ID` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_ID` bigint(30) DEFAULT NULL COMMENT '角色id',
  `MENU_ID` bigint(30) DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  KEY `MENU_ID` (`MENU_ID`),
  CONSTRAINT `sys_role_menu_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ID`),
  CONSTRAINT `sys_role_menu_ibfk_2` FOREIGN KEY (`MENU_ID`) REFERENCES `sys_menu` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

/*Data for the table `sys_role_menu` */

LOCK TABLES `sys_role_menu` WRITE;

insert  into `sys_role_menu`(`ID`,`ROLE_ID`,`MENU_ID`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8);

UNLOCK TABLES;

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `ID` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_ID` bigint(30) DEFAULT '0' COMMENT '角色ID',
  `DEPT_ID` bigint(30) DEFAULT '0' COMMENT '部门ID',
  `NAME` varchar(30) DEFAULT NULL COMMENT '用户姓名',
  `ACCOUNT` varchar(30) DEFAULT NULL COMMENT '登陆用户名(登陆号)',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '用户密码',
  `BIRTHDAY` varchar(30) DEFAULT NULL COMMENT '用户生日',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `SEX` int(1) DEFAULT '0' COMMENT '用户性别: 0-女,1-男',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '用户电话',
  `NOTES` varchar(50) DEFAULT NULL COMMENT '描述',
  `ENABLED` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被禁用 0禁用1正常',
  `ISYS` int(1) NOT NULL DEFAULT '0' COMMENT '是否是超级用户 0非1是',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `sys_user` */

LOCK TABLES `sys_user` WRITE;

insert  into `sys_user`(`ID`,`ROLE_ID`,`DEPT_ID`,`NAME`,`ACCOUNT`,`PASSWORD`,`BIRTHDAY`,`EMAIL`,`SEX`,`PHONE`,`NOTES`,`ENABLED`,`ISYS`,`CREATE_USER`,`CREATE_TIME`,`UPDATE_USER`,`UPDATE_TIME`) values (1,1,1,'超级管理员','admin','21232f297a57a5a743894a0e4a801fc3',NULL,NULL,0,NULL,'超级管理员',1,1,NULL,'2017-11-11 00:00:00',NULL,NULL),(2,NULL,0,'测试用户','user','21232f297a57a5a743894a0e4a801fc3',NULL,NULL,0,NULL,'测试用户',1,0,NULL,'2017-11-11 00:00:00',NULL,NULL),(3,NULL,0,'3333','111',NULL,NULL,NULL,0,NULL,'1123333',0,0,NULL,'2018-03-31 18:43:40',NULL,NULL),(4,NULL,0,'444','444',NULL,NULL,NULL,0,NULL,'44111',0,0,NULL,'2018-03-31 18:52:39',NULL,NULL),(5,NULL,0,'11','11',NULL,NULL,NULL,0,NULL,'11',0,0,NULL,'2018-03-31 22:34:25',NULL,NULL),(6,NULL,0,'222','22',NULL,NULL,NULL,0,NULL,'22',0,0,NULL,'2018-03-31 22:34:36',NULL,NULL),(7,NULL,0,'666','666',NULL,NULL,NULL,0,NULL,'666',0,0,NULL,'2018-03-31 22:35:19',NULL,NULL),(8,NULL,0,'555','555',NULL,NULL,NULL,0,NULL,'555',0,0,NULL,'2018-03-31 22:35:37',NULL,NULL),(9,NULL,0,'777','777',NULL,NULL,NULL,0,NULL,'777',1,0,NULL,'2018-03-31 22:35:48',NULL,NULL),(10,NULL,0,'888','888',NULL,NULL,NULL,0,NULL,'888',0,0,NULL,'2018-03-31 22:36:05',NULL,NULL),(11,NULL,0,'999','999',NULL,NULL,NULL,0,NULL,'999',0,0,NULL,'2018-03-31 22:36:13',NULL,NULL),(12,NULL,0,'0022','000',NULL,'','000@admin.com',1,'13411111111','000<br>',1,0,NULL,'2018-04-02 10:12:31',NULL,NULL);

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
