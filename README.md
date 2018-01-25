# homebrew-xv6-toolchains

This is a brew repo for installing toolchains to run xv6 on macOS 10.13 High Sierra.

## Install

```sh
brew tap krunal-shah/homebrew-xv6-toolchains
brew install i386-elf-gcc
brew install qemu
```
Move to the directory where you wish to install the xv6 OS and run
```
git clone https://github.com/mit-pdos/xv6-public
```
Now replace the Makefile in the xv6 directory with the one in this repo.

The given Makefile essentially has the following changes to the default one

`CFLAGS` is modified from 
```
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer
```
to 
```
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -march=i686 -Werror -fno-omit-frame-pointer
```
Now run 
```
cd xv6-public
make
```
xv6 is installed.

COL331 students might want to execute the following too
```
echo "export PATH=/usr/local/Cellar/i386-elf-gcc/:\$PATH" >> ~/.bash_profile
```

To use xv6 with QEMU emulator, run
```
make qemu
```
