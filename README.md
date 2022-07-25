# Dotfiles Management

Back up my dotfiles on ubuntu-20.04 with the help of [mackup](https://github.com/lra/mackup)

## Install and configure mackup
See [here](https://github.com/lra/mackup/blob/master/README.md) for installation 
and [here](https://github.com/lra/mackup/blob/master/doc/README.md) for configuation 

## Clone this repository

1. make sure in the home path.
2. git clone

## Add and Overwrite dotfiles

Assume you have configured `mackup` successfully, next step is restore 
your backuped dotfiles.
```shell
mackup restore
```

After execute this, mackup will create softlinks of backup dotfiles.
If there are existed files, you can choose overwrite it or keep the original
files.
