# 植物个性化推荐系统

本项目基于 RuoYi-Vue 二次开发，面向植物选购与养护场景，提供“问卷画像 + 推荐规则 + 植物内容 + 环境问答”的一体化演示系统。系统分为用户端与管理端两部分：用户端负责填写问卷、查看推荐结果、浏览植物详情、收藏反馈和植物百科问答；管理端负责植物资料维护、养护配置、标签规则、内容运营、导入任务和结果回查。

## 系统功能介绍

### 用户端功能

1. 首页：展示系统介绍、推荐入口与内容卡片。
2. 问卷推荐：采集场景、预算、养护能力、光照等条件，生成个性化推荐结果。
3. 推荐结果：展示 Top N 推荐植物、命中原因、养护风险与推荐说明。
4. 植物详情：查看植物基础信息、养护要点、标签、相关文章与相似植物。
5. 所有植物：按卡片方式浏览全部已上架植物。
6. 历史记录：回看当前用户历史推荐结果。
7. 收藏与反馈：收藏植物并对推荐结果提交满意度反馈。
8. 植百科问答：结合位置、天气、温湿度等环境上下文给出养护建议；当未配置大模型时，系统自动使用本地兜底回答。

### 管理端功能

1. 系统工作台：查看植物、推荐、反馈、内容等统计总览。
2. 分类管理：维护植物分类树、排序和状态。
3. 植物库管理：维护植物基础信息、封面、摘要和状态。
4. 养护配置：维护光照、浇水、温湿度、风险提示等养护参数。
5. 标签字典与植物标签配置：维护标签定义并建立植物与标签关系。
6. 推荐规则管理：配置过滤规则、权重规则与命中说明。
7. 用户画像与推荐记录回查：查看问卷快照、画像摘要、推荐记录和明细结果。
8. 反馈管理：查看用户满意度与原因。
9. 内容管理：维护植物百科与养护文章。
10. 导入任务：上传导入模板并查看导入结果。

## 环境要求

建议按照以下版本准备环境，确保与当前项目配置一致：

| 组件 | 建议版本 | 说明 |
| --- | --- | --- |
| JDK | 17 | 根工程 `pom.xml` 当前为 Spring Boot 4.x / Java 17 |
| Maven | 3.9.x | 用于后端依赖构建与启动 |
| MySQL | 8.0+ | 默认库名为 `proj_zx` |
| Redis | 6.x / 7.x | 默认地址为 `localhost:6379` |
| Node.js | 18 LTS 或 20 LTS | 用于前端开发启动 |
| npm | 9+ 或 10+ | 首次运行前端需安装依赖 |

## 目录说明

- `ruoyi-admin`：后端启动模块。
- `ruoyi-system`：植物业务领域模型、Mapper 与 Service。
- `ruoyi-ui`：前端 Vue 项目。
- `sql/proj_zx.sql`：当前演示环境推荐使用的完整数据库初始化脚本。
- `sql/ry_20260417.sql`：若依基础库脚本。
- `sql/zx_plant_demo_00_execute.sql` ~ `03_seed.sql`：植物业务增量脚本与演示数据脚本。
- `demo-assets/uploadPath`：演示图片、导入模板等运行期静态资源。

## 部署方式

下面这套流程适用于本地演示部署，也是当前项目最直接、最稳定的启动方式。

### 1. 准备数据库

1. 安装并启动 MySQL。
2. 创建数据库 `proj_zx`，字符集建议使用 `utf8mb4`。
3. 推荐直接导入 `sql/proj_zx.sql`，该文件已经包含当前演示所需的系统表、业务表、菜单和样例数据。
4. 如果你希望从若依基础库开始分步安装，则先执行 `sql/ry_20260417.sql`，再按 `sql/zx_plant_demo_执行说明.md` 中的顺序执行植物业务脚本。

示例：

```sql
CREATE DATABASE proj_zx DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. 修改后端配置

根据本机环境修改 `ruoyi-admin/src/main/resources/application-druid.yml` 中的数据库连接信息：

- `spring.datasource.druid.master.url`
- `spring.datasource.druid.master.username`
- `spring.datasource.druid.master.password`

如果 Redis 不是本机默认配置，还需要修改 `ruoyi-admin/src/main/resources/application.yml` 中的以下项：

- `spring.data.redis.host`
- `spring.data.redis.port`
- `spring.data.redis.password`
- `spring.data.redis.database`

### 3. 配置运行期静态资源目录

系统的图片、导入模板和上传文件默认指向仓库内的 `demo-assets/uploadPath`。当前默认配置如下：

```yaml
ruoyi:
  profile: ${RUOYI_PROFILE:${user.dir}/demo-assets/uploadPath}
```

说明：

1. 如果直接在项目根目录启动，系统会使用仓库内的 `demo-assets/uploadPath`。
2. 如果从 `ruoyi-admin` 模块直接启动，代码会自动回退到上一级目录中的 `demo-assets/uploadPath`，当前没有发现会影响启动的相对路径问题。
3. 如果要部署到其他电脑，最稳妥的方式是显式设置环境变量 `RUOYI_PROFILE`，把它指向一份真实存在的绝对路径目录。

Windows PowerShell 示例：

```powershell
$env:RUOYI_PROFILE = 'D:\plant-demo\uploadPath'
```

### 4. 启动 Redis

启动 Redis 服务，并确保后端配置中的地址和端口可连通。

### 5. 启动后端

可以通过 IDEA 直接运行 `ruoyi-admin` 模块中的 `RuoYiApplication.java`，也可以通过 Maven 启动。

Maven 启动示例：

```powershell
mvn -f ruoyi-admin\pom.xml -DskipTests spring-boot:run
```

默认后端访问地址：

- 接口地址：`http://localhost:8081`
- Swagger 地址：`http://localhost:8081/swagger-ui.html`

### 6. 启动前端

进入 `ruoyi-ui` 目录后执行以下命令：

```powershell
npm install
npm run dev
```


### 7. 访问系统

如果前端使用默认端口 80，则浏览器访问：

- `http://localhost`



## 生产部署补充

如果用于服务器部署，建议采用以下方式：

1. 后端通过 Maven 打包为 Jar，在服务器上以 Java 17 运行。
2. 前端在 `ruoyi-ui` 下执行 `npm run build:prod` 生成 `dist` 静态文件。
3. 使用 Nginx 托管前端 `dist` 目录，并将 `/prod-api` 反向代理到后端服务地址。
4. 将 `RUOYI_PROFILE`、数据库、Redis 和大模型相关配置统一放入服务器环境变量或外部配置中，不要写死在源码里。

## 大模型 API 配置说明

植物百科问答能力使用以下配置项：

- `PLANT_ASSISTANT_API_URL`
- `BIGMODEL_API_KEY`
- `PLANT_ASSISTANT_MODEL`
- `PLANT_ASSISTANT_TIMEOUT_SECONDS`
- `PLANT_ASSISTANT_REVERSE_GEOCODE_URL`
- `PLANT_ASSISTANT_WEATHER_API_URL`
- `PLANT_ASSISTANT_USER_AGENT`

其中最关键的是 `BIGMODEL_API_KEY`。当前项目已经改为只从环境变量读取，不再在源码中保存默认密钥。

Windows PowerShell 示例：

```powershell
$env:BIGMODEL_API_KEY = '你的真实大模型 API Key'
```

如果未配置该变量，植物百科问答页面仍可使用本地兜底回答，但不会调用外部大模型。

## 安全与密钥说明

1. 本次检查结果显示：`ruoyi-admin/src/main/resources/application.yml` 之前存在真实 `BIGMODEL_API_KEY` 默认值。
2. 这意味着该密钥已经随源码提交进入 Git 历史；如果仓库已经推送到 GitHub，就应视为已经泄露。
3. 我已经把源码当前版本中的默认密钥移除，但这只能阻止后续继续暴露，不能撤回历史提交里已经出现过的密钥。
4. 你现在应该立即到大模型平台后台轮换这把 Key，并停用旧 Key。
5. 如果需要彻底清理 GitHub 历史中的旧密钥，还需要额外执行历史改写和强推；这是单独的仓库清理动作，不属于普通 README 修改范围。

## 版本一致性建议

如果要保证同学克隆后的项目与本机功能尽量一致，至少要统一以下内容：

1. 使用同一个 Git 提交版本，不要只说“拉最新代码”，而是固定到同一个 commit 或 release tag。
2. 使用同一份数据库初始化数据，推荐直接使用本仓库内的 `sql/proj_zx.sql`。
3. 使用同一份 `demo-assets/uploadPath` 目录，否则图片、导入模板和运行期素材可能不一致。
4. 使用相同的 JDK、Maven、Node.js、npm、MySQL、Redis 版本。
5. 使用相同的后端配置项，包括数据库、Redis、`RUOYI_PROFILE` 和大模型相关环境变量。
6. 前端当前没有提交 `package-lock.json`，这意味着 `npm install` 时的部分间接依赖版本可能存在微小差异；如果你要进一步提高可复现性，建议后续补充并提交锁文件。

## 常见问题

### 问：只导入 `proj_zx.sql` 可以吗？

可以。对于当前项目，这是最简洁、最接近你本机演示环境的方式。

### 问：直接运行 `RuoYiApplication.java` 可以吗？

可以。你的理解是正确的，这就是当前本地开发和演示最直接的启动方式之一。

### 问：相对路径会不会导致图片丢失？

当前主链路没有发现会阻塞启动的相对路径问题，但为了跨电脑稳定复现，仍建议在交付环境中显式配置 `RUOYI_PROFILE` 为绝对路径。