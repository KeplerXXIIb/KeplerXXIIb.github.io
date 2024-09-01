# PowerShell 脚本，直接执行 Git 命令  
# 切换到你的 Git 仓库目录（这里需要替换为你的实际路径）  
Set-Location "D:\CS\myblog"  
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
        $continue = Read-Host "execute [git push --force]?(y/n)"  
        if ($continue.ToLower() -eq "y") {  
            # 执行 git push  
            git push myblog main --force
        }

    }  
}