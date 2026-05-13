-- 植物个性化推荐系统 Demo
-- 阶段 1：业务表结构最终执行版
-- 用途：首次建表或结构重建时执行。

set names utf8mb4;
set @old_foreign_key_checks = @@foreign_key_checks;
set foreign_key_checks = 0;

-- ----------------------------
-- 1、植物分类表
-- ----------------------------
drop table if exists zx_plant_category;
create table zx_plant_category (
  category_id        bigint(20)      not null auto_increment    comment '分类ID',
  parent_id          bigint(20)      default 0                  comment '父分类ID',
  ancestors          varchar(500)    default ''                 comment '祖级列表',
  category_name      varchar(100)    not null                   comment '分类名称',
  category_code      varchar(64)     default ''                 comment '分类编码',
  order_num          int(4)          default 0                  comment '显示顺序',
  status             char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag           char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by          varchar(64)     default ''                 comment '创建者',
  create_time        datetime                                   comment '创建时间',
  update_by          varchar(64)     default ''                 comment '更新者',
  update_time        datetime                                   comment '更新时间',
  remark             varchar(500)    default null               comment '备注',
  primary key (category_id),
  key idx_zx_plant_category_parent (parent_id),
  key idx_zx_plant_category_status (status)
) engine=innodb comment = '植物分类表';


-- ----------------------------
-- 2、植物主表
-- ----------------------------
drop table if exists zx_plant;
create table zx_plant (
  plant_id            bigint(20)      not null auto_increment    comment '植物ID',
  category_id         bigint(20)      default null               comment '分类ID',
  plant_name          varchar(100)    not null                   comment '植物名称',
  plant_code          varchar(64)     default ''                 comment '植物编码',
  alias_name          varchar(100)    default ''                 comment '别名',
  cover_image         varchar(255)    default ''                 comment '封面图',
  plant_summary       varchar(500)    default ''                 comment '植物简介',
  difficulty_level    char(1)         default '1'                comment '养护难度（1低 2中 3高）',
  price_level         char(1)         default '1'                comment '价格级别（1低 2中 3高）',
  display_status      char(1)         default '0'                comment '展示状态（0上架 1下架）',
  pet_safe_flag       char(1)         default '0'                comment '宠物友好（0否 1是）',
  purge_effect_flag   char(1)         default '0'                comment '净化能力（0否 1是）',
  aroma_flag          char(1)         default '0'                comment '芳香属性（0否 1是）',
  suitable_scene      varchar(255)    default ''                 comment '适用场景',
  sort_num            int(4)          default 0                  comment '排序号',
  status              char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag            char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by           varchar(64)     default ''                 comment '创建者',
  create_time         datetime                                   comment '创建时间',
  update_by           varchar(64)     default ''                 comment '更新者',
  update_time         datetime                                   comment '更新时间',
  remark              varchar(500)    default null               comment '备注',
  primary key (plant_id),
  key idx_zx_plant_category (category_id),
  key idx_zx_plant_status (status),
  key idx_zx_plant_display (display_status)
) engine=innodb comment = '植物主表';


-- ----------------------------
-- 3、植物详情表
-- ----------------------------
drop table if exists zx_plant_detail;
create table zx_plant_detail (
  detail_id             bigint(20)      not null auto_increment    comment '详情ID',
  plant_id              bigint(20)      not null                   comment '植物ID',
  light_requirement     varchar(100)    default ''                 comment '光照要求',
  water_requirement     varchar(100)    default ''                 comment '浇水频率',
  temperature_range     varchar(100)    default ''                 comment '适温范围',
  humidity_requirement  varchar(100)    default ''                 comment '湿度要求',
  grow_cycle            varchar(100)    default ''                 comment '生长周期',
  care_tips             text                                        comment '养护建议',
  risk_tips             varchar(500)    default ''                 comment '风险提示',
  display_content       text                                        comment '展示内容',
  create_by             varchar(64)     default ''                 comment '创建者',
  create_time           datetime                                   comment '创建时间',
  update_by             varchar(64)     default ''                 comment '更新者',
  update_time           datetime                                   comment '更新时间',
  remark                varchar(500)    default null               comment '备注',
  primary key (detail_id),
  unique key uk_zx_plant_detail_plant (plant_id)
) engine=innodb comment = '植物详情表';


-- ----------------------------
-- 4、植物标签字典表
-- ----------------------------
drop table if exists zx_plant_tag;
create table zx_plant_tag (
  tag_id              bigint(20)      not null auto_increment    comment '标签ID',
  tag_name            varchar(100)    not null                   comment '标签名称',
  tag_code            varchar(64)     not null                   comment '标签编码',
  tag_group           varchar(64)     default ''                 comment '标签分组',
  tag_desc            varchar(255)    default ''                 comment '标签描述',
  sort_num            int(4)          default 0                  comment '排序号',
  status              char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag            char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by           varchar(64)     default ''                 comment '创建者',
  create_time         datetime                                   comment '创建时间',
  update_by           varchar(64)     default ''                 comment '更新者',
  update_time         datetime                                   comment '更新时间',
  remark              varchar(500)    default null               comment '备注',
  primary key (tag_id),
  unique key uk_zx_plant_tag_code (tag_code)
) engine=innodb comment = '植物标签字典表';


-- ----------------------------
-- 5、植物标签关联表
-- ----------------------------
drop table if exists zx_plant_tag_rel;
create table zx_plant_tag_rel (
  rel_id              bigint(20)      not null auto_increment    comment '关联ID',
  plant_id            bigint(20)      not null                   comment '植物ID',
  tag_id              bigint(20)      not null                   comment '标签ID',
  tag_code            varchar(64)     default ''                 comment '标签编码冗余',
  score_weight        decimal(8,2)    default 0.00               comment '标签权重',
  create_by           varchar(64)     default ''                 comment '创建者',
  create_time         datetime                                   comment '创建时间',
  remark              varchar(500)    default null               comment '备注',
  primary key (rel_id),
  unique key uk_zx_plant_tag_rel (plant_id, tag_id),
  key idx_zx_plant_tag_rel_tag (tag_id)
) engine=innodb comment = '植物标签关联表';


-- ----------------------------
-- 6、推荐规则表
-- ----------------------------
drop table if exists zx_recommend_rule;
create table zx_recommend_rule (
  rule_id               bigint(20)      not null auto_increment    comment '规则ID',
  rule_name             varchar(100)    not null                   comment '规则名称',
  rule_code             varchar(64)     not null                   comment '规则编码',
  rule_type             varchar(32)     default ''                 comment '规则类型',
  trigger_field         varchar(64)     default ''                 comment '触发字段',
  trigger_operator      varchar(32)     default ''                 comment '触发操作符',
  trigger_value         varchar(255)    default ''                 comment '触发值',
  action_type           varchar(32)     default ''                 comment '执行动作类型',
  action_value          varchar(255)    default ''                 comment '执行动作值',
  score_value           decimal(8,2)    default 0.00               comment '加权分值',
  priority_num          int(6)          default 0                  comment '优先级',
  status                char(1)         default '0'                comment '状态（0启用 1停用）',
  rule_desc             varchar(500)    default ''                 comment '规则说明',
  create_by             varchar(64)     default ''                 comment '创建者',
  create_time           datetime                                   comment '创建时间',
  update_by             varchar(64)     default ''                 comment '更新者',
  update_time           datetime                                   comment '更新时间',
  remark                varchar(500)    default null               comment '备注',
  primary key (rule_id),
  unique key uk_zx_recommend_rule_code (rule_code),
  key idx_zx_recommend_rule_status (status)
) engine=innodb comment = '推荐规则表';


-- ----------------------------
-- 7、问卷记录表
-- ----------------------------
drop table if exists zx_questionnaire_record;
create table zx_questionnaire_record (
  questionnaire_id      bigint(20)      not null auto_increment    comment '问卷ID',
  visitor_uid           varchar(64)     not null                   comment '访客UID',
  source_terminal       varchar(32)     default ''                 comment '来源终端',
  source_channel        varchar(32)     default ''                 comment '来源渠道',
  answer_json           text                                        comment '问卷答案JSON',
  environment_summary   varchar(500)    default ''                 comment '环境摘要',
  preference_summary    varchar(500)    default ''                 comment '偏好摘要',
  budget_value          decimal(10,2)   default 0.00               comment '预算值',
  submit_ip             varchar(64)     default ''                 comment '提交IP',
  submit_time           datetime                                   comment '提交时间',
  primary key (questionnaire_id),
  key idx_zx_questionnaire_visitor (visitor_uid),
  key idx_zx_questionnaire_submit (submit_time)
) engine=innodb comment = '问卷记录表';


-- ----------------------------
-- 8、用户画像表
-- ----------------------------
drop table if exists zx_user_profile;
create table zx_user_profile (
  profile_id                bigint(20)      not null auto_increment    comment '画像ID',
  visitor_uid               varchar(64)     not null                   comment '访客UID',
  latest_questionnaire_id   bigint(20)      default null               comment '最近问卷ID',
  profile_json              text                                        comment '画像JSON',
  light_tag_code            varchar(64)     default ''                 comment '光照标签',
  water_tag_code            varchar(64)     default ''                 comment '浇水标签',
  space_tag_code            varchar(64)     default ''                 comment '空间标签',
  style_tag_code            varchar(64)     default ''                 comment '风格标签',
  budget_level              char(1)         default '1'                comment '预算档位',
  pet_preference            char(1)         default '0'                comment '宠物偏好（0否 1是）',
  care_preference           char(1)         default '1'                comment '养护偏好（1低 2中 3高）',
  last_recommend_time       datetime                                   comment '最近推荐时间',
  create_time               datetime                                   comment '创建时间',
  update_time               datetime                                   comment '更新时间',
  primary key (profile_id),
  unique key uk_zx_user_profile_visitor (visitor_uid)
) engine=innodb comment = '用户画像表';


-- ----------------------------
-- 9、推荐记录表
-- ----------------------------
drop table if exists zx_recommend_record;
create table zx_recommend_record (
  record_id                bigint(20)      not null auto_increment    comment '推荐记录ID',
  visitor_uid              varchar(64)     not null                   comment '访客UID',
  questionnaire_id         bigint(20)      default null               comment '问卷ID',
  profile_id               bigint(20)      default null               comment '画像ID',
  request_json             text                                        comment '请求参数JSON',
  result_json              text                                        comment '推荐结果JSON',
  match_rule_json          text                                        comment '命中规则JSON',
  top_plant_id             bigint(20)      default null               comment '第一推荐植物ID',
  total_candidate_count    int(11)         default 0                  comment '候选总数',
  result_count             int(11)         default 0                  comment '返回结果数',
  source_terminal          varchar(32)     default ''                 comment '来源终端',
  recommend_time           datetime                                   comment '推荐时间',
  primary key (record_id),
  key idx_zx_recommend_record_visitor (visitor_uid),
  key idx_zx_recommend_record_time (recommend_time)
) engine=innodb comment = '推荐记录表';


-- ----------------------------
-- 10、推荐明细表
-- ----------------------------
drop table if exists zx_recommend_item;
create table zx_recommend_item (
  item_id                 bigint(20)      not null auto_increment    comment '推荐明细ID',
  record_id               bigint(20)      not null                   comment '推荐记录ID',
  plant_id                bigint(20)      not null                   comment '植物ID',
  score_total             decimal(8,2)    default 0.00               comment '总分',
  score_detail_json       text                                        comment '分项分数JSON',
  rank_num                int(11)         default 0                  comment '排序名次',
  reason_text             varchar(500)    default ''                 comment '推荐原因',
  create_time             datetime                                   comment '创建时间',
  primary key (item_id),
  key idx_zx_recommend_item_record (record_id),
  key idx_zx_recommend_item_plant (plant_id)
) engine=innodb comment = '推荐明细表';


-- ----------------------------
-- 11、反馈记录表
-- ----------------------------
drop table if exists zx_feedback_record;
create table zx_feedback_record (
  feedback_id            bigint(20)      not null auto_increment    comment '反馈ID',
  visitor_uid            varchar(64)     not null                   comment '访客UID',
  record_id              bigint(20)      default null               comment '推荐记录ID',
  plant_id               bigint(20)      default null               comment '植物ID',
  feedback_type          char(1)         default '1'                comment '反馈类型（1喜欢 2不喜欢）',
  feedback_reason        varchar(255)    default ''                 comment '反馈原因',
  extra_note             varchar(500)    default ''                 comment '附加说明',
  create_time            datetime                                   comment '创建时间',
  primary key (feedback_id),
  key idx_zx_feedback_record_visitor (visitor_uid),
  key idx_zx_feedback_record_record (record_id)
) engine=innodb comment = '反馈记录表';


-- ----------------------------
-- 12、收藏记录表
-- ----------------------------
drop table if exists zx_favorite_record;
create table zx_favorite_record (
  favorite_id            bigint(20)      not null auto_increment    comment '收藏ID',
  visitor_uid            varchar(64)     not null                   comment '访客UID',
  plant_id               bigint(20)      not null                   comment '植物ID',
  status                 char(1)         default '0'                comment '状态（0收藏 1取消）',
  create_time            datetime                                   comment '创建时间',
  cancel_time            datetime                                   comment '取消时间',
  primary key (favorite_id),
  key idx_zx_favorite_record_visitor (visitor_uid),
  key idx_zx_favorite_record_plant (plant_id)
) engine=innodb comment = '收藏记录表';


-- ----------------------------
-- 13、内容文章表
-- ----------------------------
drop table if exists zx_content_article;
create table zx_content_article (
  article_id             bigint(20)      not null auto_increment    comment '文章ID',
  article_type           varchar(32)     default ''                 comment '文章类型',
  title                  varchar(200)    not null                   comment '标题',
  cover_image            varchar(255)    default ''                 comment '封面图',
  summary                varchar(500)    default ''                 comment '摘要',
  content                text                                        comment '正文',
  related_plant_id       bigint(20)      default null               comment '关联植物ID',
  status                 char(1)         default '0'                comment '状态（0发布 1草稿）',
  sort_order             int(4)          default 0                  comment '排序',
  publish_time           datetime                                   comment '发布时间',
  del_flag               char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by              varchar(64)     default ''                 comment '创建者',
  create_time            datetime                                   comment '创建时间',
  update_by              varchar(64)     default ''                 comment '更新者',
  update_time            datetime                                   comment '更新时间',
  remark                 varchar(500)    default null               comment '备注',
  primary key (article_id),
  key idx_zx_content_article_status (status)
) engine=innodb comment = '内容文章表';


-- ----------------------------
-- 14、数据导入任务表
-- ----------------------------
drop table if exists zx_data_import_task;
create table zx_data_import_task (
  task_id                bigint(20)      not null auto_increment    comment '任务ID',
  task_name              varchar(100)    not null                   comment '任务名称',
  import_type            varchar(64)     default ''                 comment '导入类型',
  file_name              varchar(255)    default ''                 comment '文件名',
  file_url               varchar(255)    default ''                 comment '文件地址',
  total_count            int(11)         default 0                  comment '总数',
  success_count          int(11)         default 0                  comment '成功数',
  fail_count             int(11)         default 0                  comment '失败数',
  status                 char(1)         default '0'                comment '状态（0待处理 1处理中 2已完成 3失败）',
  result_message         varchar(500)    default ''                 comment '结果信息',
  execute_time           datetime                                   comment '执行时间',
  create_by              varchar(64)     default ''                 comment '创建者',
  create_time            datetime                                   comment '创建时间',
  update_by              varchar(64)     default ''                 comment '更新者',
  update_time            datetime                                   comment '更新时间',
  remark                 varchar(500)    default null               comment '备注',
  primary key (task_id),
  key idx_zx_data_import_task_status (status)
) engine=innodb comment = '数据导入任务表';

set foreign_key_checks = @old_foreign_key_checks;