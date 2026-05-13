-- 植物个性化推荐系统 Demo
-- 阶段 1：总执行入口
-- 使用方式：
-- 1. 使用 utf8mb4 会话进入 mysql 命令行并切换到当前目录。
-- 2. 连接目标数据库后执行：source zx_plant_demo_00_execute.sql;
-- 3. 若使用 Navicat、DataGrip 或其他工具，请按 01 -> 02 -> 03 的顺序依次执行。
-- 重跑策略：
-- - 全量初始化或整库重装：执行本文件。
-- - 仅结构调整：执行 01，再执行 03。
-- - 仅菜单权限调整：执行 02。
-- - 仅刷新演示数据：执行 03。

set names utf8mb4;

select 'STEP 1/3 schema start' as execute_step;
source zx_plant_demo_01_schema.sql;

select 'STEP 2/3 menu start' as execute_step;
source zx_plant_demo_02_menu.sql;

select 'STEP 3/3 seed start' as execute_step;
source zx_plant_demo_03_seed.sql;

select 'plant demo sql all completed' as execute_result;