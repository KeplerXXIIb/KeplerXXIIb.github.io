###定义文件夹路径
$folderXXX = "D:\CS\myblog\source\_posts"
$folderYYY = "D:\CS\myblog\source\imgs_temp"
$folderZZZ = "D:\CS\myblog\source"
$folderAAA = "D:\CS\myblog"

###打开文件夹
Start-Process explorer.exe -ArgumentList $folderXXX
Start-Process explorer.exe -ArgumentList $folderYYY
Start-Process explorer.exe -ArgumentList $folderZZZ
Start-Process explorer.exe -ArgumentList $folderAAA

# 设置目标文件夹路径
$folderPath = $folderXXX  # 请将此路径替换为你的目标文件夹路径

# 获取文件夹下的所有文件，按最近修改时间降序排序
$files = Get-ChildItem -Path $folderPath -File | Sort-Object LastWriteTime -Descending

# 检查是否有文件存在
if ($files.Count -eq 0) {
    Write-Host 0
    exit
}

# 获取最近修改时间最新的文件
$latestFile = $files[0]

# 打开最新的文件
# 使用默认程序打开文件
Invoke-Item -Path $latestFile.FullName