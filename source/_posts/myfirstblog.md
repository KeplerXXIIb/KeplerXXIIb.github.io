---
title: 第一篇博客！My first blog!
date: 2024-05-05
cover_image: /imgs/hexo-git-work-process.jpg
categories: tech-blog
tags:
  - CS
  - school
---
- [1.环境搭建](#1环境搭建)
  - [1.1GitHub Pages和Hexo简介](#11github-pages和hexo简介)
  - [1.2环境搭建](#12环境搭建)
    - [1.2.1软件下载](#121软件下载)
    - [1.2.2安装检查](#122安装检查)
- [2.GitHub配置](#2github配置)
  - [2.1GitHub用户名、邮箱配置](#21github用户名邮箱配置)
  - [2.2创建SSH密匙](#22创建ssh密匙)
  - [2.3GitHub添加SSH密匙](#23github添加ssh密匙)
  - [2.4测试GitHub链接](#24测试github链接)
  - [2.5创建 Github Pages 仓库](#25创建-github-pages-仓库)
- [3.安装Hexo](#3安装hexo)
  - [3.1新建文件夹](#31新建文件夹)
  - [3.2本地安装Hexo](#32本地安装hexo)
  - [3.3 Hexo 初始化和本地预览](#33-hexo-初始化和本地预览)
  - [3.4部署 Hexo 到 GitHub Pages](#34部署-hexo-到-github-pages)
- [4使用Hexo](#4使用hexo)
  - [4.1基本命令](#41基本命令)
  - [4.2更换Hexo主题](#42更换hexo主题)
    - [4.2.1主题下载](#421主题下载)
    - [4.2.2主题更换](#422主题更换)
  - [4.3markdown编写文件](#43markdown编写文件)
- [5参考链接](#5参考链接)

![](/imgs/scene1.png)

这是我博客第一篇文章，正好记录下通过hexo+git搭建个人免费博客的过程，嘿！

最近在自学CS，了解到写个人技术博客是一个很好的学习方式，因而产生了搭建个人博客的想法。一番搜索下来，发现可以使用hexo+git免费搭建，遂有了下文。

有了搭建个人博客的想法后，我先后在b站、知乎、csdn等平台搜索了相关经验帖，最终在腾讯开发者平台上搜到了一篇经验贴，纯干货。[^链接]。此外，我还用了AI协助搭建，用了chatgpt3.5、文心一言3.5、通义千问等。毕竟免费的，不用白不用哈哈哈哈。

>涉及应用：chrome，Vscode，Node.js，Hexo，Git，Github

## 1.环境搭建
### 1.1GitHub Pages和Hexo简介
GitHub Pages 是由 GitHub 官方提供的一种免费的静态站点托管服务，让我们可以在 GitHub 仓库里托管和发布自己的静态网站页面。

Hexo 是一个快速、简洁且高效的静态博客框架，它基于 Node.js 运行，可以将我们撰写的 Markdown 文档解析渲染成静态的 HTML 网页，最大的优点在于我们不用费尽心力去关注前端页面。

Hexo + GitHub 文章发布原理（图片来源：知乎crystal）

在本地撰写 Markdown 格式文章后，通过 Hexo 解析文档，渲染生成具有主题样式的 HTML 静态网页，再推送到 GitHub 上完成博文的发布。
![](/imgs/hexo-git-work-process.png)

### 1.2环境搭建
#### 1.2.1软件下载
安装Git、Hexo，npm（安装Node.js时会带着）
```bash
Node.js下载地址：https://nodejs.org/zh-cn
Git下载地址：https://git-scm.com/downloads
```
软件安装在D盘，一路点 “下一步” 按默认配置完成安装。

#### 1.2.2安装检查
安装完成后，Win+R 输入 cmd 并回车打开命令行，依次输入
```bash
node -v
npm -v
git --version 
```
并回车查询版本号，如有版本信息则代表安装成功。
![](/imgs/bashcode1.png)

## 2.GitHub配置
### 2.1GitHub用户名、邮箱配置
桌面空白处右键 -> Git Bash Here，进入Gitbash设置用户名和邮箱：

```bash
git config --global user.name "GitHub 用户名"
git config --global user.email "GitHub 邮箱"
```


### 2.2创建SSH密匙
命令行输入，
```bash
 ssh-keygen -t rsa -C "GitHub 邮箱"
```
这里加密方式可以选择rsa或Ed25519

### 2.3GitHub添加SSH密匙
创建密钥后，进入[C:\Users\用户名\.ssh]目录（要勾选显示“隐藏的项目”），打开公钥 id_rsa.pub 文件并复制里面的内容。
![](/imgs/secret-key1.png)

登陆 GitHub ，进入 Settings 页面，选择左边栏的 SSH and GPG keys，点击 New SSH key。
![](/imgs/secret-key2.png)

Title 随便取个名字，粘贴复制的 id_rsa.pub 内容到 Key 中，点击 Add SSH key 完成添加。

### 2.4测试GitHub链接
打开 Git Bash，输入下面代码，出现 “Are you sure……”，输入 yes 回车确认。
```bash
ssh -T git@github.com
```
![](/imgs/bashcode2.png)

### 2.5创建 Github Pages 仓库
![](/imgs/github1.png)

```bash
GitHub page 可以建立多个，但个人账户page只能有一个， 项目page可以有多个。
个人主页必须要和用户的GitHub帐号同名，所以每个用户有且只能有一个repo作为个人主页，且必须是<username>/<username>.github.io的形式；而项目主页的命名则没有这种限制，且数量有任意多个。
不考虑绑定的自定义域名的前提下，个人主页的GitHub二级域名为<username>.github.io;项目主页的GitHub二级域名为<username>.github.io/<projectname>,没有<projectname>.<username>.github.io这种方式
个人主页的展示内容以master分支里的文件为准；而项目主页的展示内容以gh-pages分支内的文件为准
单个GitHub帐号下添加多个GitHub Pages的相关问题：
https://blog.csdn.net/weixin_34402090/article/details/89487829
```
创建后GitHub默认启用 HTTPS，所以此时我们的博客地址为：
```bash
https://用户名.github.io
```

## 3.安装Hexo
### 3.1新建文件夹
新建一个文件夹用来存放 Hexo 的程序文件，如 MyHexo。
![](/imgs/hexo1.png)

### 3.2本地安装Hexo
在该目录下，鼠标右键 -> Git Bash Here，输入以下代码
```bash
npm install -g hexo-cli
```
### 3.3 Hexo 初始化和本地预览
```bash
hexo init      # 初始化
npm install    # 安装依赖
```

输入下面命令，生成页面后启动本地服务器进行预览：
```bash
hexo g   # 生成页面，是hexo generate的缩写
hexo s   # 启动预览，是hexo service的缩写
```

在浏览器访问 http://localhost:4000，出现下面的 Hexo 默认页面，本地博客安装成功！

在安装时报错，有可能是端口被占用。这里我安装失败是因为打开了WattToolKit加速github，关闭后生成，就没问题了。
![](/imgs/bashcode3.png)
![](/imgs/bashcode4.png)

Hexo 博客文件目录结构如下:
```bash
hexo #hexo 初始化目录
├── node_modules   # Node.js 依赖安装目录
├── public         # 生成的静态文件存放目录
├── scaffolds      # 模板文件目录
|   ├── draft.md   # 默认模板
|   ├── page.md    # 页面模板
|   └── post.md    # 文章模板
├── source         # 资源目录，用来存放文章源文件
|   ├── _drafts    # 默认页面存放目录
|   └── _posts     # 文章存放目录
├── themes         # 主题目录，存放用来生成静态页面的主题
├── _config.yml    # hexo的配置文件
├── package.json   # hexo的依赖和插件信息
└── package-lock.json # npm已安装依赖的记录（具体来源和版本信息）
```
### 3.4部署 Hexo 到 GitHub Pages

本地博客测试成功后，就是上传到 GitHub 进行部署，使其能够在网络上访问。 
首先安装 hexo-deployer-git 插件：
```bash
npm install hexo-deployer-git --save
```
在hexo程序目录下修改 _config.yml文件的末尾部分，修改如下：
```bash
deploy:
  type: git
  repository: git@github.com:用户名/用户名.github.io.git
  branch: master
```
完成后运行 hexo d 命令将网站上传部署到 GitHub Pages。 
完成！这时访问我们的 GitHub 域名 https://用户名.github.io 就可以看到 Hexo 网站了。

## 4使用Hexo


### 4.1基本命令
官方文档：https://hexo.io/zh-cn/
```bash
# hexo初始化
hexo init <文件夹名> #如果 <文件夹名> 省略，则在当前目录初始化

# 新建页面
hexo new page <页面名>
# 新建文章
hexo new post <文章名> # post可以省略

# 生成静态文件
hexo generate
# 可简写为
hexo g

# 启动本地服务器
hexo server
# 可简写为
hexo s

# 清理生成的静态文件
hexo clean

# 部署静态文件
hexo deploy
# 可简写为
hexo d

# 生成静态文件并部署（二选一即可）
hexo d -g
hexo g -d
```

### 4.2更换Hexo主题
#### 4.2.1主题下载
去Hexo 官方主题页挑一个自己心仪的主题，链接：https://hexo.io/themes/，最后找到了一个，非常简约、帅气，
主题网址：https://github.com/MrWillCom/hexo-theme-cupertino
![](/imgs/theme1.png)


命令行在hexo文件夹下打开bash，
用Git将主题文件下载到Hexo安装目录\themes文件夹下
```bash
 git clone https://github.com/MrWillCom/hexo-theme-cupertino themes/cupertino
```
![](/imgs/theme4.png)
![](/imgs/theme3.png)

#### 4.2.2主题更换
按照主题操作指南更换主题，
https://cupertino.mrwillcom.com/
![](/imgs/theme2.png)

### 4.3markdown编写文件
markdown语法参考网页：
https://www.runoob.com/markdown/md-advance.html
https://markdown.com.cn/basic-syntax/
https://markdown.p2hp.com/basic-syntax/


## 5参考链接
https://cloud.tencent.com/developer/article/1695555?areaId=106001



[^链接]:https://cloud.tencent.com/developer/article/1695555?areaId=106001