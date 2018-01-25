# homebrew-xv6-toolchains

This is a brew repo for installing toolchains to run xv6 on macOS 10.13 High Sierra.

## Install

```sh
brew tap krunal-shah/homebrew-xv6-toolchains
brew install i386-elf-gcc
brew install qemu
```

Replace the Makefile in the xv6 directory with the one in this repo.

Now you can build xv6. Enjoy!
