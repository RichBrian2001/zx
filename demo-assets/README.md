# 植选 Demo 静态资源

- 默认运行目录：demo-assets/uploadPath/upload
- 资源映射清单：demo-assets/asset-manifest.json
- 植物图片 Prompt 清单：demo-assets/plant-image-prompt-manifest.json
- 生成脚本：bin/generate_plant_demo_assets.py

## 目录说明

- plant：47 株植物封面图，对应 zx_plant_demo_03_seed.sql 中的 /profile/upload/plant/*.jpg
- article：8 张首页/详情内容文章封面，对应 /profile/upload/article/*.jpg
- import：2 份演示导入模板，对应 /profile/upload/import/*.xlsx
- 注意：仓库内为了和 RuoYi 运行时路径保持一致，实际文件会生成到 demo-assets/uploadPath/upload 下，而不是 demo-assets/uploadPath 根目录。

## 当前口径

- 仓库内脚本负责生成统一风格的可复现 fallback 封面图，保证开发、演示和重跑 SQL 后的资源路径全部可命中。
- 高质量植物正式图使用统一 Prompt 模板管理，逐株清单已写入 demo-assets/plant-image-prompt-manifest.json。
- 当外部图像生成工具产出正式图片后，直接覆盖 demo-assets/uploadPath/upload/plant 下同名文件即可，无需再改数据库路径。
- 当前 47 张植物正式图已全部生成并覆盖到 demo-assets/uploadPath/upload/plant，站内运行路径已完成访问验证。
- 当前智谱接口虽然接受了 watermark_enabled=false，但实际返回的仍是带 _watermark 的资源 URL；是否能拿到无水印图片，取决于账号资源包和接口能力，不是仓库脚本参数问题。

## 重新生成

在仓库根目录执行：

```powershell
.\.venv\Scripts\python.exe bin\generate_plant_demo_assets.py
```

执行后会覆盖 uploadPath 下的演示图片、导入模板和映射清单。

## 智谱 API 正式图替换

- 推荐把智谱密钥放到环境变量 ZHIPU_API_KEY，不要直接写入仓库文件。
- 已提供批量生成脚本：bin/generate_plant_ai_assets.py。
- 该脚本读取 demo-assets/plant-image-prompt-manifest.json 中的逐株 prompt，并把返回图片直接覆盖到 demo-assets/uploadPath/upload/plant 下的同名文件。
- 文章封面也可复用同一脚本，清单文件为 demo-assets/article-image-prompt-manifest.json，输出路径直接覆盖 demo-assets/uploadPath/upload/article 下的同名文件。

示例：先只试跑 2 张正式图

```powershell
$env:ZHIPU_API_KEY = "你的完整密钥"
.\.venv\Scripts\python.exe bin\generate_plant_ai_assets.py --limit 2 --overwrite --size 1344x1024
```

示例：只重生成指定植物

```powershell
.\.venv\Scripts\python.exe bin\generate_plant_ai_assets.py --plant-ids 1001,1004,1047 --overwrite --size 1344x1024
```

示例：按收尾批次重生成此前缺口正式图

```powershell
$env:ZHIPU_API_KEY = "你的完整密钥"
.\bin\generate_remaining_plant_ai_assets.ps1
```

示例：批量覆盖 8 张文章正式封面

```powershell
$env:ZHIPU_API_KEY = "你的完整密钥"
.\.venv\Scripts\python.exe bin\generate_plant_ai_assets.py --manifest demo-assets/article-image-prompt-manifest.json --overwrite --size 1344x1024
```

说明：

- 默认接口地址是 https://open.bigmodel.cn/api/paas/v4/images/generations。
- 默认参数是 model=glm-image、quality=hd、size=1344x1024。
- 默认只补缺失图片；加上 --overwrite 才会覆盖现有 fallback 图。