---
title: 记有关Git的一次误操作及处理Something about Git.
date: 2024-05-31
cover_image: /imgs/20240606001.jpg
categories: tech-blog
tags:
  - CS
---
- [事发经过](#事发经过)
- [解决方案](#解决方案)
    - [`git flog`](#git-flog)
    - [`git reflog`](#git-reflog)
    - [`git fsck`](#git-fsck)
    - [`git fsck --no-reflogs | awk '/dangling commit/ {print $3}'`](#git-fsck---no-reflogs--awk-dangling-commit-print-3)
    - [`git show <commit-hash>`](#git-show-commit-hash)
    - [`git cherry-pick <commit hash>`](#git-cherry-pick-commit-hash)
    - [`git reset --hard <hash>`](#git-reset---hard-hash)
- [过程截图](#过程截图)


在使用VSC的过程中，发现了一个好用的git插件，GitLens。
![](/imgs/20240605008.png)


## 事发经过
2024年5月26日晚10点40左右，手贱的我，不小心在GitLens的操作界面，点到了撤销stashes。我的C语言文档（网课课件、代码等）已经部署了Git托管，距离上一次commit（0521update），已经过了5天，已经积攒了较多改动。我的这个操作直接将文档还原到了“0521update”后的状态。我慌了，虽然这部分改动我都可以凭记忆还原，但是有些麻烦，况且以后如果遇到类似问题，提交了n多次的项目文档怎么能经得起这种折腾？
于是乎，马上开始搜索相关方案抢救！

## 解决方案
通过“用户文档+用搜索引擎搜索经验贴+LLM大模型搜索”方式搜索方法后，
综合了下，大致思路是通过日志等找到stash记录然后将其恢复（直接恢复或单独生成一个分支）。
尝试了以下语句：

```bash
git log
git reflog
git fsck --no-reflogawk '/dangling commit/ {print $3}'
git show <commit-hash>
git cherry pick
git reset --hard <hash>
```
以上语句的用法及例子如下：（来源：文心大模型）

***

#### `git flog`
`git log` 命令用于显示提交历史。默认情况下，它会显示最近的提交，包括提交信息、作者和提交者、提交时间等。

**例子**：


```bash
$ git log
commit 1a2b3c4d5e6f7890abcd1234567890ef1a2b3c4d
Author: John Doe <john.doe@example.com>
Date:   Mon Mar 1 21:39:13 2023 +0100

    Initial commit

commit 0123456789abcdef0123456789abcdef01234567
Author: Jane Smith <jane.smith@example.com>
Date:   Sun Feb 28 20:38:12 2023 +0100

    Add a new feature
```

#### `git reflog`

`git reflog` 命令用于显示引用日志。这个日志记录了 HEAD 和其他引用（如分支和标签）的最近更改。这对于恢复丢失的提交或回退到以前的版本特别有用。

**例子**：


```bash
$ git reflog
1a2b3c4d HEAD@{0}: commit: Initial commit
0123456 HEAD@{1}: reset: moving to HEAD~1
...
```
#### `git fsck`

`git fsck` 是一个用于检查 Git 仓库完整性的工具。它检查仓库中的对象是否损坏或缺失。

或者更详细地检查：


```bash
git fsck --full
```
**例子**：

如果运行 `git fsck` 并发现没有输出，那么你的仓库是健康的。如果有输出，则可能表示有损坏或丢失的对象。

#### `git fsck --no-reflogs | awk '/dangling commit/ {print $3}'`

这个命令组合用于查找并列出仓库中未引用的提交（通常称为“悬挂”提交）。`--no-reflogs` 选项告诉 `git fsck` 不要检查引用日志。然后，通过 `awk` 命令过滤出与“dangling commit”相关的行，并打印出这些提交的哈希值。

**例子**：

假设你运行了这个命令并得到了以下输出：


```bash
d098765
e0f1234
```
这表示你有两个悬挂的提交，其哈希值分别为 `d098765` 和 `e0f1234`。

#### `git show <commit-hash>`

`git show` 命令用于显示指定提交的详细信息，包括提交信息、作者和提交者、差异等。


**例子**：


```bash
$ git show 1a2b3c4d5e6f7890abcd1234567890ef1a2b3c4d
commit 1a2b3c4d5e6f7890abcd1234567890ef1a2b3c4d
Author: John Doe <john.doe@example.com>
Date:   Mon Mar 1 21:39:13 2023 +0100

    Initial commit

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e69de29
...
```
在这个例子中，`git show` 显示了与提交哈希 `1a2b3c4d5e6f7890abcd1234567890ef1a2b3c4d` 相关的详细信息。


#### `git cherry-pick <commit hash>`
在 Git 中，`cherry-pick` 是一个用于选择某个或某些提交（commit）并应用它们到当前分支的操作，而无需合并（merge）或变基（rebase）整个分支。这在你想要获取某个分支上的特定更改，但不想引入该分支上的其他更改时非常有用。

以下是 `cherry-pick` 的基本用法：

1. **查看提交历史**：
首先，你需要知道你想要 `cherry-pick` 的提交的哈希值（commit hash）。你可以使用 `git log` 命令来查看提交历史。


```bash
git log
```
这将显示提交列表，每个提交都有一个唯一的哈希值。
2. **执行 cherry-pick**：
使用 `git cherry-pick <commit-hash>` 命令来应用特定的提交。


```bash
git cherry-pick abcdef123456
```
在上面的命令中，`abcdef123456` 是你想要 `cherry-pick` 的提交的哈希值。
3. **解决冲突**：
如果 `cherry-pick` 的提交与当前分支上的更改存在冲突，Git 会提示你解决这些冲突。你需要手动编辑文件以解决冲突，然后使用 `git add` 命令来标记冲突已解决，并使用 `git commit` 来完成 `cherry-pick` 操作。

注意：默认情况下，`cherry-pick` 会创建一个新的提交，即使你正在 `cherry-pick` 的提交在原始分支上是一个合并提交（merge commit）。如果你想要保持合并提交的结构，你需要使用其他更复杂的工具或方法。
4. **撤销 cherry-pick**：
如果你不小心 `cherry-pick` 了错误的提交，并且想要撤销它，你可以使用 `git reset` 命令。但请注意，这会撤销最后一次 `cherry-pick` 提交以及该提交之后的所有提交。


```bash
git reset --hard HEAD^
```
或者，如果你只想撤销最后一次 `cherry-pick`，但保留之后的提交，你可以使用 `git revert` 命令来创建一个新的提交，该提交会撤销 `cherry-pick` 提交所做的更改。


```bash
git revert HEAD
```
这将创建一个新的提交，该提交是 `cherry-pick` 提交的逆操作。


#### `git reset --hard <hash>`
在 Git 中，`git reset --hard <hash>` 是一个强大的命令，用于将当前分支的 HEAD 移动到指定的提交（由 `<hash>` 标识），并且重置索引（staging area）和工作目录（working directory）以匹配该提交的内容。这意味着所有在当前 HEAD 之后（不包括该提交）的更改都会被丢弃。

使用 `git reset --hard` 时需要特别小心，因为它会丢弃所有未提交的更改。这些更改包括暂存的（staged）更改和未暂存的（unstaged）更改。

以下是一些关于 `git reset --hard <hash>` 的重要事项：

1. **不可逆**：一旦执行了 `git reset --hard`，所有被丢弃的更改都将无法恢复（除非你之前有备份或者通过其他分支/reflogs 能够找到它们）。

2. **指定提交**：`<hash>` 是你想要重置到的提交的哈希值或引用（如 `HEAD~2` 表示前两个提交）。

3. **工作目录和索引的变化**：执行命令后，你的工作目录和索引将被更新以匹配指定提交的内容。任何暂存的或未暂存的更改都将被丢弃。

4. **HEAD 的移动**：HEAD 指针会移动到指定的提交，成为新的当前提交。

5. **不创建新的提交**：与 `git revert` 不同，`git reset --hard` 不会创建新的提交来撤销之前的更改；它仅仅是简单地丢弃它们。

6. **用途**：这个命令通常用于以下情况：
   - 当你想要完全撤销一系列提交时。
   - 当你想要将分支重置到一个干净的状态，以便重新开始。
   - 当你确信不再需要某个分支上的某些更改时。

7. **谨慎使用**：在公共分支上使用此命令时要格外小心，因为这会导致其他人尝试拉取或推送更改时遇到问题。通常，最好在本地分支或私有分支上使用它。

8. **Reflog**：Git 的 reflog 可以作为一种“后悔药”，因为它记录了 HEAD 的所有移动。即使你使用 `git reset --hard` 丢弃了更改，你也可以通过 reflog 找到它们并恢复。但是，这并不意味着你应该依赖 reflog 来避免丢失数据；始终确保你有适当的备份和版本控制策略。

示例：

```bash
# 假设你想要将当前分支重置到前两个提交
git reset --hard HEAD~2
```

这个命令会丢弃当前 HEAD 和其前一个提交的所有更改，并将 HEAD 移动到前两个提交。


***

## 过程截图
git log发现log显示的最近一次更新是0521update。
![](/imgs/20240605001.png)

git relog发现log显示的最近一次更新是0521update。
![](/imgs/20240605002.png)

通过git fsck发现了悬挂着的commit的哈希值
![](/imgs/20240605003.png)

通过git fsck --no-reflogs | awk '/dangling commit/ {print $3}'确认有两条悬挂着的commit。
使用git show <commit-hash>查看两次提交的具体内容。
![](/imgs/20240605004.png)
由于这个dangling commit是单独的commit，不需要其历史记录，所以使用cherry pick单独挑出，
![](/imgs/20240605005.png)

这里其实不需要再切换了，不过当时看到了这个命令，而且0526update后文档没有什么变动，所以怀着好奇心的我还是操作了git reset --hard <hash>。
于是乎分支重新定位到了这个提交。
![](/imgs/20240605006.png)
此时再去查看dangling commit发现该提交已不存在。
![](/imgs/20240605007.png)

就是GitLens让我瞎操作出了这次幺蛾子（狗头。再次评估自己的需求后，发现自己就是想看下分支图，所以卸载了GitLens（主要是它pro版还要收费），安装了GitGraph。
![](/imgs/20240605008.png)

cherrypick前，在此之前需将分支切换回main（原主分支）。
![](/imgs/20240605009.png)

cherrypick后，0531update是后来的更新，和这次操作无关。
![](/imgs/20240605010.png)

最终将这次提交合并到了原分支上。问题解决。