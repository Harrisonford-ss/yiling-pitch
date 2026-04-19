# Zeabur 部署指南（国内访问优化版）

## 思路
- HTML+图片：放 Zeabur（小文件，国内访问快）
- 5分钟成片视频（294M）：放国内 CDN（避免被 GitHub/Zeabur 拖累）

## 三步走

### Step 1：上传视频到国内 CDN（5-10 分钟）

**方案 A：七牛云 KODO（推荐 · 最常用）**
- 注册 [七牛云](https://www.qiniu.com/) 完成实名认证
- 免费额度：10GB 存储 + 10GB 流量/月
- 创建公开 Bucket → 上传 `finalcut.mp4`
- 在"域名管理"绑定一个测试域名（七牛会送你一个 `xxx.bkt.clouddn.com`）
- 复制视频链接，类似：`https://xxx.bkt.clouddn.com/finalcut.mp4`

**方案 B：阿里云 OSS**
- [阿里云 OSS](https://www.aliyun.com/product/oss) 控制台
- 免费额度：5GB 存储（首年）+ 1GB 流量/月
- 创建公开 Bucket → 上传文件
- 链接形如：`https://yiling.oss-cn-hangzhou.aliyuncs.com/finalcut.mp4`

**方案 C：腾讯云 COS**
- [腾讯云 COS](https://cloud.tencent.com/product/cos)
- 50GB 存储免费 + 10GB 流量/月
- 链接形如：`https://yiling-1234567.cos.ap-shanghai.myqcloud.com/finalcut.mp4`

> 💡 演讲一次性使用，10G 流量 = 30+ 次完整观看，绰绰有余

### Step 2：改一行 HTML

打开 `index.html` 第 11 行附近：
```javascript
window.CDN_VIDEO_URL = "finalcut.mp4";
// 改为你的 CDN URL：
window.CDN_VIDEO_URL = "https://xxx.bkt.clouddn.com/finalcut.mp4";
```

### Step 3：部署到 Zeabur

**方式 A · GitHub（推荐）**
```bash
cd zeabur-deploy
git init
git add .
git commit -m "init"
git remote add origin git@github.com:你的用户名/yiling-pitch.git
git push -u origin main
```
Zeabur 控制台 → 新项目 → 从 GitHub → 选这个仓库 → 自动检测 Dockerfile 部署

**方式 B · Zeabur CLI**
```bash
npm i -g @zeabur/cli
zeabur login
cd zeabur-deploy
zeabur deploy
```

部署后 Zeabur 会给你一个 `xxx.zeabur.app` 域名，打开就是 PPT。

## CDN 选择速查

| CDN | 国内速度 | 免费额度 | 实名 | 推荐场景 |
|------|---------|---------|------|---------|
| **七牛云** ⭐ | 极快 | 10G + 10G/月 | 需实名 | 一次性演讲 |
| 阿里 OSS | 极快 | 5G + 1G/月 | 需实名 | 已有阿里账号 |
| 腾讯 COS | 极快 | 50G + 10G/月 | 需实名 | 流量需求大 |
| 又拍云 | 快 | 试用 | 需实名 | 备选 |
| Cloudflare R2 | 慢（被墙） | 10G + 0 流量 | 不需 | 海外观众 |

## 演讲当天

直接访问 Zeabur 给你的域名（建议绑你自己的域名），F11 全屏。

第 11 页点击红色按钮播放视频时，视频从 CDN 拉，速度跟在线视频一样快。

---
作者：Eliza · 郑懿洋
