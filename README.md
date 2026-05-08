# Didi Prompt Tool

一个面向广告创意、活动 Banner、开屏素材和短视频首帧的 AI Prompt 工作台。

## 功能

- 内置 8 组广告场景预设：小程序广告、电商促销、本地生活、游戏宣传、旅游宣传、短视频开屏、科技产品、影视感广告。
- 支持文生图和文生视频两种模式。
- 支持结构化中文、一行中文、SD 分段三种输出格式。
- 支持保存“我的预设”、导入 JSON、导出 JSON。
- 支持 Prompt 质量检查，提醒主体、场景、风格、比例、负面规则等关键项是否完整。

## 在线访问

GitHub Pages 在线访问地址：

```text
https://sxjzyclt.github.io/didi-prompt-tool/
```

新手操作说明见：[`guide.html`](./guide.html)

Markdown 备份文档见：[`新手操作指南.md`](./新手操作指南.md)

## 发布到 GitHub

项目内置了一个发布脚本。GitHub CLI 登录成功后，在当前目录运行：

```powershell
.\publish-to-github.ps1
```

脚本会创建公开仓库 `didi-prompt-tool`，推送当前代码，并尝试开启 GitHub Pages。

## 本地打开

这是一个纯静态网页，不需要安装依赖。

直接双击 `index.html` 即可打开，也可以用本地静态服务器运行：

```bash
python -m http.server 8787
```

然后访问：

```text
http://127.0.0.1:8787/
```

## 隐私说明

当前版本没有后端服务，不会把你的预设、文案或 Prompt 上传到服务器。

“我的预设”和自定义元素保存在浏览器的 localStorage 本地存储中。更换浏览器、清理浏览器数据或换电脑后，这些本地数据可能会消失，建议定期使用“导出 JSON”备份。

## 文件结构

```text
didi-prompt-tool/
├─ index.html
├─ guide.html
├─ styles.css
├─ app.js
├─ favicon.svg
├─ publish-to-github.ps1
├─ 新手操作指南.md
└─ assets/
   └─ hero.png
```

## 版权和品牌说明

本项目是个人网页工具模板，不是滴滴官方产品，也不包含任何官方授权关系。
