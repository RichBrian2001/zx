/*
 Navicat Premium Dump SQL

 Source Server         : 01tech
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : proj_zx

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 12/05/2026 19:04:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-05-10 19:10:07', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-10 19:10:07', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-10 19:25:34');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-10 19:59:29');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码已失效', '2026-05-11 05:11:00');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 05:11:02');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 05:16:04');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码已失效', '2026-05-11 07:01:30');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 07:01:31');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 07:13:52');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 14:38:25');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '验证码已失效', '2026-05-11 15:16:50');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 15:16:53');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 18:46:49');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 18:47:29');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-11 18:59:54');
INSERT INTO `sys_logininfor` VALUES (114, 'myx', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-11 18:59:59');
INSERT INTO `sys_logininfor` VALUES (115, 'myx', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-11 19:00:12');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 19:00:17');
INSERT INTO `sys_logininfor` VALUES (117, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-11 19:01:47');
INSERT INTO `sys_logininfor` VALUES (118, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 19:01:51');
INSERT INTO `sys_logininfor` VALUES (119, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 19:40:44');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-11 21:46:05');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-11 21:46:09');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-11 21:46:11');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-11 21:46:13');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-11 21:46:15');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-11 21:46:18');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-05-11 21:46:22');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '验证码已失效', '2026-05-11 21:56:52');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 21:56:55');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-11 21:57:09');
INSERT INTO `sys_logininfor` VALUES (130, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-05-11 21:57:14');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '验证码错误', '2026-05-11 21:57:20');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 21:57:23');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-11 22:22:04');
INSERT INTO `sys_logininfor` VALUES (134, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-05-11 22:22:12');
INSERT INTO `sys_logininfor` VALUES (135, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-05-11 22:22:21');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 22:22:30');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-11 22:22:45');
INSERT INTO `sys_logininfor` VALUES (138, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-11 22:22:51');
INSERT INTO `sys_logininfor` VALUES (139, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码已失效', '2026-05-11 22:23:07');
INSERT INTO `sys_logininfor` VALUES (140, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-11 22:23:10');
INSERT INTO `sys_logininfor` VALUES (141, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 00:20:53');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-12 00:48:56');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 00:48:56');
INSERT INTO `sys_logininfor` VALUES (144, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 01:15:01');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 01:15:13');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 02:00:21');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 03:21:38');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-12 04:28:18');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-12 04:28:38');
INSERT INTO `sys_logininfor` VALUES (150, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-12 04:28:46');
INSERT INTO `sys_logininfor` VALUES (151, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-12 04:28:52');
INSERT INTO `sys_logininfor` VALUES (152, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-12 04:28:59');
INSERT INTO `sys_logininfor` VALUES (153, 'ry', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '退出成功', '2026-05-12 04:30:17');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Code 1.118.1', 'Windows 10.0', '0', '登录成功', '2026-05-12 04:30:20');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 05:16:24');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 05:16:41');
INSERT INTO `sys_logininfor` VALUES (157, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-12 05:16:47');
INSERT INTO `sys_logininfor` VALUES (158, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-05-12 05:16:49');
INSERT INTO `sys_logininfor` VALUES (159, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 05:16:51');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 18:11:27');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 18:11:29');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 18:12:51');
INSERT INTO `sys_logininfor` VALUES (163, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 18:13:27');
INSERT INTO `sys_logininfor` VALUES (164, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 18:16:24');
INSERT INTO `sys_logininfor` VALUES (165, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 18:26:57');
INSERT INTO `sys_logininfor` VALUES (166, 'ry', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 18:27:07');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-05-12 18:27:13');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-05-12 18:27:25');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2194 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 91, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-10 19:10:07', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 92, 'monitor', NULL, '', '', 1, 0, 'M', '1', '0', '', 'monitor', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:24', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 93, 'tool', NULL, '', '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:48:03', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 94, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:47:55', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-10 19:10:07', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-10 19:10:07', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-10 19:10:07', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '1', '0', 'system:dept:list', 'tree', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:38', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:50', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:43', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:55', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '1', '0', 'system:notice:list', 'message', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:58', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-05-10 19:10:07', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 1, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:49:18', '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-10 19:10:07', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-10 19:10:07', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-10 19:10:07', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:48:36', '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-10 19:10:07', 'admin', '2026-05-11 18:48:33', '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-10 19:10:07', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-10 19:10:07', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-10 19:10:07', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-10 19:10:07', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-10 19:10:07', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2001, '总览中心', 0, 1, '/index', 'plant/admin/dashboard/index', '', 'Index', 1, 0, 'C', '0', '0', 'plant:dashboard:list', 'dashboard', 'admin', '2026-05-11 23:47:39', '', NULL, '登录首页与总览中心');
INSERT INTO `sys_menu` VALUES (2002, '植物资产中心', 0, 2, 'plant-assets', '', '', '', 1, 0, 'M', '0', '0', '', 'tree', 'admin', '2026-05-11 23:47:39', '', NULL, '业务模块目录');
INSERT INTO `sys_menu` VALUES (2003, '推荐运营中心', 0, 3, 'recommend-ops', '', '', '', 1, 0, 'M', '0', '0', '', 'form', 'admin', '2026-05-11 23:47:39', '', NULL, '业务模块目录');
INSERT INTO `sys_menu` VALUES (2004, '内容与交付中心', 0, 4, 'content-delivery', '', '', '', 1, 0, 'M', '0', '0', '', 'documentation', 'admin', '2026-05-11 23:47:39', '', NULL, '业务模块目录');
INSERT INTO `sys_menu` VALUES (2012, '植物分类', 2002, 1, '/plant-admin/category', 'plant/admin/category/index', '', 'PlantAdminCategory', 1, 0, 'C', '0', '0', 'plant:category:list', 'tree', 'admin', '2026-05-11 23:47:39', '', NULL, '植物分类菜单');
INSERT INTO `sys_menu` VALUES (2013, '植物库', 2002, 2, '/plant-admin/plant', 'plant/admin/plant/index', '', 'PlantAdminPlant', 1, 0, 'C', '0', '0', 'plant:plant:list', 'example', 'admin', '2026-05-11 23:47:39', '', NULL, '植物库菜单');
INSERT INTO `sys_menu` VALUES (2014, '标签字典', 2002, 3, '/plant-admin/tag', 'plant/admin/tag/index', '', 'PlantAdminTag', 1, 0, 'C', '0', '0', 'plant:tag:list', 'dict', 'admin', '2026-05-11 23:47:39', '', NULL, '标签字典菜单');
INSERT INTO `sys_menu` VALUES (2015, '推荐规则', 2003, 1, '/plant-admin/rule', 'plant/admin/rule/index', '', 'PlantAdminRule', 1, 0, 'C', '0', '0', 'plant:rule:list', 'edit', 'admin', '2026-05-11 23:47:39', '', NULL, '推荐规则菜单');
INSERT INTO `sys_menu` VALUES (2016, '用户画像', 2003, 2, '/plant-admin/profile', 'plant/admin/profile/index', '', 'PlantAdminProfile', 1, 0, 'C', '0', '0', 'plant:profile:list', 'user', 'admin', '2026-05-11 23:47:39', '', NULL, '用户画像菜单');
INSERT INTO `sys_menu` VALUES (2017, '推荐记录', 2003, 3, '/plant-admin/recommend', 'plant/admin/recommend/index', '', 'PlantAdminRecommend', 1, 0, 'C', '0', '0', 'plant:recommend:list', 'form', 'admin', '2026-05-11 23:47:39', '', NULL, '推荐记录菜单');
INSERT INTO `sys_menu` VALUES (2018, '反馈管理', 2003, 4, '/plant-admin/feedback', 'plant/admin/feedback/index', '', 'PlantAdminFeedback', 1, 0, 'C', '0', '0', 'plant:feedback:list', 'message', 'admin', '2026-05-11 23:47:39', '', NULL, '反馈管理菜单');
INSERT INTO `sys_menu` VALUES (2019, '内容管理', 2004, 1, '/plant-admin/article', 'plant/admin/article/index', '', 'PlantAdminArticle', 1, 0, 'C', '0', '0', 'plant:article:list', 'documentation', 'admin', '2026-05-11 23:47:39', '', NULL, '内容管理菜单');
INSERT INTO `sys_menu` VALUES (2020, '数据导入', 2004, 2, '/plant-admin/import', 'plant/admin/import/index', '', 'PlantAdminImport', 1, 0, 'C', '0', '0', 'plant:import:list', 'upload', 'admin', '2026-05-11 23:47:39', '', NULL, '数据导入菜单');
INSERT INTO `sys_menu` VALUES (2101, '工作台查询', 2001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:dashboard:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2110, '分类查询', 2012, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '分类新增', 2012, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:add', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '分类修改', 2012, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:edit', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '分类删除', 2012, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:remove', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '植物查询', 2013, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '植物新增', 2013, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:add', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '植物修改', 2013, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:edit', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '植物删除', 2013, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:remove', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '植物导出', 2013, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:export', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '植物详情', 2013, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:detail', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2126, '养护配置', 2013, 7, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:care', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '标签配置', 2013, 8, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:tag', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '标签查询', 2014, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '标签新增', 2014, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:add', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '标签修改', 2014, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:edit', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '标签删除', 2014, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:remove', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '规则查询', 2015, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2141, '规则新增', 2015, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:add', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2142, '规则修改', 2015, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:edit', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, '规则删除', 2015, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:remove', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2144, '规则启停', 2015, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:changeStatus', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2150, '画像查询', 2016, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:profile:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2151, '画像详情', 2016, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:profile:detail', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2160, '记录查询', 2017, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2161, '记录详情', 2017, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:detail', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2162, '记录导出', 2017, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:export', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2170, '反馈查询', 2018, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:feedback:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2171, '反馈导出', 2018, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:feedback:export', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2180, '内容查询', 2019, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2181, '内容新增', 2019, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:add', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2182, '内容修改', 2019, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:edit', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2183, '内容删除', 2019, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:remove', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2190, '导入查询', 2020, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:query', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2191, '导入上传', 2020, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:upload', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2192, '导入执行', 2020, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:execute', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2193, '导入详情', 2020, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:detail', '#', 'admin', '2026-05-11 23:47:39', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-05-11 07:02:19');
INSERT INTO `sys_notice_read` VALUES (2, 2, 1, '2026-05-11 07:02:19');
INSERT INTO `sys_notice_read` VALUES (3, 1, 1, '2026-05-11 07:02:19');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '植物标签配置', 2, 'com.ruoyi.web.controller.plant.admin.ZxPlantTagRelController.save()', 'PUT', 1, 'admin', '研发部门', '/plant/admin/plant/tag', '127.0.0.1', '内网IP', '{\"params\":{},\"plantId\":1001,\"tagItems\":[{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"light_medium\",\"tagId\":2002,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"water_medium\",\"tagId\":2011,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"space_medium\",\"tagId\":2021,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":10,\"tagCode\":\"care_easy\",\"tagId\":2030,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"style_leaf\",\"tagId\":2040,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":6,\"tagCode\":\"pet_no\",\"tagId\":2051,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":9,\"tagCode\":\"function_purify\",\"tagId\":2060,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":7,\"tagCode\":\"price_low\",\"tagId\":2070,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":7,\"tagCode\":\"feature_hanging\",\"tagId\":2080,\"tagItems\":[]}],\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 05:19:10', 30);
INSERT INTO `sys_oper_log` VALUES (101, '植物标签配置', 2, 'com.ruoyi.web.controller.plant.admin.ZxPlantTagRelController.save()', 'PUT', 1, 'admin', '研发部门', '/plant/admin/plant/tag', '127.0.0.1', '内网IP', '{\"params\":{},\"plantId\":1001,\"tagItems\":[{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"light_medium\",\"tagId\":2002,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"water_medium\",\"tagId\":2011,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"space_medium\",\"tagId\":2021,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":10,\"tagCode\":\"care_easy\",\"tagId\":2030,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":8,\"tagCode\":\"style_leaf\",\"tagId\":2040,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":6,\"tagCode\":\"pet_no\",\"tagId\":2051,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":9,\"tagCode\":\"function_purify\",\"tagId\":2060,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":7,\"tagCode\":\"price_low\",\"tagId\":2070,\"tagItems\":[]},{\"createBy\":\"admin\",\"params\":{},\"plantId\":1001,\"scoreWeight\":7,\"tagCode\":\"feature_hanging\",\"tagId\":2080,\"tagItems\":[]}],\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 05:19:51', 8);
INSERT INTO `sys_oper_log` VALUES (102, '数据导入上传', 6, 'com.ruoyi.web.controller.plant.admin.ZxDataImportTaskController.upload()', 'POST', 1, 'admin', '研发部门', '/plant/admin/import/upload', '127.0.0.1', '内网IP', '{\"importType\":\"plant_basic\",\"taskName\":\"A12 运行校验任务\",\"remark\":\"用于验证新补的数据导入管理页面和执行链路。\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createBy\":\"admin\",\"failCount\":0,\"fileName\":\"plant_basic_demo.xlsx\",\"fileUrl\":\"/profile/upload/import/2026/05/11/a31da654d80d430dac6c64469af270b6.xlsx\",\"importType\":\"plant_basic\",\"params\":{},\"remark\":\"用于验证新补的数据导入管理页面和执行链路。\",\"resultMessage\":\"文件已上传，待执行导入。\",\"status\":\"0\",\"successCount\":0,\"taskId\":11000,\"taskName\":\"A12 运行校验任务\",\"totalCount\":0}}', 0, NULL, '2026-05-11 07:15:21', 109);
INSERT INTO `sys_oper_log` VALUES (103, '数据导入执行', 2, 'com.ruoyi.web.controller.plant.admin.ZxDataImportTaskController.execute()', 'POST', 1, 'admin', '研发部门', '/plant/admin/import/execute', '127.0.0.1', '内网IP', '{\"taskId\":\"11000\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 07:15:59', 7);
INSERT INTO `sys_oper_log` VALUES (104, '数据导入上传', 6, 'com.ruoyi.web.controller.plant.admin.ZxDataImportTaskController.upload()', 'POST', 1, 'admin', '研发部门', '/plant/admin/import/upload', '127.0.0.1', '内网IP', '{\"importType\":\"plant_basic\",\"taskName\":\"A12 行数修正校验任务\",\"remark\":\"用于验证修复后的模板行数统计。\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createBy\":\"admin\",\"failCount\":0,\"fileName\":\"plant_basic_demo.xlsx\",\"fileUrl\":\"/profile/upload/import/2026/05/11/5874606a9428417da367a56e0b3db962.xlsx\",\"importType\":\"plant_basic\",\"params\":{},\"remark\":\"用于验证修复后的模板行数统计。\",\"resultMessage\":\"文件已上传，待执行导入。\",\"status\":\"0\",\"successCount\":0,\"taskId\":11001,\"taskName\":\"A12 行数修正校验任务\",\"totalCount\":0}}', 0, NULL, '2026-05-11 07:18:10', 8);
INSERT INTO `sys_oper_log` VALUES (105, '数据导入执行', 2, 'com.ruoyi.web.controller.plant.admin.ZxDataImportTaskController.execute()', 'POST', 1, 'admin', '研发部门', '/plant/admin/import/execute', '127.0.0.1', '内网IP', '{\"taskId\":\"11001\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 07:18:12', 5);
INSERT INTO `sys_oper_log` VALUES (106, '植物详情配置', 2, 'com.ruoyi.web.controller.plant.admin.ZxPlantDetailController.save()', 'PUT', 1, 'admin', '研发部门', '/plant/admin/plant/detail', '127.0.0.1', '内网IP', '{\"careTips\":\"保持盆土微湿，避免长期积水，适合定期擦叶。\",\"categoryName\":\"办公绿植\",\"coverImage\":\"/profile/upload/plant/1001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2026-05-11 09:45:00\",\"detailId\":1101,\"displayContent\":\"绿萝适合做基础空间绿化，覆盖面广，容错率高。\",\"growCycle\":\"四季常绿\",\"humidityRequirement\":\"中等湿度\",\"lightRequirement\":\"耐阴，适合明亮散射光\",\"params\":{},\"plantId\":1001,\"plantName\":\"绿萝\",\"remark\":\"植物详情样例\",\"riskTips\":\"汁液可能刺激宠物，宠物家庭需抬高摆放。\",\"temperatureRange\":\"18-30℃\",\"updateBy\":\"admin\",\"waterRequirement\":\"春夏 5 到 7 天一次，冬季延长\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 07:29:53', 18);
INSERT INTO `sys_oper_log` VALUES (107, '植物库', 2, 'com.ruoyi.web.controller.plant.admin.ZxPlantController.edit()', 'PUT', 1, 'admin', '研发部门', '/plant/admin/plant', '127.0.0.1', '内网IP', '{\"aliasName\":\"黄金葛\",\"aromaFlag\":\"0\",\"categoryId\":105,\"categoryName\":\"办公绿植\",\"coverImage\":\"/profile/upload/plant/1001.jpg\",\"createBy\":\"admin\",\"createTime\":\"2026-05-11 09:30:00\",\"delFlag\":\"0\",\"detailId\":1101,\"difficultyLevel\":\"1\",\"displayStatus\":\"0\",\"params\":{},\"petSafeFlag\":\"0\",\"plantCode\":\"epipremnum_aureum\",\"plantId\":1001,\"plantName\":\"绿萝\",\"plantSummary\":\"经典入门观叶植物，适合书架、边柜和办公室绿化。\",\"priceLevel\":\"1\",\"purgeEffectFlag\":\"1\",\"remark\":\"高适配率样例植物\",\"sortNum\":1,\"status\":\"0\",\"suitableScene\":\"办公室、卧室、客厅边柜\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 07:49:49', 8);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:47:55', 22);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:48:03', 5);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/cache/list\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"redis-list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":114,\"menuName\":\"缓存列表\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2,\"path\":\"cacheList\",\"perms\":\"monitor:cache:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:48:33', 4);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/cache/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"redis\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":113,\"menuName\":\"缓存监控\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2,\"path\":\"cache\",\"perms\":\"monitor:cache:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:48:36', 4);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/online/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":109,\"menuName\":\"在线用户\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"online\",\"perms\":\"monitor:online:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:18', 5);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:24', 5);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:38', 4);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:43', 4);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:50', 4);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:55', 4);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2026-05-10 19:10:07\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:49:58', 5);
INSERT INTO `sys_oper_log` VALUES (119, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"email\":\"\",\"nickName\":\"myx\",\"params\":{},\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"myx\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 18:59:42', 65);
INSERT INTO `sys_oper_log` VALUES (120, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 19:01:38', 51);
INSERT INTO `sys_oper_log` VALUES (121, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 22:22:42', 55);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-05-10 19:10:07', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-10 19:10:07', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3000, '植选管理员', 'plant_admin', 10, '1', 1, 1, '0', '0', 'admin', '2026-05-11 23:47:39', '', NULL, '植选系统业务管理员');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (3000, 2001);
INSERT INTO `sys_role_menu` VALUES (3000, 2002);
INSERT INTO `sys_role_menu` VALUES (3000, 2003);
INSERT INTO `sys_role_menu` VALUES (3000, 2004);
INSERT INTO `sys_role_menu` VALUES (3000, 2012);
INSERT INTO `sys_role_menu` VALUES (3000, 2013);
INSERT INTO `sys_role_menu` VALUES (3000, 2014);
INSERT INTO `sys_role_menu` VALUES (3000, 2015);
INSERT INTO `sys_role_menu` VALUES (3000, 2016);
INSERT INTO `sys_role_menu` VALUES (3000, 2017);
INSERT INTO `sys_role_menu` VALUES (3000, 2018);
INSERT INTO `sys_role_menu` VALUES (3000, 2019);
INSERT INTO `sys_role_menu` VALUES (3000, 2020);
INSERT INTO `sys_role_menu` VALUES (3000, 2101);
INSERT INTO `sys_role_menu` VALUES (3000, 2110);
INSERT INTO `sys_role_menu` VALUES (3000, 2111);
INSERT INTO `sys_role_menu` VALUES (3000, 2112);
INSERT INTO `sys_role_menu` VALUES (3000, 2113);
INSERT INTO `sys_role_menu` VALUES (3000, 2120);
INSERT INTO `sys_role_menu` VALUES (3000, 2121);
INSERT INTO `sys_role_menu` VALUES (3000, 2122);
INSERT INTO `sys_role_menu` VALUES (3000, 2123);
INSERT INTO `sys_role_menu` VALUES (3000, 2124);
INSERT INTO `sys_role_menu` VALUES (3000, 2125);
INSERT INTO `sys_role_menu` VALUES (3000, 2126);
INSERT INTO `sys_role_menu` VALUES (3000, 2127);
INSERT INTO `sys_role_menu` VALUES (3000, 2130);
INSERT INTO `sys_role_menu` VALUES (3000, 2131);
INSERT INTO `sys_role_menu` VALUES (3000, 2132);
INSERT INTO `sys_role_menu` VALUES (3000, 2133);
INSERT INTO `sys_role_menu` VALUES (3000, 2140);
INSERT INTO `sys_role_menu` VALUES (3000, 2141);
INSERT INTO `sys_role_menu` VALUES (3000, 2142);
INSERT INTO `sys_role_menu` VALUES (3000, 2143);
INSERT INTO `sys_role_menu` VALUES (3000, 2144);
INSERT INTO `sys_role_menu` VALUES (3000, 2150);
INSERT INTO `sys_role_menu` VALUES (3000, 2151);
INSERT INTO `sys_role_menu` VALUES (3000, 2160);
INSERT INTO `sys_role_menu` VALUES (3000, 2161);
INSERT INTO `sys_role_menu` VALUES (3000, 2162);
INSERT INTO `sys_role_menu` VALUES (3000, 2170);
INSERT INTO `sys_role_menu` VALUES (3000, 2171);
INSERT INTO `sys_role_menu` VALUES (3000, 2180);
INSERT INTO `sys_role_menu` VALUES (3000, 2181);
INSERT INTO `sys_role_menu` VALUES (3000, 2182);
INSERT INTO `sys_role_menu` VALUES (3000, 2183);
INSERT INTO `sys_role_menu` VALUES (3000, 2190);
INSERT INTO `sys_role_menu` VALUES (3000, 2191);
INSERT INTO `sys_role_menu` VALUES (3000, 2192);
INSERT INTO `sys_role_menu` VALUES (3000, 2193);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '赵骁', '00', 'zx@163.com', '15888888888', '0', '/profile/avatar/2026/05/12/3c147fc931a949e7a98d86271690598a.jpg', '$2a$10$hKWeARZ1RCFrzs4nzufla.x04uoPPOt30EVn/YoVOkYWrjs6pUPhS', '0', '0', '127.0.0.1', '2026-05-12 18:27:13', '2026-05-12 08:27:27', 'admin', '2026-05-10 19:10:07', '', '2026-05-12 08:27:27', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$aOakPFOzV19dRRB3G0HpguNrfYCaQgFRz5S2NduXq/kXDX6yWkRPS', '0', '0', '127.0.0.1', '2026-05-12 18:26:58', '2026-05-11 22:22:42', 'admin', '2026-05-10 19:10:07', '', '2026-05-11 22:22:42', '测试员');
INSERT INTO `sys_user` VALUES (100, 103, 'myx', 'myx', '00', '', '', '0', '', '$2a$10$um7ELvayG2tQZOocD2nic.V3e85OSmWxZZdxQXRpHpvdW/MVr1N4C', '0', '0', '127.0.0.1', '2026-05-12 18:05:59', '2026-05-12 08:03:54', 'admin', '2026-05-11 18:59:42', '', '2026-05-12 08:03:54', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, '赵骁', 'zx', '00', '', '', '0', '', '$2a$10$pi.oWuk.HTD7/9UelgwHXeJNx.HR282RDSpu0/pYhRhu3q9exIbB6', '0', '2', '', NULL, NULL, 'admin', '2026-05-12 08:05:54', 'admin', '2026-05-12 08:06:04', NULL);
INSERT INTO `sys_user` VALUES (102, NULL, '赵晓', 'zx', '00', '', '', '0', '', '$2a$10$Fw11x0I9hFnMFJzL3u7RPeisgm22UhX77movbeedY3sjr/0gvDva.', '0', '2', '', NULL, NULL, 'admin', '2026-05-12 08:22:49', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (103, NULL, '赵骁', 'zx_cus', '00', '', '', '0', '', '$2a$10$A7lbHy/xAMUgV56011HZYurOtj14xN3uSjW2izNo1utZ1m0uaVo6W', '0', '2', '127.0.0.1', '2026-05-12 08:25:23', NULL, 'admin', '2026-05-12 08:24:10', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (104, NULL, '赵骁-管理', 'zx_admin', '00', '', '', '0', '', '$2a$10$MkhU1g/2plCtZrC8zBQpM.QmvTe.6bppl0DWzfVbSPW8EiJQ2DY6S', '0', '2', '', NULL, NULL, 'admin', '2026-05-12 08:24:43', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (100, 4);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);

-- ----------------------------
-- Table structure for zx_content_article
-- ----------------------------
DROP TABLE IF EXISTS `zx_content_article`;
CREATE TABLE `zx_content_article`  (
  `article_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `article_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '文章类型',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '封面图',
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '摘要',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正文',
  `related_plant_id` bigint NULL DEFAULT NULL COMMENT '关联植物ID',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0发布 1草稿）',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `idx_zx_content_article_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '内容文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_content_article
-- ----------------------------
INSERT INTO `zx_content_article` VALUES (9001, 'knowledge', '北向卧室如何选第一盆绿植', '/profile/upload/article/bedroom.jpg', '围绕弱光、小空间和低养护成本，快速筛出适合卧室的新手植物。', '北向卧室的核心限制在于光照不足，因此优先选择耐阴散射光植物。若同时需要宠物友好和桌面摆放，吊兰、豆瓣绿与玉露是更稳妥的首选。', 1002, '0', 3, '2026-05-11 11:00:00', '0', 'admin', '2026-05-11 11:00:00', '', NULL, '卧室场景内容');
INSERT INTO `zx_content_article` VALUES (9002, 'knowledge', '办公室绿植 5 日养护法', '/profile/upload/article/office.jpg', '针对上班族浇水频率低的问题，给出简单可执行的办公绿植维护节奏。', '办公室绿植最怕无序浇水。可统一设定每周固定检查一次盆土状态，优先保留虎皮兰、金钱树、绿萝这类容错更高的植物。', 1013, '0', 7, '2026-05-11 11:02:00', '0', 'admin', '2026-05-11 11:02:00', '', NULL, '办公场景内容');
INSERT INTO `zx_content_article` VALUES (9003, 'knowledge', '阳台花香植物入门清单', '/profile/upload/article/balcony.jpg', '面向日照充足阳台，选择能稳定开花、香味明确的入门植物。', '阳台环境更适合茉莉花、迷迭香、薄荷这类对日照响应明显的植物。若追求花香体验，茉莉花应作为首推；若希望兼具实用属性，迷迭香和薄荷更灵活。', 1010, '0', 8, '2026-05-11 11:04:00', '0', 'admin', '2026-05-11 11:04:00', '', NULL, '阳台观花内容');
INSERT INTO `zx_content_article` VALUES (9004, 'knowledge', '猫咪家庭绿植避坑清单', '/profile/upload/article/pet.jpg', '总结宠物家庭选植物时最常见的误区和替代方案。', '宠物家庭优先排除汁液刺激性明显的植物，像白掌、龟背竹、常春藤都不建议放在低位可触达区域。吊兰、袖珍椰子、散尾葵更适合作为客厅和卧室的安全方案。', 1020, '0', 6, '2026-05-11 11:06:00', '0', 'admin', '2026-05-11 11:06:00', '', NULL, '宠物家庭内容');
INSERT INTO `zx_content_article` VALUES (9005, 'knowledge', '低光办公室别只盯绿萝', '/profile/upload/article/office-lowlight.jpg', '办公室弱光工位也能有层次感，不必长期只靠绿萝支撑。', '低光办公室除了绿萝，还可以考虑金钱树、虎皮兰和袖珍椰子。前两者更偏省心，后者更偏舒展叶态，三者组合能显著提升推荐多样性。', 1013, '0', 2, '2026-05-11 11:08:00', '0', 'admin', '2026-05-11 11:08:00', '', NULL, '低光办公内容');
INSERT INTO `zx_content_article` VALUES (9006, 'knowledge', '客厅大叶植物陈设的 3 个层次位', '/profile/upload/article/living.jpg', '主景、过渡位和边角位三层布局，解决客厅大叶植物只剩一棵的单调感。', '客厅大叶植物不要只放一棵。可用龟背竹做主景，琴叶榕承担高体量焦点，橡皮树或散尾葵负责第二层次，这样空间会更完整。', 1018, '0', 1, '2026-05-11 11:10:00', '0', 'admin', '2026-05-11 11:10:00', '', NULL, '客厅陈设内容');
INSERT INTO `zx_content_article` VALUES (9007, 'knowledge', '桌面小体量植物组合指南', '/profile/upload/article/desktop.jpg', '针对书桌、床头柜和办公位，提供更稳定的小体量植物搭配思路。', '桌面植物优先看体量、维护节奏和视线舒适度。豆瓣绿、玉露、文竹各自对应低预算、低维护和氛围感三种不同诉求，能覆盖多数桌面演示场景。', 1015, '0', 5, '2026-05-11 11:12:00', '0', 'admin', '2026-05-11 11:12:00', '', NULL, '桌面组合内容');
INSERT INTO `zx_content_article` VALUES (9008, 'knowledge', '迷迭香、茉莉和薄荷怎么选', '/profile/upload/article/aroma.jpg', '把闻香观花需求拆成花香、草本香和日常取用三条路线。', '如果核心诉求是明显花香，优先选择茉莉花；如果希望兼顾香草料理，迷迭香更稳；若想要维护轻松、香味清爽，薄荷是最容易落地的备选。', 1017, '0', 4, '2026-05-11 11:14:00', '0', 'admin', '2026-05-11 11:14:00', '', NULL, '闻香场景内容');

-- ----------------------------
-- Table structure for zx_data_import_task
-- ----------------------------
DROP TABLE IF EXISTS `zx_data_import_task`;
CREATE TABLE `zx_data_import_task`  (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `import_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '导入类型',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '文件名',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '文件地址',
  `total_count` int NULL DEFAULT 0 COMMENT '总数',
  `success_count` int NULL DEFAULT 0 COMMENT '成功数',
  `fail_count` int NULL DEFAULT 0 COMMENT '失败数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待处理 1处理中 2已完成 3失败）',
  `result_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '结果信息',
  `execute_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `idx_zx_data_import_task_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '数据导入任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_data_import_task
-- ----------------------------
INSERT INTO `zx_data_import_task` VALUES (9501, '首批植物主数据导入', 'plant_basic', 'plant_basic_demo.xlsx', '/profile/upload/import/plant_basic_demo.xlsx', 47, 47, 0, '2', '????? 47 ????????', '2026-05-11 11:16:00', 'admin', '2026-05-11 11:08:00', '', NULL, '植物基础样例导入');
INSERT INTO `zx_data_import_task` VALUES (9502, '标签字典初始化导入', 'tag_basic', 'plant_tag_demo.xlsx', '/profile/upload/import/plant_tag_demo.xlsx', 27, 27, 0, '2', '标签字典 27 条全部导入成功。', '2026-05-11 11:18:00', 'admin', '2026-05-11 11:09:00', '', NULL, '标签样例导入');

-- ----------------------------
-- Table structure for zx_favorite_record
-- ----------------------------
DROP TABLE IF EXISTS `zx_favorite_record`;
CREATE TABLE `zx_favorite_record`  (
  `favorite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `visitor_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客UID',
  `plant_id` bigint NOT NULL COMMENT '植物ID',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0收藏 1取消）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`favorite_id`) USING BTREE,
  INDEX `idx_zx_favorite_record_visitor`(`visitor_uid` ASC) USING BTREE,
  INDEX `idx_zx_favorite_record_plant`(`plant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9005 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收藏记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_favorite_record
-- ----------------------------
INSERT INTO `zx_favorite_record` VALUES (8001, 'guest_demo_001', 1002, '0', '2026-05-11 11:05:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8002, 'guest_demo_002', 1004, '0', '2026-05-11 11:06:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8003, 'guest_demo_003', 1010, '0', '2026-05-11 11:07:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8004, 'guest_demo_004', 1013, '0', '2026-05-11 11:08:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8005, 'guest_demo_005', 1015, '0', '2026-05-11 11:09:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8006, 'guest_demo_006', 1020, '0', '2026-05-11 11:10:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8007, 'guest_demo_007', 1019, '0', '2026-05-11 11:11:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (8008, 'guest_demo_008', 1018, '0', '2026-05-11 11:12:00', NULL);
INSERT INTO `zx_favorite_record` VALUES (9000, 'visitor-1778516453912', 1002, '0', '2026-05-12 00:45:28', NULL);
INSERT INTO `zx_favorite_record` VALUES (9001, 'visitor-1778534212272', 1013, '0', '2026-05-12 05:45:01', NULL);
INSERT INTO `zx_favorite_record` VALUES (9002, 'visitor-1778534212272', 1004, '0', '2026-05-12 07:57:02', NULL);
INSERT INTO `zx_favorite_record` VALUES (9003, 'visitor-1778509390737', 1015, '0', '2026-05-12 18:14:06', NULL);
INSERT INTO `zx_favorite_record` VALUES (9004, 'visitor-1778509390737', 1043, '0', '2026-05-12 18:14:09', NULL);

-- ----------------------------
-- Table structure for zx_feedback_record
-- ----------------------------
DROP TABLE IF EXISTS `zx_feedback_record`;
CREATE TABLE `zx_feedback_record`  (
  `feedback_id` bigint NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `visitor_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客UID',
  `record_id` bigint NULL DEFAULT NULL COMMENT '推荐记录ID',
  `plant_id` bigint NULL DEFAULT NULL COMMENT '植物ID',
  `feedback_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '反馈类型（1喜欢 2不喜欢）',
  `feedback_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '反馈原因',
  `extra_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '附加说明',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`feedback_id`) USING BTREE,
  INDEX `idx_zx_feedback_record_visitor`(`visitor_uid` ASC) USING BTREE,
  INDEX `idx_zx_feedback_record_record`(`record_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '反馈记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_feedback_record
-- ----------------------------
INSERT INTO `zx_feedback_record` VALUES (7001, 'guest_demo_001', 5001, 1002, '1', '宠物友好且体量合适', '放在卧室边柜刚好，不担心猫咪误碰。', '2026-05-11 10:55:00');
INSERT INTO `zx_feedback_record` VALUES (7002, 'guest_demo_002', 5002, 1004, '1', '陈设感够强', '客厅第一眼就能看到，氛围符合预期。', '2026-05-11 10:56:00');
INSERT INTO `zx_feedback_record` VALUES (7003, 'guest_demo_003', 5003, 1010, '1', '花香明显', '想要的就是阳台闻香体验，开花预期符合。', '2026-05-11 10:57:00');
INSERT INTO `zx_feedback_record` VALUES (7004, 'guest_demo_004', 5004, 1013, '1', '维护省心', '一周检查一次就够，适合办公节奏。', '2026-05-11 10:58:00');
INSERT INTO `zx_feedback_record` VALUES (7005, 'guest_demo_005', 5005, 1015, '1', '桌面尺寸合适', '不压空间，预算也能接受。', '2026-05-11 10:59:00');
INSERT INTO `zx_feedback_record` VALUES (7006, 'guest_demo_006', 5006, 1020, '1', '宠物家庭更安心', '放客厅也不用担心狗狗误碰。', '2026-05-11 11:00:00');
INSERT INTO `zx_feedback_record` VALUES (7007, 'guest_demo_007', 5007, 1019, '1', '氛围柔和', '叶面纹理很治愈，适合卧室。', '2026-05-11 11:01:00');
INSERT INTO `zx_feedback_record` VALUES (7008, 'guest_demo_008', 5008, 1018, '2', '需要更稳定光位', '主景效果很好，但后续要保证位置不频繁变动。', '2026-05-11 11:02:00');
INSERT INTO `zx_feedback_record` VALUES (8000, 'visitor-1778534212272', 6015, 1040, '1', '1', '1', '2026-05-12 07:57:52');

-- ----------------------------
-- Table structure for zx_plant
-- ----------------------------
DROP TABLE IF EXISTS `zx_plant`;
CREATE TABLE `zx_plant`  (
  `plant_id` bigint NOT NULL AUTO_INCREMENT COMMENT '植物ID',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类ID',
  `plant_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '植物名称',
  `plant_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '植物编码',
  `alias_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '别名',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '封面图',
  `plant_summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '植物简介',
  `difficulty_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '养护难度（1低 2中 3高）',
  `price_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '价格级别（1低 2中 3高）',
  `display_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '展示状态（0上架 1下架）',
  `pet_safe_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '宠物友好（0否 1是）',
  `purge_effect_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '净化能力（0否 1是）',
  `aroma_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '芳香属性（0否 1是）',
  `suitable_scene` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '适用场景',
  `sort_num` int NULL DEFAULT 0 COMMENT '排序号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`plant_id`) USING BTREE,
  INDEX `idx_zx_plant_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_zx_plant_status`(`status` ASC) USING BTREE,
  INDEX `idx_zx_plant_display`(`display_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '植物主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_plant
-- ----------------------------
INSERT INTO `zx_plant` VALUES (1001, 105, '绿萝', 'epipremnum_aureum', '黄金葛', '/profile/upload/plant/1001.jpg', '经典入门观叶植物，适合书架、边柜和办公室绿化。', '1', '1', '0', '0', '1', '0', '办公室、卧室、客厅边柜', 10, '0', '0', 'admin', '2026-05-11 09:30:00', '', NULL, '高适配率样例植物');
INSERT INTO `zx_plant` VALUES (1002, 101, '吊兰', 'chlorophytum_comosum', '折鹤兰', '/profile/upload/plant/1002.jpg', '叶片轻盈舒展，桌面和高柜都容易形成层次感。', '1', '1', '0', '1', '1', '0', '书桌、窗台、办公室工位', 3, '0', '0', 'admin', '2026-05-11 09:31:00', '', NULL, '宠物友好样例植物');
INSERT INTO `zx_plant` VALUES (1003, 105, '虎皮兰', 'sansevieria_trifasciata', '虎尾兰', '/profile/upload/plant/1003.jpg', '耐旱省心，适合工作日无暇频繁养护的办公与居家空间。', '1', '1', '0', '0', '1', '0', '办公室、玄关、卧室角落', 7, '0', '0', 'admin', '2026-05-11 09:32:00', '', NULL, '耐旱场景样例植物');
INSERT INTO `zx_plant` VALUES (1004, 102, '龟背竹', 'monstera_deliciosa', '蓬莱蕉', '/profile/upload/plant/1004.jpg', '大叶型观叶植物，适合打造客厅和会客区的陈设感。', '2', '2', '0', '0', '1', '0', '客厅落地、会客区、休闲角', 1, '0', '0', 'admin', '2026-05-11 09:33:00', '', NULL, '大空间氛围植物');
INSERT INTO `zx_plant` VALUES (1005, 102, '发财树', 'pachira_macrocarpa', '瓜栗', '/profile/upload/plant/1005.jpg', '树形端正稳定，是客厅和办公室常见的中大型绿植。', '1', '2', '0', '0', '0', '0', '客厅、前台、办公室角落', 15, '0', '0', 'admin', '2026-05-11 09:34:00', '', NULL, '传统室内绿植');
INSERT INTO `zx_plant` VALUES (1006, 100, '白掌', 'spathiphyllum_kochii', '一帆风顺', '/profile/upload/plant/1006.jpg', '兼具观叶和观花属性，适合半阴环境的室内摆放。', '2', '2', '0', '0', '1', '0', '卧室边柜、书房、客厅内侧', 13, '0', '0', 'admin', '2026-05-11 09:35:00', '', NULL, '观花净化类植物');
INSERT INTO `zx_plant` VALUES (1007, 100, '常春藤', 'hedera_helix', '洋常春藤', '/profile/upload/plant/1007.jpg', '枝条柔软，适合高处垂吊或壁架延展布置。', '2', '1', '0', '0', '1', '0', '阳台层架、书柜顶部、壁架', 19, '0', '0', 'admin', '2026-05-11 09:36:00', '', NULL, '垂吊类样例植物');
INSERT INTO `zx_plant` VALUES (1008, 102, '橡皮树', 'ficus_elastica', '印度榕', '/profile/upload/plant/1008.jpg', '叶片厚实有质感，适合现代风客厅或办公空间。', '2', '2', '0', '0', '1', '0', '客厅、会议室、前台', 11, '0', '0', 'admin', '2026-05-11 09:37:00', '', NULL, '稳重陈设类植物');
INSERT INTO `zx_plant` VALUES (1009, 101, '文竹', 'asparagus_setaceus', '云片松', '/profile/upload/plant/1009.jpg', '形态轻盈细腻，适合书桌、茶台等近距离观赏场景。', '2', '1', '0', '0', '0', '0', '书桌、茶台、卧室斗柜', 20, '0', '0', 'admin', '2026-05-11 09:38:00', '', NULL, '小型观赏植物');
INSERT INTO `zx_plant` VALUES (1010, 103, '茉莉花', 'jasminum_sambac', '茉莉', '/profile/upload/plant/1010.jpg', '日照充足时花香明显，适合阳台观花与闻香体验。', '3', '2', '0', '0', '0', '1', '南向阳台、露台、窗边', 5, '0', '0', 'admin', '2026-05-11 09:39:00', '', NULL, '高光观花样例植物');
INSERT INTO `zx_plant` VALUES (1011, 104, '薄荷', 'mentha_haplocalyx', '薄荷草', '/profile/upload/plant/1011.jpg', '生长快、香味清爽，兼具观赏和日常取用属性。', '1', '1', '0', '1', '0', '1', '厨房窗边、阳台、办公桌', 16, '0', '0', 'admin', '2026-05-11 09:40:00', '', NULL, '香草植物样例');
INSERT INTO `zx_plant` VALUES (1012, 101, '玉露', 'haworthia_cooperi', '冰灯玉露', '/profile/upload/plant/1012.jpg', '小巧通透，适合桌面和窗边的小体量展示。', '1', '2', '0', '1', '0', '0', '书桌、办公桌、窗台', 17, '0', '0', 'admin', '2026-05-11 09:41:00', '', NULL, '桌面多肉样例植物');
INSERT INTO `zx_plant` VALUES (1013, 105, '金钱树', 'zamioculcas_zamiifolia', '雪铁芋', '/profile/upload/plant/1013.jpg', '耐阴耐旱，适合低光办公位和低频养护场景。', '1', '2', '0', '0', '1', '0', '办公室、会议室、客厅角落', 2, '0', '0', 'admin', '2026-05-11 09:42:00', '', NULL, '低光办公样例植物');
INSERT INTO `zx_plant` VALUES (1014, 105, '袖珍椰子', 'chamaedorea_elegans', '袖珍棕', '/profile/upload/plant/1014.jpg', '羽状叶片轻盈，宠物家庭和办公休闲角都容易融入。', '1', '2', '0', '1', '1', '0', '客厅边几、办公室休闲角、卧室窗边', 14, '0', '0', 'admin', '2026-05-11 09:43:00', '', NULL, '宠物友好中体量植物');
INSERT INTO `zx_plant` VALUES (1015, 101, '豆瓣绿', 'peperomia_obtusifolia', '碧玉椒草', '/profile/upload/plant/1015.jpg', '叶片圆润紧凑，适合桌面、小边柜和新手第一盆。', '1', '1', '0', '1', '0', '0', '书桌、床头柜、卧室边柜', 6, '0', '0', 'admin', '2026-05-11 09:44:00', '', NULL, '小空间新手样例植物');
INSERT INTO `zx_plant` VALUES (1016, 102, '鸟巢蕨', 'asplenium_nidus', '巢蕨', '/profile/upload/plant/1016.jpg', '叶片层层展开，适合半阴环境和治愈型角落布置。', '2', '2', '0', '1', '1', '0', '卧室边柜、客厅内侧、玄关', 18, '0', '0', 'admin', '2026-05-11 09:45:00', '', NULL, '治愈风中体量植物');
INSERT INTO `zx_plant` VALUES (1017, 104, '迷迭香', 'rosmarinus_officinalis', '迷迭香草', '/profile/upload/plant/1017.jpg', '日照充足时香味稳定，适合阳台与厨房窗边的香草体验。', '2', '2', '0', '1', '0', '1', '南向阳台、厨房窗边、露台', 12, '0', '0', 'admin', '2026-05-11 09:46:00', '', NULL, '阳台闻香样例植物');
INSERT INTO `zx_plant` VALUES (1018, 102, '琴叶榕', 'ficus_lyrata', 'Fiddle Leaf Fig', '/profile/upload/plant/1018.jpg', '大叶立体感强，适合客厅落地和高预算陈设场景。', '2', '3', '0', '0', '1', '0', '客厅落地、会客区、前台', 4, '0', '0', 'admin', '2026-05-11 09:47:00', '', NULL, '高预算陈设样例植物');
INSERT INTO `zx_plant` VALUES (1019, 101, '孔雀竹芋', 'calathea_makoyana', '竹芋', '/profile/upload/plant/1019.jpg', '叶纹明显、观感柔和，适合卧室和书房的治愈型陈列。', '2', '2', '0', '1', '0', '0', '卧室斗柜、书房、客厅边几', 8, '0', '0', 'admin', '2026-05-11 09:48:00', '', NULL, '卧室治愈样例植物');
INSERT INTO `zx_plant` VALUES (1020, 102, '散尾葵', 'dypsis_lutescens', '黄椰子', '/profile/upload/plant/1020.jpg', '株型舒展、体量适中，适合宠物家庭客厅和休闲区。', '1', '2', '0', '1', '1', '0', '客厅、休闲区、办公室会客位', 9, '0', '0', 'admin', '2026-05-11 09:49:00', '', NULL, '宠物家庭客厅样例植物');
INSERT INTO `zx_plant` VALUES (1021, 105, '富贵竹', 'dracaena_sanderiana', '开运竹', '/profile/upload/plant/1021.jpg', '茎杆挺拔、线条干净，适合办公室和玄关做轻量陈列。', '1', '1', '0', '0', '1', '0', '办公室、前台、书房边柜', 21, '0', '0', 'admin', '2026-05-11 09:50:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1022, 100, '鹿角蕨', 'platycerium_bifurcatum', '蝙蝠蕨', '/profile/upload/plant/1022.jpg', '叶型立体有雕塑感，适合墙面或立体热带陈设。', '2', '3', '0', '1', '0', '0', '客厅墙面、书房立架、会客区', 22, '0', '0', 'admin', '2026-05-11 09:51:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1023, 100, '合果芋', 'syngonium_podophyllum', '箭叶藤', '/profile/upload/plant/1023.jpg', '叶型柔和，可垂落也可攀援，适合做空间层次补位。', '1', '1', '0', '0', '0', '0', '书架、边柜、高柜侧边', 23, '0', '0', 'admin', '2026-05-11 09:52:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1024, 101, '冷水花', 'pilea_cadierei', '铝叶草', '/profile/upload/plant/1024.jpg', '银纹叶面细腻，适合书桌和窗边的小体量展示。', '1', '1', '0', '0', '0', '0', '书桌、窗台、卧室边柜', 24, '0', '0', 'admin', '2026-05-11 09:53:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1025, 101, '姬龟背竹', 'monstera_adansonii', '窗孔龟背竹', '/profile/upload/plant/1025.jpg', '热带叶片轻盈，适合小空间做垂吊或攀援展示。', '2', '2', '0', '0', '0', '0', '高柜、壁架、书房窗边', 25, '0', '0', 'admin', '2026-05-11 09:54:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1026, 101, '芦荟', 'aloe_vera', '库拉索芦荟', '/profile/upload/plant/1026.jpg', '耐旱省心，适合高光窗台和低维护桌面场景。', '1', '1', '0', '0', '0', '0', '窗台、书桌、阳台边柜', 26, '0', '0', 'admin', '2026-05-11 09:55:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1027, 101, '铜钱草', 'hydrocotyle_vulgaris', '金钱莲', '/profile/upload/plant/1027.jpg', '叶片圆润明快，适合窗边和桌面做治愈型点缀。', '1', '1', '0', '1', '0', '0', '窗边、书桌、餐桌小景', 27, '0', '0', 'admin', '2026-05-11 09:56:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1028, 103, '长寿花', 'kalanchoe_blossfeldiana', '圣诞伽蓝菜', '/profile/upload/plant/1028.jpg', '花期较长，适合阳台和窗边做持续观花展示。', '2', '1', '0', '0', '0', '0', '南向窗边、阳台花架', 28, '0', '0', 'admin', '2026-05-11 09:57:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1029, 103, '四季海棠', 'begonia_semperflorens', '蜡叶海棠', '/profile/upload/plant/1029.jpg', '花量稳定、颜色丰富，适合高光窗边和小花盆组合。', '2', '1', '0', '0', '0', '0', '窗边、阳台、茶几小景', 29, '0', '0', 'admin', '2026-05-11 09:58:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1030, 103, '天竺葵', 'pelargonium_hortorum', '洋绣球', '/profile/upload/plant/1030.jpg', '开花鲜明且叶片带香，适合阳台观花与香叶体验。', '2', '2', '0', '0', '0', '1', '阳台花箱、南向窗边', 30, '0', '0', 'admin', '2026-05-11 09:59:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1031, 100, '口红吊兰', 'aeschynanthus_radicans', '花蔓草', '/profile/upload/plant/1031.jpg', '垂吊枝条自然下垂，适合高柜和吊盆营造层次。', '2', '2', '0', '1', '0', '0', '高柜、吊盆、书架顶部', 31, '0', '0', 'admin', '2026-05-11 10:00:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1032, 100, '球兰', 'hoya_carnosa', '蜡兰', '/profile/upload/plant/1032.jpg', '叶片厚实，花序精巧，适合窗边和高柜做轻香垂吊展示。', '2', '2', '0', '1', '0', '0', '窗边、高柜、壁架', 32, '0', '0', 'admin', '2026-05-11 10:01:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1033, 101, '空气凤梨', 'tillandsia_ionantha', '铁兰', '/profile/upload/plant/1033.jpg', '无需土壤即可展示，适合创意桌面和小架子陈列。', '2', '2', '0', '1', '0', '0', '书桌、小架子、工作台', 33, '0', '0', 'admin', '2026-05-11 10:02:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1034, 101, '网纹草', 'fittonia_albivenis', '费道花', '/profile/upload/plant/1034.jpg', '叶脉细密柔和，适合卧室和书桌做治愈型近景。', '2', '1', '0', '1', '0', '0', '书桌、卧室边柜、窗边', 34, '0', '0', 'admin', '2026-05-11 10:03:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1035, 101, '铁线蕨', 'adiantum_raddianum', '少女的发丝', '/profile/upload/plant/1035.jpg', '羽片轻柔细碎，适合湿润柔和的窗边和案头。', '3', '1', '0', '1', '0', '0', '窗边、书桌、浴室外侧', 35, '0', '0', 'admin', '2026-05-11 10:04:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1036, 105, '龙血树', 'dracaena_marginata', '红边龙血树', '/profile/upload/plant/1036.jpg', '株型挺拔利落，适合办公室和现代风空间做竖向线条。', '1', '2', '0', '0', '1', '0', '办公室、会议室、客厅角落', 36, '0', '0', 'admin', '2026-05-11 10:05:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1037, 105, '巴西木', 'dracaena_fragrans', '香龙血树', '/profile/upload/plant/1037.jpg', '低光适应度高，适合办公室和前台做稳定绿化。', '1', '2', '0', '0', '1', '0', '前台、会议室、办公室边角', 37, '0', '0', 'admin', '2026-05-11 10:06:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1038, 102, '春羽', 'philodendron_selloum', '春芋', '/profile/upload/plant/1038.jpg', '叶片舒展有体量，适合客厅和休闲区做热带主景。', '2', '2', '0', '0', '0', '0', '客厅落地、休闲区、会客区', 38, '0', '0', 'admin', '2026-05-11 10:07:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1039, 102, '绿宝石喜林芋', 'philodendron_erubescens_green', '绿宝石', '/profile/upload/plant/1039.jpg', '叶色油润、姿态舒展，适合低光客厅和门厅过渡位。', '1', '2', '0', '0', '0', '0', '客厅边角、门厅、书房落地位', 39, '0', '0', 'admin', '2026-05-11 10:08:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1040, 102, '酒瓶兰', 'beaucarnea_recurvata', '象腿树', '/profile/upload/plant/1040.jpg', '基部膨大、造型雕塑感强，适合玄关和客厅做主景陈设。', '1', '3', '0', '1', '0', '0', '玄关、客厅落地、会客区', 40, '0', '0', 'admin', '2026-05-11 10:09:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1041, 103, '栀子花', 'gardenia_jasminoides', '栀子', '/profile/upload/plant/1041.jpg', '花香浓郁，适合高光窗边和阳台做闻香型主角。', '3', '2', '0', '0', '0', '1', '阳台、南向窗边、露台', 41, '0', '0', 'admin', '2026-05-11 10:10:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1042, 103, '薰衣草', 'lavandula_angustifolia', '香水植物', '/profile/upload/plant/1042.jpg', '草本香气明显，适合高光阳台和窗边的轻香氛围。', '2', '2', '0', '0', '0', '1', '阳台、南窗、露台', 42, '0', '0', 'admin', '2026-05-11 10:11:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1043, 104, '百里香', 'thymus_vulgaris', '香百里', '/profile/upload/plant/1043.jpg', '叶片细密、香味清爽，适合料理香草与小盆栽组合。', '1', '1', '0', '1', '0', '1', '厨房窗边、阳台、餐边柜', 43, '0', '0', 'admin', '2026-05-11 10:12:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1044, 104, '罗勒', 'ocimum_basilicum', '九层塔', '/profile/upload/plant/1044.jpg', '长势快、可反复采收，适合窗边和厨房做食用香草。', '2', '1', '0', '1', '0', '1', '厨房窗边、阳台、餐厨台面', 44, '0', '0', 'admin', '2026-05-11 10:13:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1045, 104, '柠檬香蜂草', 'melissa_officinalis', '香蜂草', '/profile/upload/plant/1045.jpg', '香味清新柔和，适合阳台和窗边做草本香氛与轻食搭配。', '1', '1', '0', '1', '0', '1', '阳台、厨房窗边、书房窗台', 45, '0', '0', 'admin', '2026-05-11 10:14:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1046, 101, '非洲堇', 'saintpaulia_ionantha', '圣保罗花', '/profile/upload/plant/1046.jpg', '花朵紧凑、体量小巧，适合室内窗边和小桌面开花展示。', '2', '1', '0', '1', '0', '0', '书桌、窗边、茶几小景', 46, '0', '0', 'admin', '2026-05-11 10:15:00', '', NULL, '扩充植物库样例');
INSERT INTO `zx_plant` VALUES (1047, 105, '银皇后', 'aglaonema_commutatum', '广东万年青', '/profile/upload/plant/1047.jpg', '耐弱光、叶面明亮，适合办公室和玄关做净化型绿化。', '1', '2', '0', '0', '1', '0', '办公室、玄关、走廊端景', 47, '0', '0', 'admin', '2026-05-11 10:16:00', '', NULL, '扩充植物库样例');

-- ----------------------------
-- Table structure for zx_plant_category
-- ----------------------------
DROP TABLE IF EXISTS `zx_plant_category`;
CREATE TABLE `zx_plant_category`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类ID',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `category_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '分类编码',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_zx_plant_category_parent`(`parent_id` ASC) USING BTREE,
  INDEX `idx_zx_plant_category_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '植物分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_plant_category
-- ----------------------------
INSERT INTO `zx_plant_category` VALUES (100, 0, '0', '室内植物', 'indoor', 1, '0', '0', 'admin', '2026-05-11 09:00:00', '', NULL, '室内绿植总分类');
INSERT INTO `zx_plant_category` VALUES (101, 100, '0,100', '桌面小型', 'desktop_small', 1, '0', '0', 'admin', '2026-05-11 09:01:00', '', NULL, '适合书桌和边柜摆放');
INSERT INTO `zx_plant_category` VALUES (102, 100, '0,100', '客厅落地', 'living_floor', 2, '0', '0', 'admin', '2026-05-11 09:02:00', '', NULL, '适合客厅和会客区摆放');
INSERT INTO `zx_plant_category` VALUES (103, 0, '0', '阳台花卉', 'balcony_flower', 2, '0', '0', 'admin', '2026-05-11 09:03:00', '', NULL, '适合有充足光照的阳台');
INSERT INTO `zx_plant_category` VALUES (104, 0, '0', '香草食用', 'herb_edible', 3, '0', '0', 'admin', '2026-05-11 09:04:00', '', NULL, '兼具气味和食用属性');
INSERT INTO `zx_plant_category` VALUES (105, 100, '0,100', '办公绿植', 'office_green', 3, '0', '0', 'admin', '2026-05-11 09:05:00', '', NULL, '适合办公区和会议室');

-- ----------------------------
-- Table structure for zx_plant_detail
-- ----------------------------
DROP TABLE IF EXISTS `zx_plant_detail`;
CREATE TABLE `zx_plant_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `plant_id` bigint NOT NULL COMMENT '植物ID',
  `light_requirement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '光照要求',
  `water_requirement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浇水频率',
  `temperature_range` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '适温范围',
  `humidity_requirement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '湿度要求',
  `grow_cycle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '生长周期',
  `care_tips` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '养护建议',
  `risk_tips` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '风险提示',
  `display_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '展示内容',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`detail_id`) USING BTREE,
  UNIQUE INDEX `uk_zx_plant_detail_plant`(`plant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '植物详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_plant_detail
-- ----------------------------
INSERT INTO `zx_plant_detail` VALUES (1101, 1001, '耐阴，适合明亮散射光', '春夏 5 到 7 天一次，冬季延长', '18-30℃', '中等湿度', '四季常绿', '保持盆土微湿，避免长期积水，适合定期擦叶。', '汁液可能刺激宠物，宠物家庭需抬高摆放。', '绿萝适合做基础空间绿化，覆盖面广，容错率高。', 'admin', '2026-05-11 09:45:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1102, 1002, '弱光到明亮散射光均可', '5 到 7 天一次', '15-28℃', '中等湿度', '生长较快', '保持通风和散射光，可定期修剪老叶。', '无明显宠物刺激风险，但仍需避免啃食。', '吊兰适合小空间和宠物家庭，兼具舒展观感。', 'admin', '2026-05-11 09:45:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1103, 1003, '中低光照可存活，明亮环境更佳', '10 到 15 天一次', '16-30℃', '普通湿度即可', '四季稳定', '宁干勿湿，适合懒人养护。', '叶尖发软通常与过浇有关。', '虎皮兰适合办公环境和低维护需求用户。', 'admin', '2026-05-11 09:46:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1104, 1004, '明亮散射光', '4 到 6 天一次', '20-30℃', '偏高湿度', '旺盛生长期在春夏', '叶片较大，需保持通风和适度喷雾。', '宠物误食有风险，不建议低位摆放。', '龟背竹适合营造客厅氛围，是大空间推荐重点。', 'admin', '2026-05-11 09:46:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1105, 1005, '明亮散射光', '7 到 10 天一次', '18-30℃', '普通湿度', '生长稳定', '避免频繁搬动，注意盆土排水。', '低温和积水易导致黄叶。', '发财树适合客厅和办公场景，树形稳定。', 'admin', '2026-05-11 09:47:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1106, 1006, '半阴环境更佳', '4 到 6 天一次', '18-28℃', '偏高湿度', '春夏生长明显', '保持空气流通，避免烈日暴晒。', '宠物家庭需注意误食风险。', '白掌兼具观花和净化属性，适合半阴室内场景。', 'admin', '2026-05-11 09:47:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1107, 1007, '明亮散射光', '4 到 6 天一次', '15-25℃', '较高湿度', '春秋生长较快', '适合高处垂吊，注意定期修枝。', '对宠物和儿童需避免直接接触。', '常春藤适合营造垂吊层次感。', 'admin', '2026-05-11 09:48:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1108, 1008, '明亮散射光到短时日照', '6 到 8 天一次', '18-30℃', '中等湿度', '四季可养', '叶片易积灰，建议定期擦叶。', '宠物家庭建议抬高摆放。', '橡皮树叶面质感强，适合现代风空间。', 'admin', '2026-05-11 09:48:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1109, 1009, '明亮散射光', '4 到 6 天一次', '15-26℃', '中等偏高湿度', '春秋较旺', '忌长期强光直射，适合精致摆台。', '空气过干容易黄枝。', '文竹适合近距离观赏，偏书卷气氛围。', 'admin', '2026-05-11 09:49:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1110, 1010, '充足日照', '2 到 4 天一次', '20-32℃', '中高湿度', '花期明显', '日照不足会影响开花，需及时修剪残花。', '冬季低温和积水会明显伤根。', '茉莉花适合阳台观花闻香，是高光场景首推。', 'admin', '2026-05-11 09:49:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1111, 1011, '充足日照到明亮散射光', '2 到 4 天一次', '15-30℃', '中等湿度', '生长快，可持续采收', '勤剪可促进分枝，适合小盆连续养护。', '长期阴暗会徒长并减弱香味。', '薄荷兼具香味和实用属性，适合阳台和厨房窗边。', 'admin', '2026-05-11 09:50:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1112, 1012, '明亮散射光，避免暴晒', '7 到 10 天一次', '10-28℃', '偏干环境', '生长较慢', '浇水宁少勿多，保持盆土疏松。', '积水容易烂根。', '玉露适合桌面展示，小空间视觉精致。', 'admin', '2026-05-11 09:50:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1113, 1013, '弱光到明亮散射光均可', '10 到 14 天一次', '18-30℃', '普通湿度即可', '四季稳定', '土壤干透后再浇，适合低频维护。', '过浇容易黄叶和烂根。', '金钱树适合低光办公和会议室角落，是办公场景常驻候选。', 'admin', '2026-05-11 09:51:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1114, 1014, '半阴到明亮散射光', '5 到 7 天一次', '18-30℃', '中等湿度', '全年可养', '避开直射暴晒，保持盆土微湿即可。', '空调直吹容易干尖。', '袖珍椰子适合宠物家庭和中等体量室内陈列。', 'admin', '2026-05-11 09:51:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1115, 1015, '半阴到明亮散射光', '5 到 7 天一次', '18-28℃', '中等湿度', '四季缓慢生长', '避免盆土长期积水，适合桌面稳定养护。', '冬季低温时要减少浇水。', '豆瓣绿体量紧凑，适合桌面和床头柜。', 'admin', '2026-05-11 09:52:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1116, 1016, '半阴环境更佳', '4 到 6 天一次', '18-28℃', '偏高湿度', '春夏生长较快', '保持空气流通，可偶尔喷雾增湿。', '空气过干时叶缘容易焦边。', '鸟巢蕨适合卧室与玄关的治愈风角落。', 'admin', '2026-05-11 09:52:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1117, 1017, '充足日照', '4 到 6 天一次', '12-28℃', '中等湿度', '春秋生长明显', '保持日照和通风，修剪后更易分枝。', '长期积水会明显影响根系健康。', '迷迭香适合阳台闻香，也能兼顾厨房香草使用。', 'admin', '2026-05-11 09:53:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1118, 1018, '明亮散射光', '5 到 7 天一次', '18-30℃', '中等湿度', '春夏长势更快', '叶片需要稳定光照，避免频繁换位。', '宠物误食有风险，不建议低位摆放。', '琴叶榕适合作为客厅和会客区的主景植物。', 'admin', '2026-05-11 09:53:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1119, 1019, '弱光到明亮散射光', '4 到 6 天一次', '18-28℃', '偏高湿度', '全年可养', '避免暴晒，保持基质湿润但不过湿。', '空气太干会影响叶面状态。', '孔雀竹芋叶纹柔和，适合卧室和书房的治愈型展示。', 'admin', '2026-05-11 09:54:00', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1120, 1020, '明亮散射光', '5 到 7 天一次', '18-30℃', '中等偏高湿度', '生长较快', '定期转盆有助于株型均衡展开。', '长期阴暗会导致株型散乱。', '散尾葵适合宠物家庭客厅，是安全型大空间候选。', 'admin', '2026-05-11 09:54:30', '', NULL, '植物详情样例');
INSERT INTO `zx_plant_detail` VALUES (1121, 1021, '明亮散射光到半阴', '5 到 7 天一次', '18-30℃', '中等湿度', '全年缓慢生长', '水培时定期换水，土培时保持基质微湿即可。', '长期低温或水质变差容易黄叶。', '富贵竹适合办公室和玄关做简洁陈列。', 'admin', '2026-05-11 09:55:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1122, 1022, '明亮散射光', '4 到 6 天一次', '16-28℃', '较高湿度', '春夏长势更快', '适合板植或挂墙展示，注意通风和增湿。', '闷热不通风时叶面容易失去光泽。', '鹿角蕨适合做墙面或立体陈设，强化热带氛围。', 'admin', '2026-05-11 09:55:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1123, 1023, '半阴到明亮散射光', '5 到 7 天一次', '18-30℃', '中等湿度', '生长较快', '枝蔓可引导上爬或下垂，盆土不宜久湿。', '汁液可能刺激皮肤和宠物。', '合果芋适合书架与柜体边缘做层次延展。', 'admin', '2026-05-11 09:56:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1124, 1024, '弱光到明亮散射光', '5 到 7 天一次', '16-28℃', '中等湿度', '全年可养', '保持叶面洁净，避免长时间烈日直射。', '通风不足时容易徒长。', '冷水花适合小桌面和窗边做轻盈点缀。', 'admin', '2026-05-11 09:56:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1125, 1025, '明亮散射光', '4 到 6 天一次', '18-30℃', '中等偏高湿度', '春夏生长明显', '可借助苔藓柱向上攀援，也适合吊盆展示。', '宠物误食有风险，需避免低位摆放。', '姬龟背竹兼具体量控制和热带叶型。', 'admin', '2026-05-11 09:57:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1126, 1026, '充足日照到明亮散射光', '10 到 14 天一次', '10-30℃', '偏干环境', '生长较慢', '保持介质疏松透气，宁干勿湿。', '宠物误食可能引起肠胃不适。', '芦荟适合窗台和桌面做低维护展示。', 'admin', '2026-05-11 09:57:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1127, 1027, '充足日照到明亮散射光', '2 到 4 天一次', '15-30℃', '中高湿度', '生长较快', '缺水时易塌叶，可浅水养或保持盆土湿润。', '长期阴暗会导致叶柄徒长。', '铜钱草适合窗边和桌面做明快治愈型点缀。', 'admin', '2026-05-11 09:58:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1128, 1028, '充足日照', '7 到 10 天一次', '12-28℃', '普通湿度', '花期稳定', '保持光照和适度修剪，更利于持续开花。', '宠物家庭需避免啃食叶片。', '长寿花适合阳台和窗边做持久观花展示。', 'admin', '2026-05-11 09:58:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1129, 1029, '充足日照到明亮散射光', '4 到 6 天一次', '15-28℃', '中等湿度', '花量较稳定', '花后及时修剪残花，利于继续分枝。', '积水和闷根容易影响花期表现。', '四季海棠适合阳台与窗边做连续观花陈列。', 'admin', '2026-05-11 09:59:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1130, 1030, '充足日照', '4 到 6 天一次', '15-30℃', '中等湿度', '春夏开花明显', '保持充足通风和日照，及时摘除残花。', '宠物误食叶片与花朵有风险。', '天竺葵适合阳台花箱和香叶体验场景。', 'admin', '2026-05-11 09:59:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1131, 1031, '明亮散射光', '4 到 6 天一次', '18-30℃', '中等偏高湿度', '春夏更易开花', '适合吊盆或高柜摆放，注意避免长期干透。', '空气过干时容易掉蕾。', '口红吊兰适合做层次型垂吊陈列。', 'admin', '2026-05-11 10:00:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1132, 1032, '明亮散射光到短时日照', '7 到 10 天一次', '18-30℃', '中等湿度', '生长平稳', '盆土干一些再浇水，更容易维持稳定开花。', '长期积水会伤根。', '球兰适合高柜和窗边做轻香垂吊展示。', 'admin', '2026-05-11 10:00:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1133, 1033, '明亮散射光到充足日照', '5 到 7 天喷雾一次', '15-28℃', '较低到中等湿度', '生长较慢', '需要良好通风，浸泡补水后务必沥干。', '闷湿环境容易造成芯部腐烂。', '空气凤梨适合桌面、小架子和创意容器展示。', 'admin', '2026-05-11 10:01:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1134, 1034, '弱光到明亮散射光', '3 到 5 天一次', '18-28℃', '较高湿度', '全年缓慢生长', '保持基质微湿，避免空调直吹。', '缺水时叶片边缘会快速卷曲。', '网纹草适合卧室和书桌做细腻治愈型摆设。', 'admin', '2026-05-11 10:01:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1135, 1035, '半阴环境更佳', '2 到 4 天一次', '16-26℃', '高湿度', '春秋较旺', '适合高湿环境，缺水时需及时补湿。', '空气太干会迅速干尖落叶。', '铁线蕨适合湿润窗边和柔和角落陈列。', 'admin', '2026-05-11 10:02:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1136, 1036, '明亮散射光', '10 到 14 天一次', '18-30℃', '普通湿度即可', '四季稳定', '保持盆土偏干，适合低频维护。', '宠物误食叶片有风险。', '龙血树适合办公室和客厅角落做竖向线条陈列。', 'admin', '2026-05-11 10:02:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1137, 1037, '弱光到明亮散射光均可', '7 到 10 天一次', '18-30℃', '普通湿度即可', '生长稳定', '避免盆土长期积水，适合低光办公室。', '宠物误食可能引起不适。', '巴西木适合会议室、前台和客厅边角做稳定绿化。', 'admin', '2026-05-11 10:03:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1138, 1038, '明亮散射光', '5 到 7 天一次', '18-30℃', '中等偏高湿度', '春夏长势明显', '叶片较大，保持通风和适度增湿更佳。', '宠物家庭不建议放在低位。', '春羽适合客厅和休闲区做热带主景。', 'admin', '2026-05-11 10:03:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1139, 1039, '半阴到明亮散射光', '5 到 7 天一次', '18-30℃', '中等湿度', '生长较快', '可借助支撑杆塑形，叶面保持洁净更显质感。', '汁液对宠物和儿童有刺激风险。', '绿宝石喜林芋适合低光客厅做热带层次补位。', 'admin', '2026-05-11 10:04:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1140, 1040, '充足日照到明亮散射光', '10 到 14 天一次', '10-30℃', '普通湿度', '生长较慢', '浇水要少，放在光线稳定的位置更利于株型。', '长期阴暗会让叶色和株型走样。', '酒瓶兰适合客厅和玄关做雕塑感陈设。', 'admin', '2026-05-11 10:04:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1141, 1041, '充足日照到明亮散射光', '3 到 5 天一次', '16-28℃', '较高湿度', '花期明显', '保持酸性基质和通风，花后及时修剪。', '宠物家庭需避免啃食花叶。', '栀子花适合阳台和窗边做花香型主角。', 'admin', '2026-05-11 10:05:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1142, 1042, '充足日照', '6 到 8 天一次', '12-28℃', '偏干到中等湿度', '春夏生长明显', '保持日照和排水，花后轻剪可维持株型。', '高温闷湿时容易黑腐。', '薰衣草适合高光阳台做草本香氛陈列。', 'admin', '2026-05-11 10:05:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1143, 1043, '充足日照', '6 到 8 天一次', '10-28℃', '中等湿度', '生长较快', '修剪后更容易分枝，适合小盆持续采收。', '长期积水会影响根系和香味。', '百里香适合窗边和阳台做料理香草。', 'admin', '2026-05-11 10:06:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1144, 1044, '充足日照到明亮散射光', '3 到 5 天一次', '18-32℃', '中等湿度', '生长快，可反复采收', '勤摘心可促进分枝，避免长期缺水。', '寒冷和长期缺光会影响长势。', '罗勒适合厨房窗边和阳台做食用香草。', 'admin', '2026-05-11 10:06:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1145, 1045, '充足日照到明亮散射光', '4 到 6 天一次', '15-30℃', '中等湿度', '春夏长势更快', '适合定期修剪采收，保持通风更不易徒长。', '长期缺光会导致香味变淡。', '柠檬香蜂草适合阳台和窗边做清新香草。', 'admin', '2026-05-11 10:07:00', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1146, 1046, '明亮散射光', '4 到 6 天一次', '16-28℃', '中等湿度', '花期较长', '浇水尽量避开叶心，保持环境通风。', '积水和闷湿容易引起叶片发软。', '非洲堇适合室内窗边和小桌面做开花展示。', 'admin', '2026-05-11 10:07:30', '', NULL, '植物详情扩展样例');
INSERT INTO `zx_plant_detail` VALUES (1147, 1047, '弱光到明亮散射光均可', '5 到 7 天一次', '18-30℃', '中等湿度', '全年可养', '适合稳定室温环境，定期擦叶能提升观感。', '宠物误食叶片有刺激风险。', '银皇后适合低光办公室和玄关做净化型绿化。', 'admin', '2026-05-11 10:08:00', '', NULL, '植物详情扩展样例');

-- ----------------------------
-- Table structure for zx_plant_tag
-- ----------------------------
DROP TABLE IF EXISTS `zx_plant_tag`;
CREATE TABLE `zx_plant_tag`  (
  `tag_id` bigint NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tag_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名称',
  `tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签编码',
  `tag_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签分组',
  `tag_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签描述',
  `sort_num` int NULL DEFAULT 0 COMMENT '排序号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`tag_id`) USING BTREE,
  UNIQUE INDEX `uk_zx_plant_tag_code`(`tag_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '植物标签字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_plant_tag
-- ----------------------------
INSERT INTO `zx_plant_tag` VALUES (2001, '低光照', 'light_low', 'light', '适合弱光或散射光环境', 1, '0', '0', 'admin', '2026-05-11 09:10:00', '', NULL, '光照标签');
INSERT INTO `zx_plant_tag` VALUES (2002, '中等光照', 'light_medium', 'light', '适合明亮散射光环境', 2, '0', '0', 'admin', '2026-05-11 09:10:30', '', NULL, '光照标签');
INSERT INTO `zx_plant_tag` VALUES (2003, '高光照', 'light_high', 'light', '适合直射光或充足日照环境', 3, '0', '0', 'admin', '2026-05-11 09:11:00', '', NULL, '光照标签');
INSERT INTO `zx_plant_tag` VALUES (2010, '低频浇水', 'water_low', 'water', '更耐旱，浇水频率低', 10, '0', '0', 'admin', '2026-05-11 09:11:30', '', NULL, '浇水标签');
INSERT INTO `zx_plant_tag` VALUES (2011, '中频浇水', 'water_medium', 'water', '保持土壤微湿即可', 11, '0', '0', 'admin', '2026-05-11 09:12:00', '', NULL, '浇水标签');
INSERT INTO `zx_plant_tag` VALUES (2012, '高频浇水', 'water_high', 'water', '偏好湿润环境，浇水更频繁', 12, '0', '0', 'admin', '2026-05-11 09:12:30', '', NULL, '浇水标签');
INSERT INTO `zx_plant_tag` VALUES (2020, '小空间', 'space_small', 'space', '适合桌面、窗台和边角位', 20, '0', '0', 'admin', '2026-05-11 09:13:00', '', NULL, '空间标签');
INSERT INTO `zx_plant_tag` VALUES (2021, '中等空间', 'space_medium', 'space', '适合单椅旁、斗柜旁等位置', 21, '0', '0', 'admin', '2026-05-11 09:13:30', '', NULL, '空间标签');
INSERT INTO `zx_plant_tag` VALUES (2022, '大空间', 'space_large', 'space', '适合客厅落地或门厅摆放', 22, '0', '0', 'admin', '2026-05-11 09:14:00', '', NULL, '空间标签');
INSERT INTO `zx_plant_tag` VALUES (2030, '好养', 'care_easy', 'care', '新手友好，容错率高', 30, '0', '0', 'admin', '2026-05-11 09:14:30', '', NULL, '养护标签');
INSERT INTO `zx_plant_tag` VALUES (2031, '中等养护', 'care_medium', 'care', '需要定期观察生长状态', 31, '0', '0', 'admin', '2026-05-11 09:15:00', '', NULL, '养护标签');
INSERT INTO `zx_plant_tag` VALUES (2032, '进阶养护', 'care_hard', 'care', '对光照、水肥和环境更敏感', 32, '0', '0', 'admin', '2026-05-11 09:15:30', '', NULL, '养护标签');
INSERT INTO `zx_plant_tag` VALUES (2040, '观叶型', 'style_leaf', 'style', '以叶型和叶色为主要观赏点', 40, '0', '0', 'admin', '2026-05-11 09:16:00', '', NULL, '风格标签');
INSERT INTO `zx_plant_tag` VALUES (2041, '观花型', 'style_flower', 'style', '以花色和花香为主要观赏点', 41, '0', '0', 'admin', '2026-05-11 09:16:30', '', NULL, '风格标签');
INSERT INTO `zx_plant_tag` VALUES (2042, '极简感', 'style_minimal', 'style', '线条利落，适合简约风空间', 42, '0', '0', 'admin', '2026-05-11 09:16:40', '', NULL, '风格标签');
INSERT INTO `zx_plant_tag` VALUES (2043, '治愈感', 'style_healing', 'style', '叶型柔和，适合卧室与书房氛围', 43, '0', '0', 'admin', '2026-05-11 09:16:50', '', NULL, '风格标签');
INSERT INTO `zx_plant_tag` VALUES (2044, '热带感', 'style_tropical', 'style', '大叶舒展，适合客厅陈设场景', 44, '0', '0', 'admin', '2026-05-11 09:17:00', '', NULL, '风格标签');
INSERT INTO `zx_plant_tag` VALUES (2050, '宠物友好', 'pet_yes', 'pet', '适合有猫狗家庭优先考虑', 50, '0', '0', 'admin', '2026-05-11 09:17:00', '', NULL, '宠物标签');
INSERT INTO `zx_plant_tag` VALUES (2051, '宠物慎选', 'pet_no', 'pet', '宠物家庭需要提高摆放和接触管理', 51, '0', '0', 'admin', '2026-05-11 09:17:30', '', NULL, '宠物标签');
INSERT INTO `zx_plant_tag` VALUES (2060, '空气净化', 'function_purify', 'function', '适合办公、卧室等净化诉求', 60, '0', '0', 'admin', '2026-05-11 09:18:00', '', NULL, '功能标签');
INSERT INTO `zx_plant_tag` VALUES (2061, '芳香体验', 'function_aroma', 'function', '适合偏好香味和嗅觉体验场景', 61, '0', '0', 'admin', '2026-05-11 09:18:30', '', NULL, '功能标签');
INSERT INTO `zx_plant_tag` VALUES (2070, '低预算', 'price_low', 'price', '单盆成本较低，适合入门', 70, '0', '0', 'admin', '2026-05-11 09:19:00', '', NULL, '价格标签');
INSERT INTO `zx_plant_tag` VALUES (2071, '中预算', 'price_mid', 'price', '适合想兼顾观赏和性价比用户', 71, '0', '0', 'admin', '2026-05-11 09:19:30', '', NULL, '价格标签');
INSERT INTO `zx_plant_tag` VALUES (2072, '高预算', 'price_high', 'price', '适合重视陈设和体量感的场景', 72, '0', '0', 'admin', '2026-05-11 09:20:00', '', NULL, '价格标签');
INSERT INTO `zx_plant_tag` VALUES (2080, '垂吊型', 'feature_hanging', 'feature', '适合高柜、吊盆或架子摆放', 80, '0', '0', 'admin', '2026-05-11 09:20:30', '', NULL, '形态标签');
INSERT INTO `zx_plant_tag` VALUES (2081, '桌面型', 'feature_desktop', 'feature', '适合桌面和小边柜摆放', 81, '0', '0', 'admin', '2026-05-11 09:21:00', '', NULL, '形态标签');
INSERT INTO `zx_plant_tag` VALUES (2082, '陈设型', 'feature_statement', 'feature', '适合客厅主景和会客区焦点位', 82, '0', '0', 'admin', '2026-05-11 09:21:10', '', NULL, '形态标签');

-- ----------------------------
-- Table structure for zx_plant_tag_rel
-- ----------------------------
DROP TABLE IF EXISTS `zx_plant_tag_rel`;
CREATE TABLE `zx_plant_tag_rel`  (
  `rel_id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `plant_id` bigint NOT NULL COMMENT '植物ID',
  `tag_id` bigint NOT NULL COMMENT '标签ID',
  `tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签编码冗余',
  `score_weight` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '标签权重',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`rel_id`) USING BTREE,
  UNIQUE INDEX `uk_zx_plant_tag_rel`(`plant_id` ASC, `tag_id` ASC) USING BTREE,
  INDEX `idx_zx_plant_tag_rel_tag`(`tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '植物标签关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_plant_tag_rel
-- ----------------------------
INSERT INTO `zx_plant_tag_rel` VALUES (1, 1001, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 09:55:00', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (2, 1001, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 09:55:10', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (3, 1001, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 09:55:20', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (4, 1001, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 09:55:30', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (5, 1001, 2040, 'style_leaf', 8.00, 'admin', '2026-05-11 09:55:40', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (6, 1001, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 09:55:50', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (7, 1001, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 09:56:00', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (8, 1001, 2070, 'price_low', 7.00, 'admin', '2026-05-11 09:56:10', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (9, 1001, 2080, 'feature_hanging', 7.00, 'admin', '2026-05-11 09:56:20', '绿萝标签');
INSERT INTO `zx_plant_tag_rel` VALUES (10, 1002, 2001, 'light_low', 9.00, 'admin', '2026-05-11 09:56:30', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (11, 1002, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 09:56:40', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (12, 1002, 2020, 'space_small', 10.00, 'admin', '2026-05-11 09:56:50', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (13, 1002, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 09:57:00', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (14, 1002, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 09:57:10', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (15, 1002, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 09:57:20', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (16, 1002, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 09:57:30', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (17, 1002, 2070, 'price_low', 8.00, 'admin', '2026-05-11 09:57:40', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (18, 1002, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 09:57:50', '吊兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (19, 1003, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 09:58:00', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (20, 1003, 2010, 'water_low', 10.00, 'admin', '2026-05-11 09:58:10', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (21, 1003, 2020, 'space_small', 8.00, 'admin', '2026-05-11 09:58:20', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (22, 1003, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 09:58:30', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (23, 1003, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 09:58:40', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (24, 1003, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 09:58:50', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (25, 1003, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 09:59:00', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (26, 1003, 2070, 'price_low', 8.00, 'admin', '2026-05-11 09:59:10', '虎皮兰标签');
INSERT INTO `zx_plant_tag_rel` VALUES (27, 1004, 2002, 'light_medium', 9.00, 'admin', '2026-05-11 09:59:20', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (28, 1004, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 09:59:30', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (29, 1004, 2022, 'space_large', 10.00, 'admin', '2026-05-11 09:59:40', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (30, 1004, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 09:59:50', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (31, 1004, 2040, 'style_leaf', 10.00, 'admin', '2026-05-11 10:00:00', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (32, 1004, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:00:10', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (33, 1004, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 10:00:20', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (34, 1004, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:00:30', '龟背竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (35, 1005, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:00:40', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (36, 1005, 2010, 'water_low', 8.00, 'admin', '2026-05-11 10:00:50', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (37, 1005, 2022, 'space_large', 9.00, 'admin', '2026-05-11 10:01:00', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (38, 1005, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:01:10', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (39, 1005, 2040, 'style_leaf', 8.00, 'admin', '2026-05-11 10:01:20', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (40, 1005, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:01:30', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (41, 1005, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:01:40', '发财树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (42, 1006, 2001, 'light_low', 8.00, 'admin', '2026-05-11 10:01:50', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (43, 1006, 2012, 'water_high', 9.00, 'admin', '2026-05-11 10:02:00', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (44, 1006, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:02:10', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (45, 1006, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:02:20', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (46, 1006, 2041, 'style_flower', 8.00, 'admin', '2026-05-11 10:02:30', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (47, 1006, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:02:40', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (48, 1006, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 10:02:50', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (49, 1006, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:03:00', '白掌标签');
INSERT INTO `zx_plant_tag_rel` VALUES (50, 1007, 2002, 'light_medium', 7.00, 'admin', '2026-05-11 10:03:10', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (51, 1007, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:03:20', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (52, 1007, 2021, 'space_medium', 7.00, 'admin', '2026-05-11 10:03:30', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (53, 1007, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:03:40', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (54, 1007, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:03:50', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (55, 1007, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:04:00', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (56, 1007, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 10:04:10', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (57, 1007, 2070, 'price_low', 7.00, 'admin', '2026-05-11 10:04:20', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (58, 1007, 2080, 'feature_hanging', 10.00, 'admin', '2026-05-11 10:04:30', '常春藤标签');
INSERT INTO `zx_plant_tag_rel` VALUES (59, 1008, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:04:40', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (60, 1008, 2011, 'water_medium', 7.00, 'admin', '2026-05-11 10:04:50', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (61, 1008, 2022, 'space_large', 9.00, 'admin', '2026-05-11 10:05:00', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (62, 1008, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:05:10', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (63, 1008, 2040, 'style_leaf', 9.00, 'admin', '2026-05-11 10:05:20', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (64, 1008, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:05:30', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (65, 1008, 2060, 'function_purify', 7.00, 'admin', '2026-05-11 10:05:40', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (66, 1008, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:05:50', '橡皮树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (67, 1009, 2002, 'light_medium', 7.00, 'admin', '2026-05-11 10:06:00', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (68, 1009, 2011, 'water_medium', 7.00, 'admin', '2026-05-11 10:06:10', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (69, 1009, 2020, 'space_small', 9.00, 'admin', '2026-05-11 10:06:20', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (70, 1009, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:06:30', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (71, 1009, 2040, 'style_leaf', 8.00, 'admin', '2026-05-11 10:06:40', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (72, 1009, 2070, 'price_low', 7.00, 'admin', '2026-05-11 10:06:50', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (73, 1009, 2081, 'feature_desktop', 10.00, 'admin', '2026-05-11 10:07:00', '文竹标签');
INSERT INTO `zx_plant_tag_rel` VALUES (74, 1010, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:07:10', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (75, 1010, 2012, 'water_high', 8.00, 'admin', '2026-05-11 10:07:20', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (76, 1010, 2021, 'space_medium', 7.00, 'admin', '2026-05-11 10:07:30', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (77, 1010, 2032, 'care_hard', 8.00, 'admin', '2026-05-11 10:07:40', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (78, 1010, 2041, 'style_flower', 10.00, 'admin', '2026-05-11 10:07:50', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (79, 1010, 2061, 'function_aroma', 10.00, 'admin', '2026-05-11 10:08:00', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (80, 1010, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:08:10', '茉莉花标签');
INSERT INTO `zx_plant_tag_rel` VALUES (81, 1011, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:08:20', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (82, 1011, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:08:30', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (83, 1011, 2020, 'space_small', 8.00, 'admin', '2026-05-11 10:08:40', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (84, 1011, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:08:50', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (85, 1011, 2041, 'style_flower', 7.00, 'admin', '2026-05-11 10:09:00', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (86, 1011, 2050, 'pet_yes', 8.00, 'admin', '2026-05-11 10:09:10', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (87, 1011, 2061, 'function_aroma', 9.00, 'admin', '2026-05-11 10:09:20', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (88, 1011, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:09:30', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (89, 1011, 2081, 'feature_desktop', 8.00, 'admin', '2026-05-11 10:09:40', '薄荷标签');
INSERT INTO `zx_plant_tag_rel` VALUES (90, 1012, 2001, 'light_low', 7.00, 'admin', '2026-05-11 10:09:50', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (91, 1012, 2010, 'water_low', 10.00, 'admin', '2026-05-11 10:10:00', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (92, 1012, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:10:10', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (93, 1012, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:10:20', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (94, 1012, 2040, 'style_leaf', 9.00, 'admin', '2026-05-11 10:10:30', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (95, 1012, 2050, 'pet_yes', 9.00, 'admin', '2026-05-11 10:10:40', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (96, 1012, 2071, 'price_mid', 6.00, 'admin', '2026-05-11 10:10:50', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (97, 1012, 2081, 'feature_desktop', 10.00, 'admin', '2026-05-11 10:11:00', '玉露标签');
INSERT INTO `zx_plant_tag_rel` VALUES (98, 1001, 2043, 'style_healing', 7.00, 'admin', '2026-05-11 10:11:10', '绿萝扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (99, 1002, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:11:20', '吊兰扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (100, 1003, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:11:30', '虎皮兰扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (101, 1004, 2044, 'style_tropical', 10.00, 'admin', '2026-05-11 10:11:40', '龟背竹扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (102, 1004, 2082, 'feature_statement', 9.00, 'admin', '2026-05-11 10:11:50', '龟背竹扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (103, 1005, 2042, 'style_minimal', 8.00, 'admin', '2026-05-11 10:12:00', '发财树扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (104, 1005, 2082, 'feature_statement', 8.00, 'admin', '2026-05-11 10:12:10', '发财树扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (105, 1006, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:12:20', '白掌扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (106, 1007, 2043, 'style_healing', 7.00, 'admin', '2026-05-11 10:12:30', '常春藤扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (107, 1008, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:12:40', '橡皮树扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (108, 1008, 2082, 'feature_statement', 8.00, 'admin', '2026-05-11 10:12:50', '橡皮树扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (109, 1009, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:13:00', '文竹扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (110, 1010, 2043, 'style_healing', 6.00, 'admin', '2026-05-11 10:13:10', '茉莉花扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (111, 1011, 2043, 'style_healing', 7.00, 'admin', '2026-05-11 10:13:20', '薄荷扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (112, 1012, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:13:30', '玉露扩展标签');
INSERT INTO `zx_plant_tag_rel` VALUES (113, 1013, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:13:40', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (114, 1013, 2010, 'water_low', 10.00, 'admin', '2026-05-11 10:13:50', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (115, 1013, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:14:00', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (116, 1013, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:14:10', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (117, 1013, 2040, 'style_leaf', 8.00, 'admin', '2026-05-11 10:14:20', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (118, 1013, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:14:30', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (119, 1013, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:14:40', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (120, 1013, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 10:14:50', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (121, 1013, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:15:00', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (122, 1013, 2082, 'feature_statement', 7.00, 'admin', '2026-05-11 10:15:10', '金钱树标签');
INSERT INTO `zx_plant_tag_rel` VALUES (123, 1014, 2001, 'light_low', 8.00, 'admin', '2026-05-11 10:15:20', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (124, 1014, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:15:30', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (125, 1014, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:15:40', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (126, 1014, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:15:50', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (127, 1014, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:16:00', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (128, 1014, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:16:10', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (129, 1014, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:16:20', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (130, 1014, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 10:16:30', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (131, 1014, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:16:40', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (132, 1014, 2082, 'feature_statement', 6.00, 'admin', '2026-05-11 10:16:50', '袖珍椰子标签');
INSERT INTO `zx_plant_tag_rel` VALUES (133, 1015, 2001, 'light_low', 8.00, 'admin', '2026-05-11 10:17:00', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (134, 1015, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:17:10', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (135, 1015, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:17:20', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (136, 1015, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:17:30', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (137, 1015, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:17:40', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (138, 1015, 2042, 'style_minimal', 8.00, 'admin', '2026-05-11 10:17:50', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (139, 1015, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:18:00', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (140, 1015, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:18:10', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (141, 1015, 2081, 'feature_desktop', 10.00, 'admin', '2026-05-11 10:18:20', '豆瓣绿标签');
INSERT INTO `zx_plant_tag_rel` VALUES (142, 1016, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:18:30', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (143, 1016, 2012, 'water_high', 8.00, 'admin', '2026-05-11 10:18:40', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (144, 1016, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:18:50', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (145, 1016, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:19:00', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (146, 1016, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:19:10', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (147, 1016, 2043, 'style_healing', 9.00, 'admin', '2026-05-11 10:19:20', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (148, 1016, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:19:30', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (149, 1016, 2060, 'function_purify', 7.00, 'admin', '2026-05-11 10:19:40', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (150, 1016, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:19:50', '鸟巢蕨标签');
INSERT INTO `zx_plant_tag_rel` VALUES (151, 1017, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:20:00', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (152, 1017, 2010, 'water_low', 8.00, 'admin', '2026-05-11 10:20:10', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (153, 1017, 2020, 'space_small', 7.00, 'admin', '2026-05-11 10:20:20', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (154, 1017, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:20:30', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (155, 1017, 2041, 'style_flower', 7.00, 'admin', '2026-05-11 10:20:40', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (156, 1017, 2061, 'function_aroma', 10.00, 'admin', '2026-05-11 10:20:50', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (157, 1017, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:21:00', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (158, 1017, 2081, 'feature_desktop', 7.00, 'admin', '2026-05-11 10:21:10', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (159, 1017, 2050, 'pet_yes', 8.00, 'admin', '2026-05-11 10:21:20', '迷迭香标签');
INSERT INTO `zx_plant_tag_rel` VALUES (160, 1018, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:21:30', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (161, 1018, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:21:40', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (162, 1018, 2022, 'space_large', 10.00, 'admin', '2026-05-11 10:21:50', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (163, 1018, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:22:00', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (164, 1018, 2040, 'style_leaf', 8.00, 'admin', '2026-05-11 10:22:10', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (165, 1018, 2044, 'style_tropical', 10.00, 'admin', '2026-05-11 10:22:20', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (166, 1018, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:22:30', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (167, 1018, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 10:22:40', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (168, 1018, 2072, 'price_high', 10.00, 'admin', '2026-05-11 10:22:50', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (169, 1018, 2082, 'feature_statement', 10.00, 'admin', '2026-05-11 10:23:00', '琴叶榕标签');
INSERT INTO `zx_plant_tag_rel` VALUES (170, 1019, 2001, 'light_low', 10.00, 'admin', '2026-05-11 10:23:10', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (171, 1019, 2012, 'water_high', 8.00, 'admin', '2026-05-11 10:23:20', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (172, 1019, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:23:30', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (173, 1019, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:23:40', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (174, 1019, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:23:50', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (175, 1019, 2043, 'style_healing', 10.00, 'admin', '2026-05-11 10:24:00', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (176, 1019, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:24:10', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (177, 1019, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:24:20', '孔雀竹芋标签');
INSERT INTO `zx_plant_tag_rel` VALUES (178, 1020, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:24:30', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (179, 1020, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:24:40', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (180, 1020, 2022, 'space_large', 9.00, 'admin', '2026-05-11 10:24:50', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (181, 1020, 2030, 'care_easy', 8.00, 'admin', '2026-05-11 10:25:00', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (182, 1020, 2040, 'style_leaf', 7.00, 'admin', '2026-05-11 10:25:10', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (183, 1020, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:25:20', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (184, 1020, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:25:30', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (185, 1020, 2060, 'function_purify', 8.00, 'admin', '2026-05-11 10:25:40', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (186, 1020, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:25:50', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (187, 1020, 2082, 'feature_statement', 8.00, 'admin', '2026-05-11 10:26:00', '散尾葵标签');
INSERT INTO `zx_plant_tag_rel` VALUES (188, 1021, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:26:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (189, 1021, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:26:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (190, 1021, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:26:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (191, 1021, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:26:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (192, 1021, 2042, 'style_minimal', 8.00, 'admin', '2026-05-11 10:26:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (193, 1021, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:27:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (194, 1021, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:27:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (195, 1021, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 10:27:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (196, 1022, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:27:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (197, 1022, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:27:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (198, 1022, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:27:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (199, 1022, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:28:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (200, 1022, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:28:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (201, 1022, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:28:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (202, 1022, 2072, 'price_high', 8.00, 'admin', '2026-05-11 10:28:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (203, 1022, 2082, 'feature_statement', 9.00, 'admin', '2026-05-11 10:28:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (204, 1023, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:28:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (205, 1023, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:29:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (206, 1023, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:29:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (207, 1023, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:29:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (208, 1023, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:29:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (209, 1023, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:29:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (210, 1023, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:29:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (211, 1023, 2080, 'feature_hanging', 9.00, 'admin', '2026-05-11 10:30:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (212, 1024, 2001, 'light_low', 8.00, 'admin', '2026-05-11 10:30:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (213, 1024, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:30:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (214, 1024, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:30:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (215, 1024, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:30:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (216, 1024, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:30:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (217, 1024, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:31:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (218, 1024, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:31:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (219, 1024, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 10:31:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (220, 1025, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:31:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (221, 1025, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:31:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (222, 1025, 2020, 'space_small', 9.00, 'admin', '2026-05-11 10:31:50', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (223, 1025, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:32:00', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (224, 1025, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:32:10', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (225, 1025, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:32:20', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (226, 1025, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:32:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (227, 1025, 2080, 'feature_hanging', 10.00, 'admin', '2026-05-11 10:32:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (228, 1026, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:32:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (229, 1026, 2010, 'water_low', 10.00, 'admin', '2026-05-11 10:33:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (230, 1026, 2020, 'space_small', 9.00, 'admin', '2026-05-11 10:33:10', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (231, 1026, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:33:20', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (232, 1026, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:33:30', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (233, 1026, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:33:40', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (234, 1026, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:33:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (235, 1026, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 10:34:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (236, 1027, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:34:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (237, 1027, 2012, 'water_high', 9.00, 'admin', '2026-05-11 10:34:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (238, 1027, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:34:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (239, 1027, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:34:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (240, 1027, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:34:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (241, 1027, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:35:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (242, 1027, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:35:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (243, 1027, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 10:35:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (244, 1028, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:35:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (245, 1028, 2010, 'water_low', 8.00, 'admin', '2026-05-11 10:35:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (246, 1028, 2020, 'space_small', 8.00, 'admin', '2026-05-11 10:35:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (247, 1028, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:36:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (248, 1028, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:36:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (249, 1028, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:36:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (250, 1028, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:36:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (251, 1028, 2081, 'feature_desktop', 8.00, 'admin', '2026-05-11 10:36:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (252, 1029, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:36:50', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (253, 1029, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:37:00', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (254, 1029, 2020, 'space_small', 8.00, 'admin', '2026-05-11 10:37:10', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (255, 1029, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:37:20', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (256, 1029, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:37:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (257, 1029, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:37:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (258, 1029, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:37:50', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (259, 1029, 2081, 'feature_desktop', 8.00, 'admin', '2026-05-11 10:38:00', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (260, 1030, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:38:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (261, 1030, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:38:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (262, 1030, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:38:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (263, 1030, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:38:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (264, 1030, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:38:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (265, 1030, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:39:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (266, 1030, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:39:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (267, 1030, 2061, 'function_aroma', 10.00, 'admin', '2026-05-11 10:39:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (268, 1031, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:39:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (269, 1031, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:39:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (270, 1031, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:39:50', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (271, 1031, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:40:00', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (272, 1031, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:40:10', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (273, 1031, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:40:20', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (274, 1031, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:40:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (275, 1031, 2080, 'feature_hanging', 10.00, 'admin', '2026-05-11 10:40:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (276, 1032, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:40:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (277, 1032, 2010, 'water_low', 9.00, 'admin', '2026-05-11 10:41:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (278, 1032, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:41:10', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (279, 1032, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:41:20', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (280, 1032, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:41:30', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (281, 1032, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:41:40', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (282, 1032, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:41:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (283, 1032, 2080, 'feature_hanging', 9.00, 'admin', '2026-05-11 10:42:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (284, 1033, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:42:10', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (285, 1033, 2010, 'water_low', 9.00, 'admin', '2026-05-11 10:42:20', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (286, 1033, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:42:30', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (287, 1033, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:42:40', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (288, 1033, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:42:50', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (289, 1033, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:43:00', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (290, 1033, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:43:10', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (291, 1033, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 10:43:20', '??????');
INSERT INTO `zx_plant_tag_rel` VALUES (292, 1034, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:43:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (293, 1034, 2012, 'water_high', 9.00, 'admin', '2026-05-11 10:43:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (294, 1034, 2020, 'space_small', 10.00, 'admin', '2026-05-11 10:43:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (295, 1034, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:44:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (296, 1034, 2043, 'style_healing', 9.00, 'admin', '2026-05-11 10:44:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (297, 1034, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:44:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (298, 1034, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:44:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (299, 1034, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 10:44:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (300, 1035, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:44:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (301, 1035, 2012, 'water_high', 10.00, 'admin', '2026-05-11 10:45:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (302, 1035, 2020, 'space_small', 9.00, 'admin', '2026-05-11 10:45:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (303, 1035, 2032, 'care_hard', 8.00, 'admin', '2026-05-11 10:45:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (304, 1035, 2043, 'style_healing', 9.00, 'admin', '2026-05-11 10:45:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (305, 1035, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:45:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (306, 1035, 2070, 'price_low', 7.00, 'admin', '2026-05-11 10:45:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (307, 1035, 2081, 'feature_desktop', 8.00, 'admin', '2026-05-11 10:46:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (308, 1036, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:46:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (309, 1036, 2010, 'water_low', 9.00, 'admin', '2026-05-11 10:46:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (310, 1036, 2022, 'space_large', 10.00, 'admin', '2026-05-11 10:46:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (311, 1036, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:46:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (312, 1036, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:46:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (313, 1036, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:47:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (314, 1036, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:47:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (315, 1036, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 10:47:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (316, 1037, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:47:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (317, 1037, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:47:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (318, 1037, 2022, 'space_large', 10.00, 'admin', '2026-05-11 10:47:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (319, 1037, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:48:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (320, 1037, 2042, 'style_minimal', 8.00, 'admin', '2026-05-11 10:48:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (321, 1037, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:48:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (322, 1037, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:48:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (323, 1037, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 10:48:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (324, 1038, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:48:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (325, 1038, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:49:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (326, 1038, 2022, 'space_large', 10.00, 'admin', '2026-05-11 10:49:10', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (327, 1038, 2031, 'care_medium', 8.00, 'admin', '2026-05-11 10:49:20', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (328, 1038, 2044, 'style_tropical', 10.00, 'admin', '2026-05-11 10:49:30', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (329, 1038, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:49:40', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (330, 1038, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 10:49:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (331, 1038, 2082, 'feature_statement', 10.00, 'admin', '2026-05-11 10:50:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (332, 1039, 2001, 'light_low', 9.00, 'admin', '2026-05-11 10:50:10', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (333, 1039, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:50:20', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (334, 1039, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:50:30', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (335, 1039, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:50:40', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (336, 1039, 2044, 'style_tropical', 9.00, 'admin', '2026-05-11 10:50:50', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (337, 1039, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:51:00', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (338, 1039, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:51:10', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (339, 1039, 2082, 'feature_statement', 9.00, 'admin', '2026-05-11 10:51:20', '????????');
INSERT INTO `zx_plant_tag_rel` VALUES (340, 1040, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:51:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (341, 1040, 2010, 'water_low', 10.00, 'admin', '2026-05-11 10:51:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (342, 1040, 2022, 'space_large', 9.00, 'admin', '2026-05-11 10:51:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (343, 1040, 2030, 'care_easy', 10.00, 'admin', '2026-05-11 10:52:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (344, 1040, 2042, 'style_minimal', 9.00, 'admin', '2026-05-11 10:52:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (345, 1040, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:52:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (346, 1040, 2072, 'price_high', 9.00, 'admin', '2026-05-11 10:52:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (347, 1040, 2082, 'feature_statement', 9.00, 'admin', '2026-05-11 10:52:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (348, 1041, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:52:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (349, 1041, 2012, 'water_high', 9.00, 'admin', '2026-05-11 10:53:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (350, 1041, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:53:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (351, 1041, 2032, 'care_hard', 8.00, 'admin', '2026-05-11 10:53:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (352, 1041, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:53:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (353, 1041, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:53:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (354, 1041, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:53:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (355, 1041, 2061, 'function_aroma', 10.00, 'admin', '2026-05-11 10:54:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (356, 1042, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:54:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (357, 1042, 2010, 'water_low', 8.00, 'admin', '2026-05-11 10:54:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (358, 1042, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:54:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (359, 1042, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:54:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (360, 1042, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:54:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (361, 1042, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 10:55:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (362, 1042, 2071, 'price_mid', 7.00, 'admin', '2026-05-11 10:55:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (363, 1042, 2061, 'function_aroma', 10.00, 'admin', '2026-05-11 10:55:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (364, 1043, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:55:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (365, 1043, 2010, 'water_low', 8.00, 'admin', '2026-05-11 10:55:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (366, 1043, 2020, 'space_small', 8.00, 'admin', '2026-05-11 10:55:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (367, 1043, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:56:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (368, 1043, 2042, 'style_minimal', 8.00, 'admin', '2026-05-11 10:56:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (369, 1043, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:56:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (370, 1043, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:56:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (371, 1043, 2061, 'function_aroma', 9.00, 'admin', '2026-05-11 10:56:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (372, 1044, 2003, 'light_high', 10.00, 'admin', '2026-05-11 10:56:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (373, 1044, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:57:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (374, 1044, 2020, 'space_small', 8.00, 'admin', '2026-05-11 10:57:10', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (375, 1044, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 10:57:20', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (376, 1044, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:57:30', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (377, 1044, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:57:40', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (378, 1044, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:57:50', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (379, 1044, 2061, 'function_aroma', 9.00, 'admin', '2026-05-11 10:58:00', '????');
INSERT INTO `zx_plant_tag_rel` VALUES (380, 1045, 2003, 'light_high', 9.00, 'admin', '2026-05-11 10:58:10', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (381, 1045, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:58:20', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (382, 1045, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 10:58:30', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (383, 1045, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 10:58:40', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (384, 1045, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 10:58:50', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (385, 1045, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 10:59:00', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (386, 1045, 2070, 'price_low', 8.00, 'admin', '2026-05-11 10:59:10', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (387, 1045, 2061, 'function_aroma', 9.00, 'admin', '2026-05-11 10:59:20', '???????');
INSERT INTO `zx_plant_tag_rel` VALUES (388, 1046, 2002, 'light_medium', 8.00, 'admin', '2026-05-11 10:59:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (389, 1046, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 10:59:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (390, 1046, 2020, 'space_small', 9.00, 'admin', '2026-05-11 10:59:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (391, 1046, 2031, 'care_medium', 7.00, 'admin', '2026-05-11 11:00:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (392, 1046, 2043, 'style_healing', 9.00, 'admin', '2026-05-11 11:00:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (393, 1046, 2050, 'pet_yes', 10.00, 'admin', '2026-05-11 11:00:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (394, 1046, 2070, 'price_low', 8.00, 'admin', '2026-05-11 11:00:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (395, 1046, 2081, 'feature_desktop', 9.00, 'admin', '2026-05-11 11:00:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (396, 1047, 2001, 'light_low', 9.00, 'admin', '2026-05-11 11:00:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (397, 1047, 2011, 'water_medium', 8.00, 'admin', '2026-05-11 11:01:00', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (398, 1047, 2021, 'space_medium', 8.00, 'admin', '2026-05-11 11:01:10', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (399, 1047, 2030, 'care_easy', 9.00, 'admin', '2026-05-11 11:01:20', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (400, 1047, 2043, 'style_healing', 8.00, 'admin', '2026-05-11 11:01:30', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (401, 1047, 2051, 'pet_no', 6.00, 'admin', '2026-05-11 11:01:40', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (402, 1047, 2071, 'price_mid', 8.00, 'admin', '2026-05-11 11:01:50', '?????');
INSERT INTO `zx_plant_tag_rel` VALUES (403, 1047, 2060, 'function_purify', 9.00, 'admin', '2026-05-11 11:02:00', '?????');

-- ----------------------------
-- Table structure for zx_questionnaire_record
-- ----------------------------
DROP TABLE IF EXISTS `zx_questionnaire_record`;
CREATE TABLE `zx_questionnaire_record`  (
  `questionnaire_id` bigint NOT NULL AUTO_INCREMENT COMMENT '问卷ID',
  `visitor_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客UID',
  `source_terminal` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '来源终端',
  `source_channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '来源渠道',
  `answer_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '问卷答案JSON',
  `environment_summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '环境摘要',
  `preference_summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '偏好摘要',
  `budget_value` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '预算值',
  `submit_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提交IP',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  PRIMARY KEY (`questionnaire_id`) USING BTREE,
  INDEX `idx_zx_questionnaire_visitor`(`visitor_uid` ASC) USING BTREE,
  INDEX `idx_zx_questionnaire_submit`(`submit_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '问卷记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_questionnaire_record
-- ----------------------------
INSERT INTO `zx_questionnaire_record` VALUES (4001, 'guest_demo_001', 'h5', 'direct', '{\"scene\":\"bedroom\",\"light\":\"半阴\",\"space\":\"小空间\",\"pet\":\"是\",\"budget\":\"100\",\"care\":\"低维护\",\"style\":\"治愈\",\"goal\":\"桌面绿植\"}', '北向卧室边柜，光照偏弱，摆放空间小。', '希望宠物友好、好养、看起来柔和。', 100.00, '127.0.0.1', '2026-05-11 10:30:00');
INSERT INTO `zx_questionnaire_record` VALUES (4002, 'guest_demo_002', 'h5', 'direct', '{\"scene\":\"living\",\"light\":\"散射光\",\"space\":\"大空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"中维护\",\"style\":\"热带\",\"goal\":\"提升空间层次\"}', '客厅有明亮散射光，预留了落地陈列位。', '希望大叶观叶、有空间层次、陈设感强。', 300.00, '127.0.0.1', '2026-05-11 10:32:00');
INSERT INTO `zx_questionnaire_record` VALUES (4003, 'guest_demo_003', 'h5', 'direct', '{\"scene\":\"balcony\",\"light\":\"直射光\",\"space\":\"中等空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"中维护\",\"style\":\"治愈\",\"goal\":\"闻香观花\"}', '南向阳台日照足，通风良好。', '希望香味明确，最好兼顾观花体验。', 200.00, '127.0.0.1', '2026-05-11 10:34:00');
INSERT INTO `zx_questionnaire_record` VALUES (4004, 'guest_demo_004', 'h5', 'direct', '{\"scene\":\"office\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"空气净化\"}', '办公室工位靠窗，空间有限。', '优先省心维护和空气净化。', 200.00, '127.0.0.1', '2026-05-11 10:36:00');
INSERT INTO `zx_questionnaire_record` VALUES (4005, 'guest_demo_005', 'h5', 'direct', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"100\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', '书桌侧边留有一盆小植物的位置。', '预算低，希望第一盆就稳定好养。', 100.00, '127.0.0.1', '2026-05-11 10:38:00');
INSERT INTO `zx_questionnaire_record` VALUES (4006, 'guest_demo_006', 'h5', 'direct', '{\"scene\":\"living\",\"light\":\"半阴\",\"space\":\"大空间\",\"pet\":\"是\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"热带\",\"goal\":\"提升空间层次\"}', '宠物家庭客厅内侧，日照较柔和。', '希望客厅有层次感，同时要兼顾宠物安全。', 200.00, '127.0.0.1', '2026-05-11 10:40:00');
INSERT INTO `zx_questionnaire_record` VALUES (4007, 'guest_demo_007', 'h5', 'direct', '{\"scene\":\"bedroom\",\"light\":\"半阴\",\"space\":\"中等空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"中维护\",\"style\":\"治愈\",\"goal\":\"提升空间层次\"}', '卧室窗边散射光柔和，摆放位在斗柜和边几。', '希望氛围柔和、叶片有层次，不想太张扬。', 200.00, '127.0.0.1', '2026-05-11 10:42:00');
INSERT INTO `zx_questionnaire_record` VALUES (4008, 'guest_demo_008', 'h5', 'direct', '{\"scene\":\"living\",\"light\":\"散射光\",\"space\":\"大空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"中维护\",\"style\":\"简约\",\"goal\":\"提升空间层次\"}', '客厅会客区层高足，适合一株主植物。', '希望体量明确、线条利落、陈设感强。', 300.00, '127.0.0.1', '2026-05-11 10:44:00');
INSERT INTO `zx_questionnaire_record` VALUES (5000, 'runtime_case_01', 'web', 'demo', '{\"scene\":\"bedroom\",\"light\":\"半阴\",\"space\":\"小空间\",\"pet\":\"是\",\"budget\":\"100\",\"care\":\"低维护\",\"style\":\"治愈\",\"goal\":\"桌面绿植\"}', 'bedroom / 半阴 / 小空间', '是 / 低维护 / 治愈 / 桌面绿植', 100.00, '', '2026-05-11 23:52:01');
INSERT INTO `zx_questionnaire_record` VALUES (5001, 'runtime_case_02', 'web', 'demo', '{\"scene\":\"living\",\"light\":\"散射光\",\"space\":\"大空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"中维护\",\"style\":\"热带\",\"goal\":\"提升空间层次\"}', 'living / 散射光 / 大空间', '否 / 中维护 / 热带 / 提升空间层次', 300.00, '', '2026-05-11 23:52:01');
INSERT INTO `zx_questionnaire_record` VALUES (5002, 'runtime_case_03', 'web', 'demo', '{\"scene\":\"balcony\",\"light\":\"直射光\",\"space\":\"中等空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"中维护\",\"style\":\"治愈\",\"goal\":\"闻香观花\"}', 'balcony / 直射光 / 中等空间', '否 / 中维护 / 治愈 / 闻香观花', 200.00, '', '2026-05-11 23:52:01');
INSERT INTO `zx_questionnaire_record` VALUES (5003, 'runtime_case_04', 'web', 'demo', '{\"scene\":\"office\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"空气净化\"}', 'office / 散射光 / 小空间', '否 / 低维护 / 简约 / 空气净化', 200.00, '', '2026-05-11 23:52:01');
INSERT INTO `zx_questionnaire_record` VALUES (5004, 'runtime_case_05', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"100\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', 'desk / 散射光 / 小空间', '否 / 低维护 / 简约 / 桌面绿植', 100.00, '', '2026-05-11 23:52:01');
INSERT INTO `zx_questionnaire_record` VALUES (5005, 'runtime_case_06', 'web', 'demo', '{\"scene\":\"living\",\"light\":\"半阴\",\"space\":\"大空间\",\"pet\":\"是\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"热带\",\"goal\":\"提升空间层次\"}', 'living / 半阴 / 大空间', '是 / 低维护 / 热带 / 提升空间层次', 200.00, '', '2026-05-11 23:52:02');
INSERT INTO `zx_questionnaire_record` VALUES (5006, 'runtime_case_07', 'web', 'demo', '{\"scene\":\"bedroom\",\"light\":\"半阴\",\"space\":\"中等空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"中维护\",\"style\":\"治愈\",\"goal\":\"提升空间层次\"}', 'bedroom / 半阴 / 中等空间', '否 / 中维护 / 治愈 / 提升空间层次', 200.00, '', '2026-05-11 23:52:02');
INSERT INTO `zx_questionnaire_record` VALUES (5007, 'runtime_case_08', 'web', 'demo', '{\"scene\":\"living\",\"light\":\"散射光\",\"space\":\"大空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"中维护\",\"style\":\"简约\",\"goal\":\"提升空间层次\"}', 'living / 散射光 / 大空间', '否 / 中维护 / 简约 / 提升空间层次', 300.00, '', '2026-05-11 23:52:02');
INSERT INTO `zx_questionnaire_record` VALUES (5008, 'runtime_case_office_chain', 'web', 'demo', '{\"scene\":\"office\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"空气净化\"}', 'office / 散射光 / 小空间', '否 / 低维护 / 简约 / 空气净化', 200.00, '', '2026-05-11 23:53:35');
INSERT INTO `zx_questionnaire_record` VALUES (5009, 'visitor-1778516469575', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', 'desk / 散射光 / 小空间', '否 / 低维护 / 简约 / 桌面绿植', 200.00, '', '2026-05-12 00:23:27');
INSERT INTO `zx_questionnaire_record` VALUES (5010, 'visitor-1778516469575', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', '桌面 / 散射光 / 小空间', '否 / 低维护 / 简约 / 桌面绿植', 200.00, '', '2026-05-12 00:27:47');
INSERT INTO `zx_questionnaire_record` VALUES (5011, 'visitor-1778516453912', 'web', 'demo', '{\"scene\":\"office\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"是\",\"budget\":\"200\",\"care\":\"中维护\",\"style\":\"治愈\",\"goal\":\"空气净化\"}', '办公室 / 散射光 / 小空间', '是 / 中维护 / 治愈 / 空气净化', 200.00, '', '2026-05-12 00:45:11');
INSERT INTO `zx_questionnaire_record` VALUES (5012, 'visitor-1778509390737', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"直射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"高维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', '桌面 / 直射光 / 小空间', '否 / 高维护 / 简约 / 桌面绿植', 300.00, '', '2026-05-12 03:22:12');
INSERT INTO `zx_questionnaire_record` VALUES (5013, 'visitor-1778534212272', 'web', 'demo', '{\"scene\":\"office\",\"light\":\"直射光\",\"space\":\"中等空间\",\"pet\":\"否\",\"budget\":\"300\",\"care\":\"低维护\",\"style\":\"治愈\",\"goal\":\"桌面绿植\"}', '办公室 / 直射光 / 中等空间', '否 / 低维护 / 治愈 / 桌面绿植', 300.00, '', '2026-05-12 06:56:39');
INSERT INTO `zx_questionnaire_record` VALUES (5014, 'visitor-1778534212272', 'web', 'demo', '{\"scene\":\"balcony\",\"light\":\"直射光\",\"space\":\"大空间\",\"pet\":\"是\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"热带\",\"goal\":\"桌面绿植\"}', '阳台 / 直射光 / 大空间', '是 / 低维护 / 热带 / 桌面绿植', 200.00, '', '2026-05-12 07:34:46');
INSERT INTO `zx_questionnaire_record` VALUES (5015, 'visitor-1778534212272', 'web', 'demo', '{\"scene\":\"living\",\"light\":\"直射光\",\"space\":\"大空间\",\"pet\":\"是\",\"budget\":\"300\",\"care\":\"高维护\",\"style\":\"治愈\",\"goal\":\"提升空间层次\"}', '客厅 / 直射光 / 大空间', '是 / 高维护 / 治愈 / 提升空间层次', 300.00, '', '2026-05-12 07:57:25');
INSERT INTO `zx_questionnaire_record` VALUES (5016, 'visitor-1778534212272', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', '桌面 / 散射光 / 小空间', '否 / 低维护 / 简约 / 桌面绿植', 200.00, '', '2026-05-12 08:09:48');
INSERT INTO `zx_questionnaire_record` VALUES (5017, 'visitor-1778516453912', 'web', 'demo', '{\"scene\":\"desk\",\"light\":\"散射光\",\"space\":\"小空间\",\"pet\":\"否\",\"budget\":\"200\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"桌面绿植\"}', '桌面 / 散射光 / 小空间', '否 / 低维护 / 简约 / 桌面绿植', 200.00, '', '2026-05-12 17:54:35');
INSERT INTO `zx_questionnaire_record` VALUES (5018, 'visitor-1778509390737', 'web', 'demo', '{\"scene\":\"bedroom\",\"light\":\"半阴\",\"space\":\"小空间\",\"pet\":\"是\",\"budget\":\"100\",\"care\":\"低维护\",\"style\":\"简约\",\"goal\":\"闻香观花\"}', '卧室 / 半阴 / 小空间', '是 / 低维护 / 简约 / 闻香观花', 100.00, '', '2026-05-12 18:14:00');

-- ----------------------------
-- Table structure for zx_recommend_item
-- ----------------------------
DROP TABLE IF EXISTS `zx_recommend_item`;
CREATE TABLE `zx_recommend_item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '推荐明细ID',
  `record_id` bigint NOT NULL COMMENT '推荐记录ID',
  `plant_id` bigint NOT NULL COMMENT '植物ID',
  `score_total` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '总分',
  `score_detail_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '分项分数JSON',
  `rank_num` int NULL DEFAULT 0 COMMENT '排序名次',
  `reason_text` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '推荐原因',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `idx_zx_recommend_item_record`(`record_id` ASC) USING BTREE,
  INDEX `idx_zx_recommend_item_plant`(`plant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7057 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '推荐明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_recommend_item
-- ----------------------------
INSERT INTO `zx_recommend_item` VALUES (6001, 5001, 1002, 95.00, '{\"base\":40,\"light\":15,\"space\":18,\"pet\":20,\"goal\":14}', 1, '吊兰弱光适应好，宠物友好，桌面尺度也稳妥。', '2026-05-11 10:45:00');
INSERT INTO `zx_recommend_item` VALUES (6002, 5001, 1015, 92.00, '{\"base\":40,\"light\":13,\"space\":18,\"pet\":20,\"goal\":13}', 2, '豆瓣绿体量紧凑、养护门槛低，适合卧室边柜。', '2026-05-11 10:45:00');
INSERT INTO `zx_recommend_item` VALUES (6003, 5001, 1012, 89.00, '{\"base\":40,\"space\":18,\"pet\":19,\"goal\":12}', 3, '玉露占地小且耐旱，适合需要低维护的小空间。', '2026-05-11 10:45:00');
INSERT INTO `zx_recommend_item` VALUES (6004, 5002, 1004, 95.00, '{\"base\":40,\"space\":21,\"style\":18,\"goal\":18,\"scene\":16}', 1, '龟背竹大叶张力强，适合客厅做主陈列。', '2026-05-11 10:46:00');
INSERT INTO `zx_recommend_item` VALUES (6005, 5002, 1018, 93.00, '{\"base\":40,\"space\":21,\"style\":20,\"goal\":17,\"budget\":15}', 2, '琴叶榕体量明确，热带感和陈设感都更突出。', '2026-05-11 10:46:00');
INSERT INTO `zx_recommend_item` VALUES (6006, 5002, 1008, 89.00, '{\"base\":40,\"space\":20,\"style\":18,\"goal\":15,\"scene\":12}', 3, '橡皮树线条稳重，适合作为客厅次主景。', '2026-05-11 10:46:00');
INSERT INTO `zx_recommend_item` VALUES (6007, 5003, 1010, 95.00, '{\"base\":40,\"light\":20,\"goal\":18,\"style\":12,\"aroma\":20}', 1, '茉莉花在高光阳台更容易稳定开花并形成花香。', '2026-05-11 10:47:00');
INSERT INTO `zx_recommend_item` VALUES (6008, 5003, 1017, 92.00, '{\"base\":40,\"light\":18,\"goal\":17,\"aroma\":20,\"care\":12}', 2, '迷迭香适合阳台闻香，也能兼顾日常取用。', '2026-05-11 10:47:00');
INSERT INTO `zx_recommend_item` VALUES (6009, 5003, 1011, 89.00, '{\"base\":40,\"light\":18,\"goal\":16,\"aroma\":18,\"space\":12}', 3, '薄荷清爽好养，适合作为阳台香草备选。', '2026-05-11 10:47:00');
INSERT INTO `zx_recommend_item` VALUES (6010, 5004, 1013, 94.00, '{\"base\":40,\"light\":16,\"care\":19,\"goal\":18,\"scene\":15}', 1, '金钱树低光耐受高，适合办公室低频维护。', '2026-05-11 10:48:00');
INSERT INTO `zx_recommend_item` VALUES (6011, 5004, 1003, 91.00, '{\"base\":40,\"care\":20,\"goal\":18,\"space\":14,\"scene\":15}', 2, '虎皮兰省心耐旱，小空间工位也容易放下。', '2026-05-11 10:48:00');
INSERT INTO `zx_recommend_item` VALUES (6012, 5004, 1001, 88.00, '{\"base\":40,\"goal\":18,\"scene\":14,\"style\":10,\"water\":6}', 3, '绿萝净化能力稳定，适合办公边柜做基础绿化。', '2026-05-11 10:48:00');
INSERT INTO `zx_recommend_item` VALUES (6013, 5005, 1015, 93.00, '{\"base\":40,\"space\":18,\"care\":18,\"goal\":16,\"budget\":13}', 1, '豆瓣绿价格友好、体量克制，适合桌面第一盆。', '2026-05-11 10:49:00');
INSERT INTO `zx_recommend_item` VALUES (6014, 5005, 1012, 90.00, '{\"base\":40,\"space\":18,\"care\":18,\"goal\":15,\"style\":14}', 2, '玉露桌面展示精致，维护频率也比较低。', '2026-05-11 10:49:00');
INSERT INTO `zx_recommend_item` VALUES (6015, 5005, 1009, 86.00, '{\"base\":40,\"space\":17,\"goal\":14,\"style\":11,\"care\":12}', 3, '文竹氛围轻盈，适合预算有限时做桌面搭配。', '2026-05-11 10:49:00');
INSERT INTO `zx_recommend_item` VALUES (6016, 5006, 1020, 95.00, '{\"base\":40,\"space\":20,\"pet\":20,\"style\":16,\"goal\":17}', 1, '散尾葵株型舒展且宠物友好，适合客厅安全陈列。', '2026-05-11 10:50:00');
INSERT INTO `zx_recommend_item` VALUES (6017, 5006, 1014, 91.00, '{\"base\":40,\"light\":15,\"pet\":19,\"style\":16,\"goal\":15}', 2, '袖珍椰子叶态轻盈，宠物家庭也更安心。', '2026-05-11 10:50:00');
INSERT INTO `zx_recommend_item` VALUES (6018, 5006, 1002, 87.00, '{\"base\":40,\"pet\":20,\"space\":16,\"goal\":14,\"light\":13}', 3, '吊兰安全性高，可作为客厅层次感的轻体量补位。', '2026-05-11 10:50:00');
INSERT INTO `zx_recommend_item` VALUES (6019, 5007, 1019, 93.00, '{\"base\":40,\"light\":18,\"style\":19,\"space\":14,\"care\":12}', 1, '孔雀竹芋叶纹柔和，弱光卧室也能保持治愈感。', '2026-05-11 10:51:00');
INSERT INTO `zx_recommend_item` VALUES (6020, 5007, 1016, 90.00, '{\"base\":40,\"light\":18,\"style\":17,\"purify\":14,\"water\":11}', 2, '鸟巢蕨更适合半阴环境，能把卧室角落做得更柔和。', '2026-05-11 10:51:00');
INSERT INTO `zx_recommend_item` VALUES (6021, 5007, 1006, 86.00, '{\"base\":40,\"light\":16,\"style\":15,\"purify\":15,\"water\":10}', 3, '白掌兼顾花形和净化属性，是治愈风卧室的补充选择。', '2026-05-11 10:51:00');
INSERT INTO `zx_recommend_item` VALUES (6022, 5008, 1018, 96.00, '{\"base\":40,\"space\":21,\"budget\":18,\"goal\":17,\"style\":16}', 1, '琴叶榕体量明确，适合高预算客厅做主视觉。', '2026-05-11 10:52:00');
INSERT INTO `zx_recommend_item` VALUES (6023, 5008, 1005, 92.00, '{\"base\":40,\"space\":19,\"budget\":16,\"style\":14,\"goal\":15}', 2, '发财树线条利落，简约客厅里更容易融入。', '2026-05-11 10:52:00');
INSERT INTO `zx_recommend_item` VALUES (6024, 5008, 1008, 90.00, '{\"base\":40,\"space\":19,\"style\":15,\"goal\":14,\"budget\":16}', 3, '橡皮树质感稳重，可作为主植物之外的第二层次。', '2026-05-11 10:52:00');
INSERT INTO `zx_recommend_item` VALUES (7000, 6000, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_shade、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7001, 6000, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_shade、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7002, 6000, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_shade、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7003, 6001, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7004, 6001, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7005, 6001, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7006, 6002, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_sun、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7007, 6002, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_sun、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7008, 6002, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_sun、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7009, 6003, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7010, 6003, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7011, 6003, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7012, 6004, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7013, 6004, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7014, 6004, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7015, 6005, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_shade、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7016, 6005, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_shade、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7017, 6005, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_shade、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7018, 6006, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_shade、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7019, 6006, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_shade、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7020, 6006, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_shade、空间 space_medium，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7021, 6007, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7022, 6007, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7023, 6007, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_large，适合演示首版推荐', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_item` VALUES (7024, 6008, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:53:35');
INSERT INTO `zx_recommend_item` VALUES (7025, 6008, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:53:35');
INSERT INTO `zx_recommend_item` VALUES (7026, 6008, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-11 23:53:35');
INSERT INTO `zx_recommend_item` VALUES (7027, 6009, 1004, 96.00, '{\"base\":90,\"profile\":6}', 1, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-12 00:23:27');
INSERT INTO `zx_recommend_item` VALUES (7028, 6009, 1013, 92.00, '{\"base\":86,\"profile\":6}', 2, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-12 00:23:27');
INSERT INTO `zx_recommend_item` VALUES (7029, 6009, 1002, 88.00, '{\"base\":82,\"profile\":6}', 3, '匹配光照 light_soft、空间 space_small，适合演示首版推荐', '2026-05-12 00:23:27');
INSERT INTO `zx_recommend_item` VALUES (7030, 6010, 1012, 234.40, '{\"base\":40,\"water\":14,\"space\":18,\"care\":16,\"budget\":11.6,\"style\":15.4,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 1, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 00:27:47');
INSERT INTO `zx_recommend_item` VALUES (7031, 6010, 1015, 207.60, '{\"base\":40,\"space\":18,\"care\":16,\"style\":14.8,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":14.8}', 2, '基础上架候选，空间尺度匹配，养护投入匹配', '2026-05-12 00:27:47');
INSERT INTO `zx_recommend_item` VALUES (7032, 6010, 1003, 186.00, '{\"base\":40,\"light\":18.8,\"water\":14,\"space\":16.8,\"care\":16,\"style\":15.4,\"scene\":8.8,\"rule_FILTER_SMALL_SPACE\":16.8,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 3, '基础上架候选，光照条件匹配，浇水频率匹配', '2026-05-12 00:27:47');
INSERT INTO `zx_recommend_item` VALUES (7033, 6011, 1002, 215.60, '{\"base\":40,\"water\":12.8,\"space\":18,\"style\":14.8,\"pet\":20,\"goal\":18.8,\"goal_flag\":3,\"scene\":22.8,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_PURIFY\":19.8,\"rule_SCORE_SCENE_OFFICE\":12.8,\"rule_SCORE_STYLE_HEALING\":14.8}', 1, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 00:45:11');
INSERT INTO `zx_recommend_item` VALUES (7034, 6011, 1016, 180.60, '{\"base\":40,\"care\":14.8,\"budget\":12.2,\"style\":15.4,\"pet\":20,\"goal\":18.2,\"goal_flag\":3,\"scene\":10.2,\"rule_SCORE_PURIFY\":19.2,\"rule_SCORE_SCENE_OFFICE\":12.2,\"rule_SCORE_STYLE_HEALING\":15.4}', 2, '基础上架候选，养护投入匹配，预算区间匹配', '2026-05-12 00:45:11');
INSERT INTO `zx_recommend_item` VALUES (7035, 6011, 1020, 179.80, '{\"base\":40,\"light\":18.8,\"water\":12.8,\"budget\":12.2,\"pet\":20,\"goal\":18.8,\"goal_flag\":3,\"scene\":21.6,\"rule_SCORE_PURIFY\":19.8,\"rule_SCORE_SCENE_OFFICE\":12.8}', 3, '基础上架候选，光照条件匹配，浇水频率匹配', '2026-05-12 00:45:11');
INSERT INTO `zx_recommend_item` VALUES (7036, 6012, 1033, 186.40, '{\"base\":40,\"light\":19.4,\"space\":18,\"style\":15.4,\"goal\":17.4,\"scene\":23.4,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 1, '基础上架候选，光照条件匹配，空间尺度匹配', '2026-05-12 03:22:12');
INSERT INTO `zx_recommend_item` VALUES (7037, 6012, 1026, 185.20, '{\"base\":40,\"light\":20,\"space\":17.4,\"style\":15.4,\"goal\":17.4,\"scene\":22.8,\"rule_FILTER_SMALL_SPACE\":17.4,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 2, '基础上架候选，光照条件匹配，空间尺度匹配', '2026-05-12 03:22:12');
INSERT INTO `zx_recommend_item` VALUES (7038, 6012, 1027, 169.00, '{\"base\":40,\"light\":19.4,\"water\":13.4,\"space\":18,\"goal\":17.4,\"scene\":23.4,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_DESKTOP\":19.4}', 3, '基础上架候选，光照条件匹配，浇水频率匹配', '2026-05-12 03:22:12');
INSERT INTO `zx_recommend_item` VALUES (7039, 6013, 1002, 182.00, '{\"base\":40,\"care\":16,\"style\":14.8,\"goal\":17.4,\"scene\":22.8,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_SCENE_OFFICE\":12.8,\"rule_SCORE_STYLE_HEALING\":14.8}', 1, '基础上架候选，养护投入匹配，风格偏好匹配', '2026-05-12 06:56:39');
INSERT INTO `zx_recommend_item` VALUES (7040, 6013, 1027, 176.00, '{\"base\":40,\"light\":19.4,\"care\":15.4,\"style\":14.8,\"goal\":17.4,\"scene\":11.4,\"rule_SCORE_CARE_EASY\":23.4,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_STYLE_HEALING\":14.8}', 2, '基础上架候选，光照条件匹配，养护投入匹配', '2026-05-12 06:56:39');
INSERT INTO `zx_recommend_item` VALUES (7041, 6013, 1011, 173.60, '{\"base\":40,\"light\":19.4,\"care\":15.4,\"style\":14.2,\"goal\":16.8,\"scene\":11.4,\"rule_SCORE_CARE_EASY\":23.4,\"rule_SCORE_DESKTOP\":18.8,\"rule_SCORE_STYLE_HEALING\":14.2}', 3, '基础上架候选，光照条件匹配，养护投入匹配', '2026-05-12 06:56:39');
INSERT INTO `zx_recommend_item` VALUES (7042, 6014, 1011, 189.80, '{\"base\":40,\"light\":19.4,\"care\":15.4,\"pet\":18.8,\"goal\":16.8,\"scene\":23.8,\"rule_SCORE_CARE_EASY\":23.4,\"rule_SCORE_DESKTOP\":18.8,\"rule_SCORE_SCENE_BALCONY\":13.4}', 1, '基础上架候选，光照条件匹配，养护投入匹配', '2026-05-12 07:34:46');
INSERT INTO `zx_recommend_item` VALUES (7043, 6014, 1027, 181.80, '{\"base\":40,\"light\":19.4,\"care\":15.4,\"pet\":20,\"goal\":17.4,\"scene\":13.4,\"rule_SCORE_CARE_EASY\":23.4,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_SCENE_BALCONY\":13.4}', 2, '基础上架候选，光照条件匹配，养护投入匹配', '2026-05-12 07:34:46');
INSERT INTO `zx_recommend_item` VALUES (7044, 6014, 1040, 177.60, '{\"base\":40,\"light\":19.4,\"water\":14,\"space\":17.4,\"care\":16,\"pet\":20,\"scene\":13.4,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_SCENE_BALCONY\":13.4}', 3, '基础上架候选，光照条件匹配，浇水频率匹配', '2026-05-12 07:34:46');
INSERT INTO `zx_recommend_item` VALUES (7045, 6015, 1040, 187.20, '{\"base\":40,\"light\":19.4,\"space\":17.4,\"budget\":13.4,\"pet\":20,\"goal\":15.4,\"scene\":26.8,\"rule_SCORE_PRICE_HIGH\":15.4,\"rule_SCORE_LAYER_STATEMENT\":19.4}', 1, '基础上架候选，光照条件匹配，空间尺度匹配', '2026-05-12 07:57:25');
INSERT INTO `zx_recommend_item` VALUES (7046, 6015, 1032, 137.80, '{\"base\":40,\"light\":19.4,\"style\":14.8,\"pet\":20,\"goal\":13.4,\"rule_SCORE_LAYER_HANGING\":15.4,\"rule_SCORE_STYLE_HEALING\":14.8}', 2, '基础上架候选，光照条件匹配，风格偏好匹配', '2026-05-12 07:57:25');
INSERT INTO `zx_recommend_item` VALUES (7047, 6015, 1020, 137.20, '{\"base\":40,\"space\":17.4,\"pet\":20,\"goal\":14.8,\"scene\":26.2,\"rule_SCORE_LAYER_STATEMENT\":18.8}', 3, '基础上架候选，空间尺度匹配，宠物友好优先', '2026-05-12 07:57:25');
INSERT INTO `zx_recommend_item` VALUES (7048, 6016, 1012, 234.40, '{\"base\":40,\"water\":14,\"space\":18,\"care\":16,\"budget\":11.6,\"style\":15.4,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 1, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 08:09:48');
INSERT INTO `zx_recommend_item` VALUES (7049, 6016, 1026, 219.20, '{\"base\":40,\"water\":14,\"space\":17.4,\"care\":16,\"style\":15.4,\"goal\":17.4,\"scene\":22.8,\"rule_FILTER_SMALL_SPACE\":17.4,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 2, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 08:09:48');
INSERT INTO `zx_recommend_item` VALUES (7050, 6016, 1015, 207.60, '{\"base\":40,\"space\":18,\"care\":16,\"style\":14.8,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":14.8}', 3, '基础上架候选，空间尺度匹配，养护投入匹配', '2026-05-12 08:09:48');
INSERT INTO `zx_recommend_item` VALUES (7051, 6017, 1012, 234.40, '{\"base\":40,\"water\":14,\"space\":18,\"care\":16,\"budget\":11.6,\"style\":15.4,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 1, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 17:54:35');
INSERT INTO `zx_recommend_item` VALUES (7052, 6017, 1026, 219.20, '{\"base\":40,\"water\":14,\"space\":17.4,\"care\":16,\"style\":15.4,\"goal\":17.4,\"scene\":22.8,\"rule_FILTER_SMALL_SPACE\":17.4,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":19.4,\"rule_SCORE_STYLE_MINIMAL\":15.4}', 2, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 17:54:35');
INSERT INTO `zx_recommend_item` VALUES (7053, 6017, 1015, 207.60, '{\"base\":40,\"space\":18,\"care\":16,\"style\":14.8,\"goal\":18,\"scene\":24,\"rule_FILTER_SMALL_SPACE\":18,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_DESKTOP\":20,\"rule_SCORE_STYLE_MINIMAL\":14.8}', 3, '基础上架候选，空间尺度匹配，养护投入匹配', '2026-05-12 17:54:35');
INSERT INTO `zx_recommend_item` VALUES (7054, 6018, 1015, 260.40, '{\"base\":40,\"light\":18.8,\"space\":18,\"care\":16,\"budget\":12.8,\"style\":14.8,\"pet\":20,\"scene\":20.8,\"rule_FILTER_SMALL_SPACE\":18,\"rule_FILTER_LOW_LIGHT\":14.8,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_PRICE_LOW\":16.8,\"rule_SCORE_STYLE_MINIMAL\":14.8,\"rule_SCORE_SCENE_BEDROOM\":10.8}', 1, '基础上架候选，光照条件匹配，空间尺度匹配', '2026-05-12 18:13:59');
INSERT INTO `zx_recommend_item` VALUES (7055, 6018, 1043, 257.00, '{\"base\":40,\"water\":12.8,\"space\":16.8,\"care\":15.4,\"budget\":12.8,\"style\":14.8,\"pet\":20,\"goal\":19.4,\"goal_flag\":3,\"scene\":8.8,\"rule_FILTER_SMALL_SPACE\":16.8,\"rule_SCORE_CARE_EASY\":23.4,\"rule_SCORE_AROMA\":21.4,\"rule_SCORE_PRICE_LOW\":16.8,\"rule_SCORE_STYLE_MINIMAL\":14.8}', 2, '基础上架候选，浇水频率匹配，空间尺度匹配', '2026-05-12 18:13:59');
INSERT INTO `zx_recommend_item` VALUES (7056, 6018, 1012, 243.00, '{\"base\":40,\"light\":18.2,\"water\":14,\"space\":18,\"care\":16,\"style\":15.4,\"pet\":19.4,\"scene\":20.2,\"rule_FILTER_SMALL_SPACE\":18,\"rule_FILTER_LOW_LIGHT\":14.2,\"rule_SCORE_CARE_EASY\":24,\"rule_SCORE_STYLE_MINIMAL\":15.4,\"rule_SCORE_SCENE_BEDROOM\":10.2}', 3, '基础上架候选，光照条件匹配，浇水频率匹配', '2026-05-12 18:13:59');

-- ----------------------------
-- Table structure for zx_recommend_record
-- ----------------------------
DROP TABLE IF EXISTS `zx_recommend_record`;
CREATE TABLE `zx_recommend_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '推荐记录ID',
  `visitor_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客UID',
  `questionnaire_id` bigint NULL DEFAULT NULL COMMENT '问卷ID',
  `profile_id` bigint NULL DEFAULT NULL COMMENT '画像ID',
  `request_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数JSON',
  `result_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推荐结果JSON',
  `match_rule_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '命中规则JSON',
  `top_plant_id` bigint NULL DEFAULT NULL COMMENT '第一推荐植物ID',
  `total_candidate_count` int NULL DEFAULT 0 COMMENT '候选总数',
  `result_count` int NULL DEFAULT 0 COMMENT '返回结果数',
  `source_terminal` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '来源终端',
  `recommend_time` datetime NULL DEFAULT NULL COMMENT '推荐时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_zx_recommend_record_visitor`(`visitor_uid` ASC) USING BTREE,
  INDEX `idx_zx_recommend_record_time`(`recommend_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '推荐记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_recommend_record
-- ----------------------------
INSERT INTO `zx_recommend_record` VALUES (5001, 'guest_demo_001', 4001, 4501, '{\"scene\":\"bedroom\",\"light\":\"low\",\"space\":\"small\",\"pet\":\"true\",\"budget\":100,\"care\":\"easy\",\"style\":\"healing\",\"goal\":\"desktop\"}', '[{\"plantId\":1002,\"score\":95},{\"plantId\":1015,\"score\":92},{\"plantId\":1012,\"score\":89}]', '[\"FILTER_PET_SAFE\",\"FILTER_SMALL_SPACE\",\"FILTER_LOW_LIGHT\",\"SCORE_CARE_EASY\",\"SCORE_PRICE_LOW\",\"SCORE_DESKTOP\",\"SCORE_STYLE_HEALING\",\"SCORE_SCENE_BEDROOM\"]', 1002, 47, 3, 'h5', '2026-05-11 10:45:00');
INSERT INTO `zx_recommend_record` VALUES (5002, 'guest_demo_002', 4002, 4502, '{\"scene\":\"living\",\"light\":\"medium\",\"space\":\"large\",\"pet\":\"false\",\"budget\":300,\"care\":\"medium\",\"style\":\"tropical\",\"goal\":\"layered\"}', '[{\"plantId\":1004,\"score\":95},{\"plantId\":1018,\"score\":93},{\"plantId\":1008,\"score\":89}]', '[\"SCORE_PRICE_HIGH\",\"SCORE_LAYER_STATEMENT\",\"SCORE_STYLE_TROPICAL\"]', 1004, 47, 3, 'h5', '2026-05-11 10:46:00');
INSERT INTO `zx_recommend_record` VALUES (5003, 'guest_demo_003', 4003, 4503, '{\"scene\":\"balcony\",\"light\":\"high\",\"space\":\"medium\",\"pet\":\"false\",\"budget\":200,\"care\":\"medium\",\"style\":\"healing\",\"goal\":\"aroma\"}', '[{\"plantId\":1010,\"score\":95},{\"plantId\":1017,\"score\":92},{\"plantId\":1011,\"score\":89}]', '[\"SCORE_AROMA\",\"SCORE_SCENE_BALCONY\"]', 1010, 47, 3, 'h5', '2026-05-11 10:47:00');
INSERT INTO `zx_recommend_record` VALUES (5004, 'guest_demo_004', 4004, 4504, '{\"scene\":\"office\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"false\",\"budget\":200,\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"purify\"}', '[{\"plantId\":1013,\"score\":94},{\"plantId\":1003,\"score\":91},{\"plantId\":1001,\"score\":88}]', '[\"FILTER_SMALL_SPACE\",\"SCORE_CARE_EASY\",\"SCORE_PURIFY\",\"SCORE_SCENE_OFFICE\"]', 1013, 47, 3, 'h5', '2026-05-11 10:48:00');
INSERT INTO `zx_recommend_record` VALUES (5005, 'guest_demo_005', 4005, 4505, '{\"scene\":\"desk\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"false\",\"budget\":100,\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"desktop\"}', '[{\"plantId\":1015,\"score\":93},{\"plantId\":1012,\"score\":90},{\"plantId\":1009,\"score\":86}]', '[\"FILTER_SMALL_SPACE\",\"SCORE_CARE_EASY\",\"SCORE_PRICE_LOW\",\"SCORE_DESKTOP\",\"SCORE_STYLE_MINIMAL\"]', 1015, 47, 3, 'h5', '2026-05-11 10:49:00');
INSERT INTO `zx_recommend_record` VALUES (5006, 'guest_demo_006', 4006, 4506, '{\"scene\":\"living\",\"light\":\"low\",\"space\":\"large\",\"pet\":\"true\",\"budget\":200,\"care\":\"easy\",\"style\":\"tropical\",\"goal\":\"layered\"}', '[{\"plantId\":1020,\"score\":95},{\"plantId\":1014,\"score\":91},{\"plantId\":1002,\"score\":87}]', '[\"FILTER_PET_SAFE\",\"FILTER_LOW_LIGHT\",\"SCORE_LAYER_STATEMENT\",\"SCORE_STYLE_TROPICAL\"]', 1020, 47, 3, 'h5', '2026-05-11 10:50:00');
INSERT INTO `zx_recommend_record` VALUES (5007, 'guest_demo_007', 4007, 4507, '{\"scene\":\"bedroom\",\"light\":\"low\",\"space\":\"medium\",\"pet\":\"false\",\"budget\":200,\"care\":\"medium\",\"style\":\"healing\",\"goal\":\"layered\"}', '[{\"plantId\":1019,\"score\":93},{\"plantId\":1016,\"score\":90},{\"plantId\":1006,\"score\":86}]', '[\"FILTER_LOW_LIGHT\",\"SCORE_STYLE_HEALING\",\"SCORE_SCENE_BEDROOM\"]', 1019, 47, 3, 'h5', '2026-05-11 10:51:00');
INSERT INTO `zx_recommend_record` VALUES (5008, 'guest_demo_008', 4008, 4508, '{\"scene\":\"living\",\"light\":\"medium\",\"space\":\"large\",\"pet\":\"false\",\"budget\":300,\"care\":\"medium\",\"style\":\"minimal\",\"goal\":\"layered\"}', '[{\"plantId\":1018,\"score\":96},{\"plantId\":1005,\"score\":92},{\"plantId\":1008,\"score\":90}]', '[\"SCORE_PRICE_HIGH\",\"SCORE_LAYER_STATEMENT\",\"SCORE_STYLE_MINIMAL\"]', 1018, 47, 3, 'h5', '2026-05-11 10:52:00');
INSERT INTO `zx_recommend_record` VALUES (6000, 'runtime_case_01', 5000, 5000, '{\"questionnaireId\":5000,\"profileId\":5000,\"visitorUid\":\"runtime_case_01\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_shade\",\"spaceTagCode\":\"space_small\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_record` VALUES (6001, 'runtime_case_02', 5001, 5001, '{\"questionnaireId\":5001,\"profileId\":5001,\"visitorUid\":\"runtime_case_02\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_large\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_record` VALUES (6002, 'runtime_case_03', 5002, 5002, '{\"questionnaireId\":5002,\"profileId\":5002,\"visitorUid\":\"runtime_case_03\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_sun\",\"spaceTagCode\":\"space_medium\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_record` VALUES (6003, 'runtime_case_04', 5003, 5003, '{\"questionnaireId\":5003,\"profileId\":5003,\"visitorUid\":\"runtime_case_04\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_small\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_record` VALUES (6004, 'runtime_case_05', 5004, 5004, '{\"questionnaireId\":5004,\"profileId\":5004,\"visitorUid\":\"runtime_case_05\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_small\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:01');
INSERT INTO `zx_recommend_record` VALUES (6005, 'runtime_case_06', 5005, 5005, '{\"questionnaireId\":5005,\"profileId\":5005,\"visitorUid\":\"runtime_case_06\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_shade\",\"spaceTagCode\":\"space_large\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:02');
INSERT INTO `zx_recommend_record` VALUES (6006, 'runtime_case_07', 5006, 5006, '{\"questionnaireId\":5006,\"profileId\":5006,\"visitorUid\":\"runtime_case_07\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_shade\",\"spaceTagCode\":\"space_medium\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:02');
INSERT INTO `zx_recommend_record` VALUES (6007, 'runtime_case_08', 5007, 5007, '{\"questionnaireId\":5007,\"profileId\":5007,\"visitorUid\":\"runtime_case_08\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_large\"}]', 1004, 20, 3, 'web', '2026-05-11 23:52:02');
INSERT INTO `zx_recommend_record` VALUES (6008, 'runtime_case_office_chain', 5008, 5008, '{\"questionnaireId\":5008,\"profileId\":5008,\"visitorUid\":\"runtime_case_office_chain\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_small\"}]', 1004, 20, 3, 'web', '2026-05-11 23:53:35');
INSERT INTO `zx_recommend_record` VALUES (6009, 'visitor-1778516469575', 5009, 5009, '{\"questionnaireId\":5009,\"profileId\":5009,\"visitorUid\":\"visitor-1778516469575\"}', '[1004,1013,1002]', '[{\"type\":\"profile\",\"lightTagCode\":\"light_soft\",\"spaceTagCode\":\"space_small\"}]', 1004, 20, 3, 'web', '2026-05-12 00:23:27');
INSERT INTO `zx_recommend_record` VALUES (6010, 'visitor-1778516469575', 5010, 5009, '{\"questionnaireId\":5010,\"profileId\":5009,\"visitorUid\":\"visitor-1778516469575\"}', '[{\"plantId\":1012,\"score\":234.4},{\"plantId\":1015,\"score\":207.6},{\"plantId\":1003,\"score\":186}]', '{\"context\":{\"scene\":\"desk\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"false\",\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"desktop\",\"budget\":200},\"rules\":[{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_STYLE_MINIMAL\",\"desc\":\"简约风偏好优先线条利落的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1012, 20, 3, 'web', '2026-05-12 00:27:48');
INSERT INTO `zx_recommend_record` VALUES (6011, 'visitor-1778516453912', 5011, 5010, '{\"questionnaireId\":5011,\"profileId\":5010,\"visitorUid\":\"visitor-1778516453912\"}', '[{\"plantId\":1002,\"score\":215.6},{\"plantId\":1016,\"score\":180.6},{\"plantId\":1020,\"score\":179.8}]', '{\"context\":{\"scene\":\"office\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"true\",\"care\":\"medium\",\"style\":\"healing\",\"goal\":\"purify\",\"budget\":200},\"rules\":[{\"code\":\"FILTER_PET_SAFE\",\"desc\":\"宠物家庭优先排除宠物慎选植物。\"},{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"SCORE_PURIFY\",\"desc\":\"净化诉求下提高净化植物得分。\"},{\"code\":\"SCORE_SCENE_OFFICE\",\"desc\":\"办公室场景优先考虑净化和低维护植物。\"},{\"code\":\"SCORE_STYLE_HEALING\",\"desc\":\"治愈风偏好优先叶面柔和的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1002, 11, 3, 'web', '2026-05-12 00:45:11');
INSERT INTO `zx_recommend_record` VALUES (6012, 'visitor-1778509390737', 5012, 5011, '{\"questionnaireId\":5012,\"profileId\":5011,\"visitorUid\":\"visitor-1778509390737\"}', '[{\"plantId\":1033,\"score\":186.4},{\"plantId\":1026,\"score\":185.2},{\"plantId\":1027,\"score\":169}]', '{\"context\":{\"scene\":\"desk\",\"light\":\"high\",\"space\":\"small\",\"pet\":\"false\",\"care\":\"hard\",\"style\":\"minimal\",\"goal\":\"desktop\",\"budget\":300},\"rules\":[{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"SCORE_PRICE_HIGH\",\"desc\":\"预算充足时提高高体量陈设植物权重。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_STYLE_MINIMAL\",\"desc\":\"简约风偏好优先线条利落的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1033, 47, 3, 'web', '2026-05-12 03:22:13');
INSERT INTO `zx_recommend_record` VALUES (6013, 'visitor-1778534212272', 5013, 5012, '{\"questionnaireId\":5013,\"profileId\":5012,\"visitorUid\":\"visitor-1778534212272\"}', '[{\"plantId\":1002,\"score\":182},{\"plantId\":1027,\"score\":176},{\"plantId\":1011,\"score\":173.6}]', '{\"context\":{\"scene\":\"office\",\"light\":\"high\",\"space\":\"medium\",\"pet\":\"false\",\"care\":\"easy\",\"style\":\"healing\",\"goal\":\"desktop\",\"budget\":300},\"rules\":[{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_PRICE_HIGH\",\"desc\":\"预算充足时提高高体量陈设植物权重。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_SCENE_OFFICE\",\"desc\":\"办公室场景优先考虑净化和低维护植物。\"},{\"code\":\"SCORE_STYLE_HEALING\",\"desc\":\"治愈风偏好优先叶面柔和的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1002, 47, 3, 'web', '2026-05-12 06:56:39');
INSERT INTO `zx_recommend_record` VALUES (6014, 'visitor-1778534212272', 5014, 5012, '{\"questionnaireId\":5014,\"profileId\":5012,\"visitorUid\":\"visitor-1778534212272\"}', '[{\"plantId\":1011,\"score\":189.8},{\"plantId\":1027,\"score\":181.8},{\"plantId\":1040,\"score\":177.6}]', '{\"context\":{\"scene\":\"balcony\",\"light\":\"high\",\"space\":\"large\",\"pet\":\"true\",\"care\":\"easy\",\"style\":\"tropical\",\"goal\":\"desktop\",\"budget\":200},\"rules\":[{\"code\":\"FILTER_PET_SAFE\",\"desc\":\"宠物家庭优先排除宠物慎选植物。\"},{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_SCENE_BALCONY\",\"desc\":\"阳台场景优先考虑耐日照植物。\"},{\"code\":\"SCORE_STYLE_TROPICAL\",\"desc\":\"热带风偏好优先大叶舒展植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1011, 23, 3, 'web', '2026-05-12 07:34:46');
INSERT INTO `zx_recommend_record` VALUES (6015, 'visitor-1778534212272', 5015, 5012, '{\"questionnaireId\":5015,\"profileId\":5012,\"visitorUid\":\"visitor-1778534212272\"}', '[{\"plantId\":1040,\"score\":187.2},{\"plantId\":1032,\"score\":137.8},{\"plantId\":1020,\"score\":137.2}]', '{\"context\":{\"scene\":\"living\",\"light\":\"high\",\"space\":\"large\",\"pet\":\"true\",\"care\":\"hard\",\"style\":\"healing\",\"goal\":\"layered\",\"budget\":300},\"rules\":[{\"code\":\"FILTER_PET_SAFE\",\"desc\":\"宠物家庭优先排除宠物慎选植物。\"},{\"code\":\"SCORE_PRICE_HIGH\",\"desc\":\"预算充足时提高高体量陈设植物权重。\"},{\"code\":\"SCORE_LAYER_HANGING\",\"desc\":\"空间层次目标优先垂吊或延展型植物。\"},{\"code\":\"SCORE_LAYER_STATEMENT\",\"desc\":\"空间层次目标优先陈设感更强的主景植物。\"},{\"code\":\"SCORE_STYLE_HEALING\",\"desc\":\"治愈风偏好优先叶面柔和的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1040, 23, 3, 'web', '2026-05-12 07:57:25');
INSERT INTO `zx_recommend_record` VALUES (6016, 'visitor-1778534212272', 5016, 5012, '{\"questionnaireId\":5016,\"profileId\":5012,\"visitorUid\":\"visitor-1778534212272\"}', '[{\"plantId\":1012,\"score\":234.4},{\"plantId\":1026,\"score\":219.2},{\"plantId\":1015,\"score\":207.6}]', '{\"context\":{\"scene\":\"desk\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"false\",\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"desktop\",\"budget\":200},\"rules\":[{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_STYLE_MINIMAL\",\"desc\":\"简约风偏好优先线条利落的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1012, 47, 3, 'web', '2026-05-12 08:09:48');
INSERT INTO `zx_recommend_record` VALUES (6017, 'visitor-1778516453912', 5017, 5010, '{\"questionnaireId\":5017,\"profileId\":5010,\"visitorUid\":\"visitor-1778516453912\"}', '[{\"plantId\":1012,\"score\":234.4},{\"plantId\":1026,\"score\":219.2},{\"plantId\":1015,\"score\":207.6}]', '{\"context\":{\"scene\":\"desk\",\"light\":\"medium\",\"space\":\"small\",\"pet\":\"false\",\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"desktop\",\"budget\":200},\"rules\":[{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_DESKTOP\",\"desc\":\"桌面绿植目标优先桌面型植物。\"},{\"code\":\"SCORE_STYLE_MINIMAL\",\"desc\":\"简约风偏好优先线条利落的植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1012, 47, 3, 'web', '2026-05-12 17:54:35');
INSERT INTO `zx_recommend_record` VALUES (6018, 'visitor-1778509390737', 5018, 5011, '{\"questionnaireId\":5018,\"profileId\":5011,\"visitorUid\":\"visitor-1778509390737\"}', '[{\"plantId\":1015,\"score\":260.4},{\"plantId\":1043,\"score\":257},{\"plantId\":1012,\"score\":243}]', '{\"context\":{\"scene\":\"bedroom\",\"light\":\"low\",\"space\":\"small\",\"pet\":\"true\",\"care\":\"easy\",\"style\":\"minimal\",\"goal\":\"aroma\",\"budget\":100},\"rules\":[{\"code\":\"FILTER_PET_SAFE\",\"desc\":\"宠物家庭优先排除宠物慎选植物。\"},{\"code\":\"FILTER_SMALL_SPACE\",\"desc\":\"小空间场景优先提高桌面型和小体量植物权重。\"},{\"code\":\"FILTER_LOW_LIGHT\",\"desc\":\"弱光环境优先筛出耐阴植物。\"},{\"code\":\"SCORE_CARE_EASY\",\"desc\":\"希望好养时，对低养护植物加权。\"},{\"code\":\"SCORE_AROMA\",\"desc\":\"偏好闻香和观花时，优先芳香型植物。\"},{\"code\":\"SCORE_PRICE_LOW\",\"desc\":\"预算较低时优先性价比植物。\"},{\"code\":\"SCORE_STYLE_MINIMAL\",\"desc\":\"简约风偏好优先线条利落的植物。\"},{\"code\":\"SCORE_SCENE_BEDROOM\",\"desc\":\"卧室场景优先耐弱光和柔和叶型植物。\"},{\"code\":\"EXPLAIN_TAG_MATCH\",\"desc\":\"用于生成推荐原因文本。\"}]}', 1015, 23, 3, 'web', '2026-05-12 18:14:00');

-- ----------------------------
-- Table structure for zx_recommend_rule
-- ----------------------------
DROP TABLE IF EXISTS `zx_recommend_rule`;
CREATE TABLE `zx_recommend_rule`  (
  `rule_id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `rule_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则名称',
  `rule_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则编码',
  `rule_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '规则类型',
  `trigger_field` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '触发字段',
  `trigger_operator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '触发操作符',
  `trigger_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '触发值',
  `action_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '执行动作类型',
  `action_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '执行动作值',
  `score_value` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '加权分值',
  `priority_num` int NULL DEFAULT 0 COMMENT '优先级',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `rule_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '规则说明',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`rule_id`) USING BTREE,
  UNIQUE INDEX `uk_zx_recommend_rule_code`(`rule_code` ASC) USING BTREE,
  INDEX `idx_zx_recommend_rule_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '推荐规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_recommend_rule
-- ----------------------------
INSERT INTO `zx_recommend_rule` VALUES (3001, '宠物家庭过滤', 'FILTER_PET_SAFE', 'filter', 'pet', '=', 'true', 'excludeTag', 'pet_no', 0.00, 10, '0', '宠物家庭优先排除宠物慎选植物。', 'admin', '2026-05-11 10:20:00', '', NULL, '过滤规则');
INSERT INTO `zx_recommend_rule` VALUES (3002, '小空间过滤', 'FILTER_SMALL_SPACE', 'filter', 'space', '=', 'small', 'preferTag', 'space_small', 12.00, 20, '0', '小空间场景优先提高桌面型和小体量植物权重。', 'admin', '2026-05-11 10:20:30', '', NULL, '过滤规则');
INSERT INTO `zx_recommend_rule` VALUES (3003, '低光照过滤', 'FILTER_LOW_LIGHT', 'filter', 'light', '=', 'low', 'preferTag', 'light_low', 10.00, 30, '0', '弱光环境优先筛出耐阴植物。', 'admin', '2026-05-11 10:21:00', '', NULL, '过滤规则');
INSERT INTO `zx_recommend_rule` VALUES (3004, '好养加分', 'SCORE_CARE_EASY', 'score', 'care', '=', 'easy', 'addScoreByTag', 'care_easy', 18.00, 40, '0', '希望好养时，对低养护植物加权。', 'admin', '2026-05-11 10:21:30', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3005, '空气净化加分', 'SCORE_PURIFY', 'score', 'goal', '=', 'purify', 'addScoreByTag', 'function_purify', 15.00, 50, '0', '净化诉求下提高净化植物得分。', 'admin', '2026-05-11 10:22:00', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3006, '闻香观花加分', 'SCORE_AROMA', 'score', 'goal', '=', 'aroma', 'addScoreByTag', 'function_aroma', 16.00, 60, '0', '偏好闻香和观花时，优先芳香型植物。', 'admin', '2026-05-11 10:22:30', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3007, '低预算加分', 'SCORE_PRICE_LOW', 'score', 'budget', '<=', '100', 'addScoreByTag', 'price_low', 12.00, 70, '0', '预算较低时优先性价比植物。', 'admin', '2026-05-11 10:23:00', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3008, '高预算加分', 'SCORE_PRICE_HIGH', 'score', 'budget', '>=', '300', 'addScoreByTag', 'price_high', 10.00, 72, '0', '预算充足时提高高体量陈设植物权重。', 'admin', '2026-05-11 10:23:10', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3009, '桌面目标加分', 'SCORE_DESKTOP', 'score', 'goal', '=', 'desktop', 'preferTag', 'feature_desktop', 14.00, 80, '0', '桌面绿植目标优先桌面型植物。', 'admin', '2026-05-11 10:23:20', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3010, '层次目标垂吊加分', 'SCORE_LAYER_HANGING', 'score', 'goal', '=', 'layered', 'preferTag', 'feature_hanging', 10.00, 82, '0', '空间层次目标优先垂吊或延展型植物。', 'admin', '2026-05-11 10:23:30', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3011, '层次目标陈设加分', 'SCORE_LAYER_STATEMENT', 'score', 'goal', '=', 'layered', 'preferTag', 'feature_statement', 14.00, 84, '0', '空间层次目标优先陈设感更强的主景植物。', 'admin', '2026-05-11 10:23:40', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3012, '办公场景加分', 'SCORE_SCENE_OFFICE', 'score', 'scene', '=', 'office', 'addScoreByTag', 'function_purify', 8.00, 90, '0', '办公室场景优先考虑净化和低维护植物。', 'admin', '2026-05-11 10:23:50', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3013, '阳台场景加分', 'SCORE_SCENE_BALCONY', 'score', 'scene', '=', 'balcony', 'addScoreByTag', 'light_high', 8.00, 92, '0', '阳台场景优先考虑耐日照植物。', 'admin', '2026-05-11 10:24:00', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3014, '简约风格加分', 'SCORE_STYLE_MINIMAL', 'score', 'style', '=', 'minimal', 'addScoreByTag', 'style_minimal', 10.00, 100, '0', '简约风偏好优先线条利落的植物。', 'admin', '2026-05-11 10:24:10', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3015, '治愈风格加分', 'SCORE_STYLE_HEALING', 'score', 'style', '=', 'healing', 'addScoreByTag', 'style_healing', 10.00, 102, '0', '治愈风偏好优先叶面柔和的植物。', 'admin', '2026-05-11 10:24:20', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3016, '热带风格加分', 'SCORE_STYLE_TROPICAL', 'score', 'style', '=', 'tropical', 'addScoreByTag', 'style_tropical', 12.00, 104, '0', '热带风偏好优先大叶舒展植物。', 'admin', '2026-05-11 10:24:30', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3017, '卧室场景加分', 'SCORE_SCENE_BEDROOM', 'score', 'scene', '=', 'bedroom', 'addScoreByTag', 'light_low', 6.00, 106, '0', '卧室场景优先耐弱光和柔和叶型植物。', 'admin', '2026-05-11 10:24:40', '', NULL, '加分规则');
INSERT INTO `zx_recommend_rule` VALUES (3018, '命中标签解释', 'EXPLAIN_TAG_MATCH', 'explain', 'match', '=', 'true', 'appendReason', 'tag_match', 0.00, 110, '0', '用于生成推荐原因文本。', 'admin', '2026-05-11 10:24:50', '', NULL, '解释规则');

-- ----------------------------
-- Table structure for zx_user_profile
-- ----------------------------
DROP TABLE IF EXISTS `zx_user_profile`;
CREATE TABLE `zx_user_profile`  (
  `profile_id` bigint NOT NULL AUTO_INCREMENT COMMENT '画像ID',
  `visitor_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客UID',
  `latest_questionnaire_id` bigint NULL DEFAULT NULL COMMENT '最近问卷ID',
  `profile_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '画像JSON',
  `light_tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '光照标签',
  `water_tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浇水标签',
  `space_tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '空间标签',
  `style_tag_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '风格标签',
  `budget_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '预算档位',
  `pet_preference` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '宠物偏好（0否 1是）',
  `care_preference` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '养护偏好（1低 2中 3高）',
  `last_recommend_time` datetime NULL DEFAULT NULL COMMENT '最近推荐时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`profile_id`) USING BTREE,
  UNIQUE INDEX `uk_zx_user_profile_visitor`(`visitor_uid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5013 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户画像表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zx_user_profile
-- ----------------------------
INSERT INTO `zx_user_profile` VALUES (4501, 'guest_demo_001', 4001, '{\"lightTagCode\":\"light_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"1\",\"petPreference\":\"1\",\"carePreference\":\"1\"}', 'light_low', 'water_low', 'space_small', 'style_healing', '1', '1', '1', '2026-05-11 10:45:00', '2026-05-11 10:30:30', '2026-05-11 10:45:00');
INSERT INTO `zx_user_profile` VALUES (4502, 'guest_demo_002', 4002, '{\"lightTagCode\":\"light_medium\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_tropical\",\"budgetLevel\":\"3\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_medium', 'water_medium', 'space_large', 'style_tropical', '3', '0', '2', '2026-05-11 10:46:00', '2026-05-11 10:32:30', '2026-05-11 10:46:00');
INSERT INTO `zx_user_profile` VALUES (4503, 'guest_demo_003', 4003, '{\"lightTagCode\":\"light_high\",\"spaceTagCode\":\"space_medium\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_high', 'water_medium', 'space_medium', 'style_healing', '2', '0', '2', '2026-05-11 10:47:00', '2026-05-11 10:34:30', '2026-05-11 10:47:00');
INSERT INTO `zx_user_profile` VALUES (4504, 'guest_demo_004', 4004, '{\"lightTagCode\":\"light_medium\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_medium', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-11 10:48:00', '2026-05-11 10:36:30', '2026-05-11 10:48:00');
INSERT INTO `zx_user_profile` VALUES (4505, 'guest_demo_005', 4005, '{\"lightTagCode\":\"light_medium\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"1\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_medium', 'water_low', 'space_small', 'style_minimal', '1', '0', '1', '2026-05-11 10:49:00', '2026-05-11 10:38:30', '2026-05-11 10:49:00');
INSERT INTO `zx_user_profile` VALUES (4506, 'guest_demo_006', 4006, '{\"lightTagCode\":\"light_low\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_tropical\",\"budgetLevel\":\"2\",\"petPreference\":\"1\",\"carePreference\":\"1\"}', 'light_low', 'water_low', 'space_large', 'style_tropical', '2', '1', '1', '2026-05-11 10:50:00', '2026-05-11 10:40:30', '2026-05-11 10:50:00');
INSERT INTO `zx_user_profile` VALUES (4507, 'guest_demo_007', 4007, '{\"lightTagCode\":\"light_low\",\"spaceTagCode\":\"space_medium\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_low', 'water_medium', 'space_medium', 'style_healing', '2', '0', '2', '2026-05-11 10:51:00', '2026-05-11 10:42:30', '2026-05-11 10:51:00');
INSERT INTO `zx_user_profile` VALUES (4508, 'guest_demo_008', 4008, '{\"lightTagCode\":\"light_medium\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"3\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_medium', 'water_medium', 'space_large', 'style_minimal', '3', '0', '2', '2026-05-11 10:52:00', '2026-05-11 10:44:30', '2026-05-11 10:52:00');
INSERT INTO `zx_user_profile` VALUES (5000, 'runtime_case_01', 5000, '{\"lightTagCode\":\"light_shade\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"1\",\"petPreference\":\"1\",\"carePreference\":\"1\"}', 'light_shade', 'water_low', 'space_small', 'style_healing', '1', '1', '1', '2026-05-11 23:52:01', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5001, 'runtime_case_02', 5001, '{\"lightTagCode\":\"light_soft\",\"waterTagCode\":\"water_medium\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_tropical\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_soft', 'water_medium', 'space_large', 'style_tropical', '2', '0', '2', '2026-05-11 23:52:01', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5002, 'runtime_case_03', 5002, '{\"lightTagCode\":\"light_sun\",\"waterTagCode\":\"water_medium\",\"spaceTagCode\":\"space_medium\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_sun', 'water_medium', 'space_medium', 'style_healing', '2', '0', '2', '2026-05-11 23:52:01', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5003, 'runtime_case_04', 5003, '{\"lightTagCode\":\"light_soft\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_soft', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-11 23:52:01', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5004, 'runtime_case_05', 5004, '{\"lightTagCode\":\"light_soft\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"1\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_soft', 'water_low', 'space_small', 'style_minimal', '1', '0', '1', '2026-05-11 23:52:01', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5005, 'runtime_case_06', 5005, '{\"lightTagCode\":\"light_shade\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_tropical\",\"budgetLevel\":\"2\",\"petPreference\":\"1\",\"carePreference\":\"1\"}', 'light_shade', 'water_low', 'space_large', 'style_tropical', '2', '1', '1', '2026-05-11 23:52:02', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5006, 'runtime_case_07', 5006, '{\"lightTagCode\":\"light_shade\",\"waterTagCode\":\"water_medium\",\"spaceTagCode\":\"space_medium\",\"styleTagCode\":\"style_healing\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_shade', 'water_medium', 'space_medium', 'style_healing', '2', '0', '2', '2026-05-11 23:52:02', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5007, 'runtime_case_08', 5007, '{\"lightTagCode\":\"light_soft\",\"waterTagCode\":\"water_medium\",\"spaceTagCode\":\"space_large\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"2\"}', 'light_soft', 'water_medium', 'space_large', 'style_minimal', '2', '0', '2', '2026-05-11 23:52:02', '2026-05-11 23:52:01', '2026-05-11 23:52:01');
INSERT INTO `zx_user_profile` VALUES (5008, 'runtime_case_office_chain', 5008, '{\"lightTagCode\":\"light_soft\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_soft', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-11 23:53:35', '2026-05-11 23:53:35', '2026-05-11 23:53:35');
INSERT INTO `zx_user_profile` VALUES (5009, 'visitor-1778516469575', 5010, '{\"lightTagCode\":\"light_medium\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_medium', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-12 00:27:48', '2026-05-12 00:23:27', '2026-05-12 00:27:47');
INSERT INTO `zx_user_profile` VALUES (5010, 'visitor-1778516453912', 5017, '{\"lightTagCode\":\"light_medium\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_medium', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-12 17:54:35', '2026-05-12 00:45:11', '2026-05-12 17:54:35');
INSERT INTO `zx_user_profile` VALUES (5011, 'visitor-1778509390737', 5018, '{\"lightTagCode\":\"light_low\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"1\",\"petPreference\":\"1\",\"carePreference\":\"1\"}', 'light_low', 'water_low', 'space_small', 'style_minimal', '1', '1', '1', '2026-05-12 18:14:00', '2026-05-12 03:22:12', '2026-05-12 18:13:59');
INSERT INTO `zx_user_profile` VALUES (5012, 'visitor-1778534212272', 5016, '{\"lightTagCode\":\"light_medium\",\"waterTagCode\":\"water_low\",\"spaceTagCode\":\"space_small\",\"styleTagCode\":\"style_minimal\",\"budgetLevel\":\"2\",\"petPreference\":\"0\",\"carePreference\":\"1\"}', 'light_medium', 'water_low', 'space_small', 'style_minimal', '2', '0', '1', '2026-05-12 08:09:48', '2026-05-12 06:56:38', '2026-05-12 08:09:48');

SET FOREIGN_KEY_CHECKS = 1;
