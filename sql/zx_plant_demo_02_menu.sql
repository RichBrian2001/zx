-- 植物个性化推荐系统 Demo
-- 阶段 1：管理端菜单、按钮权限、业务角色最终执行版
-- 说明：用户端页面走固定前端路由，不写入 sys_menu。

set names utf8mb4;
set @old_foreign_key_checks = @@foreign_key_checks;
set foreign_key_checks = 0;
start transaction;

-- ----------------------------
-- 1、清理旧草案数据
-- ----------------------------
delete from sys_role_menu where role_id = 3000 or menu_id between 2000 and 2199;
delete from sys_user_role where role_id = 3000;
delete from sys_role where role_id = 3000;
delete from sys_menu where menu_id between 2000 and 2199;


-- ----------------------------
-- 2、业务角色
-- ----------------------------
insert into sys_role
	(role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark)
values
	('3000', '植选管理员', 'plant_admin', 10, 1, 1, 1, '0', '0', 'admin', sysdate(), '', null, '植选系统业务管理员');


-- ----------------------------
-- 2.5、原生若依菜单沉底
-- ----------------------------
update sys_menu
set order_num = case menu_id
	when 1 then 91
	when 2 then 92
	when 3 then 93
	when 4 then 94
	else order_num
end
where menu_id in (1, 2, 3, 4);


-- ----------------------------
-- 3、管理端菜单目录与页面菜单
-- ----------------------------
insert into sys_menu
	(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values
	('2001', '总览中心',       '0',    '1',  '/index',                 'plant/admin/dashboard/index', '', 'Index',               1, 0, 'C', '0', '0', 'plant:dashboard:list', 'dashboard',     'admin', sysdate(), '', null, '登录首页与总览中心'),
	('2002', '植物资产中心',   '0',    '2',  'plant-assets',           '',                           '', '',                      1, 0, 'M', '0', '0', '',                     'tree',          'admin', sysdate(), '', null, '业务模块目录'),
	('2003', '推荐运营中心',   '0',    '3',  'recommend-ops',          '',                           '', '',                      1, 0, 'M', '0', '0', '',                     'form',          'admin', sysdate(), '', null, '业务模块目录'),
	('2004', '内容与交付中心', '0',    '4',  'content-delivery',       '',                           '', '',                      1, 0, 'M', '0', '0', '',                     'documentation', 'admin', sysdate(), '', null, '业务模块目录'),
	('2012', '植物分类',       '2002', '1',  '/plant-admin/category',  'plant/admin/category/index',  '', 'PlantAdminCategory',  1, 0, 'C', '0', '0', 'plant:category:list',  'tree',          'admin', sysdate(), '', null, '植物分类菜单'),
	('2013', '植物库',         '2002', '2',  '/plant-admin/plant',     'plant/admin/plant/index',     '', 'PlantAdminPlant',     1, 0, 'C', '0', '0', 'plant:plant:list',     'example',       'admin', sysdate(), '', null, '植物库菜单'),
	('2014', '标签字典',       '2002', '3',  '/plant-admin/tag',       'plant/admin/tag/index',       '', 'PlantAdminTag',       1, 0, 'C', '0', '0', 'plant:tag:list',       'dict',          'admin', sysdate(), '', null, '标签字典菜单'),
	('2015', '推荐规则',       '2003', '1',  '/plant-admin/rule',      'plant/admin/rule/index',      '', 'PlantAdminRule',      1, 0, 'C', '0', '0', 'plant:rule:list',      'edit',          'admin', sysdate(), '', null, '推荐规则菜单'),
	('2016', '用户画像',       '2003', '2',  '/plant-admin/profile',   'plant/admin/profile/index',   '', 'PlantAdminProfile',   1, 0, 'C', '0', '0', 'plant:profile:list',   'user',          'admin', sysdate(), '', null, '用户画像菜单'),
	('2017', '推荐记录',       '2003', '3',  '/plant-admin/recommend', 'plant/admin/recommend/index', '', 'PlantAdminRecommend', 1, 0, 'C', '0', '0', 'plant:recommend:list', 'form',          'admin', sysdate(), '', null, '推荐记录菜单'),
	('2018', '反馈管理',       '2003', '4',  '/plant-admin/feedback',  'plant/admin/feedback/index',  '', 'PlantAdminFeedback',  1, 0, 'C', '0', '0', 'plant:feedback:list',  'message',       'admin', sysdate(), '', null, '反馈管理菜单'),
	('2019', '内容管理',       '2004', '1',  '/plant-admin/article',   'plant/admin/article/index',   '', 'PlantAdminArticle',   1, 0, 'C', '0', '0', 'plant:article:list',   'documentation', 'admin', sysdate(), '', null, '内容管理菜单'),
	('2020', '数据导入',       '2004', '2',  '/plant-admin/import',    'plant/admin/import/index',    '', 'PlantAdminImport',    1, 0, 'C', '0', '0', 'plant:import:list',    'upload',        'admin', sysdate(), '', null, '数据导入菜单');


-- ----------------------------
-- 4、管理端按钮权限
-- ----------------------------
insert into sys_menu
	(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values
	('2101', '工作台查询', '2001', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:dashboard:query', '#', 'admin', sysdate(), '', null, ''),
	('2110', '分类查询',   '2012', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:query',  '#', 'admin', sysdate(), '', null, ''),
	('2111', '分类新增',   '2012', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:add',    '#', 'admin', sysdate(), '', null, ''),
	('2112', '分类修改',   '2012', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:edit',   '#', 'admin', sysdate(), '', null, ''),
	('2113', '分类删除',   '2012', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:category:remove', '#', 'admin', sysdate(), '', null, ''),
	('2120', '植物查询',   '2013', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:query',     '#', 'admin', sysdate(), '', null, ''),
	('2121', '植物新增',   '2013', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:add',       '#', 'admin', sysdate(), '', null, ''),
	('2122', '植物修改',   '2013', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:edit',      '#', 'admin', sysdate(), '', null, ''),
	('2123', '植物删除',   '2013', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:remove',    '#', 'admin', sysdate(), '', null, ''),
	('2124', '植物导出',   '2013', '5', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:export',    '#', 'admin', sysdate(), '', null, ''),
	('2125', '植物详情',   '2013', '6', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:detail',    '#', 'admin', sysdate(), '', null, ''),
	('2126', '养护配置',   '2013', '7', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:care',      '#', 'admin', sysdate(), '', null, ''),
	('2127', '标签配置',   '2013', '8', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:plant:tag',       '#', 'admin', sysdate(), '', null, ''),
	('2130', '标签查询',   '2014', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:query',       '#', 'admin', sysdate(), '', null, ''),
	('2131', '标签新增',   '2014', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:add',         '#', 'admin', sysdate(), '', null, ''),
	('2132', '标签修改',   '2014', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:edit',        '#', 'admin', sysdate(), '', null, ''),
	('2133', '标签删除',   '2014', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:tag:remove',      '#', 'admin', sysdate(), '', null, ''),
	('2140', '规则查询',   '2015', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:query',      '#', 'admin', sysdate(), '', null, ''),
	('2141', '规则新增',   '2015', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:add',        '#', 'admin', sysdate(), '', null, ''),
	('2142', '规则修改',   '2015', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:edit',       '#', 'admin', sysdate(), '', null, ''),
	('2143', '规则删除',   '2015', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:remove',     '#', 'admin', sysdate(), '', null, ''),
	('2144', '规则启停',   '2015', '5', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:rule:changeStatus','#', 'admin', sysdate(), '', null, ''),
	('2150', '画像查询',   '2016', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:profile:query',   '#', 'admin', sysdate(), '', null, ''),
	('2151', '画像详情',   '2016', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:profile:detail',  '#', 'admin', sysdate(), '', null, ''),
	('2160', '记录查询',   '2017', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:query', '#', 'admin', sysdate(), '', null, ''),
	('2161', '记录详情',   '2017', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:detail','#', 'admin', sysdate(), '', null, ''),
	('2162', '记录导出',   '2017', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:recommend:export','#', 'admin', sysdate(), '', null, ''),
	('2170', '反馈查询',   '2018', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:feedback:query',  '#', 'admin', sysdate(), '', null, ''),
	('2171', '反馈导出',   '2018', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:feedback:export', '#', 'admin', sysdate(), '', null, ''),
	('2180', '内容查询',   '2019', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:query',   '#', 'admin', sysdate(), '', null, ''),
	('2181', '内容新增',   '2019', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:add',     '#', 'admin', sysdate(), '', null, ''),
	('2182', '内容修改',   '2019', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:edit',    '#', 'admin', sysdate(), '', null, ''),
	('2183', '内容删除',   '2019', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:article:remove',  '#', 'admin', sysdate(), '', null, ''),
	('2190', '导入查询',   '2020', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:query',    '#', 'admin', sysdate(), '', null, ''),
	('2191', '导入上传',   '2020', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:upload',   '#', 'admin', sysdate(), '', null, ''),
	('2192', '导入执行',   '2020', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:execute',  '#', 'admin', sysdate(), '', null, ''),
	('2193', '导入详情',   '2020', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'plant:import:detail',   '#', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 5、角色和菜单关联
-- ----------------------------
insert into sys_role_menu (role_id, menu_id) values ('3000', '2001');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2002');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2003');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2004');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2012');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2013');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2014');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2015');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2016');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2017');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2018');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2019');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2020');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2101');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2110');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2111');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2112');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2113');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2120');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2121');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2122');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2123');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2124');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2125');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2126');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2127');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2130');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2131');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2132');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2133');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2140');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2141');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2142');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2143');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2144');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2150');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2151');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2160');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2161');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2162');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2170');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2171');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2180');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2181');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2182');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2183');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2190');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2191');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2192');
insert into sys_role_menu (role_id, menu_id) values ('3000', '2193');

commit;
set foreign_key_checks = @old_foreign_key_checks;