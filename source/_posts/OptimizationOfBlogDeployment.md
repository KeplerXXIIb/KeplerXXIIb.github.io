---
title: 记一次对个人博客部署(主题+素材部署）的优化Optimization Of Blog Deployment
date: 2024-06-11
cover_image: /imgs/20240615000.png
categories: tech-blog
tags:
  - CS
---

## 简述
我的个人博客已经搭建好了，详情见[我的第一篇博文]（写了搭博客的方法及过程嘿嘿）.
整体博客的主题我发现了相当酷炫的[hexo-theme-cupertino]，在此基础上小小DIY了一下。
在写博文的过程中我发现个问题：图片素材的管理有点麻烦。
我的原始方案：素材单独放一个库，然后去引用。考虑到只是个人博客，且图片量不大，所以直接选了github来托管。然而在实操过程中我发现，每次写文章，上传图片很麻烦，要单独去管理。于是乎，打算优化一下。
如果换成其他的图库，问题仍然存在，因为依然要去维护，所以我选择将图片放本地。
偶然间发现我所用主题的作者也用这个方式部署了博客[Mrwill'sblog]，见贤思齐，所以我打开他的github“学习”了一手（狗头，哈哈。

## 详细过程
### Hexo主题DIY
在hexo主题网站找到了这个炫酷的主题[hexo-theme-cupertino]。
![](/imgs/20240615010.png "hexo-theme-cupertino")
主题的配置指南为[cupertino-configuration]。最后，我的配置文件"_config.cupertino.yml"内容如图。
![](/imgs/20240615011.png "cupertino-configuration")
![](/imgs/20240615009.png "_config.cupertino.yml")
将独特的“彩虹月份”改到了我生日所在的2月，嘿嘿。


### 发现问题
#### 图片素材管理原方案
刚开始写博客时，我的图片素材管理方案是，将图片上传到某个线上库，然后直接在博文中通过链接引用。由于钱包空空，而且博客也是通过GitHub部署，所以我选择了Github新建个repository来放图片素材。
新建的repo，写文时已经被有强迫症的我删除了哈哈

![](/imgs/20240615001.png "图片素材repo删除记录")

#### 一些建议
>对GitHub的访问，懂的都懂，要靠运气，要想稳定访问，还是需要施展一些小魔法。不过由于本身博客就是用GitHub搭的，怎么都得访问GitHub，所以直接用GitHub来放图片素材也行，如果用其他平台部署，然后又有类似的图片素材管理需求的话，可以考虑其他的方式：譬如Gitee，或者其他一些偏向图片管理的云服务，譬如百度云、腾讯云等等。

#### 问题点
在此方案下我遇到的问题：
1. 图片素材没存在hexo项目本地文件夹下，得单独用一个文件夹放，不方便一起管理。
注：刚开始时我试了将图片素材文件夹放hexo项目文件夹下，因为是两个repo，所以不能放一起，除非用子模块（Git Submodule），我没想维护那么复杂就直接分开了。
2. 图片素材是单独开了一个repo，感觉有点浪费repo的资源，因为该repo下只有图片。
3. 每次发文，push完文章后还要单独push一次图片，浪费时间。
4. 如果图片没有在写文章之前上传到图库，写作时没法预览。

### 见贤思齐
在我苦恼怎么改进之时，突然想起我所用hexo主题的作者，也部署了这个博客，所以我打开了[Mrwill'sblog]，然后顺着打开了他GitHub中部署博客的repo[Mrwill's"BlogRepo"]。
哇，怎么和我的大不一样！
我发现这位大佬将hexo项目文件（包含图片素材）都传到了GitHub，而且他的推送是
通过机器人完成的，瞬间觉得非常6啊。
#### 大佬的repo
![](/imgs/20240615002.png "大佬的repo截图")
![](/imgs/20240615003.png "大佬的repo截图")

反观我的，hexo项目文件仍在本地，用的是hexo-git-deploy插件，传到GitHub的只有生成的静态网页文件，而且图片还要单独放其他地方，这差距太大了！

痛定思痛，马上改！
#### 优化的点
1. 图片素材存放地址
* 备份了图片
* 删除了原来单独放图片的repo
* 在hexo项目文件夹source里新建了存放图片的"imgs"文件夹
* 博客文章中对图片的引用链接修改
  ![](/imgs/20240615006.png )


2. 将hexo项目文件上传至GitHub，hexo项目文件夹作出相应修改
* 取消使用hexo的deploy插件，删除hexo项目文件中的.deploy文件夹。
  本来想展示repo在此之前的历史提交的，不过我发现我用的是强制提交（因为文件绝大部分都不一样所以用了强制提交），所以把之前的提交历史顶掉了。这里其实操作失误了，应该提交为另一个分支，或者删除的时候不删.git，推送上去就好了，害，以后注意！。这里就展示下我回收站里的.delpoy文件夹吧哈哈哈。
  ![](/imgs/20240615004.png "躺在回收站里的.deploy")

* 了解GitHubPages的作用原理[GithubPagesDocs]
  之前用hexo-git-deploy插件，它是生成.deploy文件夹，把public文件夹下的内容copy到了.deploy下，然后传到了GitHub。GitHubPages的原理是找到名为“用户名.github.io”的repo下的指定文件夹，默认为/root，可设置/docs。

* 这里我遵循了[Mrwill's"BlogRepo"]的设计，使用/docs。
  ![](/imgs/20240615005.png "GitHubPages设置详情")
  
3. 使用Github Actions配置push后自动部署
  使用hexo g生成新的静态网页页面时，会将生成的文件放到public文件夹下，而2中GitHubPages配置的是找/docs，所以这里还需要处理，不然每次push要自己手动新建docs文件夹并复制内容进去。正好将这个动作写到GitHub Actions中。

* 在hexo项目文件夹下新建.github/workflows/blog-builder.yml，配置内容如图所示：
* 启动Ubuntu->
* 拉取更新->
* 安装依赖->
* 新建docs，复制public中的内容到docs（本地.gitignore添加了"/public"）->
* push更新到远程仓库
![](/imgs/20240615007.png "blog-builder.yml")
![](/imgs/20240615008.png "blog-builder.yml")

注：在GitHub Actions中配置git执行语句，会有个问题：会触发两次aciton。
因为动作的触发条件设置为push，配置文件中，有两次push，一次是手工push的时候，一次是触发后执行的“git push”语句。这导致每次我push都会有两次action触发，然后有一个被强行暂停，然后我就会收到提醒邮件。我看了大佬也是一样的有报错。
官方说不推荐在配置文件里写git语句，而是推荐了内置的“deploy”指令.
![](/imgs/20240615013.png "blog-builder.yml")

这里因为我要从public复制内容到docs，要push，所以没再尝试使用官方的指令了，而是选择关掉了报错提醒哈哈哈。
![](/imgs/20240615012.png )
后续可以再看下如何优化，省得每次push，Github Action都要报错。




[我的第一篇博文]:https://keplerxxiib.github.io/2024/05/05/myfirstblog
[hexo-theme-cupertino]:https://github.com/MrWillCom/hexo-theme-cupertino
[Mrwill'sblog]:https://blog.mrwillcom.com
[Mrwill's"BlogRepo"]:https://github.com/MrWillCom/MrWillCom.github.io
[GithubPagesDocs]:https://docs.github.com/zh/pages
[cupertino-configuration]:https://cupertino.mrwillcom.com/configuration/navigation