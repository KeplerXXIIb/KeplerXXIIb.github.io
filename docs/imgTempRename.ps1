# 指定要扫描的文件夹路径
$folderPath = "D:\CS\myblog\source\imgs_temp"

# 获取当前日期并格式化
$currentDate = Get-Date -Format "yyyyMMdd"

# 初始化文件计数器
$fileCount = 1

# 获取文件夹中的所有文件
$files = Get-ChildItem -Path $folderPath -File|Sort-Object CreationTime

# 遍历并重命名每个文件
foreach ($file in $files) {
    # 构建新的文件名
    $formattedCount = "{0:D2}" -f $fileCount
    $newName = "$currentDate$formattedCount$($file.Extension)"
    
    # 构建新的文件路径
    $newFilePath = Join-Path -Path $folderPath -ChildPath $newName
    
    # 重命名文件
    Rename-Item -Path $file.FullName -NewName $newFilePath
    
    # 增加文件计数器
    $fileCount++
}
