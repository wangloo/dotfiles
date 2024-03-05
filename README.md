# 介绍

借助 [mackup](https://github.com/lra/mackup)
实现对 dotfiles 的快速备份和恢复。

此工程是我的[开发环境快速构建](https://wangloo.github.io/posts/tools/dev_env/)的支撑之一。

# 使用方法

拿到新机器后，按照下面的步骤来执行。

## 安装 `mackup`
先安装好 mackup, 按照官方文档即可:

   - See [here](https://github.com/lra/mackup/blob/master/README.md) for installation
   - and [here](https://github.com/lra/mackup/blob/master/doc/README.md) for configuation
>使用pip方式安装后，可能安装目录不在PATH中，需要手动添加。
>```sh
>export PATH=$HOME/.local/bin:$PATH
>```
## Clone 本项目
clone 本项目到本地**的 home 目录**！！

## 恢复dotfiles

Assume you have configured `mackup` successfully, next step is restore
your backuped dotfiles.

```shell
# mackup运行需要依赖config文件，先将其拷贝到根目录
# 在后续恢复的时候对其进行覆盖即可
cp -r ~/dotfiles/backup/.mackup* ~
mackup restore
```

After execute this, mackup will create softlinks of backup dotfiles.
If there are existed files, you can choose overwrite it or keep the original
files.

> tips: 在做恢复、备份这些敏感操作之前，可以添加参数`-n`，会显示执行结果但并不实际执行

> 其他的技巧请多看 mackup 官方文档，感谢 mackup!！
