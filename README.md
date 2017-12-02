# homebrew-xv6-toolchains

This is a brew repo for installing toolchains to run xv6 on macOS 10.13 High Sierra.

## Install

```sh
brew tap coverxit/homebrew-xv6-toolchains
brew install i386-elf-gcc
```

You then may have to modify `Makefile` in xv6, by first setting the `TOOLPREFIX`:

```
TOOLPREFIX = i386-elf-
```

and modifying `CFLAGS`, adding `-march=i686` after `-m32`, which before modification, looks like:

```
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer
```

then after:

```
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -march=i686 -Werror -fno-omit-frame-pointer
```

Now you can build xv6. Enjoy!
