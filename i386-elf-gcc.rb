require 'formula'

class I386ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'https://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2'
  mirror 'https://ftpmirror.gnu.org/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2'
  sha256 '6c11d292cd01b294f9f84c9a59c230d80e9e4a47e5c6355f046bb36d4f358092'
  
  depends_on 'gmp@4'
  depends_on 'libmpc@0.8'
  depends_on 'mpfr@2'
  depends_on 'i386-elf-binutils'

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  def pour_bottle?
    MacOS::CLT.installed?
  end

  # Fix build with Xcode 9
  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82091
  if DevelopmentTools.clang_build_version >= 900
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/c2dae73416/gcc%404.9/xcode9.patch"
      sha256 "92c13867afe18ccb813526c3b3c19d95a2dd00973f9939cf56ab7698bdd38108"
    end
  end

  # Fix issues with macOS 10.13 headers and parallel build on APFS
  if MacOS.version >= :high_sierra
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/19d56dcb8c/gcc%404.9/high_sierra.patch"
      sha256 "360ba78af8b13cda0503eef2c809b98404613a7cda9798e53c8b65a9b61b37b5"
    end
  end

  def install
    binutils = Formulary.factory 'i386-elf-binutils'
    ENV['PATH'] += ':#{binutils.prefix/"bin"}'

    args = [
      '--disable-nls', 
      '--target=i386-elf', 
      '--disable-werror',
      "--prefix=#{prefix}",
      '--enable-languages=c',
      '--without-headers',
      "--with-gmp=#{Formula["gmp@4"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr@2"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc@0.8"].opt_prefix}",
    ]

    mkdir 'build' do
      unless MacOS::CLT.installed?
        # For Xcode-only systems, we need to tell the sysroot path.
        # "native-system-headers" will be appended
        args << "--with-native-system-header-dir=/usr/include",
        args << "--with-sysroot=#{MacOS.sdk_path}"
      end
      
      system '../configure', *args
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/'i386-elf', prefix/'i386-elf"'
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/'man'/'man7'
    end
  end
end
