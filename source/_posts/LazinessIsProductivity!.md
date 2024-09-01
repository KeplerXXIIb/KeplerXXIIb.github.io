---
title: 懒惰也是种生产力！记对PowerShell脚本的初体验
date: 2024-08-30
cover_image: /imgs/20240831001.png
categories: tech-blog
tags:
  - CS
---
## 简述：懒惰引发的Idea
最近在恶补计算机专业四大件，每次学习当天我都会git上传我本地的学习文件。然后我觉得每次输入"git status","git add ."...很麻烦，上一份工作时接触过一些工作流程自动化软件，譬如影刀，给我留下了挺深刻的印象：简单、重复的工作，让计算机来做！由于接触过一些简单的脚本代码（.bat），加上最近对计算机的了解愈来愈深入，我心里对自己用代码实现这个事还是有底的，说干就干，直接打开文心一言搜索相关方案！（狗头）我是windows系统，最后选择了PowerShell脚本。
![](/imgs/20240831001.png)


## PowerShell初体验：自动帮我写git
![](/imgs/20240626004.png)
因为每天不一定有文件更新（有可能更新一次文件，要学两天），所以我的想法是将其做成会话，让我自由选择是否进行git语句。
最终代码放后面了
[GitInstructs.ps1](####GitInstructs.ps1)


## PowerShell再探：pdf转jpg + OCR文字识别
此外呢，我每次听完网课就用语雀来记录。
刚开始我是自己手打笔记的，但发现用来回顾的效果不太好，主要是因为自己总结的远没有课程作者总结得精辟，而且还浪费时间，后来索性改为：直接把课件（主要为pdf）导出图片，手输大小标题然后上传到语雀。
刚开始吧工作量也不大，手输也还能接受，可越到后面课程越多，越发耗费时间。由于刚用powershell实现了上述所说的git交互脚本，内心跃跃欲试。于是乎又开始百度，哦不，文心一言了（狗头。
版本的演化过程如下，期间经历了很多“发现bug-寻找解决办法-代码优化”的痛苦循环哈哈

## PowerShell script的版本演化
Script_V1：
利用Ghostscript将指定文件夹中的pdf文件导出为图片（每页pdf导出一页图片）。
用了几天后我觉得pdf的标题和pdf文件名差不多，可以直接将文件名汇总一下，这样我复制到语雀上的时候就很方便，所以在又加了点功能：

Script_V2：
1. 利用Ghostscript将指定文件夹中的pdf文件导出为图片（每页pdf导出一页图片）
2. 将指定文件夹中的pdf文件名汇总导出到txt中

又用了几天，我觉得自己手输小标题也很麻烦，所以在想能不能直接脚本搞出来。
在观察了哈工大计网的ppt后，我发现其用的都是同一个模板，小标题都集中到图片的上方，所以决定利用图片裁剪工具+图片OCR工具来完成这个功能。

Script_V3：
1. 利用Ghostscript将指定文件夹中的pdf文件导出为图片（每页pdf导出一页图片）
2. 将指定文件夹中的pdf文件名汇总导出到txt中
3. 将图片复制到暂存文件夹中，用ImageMagick裁剪暂存文件夹中的图片
4. 用Tesserart OCR进行文本识别，并将文本导出到txt中
5. 
>有很多想吐槽的，害
>1. 有关Tesserart OCR
>```PowerShell
>$cmd = "& `"$tesseractPath`" `"$inputFile`" `"$outputFile1`" -l chi_sim"
>```
>这里的outputFile1我以为输出的文件要事先规定好是txt，没想到它默认导出会变成txt，不需要事先指定，所以执行语句前赋值为你需要的txt文件名称就好（不含".txt"）。
我也没看用户手册哈哈，只是觉得有点和前面的语句不搭而已（前面的要指定含后缀的文件名）。
>2. 还是有关Tesserart OCR
尽管人眼看起来这图中的字很清晰，但是这个插件的简体中文识别硬没识别出来。没办法，只能去调图片背景颜色和对比度。调完后识别的精准度上来了，不过依然难顶...
嗐！能用就行！
>![图片调整前](/imgs/20240831005.png)
>![图片调整后](/imgs/20240831006.png)
>![文字识别出来的鬼东西](/imgs/20240831008.png)
>![这里是想表现OCR很拉跨的节目效果哈哈原文是繁体而且图片中字很小](/imgs/20240831007.png)


目前版本如下：截止到2024/08/31
[pdf2pic-Transfer.ps1](####pdf2pic-Transfer.ps1)

代码框架都是从文心一言搜索出来的哈哈哈，不断调试改了些参数加了些语句。
写着写着突然觉得自己写代码还有很多很多很多很多的进步空间，比如备注下啥时候做了啥更改，害，其实这应该算是基本素养叭哈哈，下次一定！

#### GitInstructs.ps1
```PowerShell
# PowerShell 脚本，直接执行 Git 命令  
# 切换到你的 Git 仓库目录（这里需要替换为你的实际路径）  
Set-Location "D:\CS\CS-Learning"  
# 执行 git status 并显示结果  
git status  
$continue = Read-Host "execute [git add]?(y/n)"  
if ($continue.ToLower() -eq "y") {  
    # 执行 git add .  
    git add .  
    $continue = Read-Host "execute [git commit]?(y/n)"  
    if ($continue.ToLower() -eq "y") {  
        # 执行 git commit  
        Write-Host "N times commit today? Input N:"  
        $count = Read-Host
        $date = Get-Date -Format "yyyy-MM-dd"
        $commitMessage = "$date update$count by PowerShellScript"  
        git commit -m $commitMessage  
        $continue = Read-Host "execute [git push]?(y/n)"  
        if ($continue.ToLower() -eq "y") {  
            # 执行 git push  
            git push csl main  
        }

    }  
}
```


#### pdf2pic-Transfer.ps1
```PowerShell
# 设置Ghostscript的安装路径  
$ghostscriptPath = "D:\Program Files\gs\gs10.03.1\bin\gswin64c.exe"  

# 设置源PDF文件夹和目标图片文件夹  
$sourceFolder = "D:\CS\CS-Learning\ComputerNetwork-HIT-LQL\01Courseware"  
$targetFolder = "D:\CS\CS-Learning\ComputerNetwork-HIT-LQL\01Courseware\temp"  
$pTempFolder = Join-Path $targetFolder "p-temp"  

$pdfFileNames = ""

# 确保目标文件夹和p-temp文件夹存在 
if (-not (Test-Path -Path $targetFolder)) {  
    New-Item -ItemType Directory -Path $targetFolder | Out-Null  
}  
if (-not (Test-Path -Path $pTempFolder)) {  
    New-Item -ItemType Directory -Path $pTempFolder | Out-Null  
}
  
# # 获取今天的开始时间（午夜）和结束时间（午夜前一秒）  
# $todayStart = Get-Date -Year $env:YEAR -Month $env:MONTH -Day $env:DAY -Hour 0 -Minute 0 -Second 0  
# $todayEnd = $todayStart.AddDays(1).AddSeconds(-1)  

# 获取今天的开始时间和结束时间  
$today = Get-Date
$todayStart = $today.Date  # 这将自动设置为当天的午夜  
$todayEnd = $today.Date.AddDays(1).AddSeconds(-1)
  
# 遍历源文件夹，只选择创建日期为今天的PDF文件  
Get-ChildItem -Path $sourceFolder -Filter "*.pdf" | Where-Object {  
    $_.CreationTime -ge $todayStart -and $_.CreationTime -le $todayEnd  
} | ForEach-Object {  
    $pdfFile = $_.FullName  
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($pdfFile)  
      
    # 构建Ghostscript命令  
    $cmd = "& `"$ghostscriptPath`" -dBATCH -dNOPAUSE -sDEVICE=jpeg -dJPEGQ=10 -r300 -sOutputFile=`"$targetFolder\$baseName-%d.jpg`" `"$pdfFile`""  

    # 执行命令  
    Invoke-Expression $cmd  
      
    # 输出一些信息到控制台（可选）  
    Write-Host "正在转换: $pdfFile"  

    # 将PDF文件名添加到列表中（准备写入txt文件）  
    $pdfFileNames += $baseName + "`r`n"  
}  

# 如果列表不为空，则将其写入txt文件  
if (![string]::IsNullOrEmpty($pdfFileNames)) {  
    # 构建txt文件的完整路径  
    $txtFilePath = Join-Path $targetFolder "pdfname1_list.txt"  
  
    # 将文件名列表写入txt文件  
    $pdfFileNames | Out-File -FilePath $txtFilePath -Encoding utf8  
  
    # 输出信息到控制台  
    Write-Host "PDF文件名已保存到: $txtFilePath"  
}



# #替换中文名称
# # 复制图片到p-temp文件夹，并删除文件名中的中文（或非ASCII字符）  
# Get-ChildItem -Path $targetFolder -Filter "*.jpg" | ForEach-Object {  
#     $sourcePath = $_.FullName  
#     # 移除文件名中的非ASCII字符  
#     $asciiOnlyName = [System.Text.RegularExpressions.Regex]::Replace($_.Name, "[^\x00-\x7F]", "")  
#     $destinationPath = Join-Path $pTempFolder $asciiOnlyName  
#     Copy-Item -Path $sourcePath -Destination $destinationPath 
# }

#不替换中文名称
# 复制图片到p-temp文件夹，并删除文件名中的中文（或非ASCII字符）  
Get-ChildItem -Path $targetFolder -Filter "*.jpg" | ForEach-Object {  
    $sourcePath = $_.FullName  
    # 移除文件名中的非ASCII字符  
    $asciiOnlyName = $_.Name 
    $destinationPath = Join-Path $pTempFolder $asciiOnlyName  
    Copy-Item -Path $sourcePath -Destination $destinationPath 
}


############
  # 裁剪p-temp中的每张图片并保存到p-temp中（不保存原版）  
$magickPath = "D:\Program Files\ImageMagick-7.1.1-Q16\magick.exe"  # ImageMagick路径  
$tempImages = Get-ChildItem -Path $pTempFolder -Filter "*.jpg"  
  
foreach ($img in $tempImages) {  
    $sourcePath = $img.FullName  
  
    # 获取图片的原始尺寸  
    $originalSize = & "$magickPath" identify -format "%wx%h" "$sourcePath"  
    $width, $height = $originalSize.Split('x')  
    $newheight1 = [double]$height
    $newHeight = [int]($newheight1 * 0.1186)
    # $cropTop = [math]::Floor($height * 0.1186)  ;
    # $cropTop = [math]::Floor(($height - $newHeight) / 2)  
  
    # 构建裁剪命令  
    # 注意：裁剪宽度应该使用原始宽度，X坐标应为0，Y坐标为$cropTop  
    $outputFile = $sourcePath.Replace('.jpg', '_cropped.jpg')  
    $cmd = "& `"$magickPath`" `"$sourcePath`" -crop ${width}x${newHeight}+0+0 `"$outputFile`""  
    # 执行命令  
    Invoke-Expression $cmd  

    # 构造ImageMagick命令以增加对比度（这里假设对比度增加1.5倍）  
    $contrastCmd = "& `"$magickPath`" `"$outputFile`" -level 66%,93% `"$outputFile`""  
    # 执行ImageMagick命令  
    Invoke-Expression $contrastCmd 

    # 如果需要，可以删除原始图片（这里执行删除）  
    Remove-Item $sourcePath  
}
  
# 调用Tesseract OCR识别p-temp文件夹中的每张图片中的文字  
$tesseractPath = "D:\Users\DKLi\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"  # Tesseract OCR路径  
$ocrResults = ""  
foreach ($img in Get-ChildItem -Path $pTempFolder -Filter "*.jpg") { 
    $inputFile = Join-Path $pTempFolder $img
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($img.FullName)  
    $outputFile1 = Join-Path $pTempFolder "$baseName"  
    $cmd = "& `"$tesseractPath`" `"$inputFile`" `"$outputFile1`" -l chi_sim"  # 使用图片的完整路径作为输入  
  
    # 执行命令  
    Invoke-Expression $cmd  
    # 读取OCR结果并添加到汇总文本中  
    $outputFile = Join-Path $pTempFolder "$baseName.txt" 
    $ocrText = Get-Content $outputFile -Raw  -Encoding UTF8   #使用-Raw以避免换行符问题  
    $ocrResults += $ocrText + "`r`n"  # 添加分隔符  
  
    # 清理：删除临时txt文件（如果需要）  
    Remove-Item $outputFile  
}  
  
# 将OCR结果汇总到文件  
$ocrResultFilePath = Join-Path $targetFolder "pdfname2_list.txt"  
$ocrResults | Out-File -FilePath $ocrResultFilePath -Encoding utf8  
Write-Host "OCR结果已汇总到: $ocrResultFilePath"  

############
# 读取文件内容  
$content = Get-Content -Path $ocrResultFilePath 
  
# 使用正则表达式进行查找和替换（这里不需要复杂的正则表达式，但为了展示其可能性）  
$updatedContent = $content -replace " ", ""  
  
# 将更新后的内容写回文件  
$updatedContent | Set-Content -Path $ocrResultFilePath 


Write-Output "今天创建的PDF文件转换完成"
```