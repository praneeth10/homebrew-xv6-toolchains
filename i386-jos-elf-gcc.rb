require 'formula'

class I386JosElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  #url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  #mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  #sha256 'b037fe5132b71ecad2ea7141ec92292b5d32427bf90fd90cde432b1d5abacc2c'
  url "https://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2"
  sha256 "6c11d292cd01b294f9f84c9a59c230d80e9e4a47e5c6355f046bb36d4f358092"
  
  depends_on 'gcc@4.9'
  depends_on 'gmp@4'
  depends_on 'libmpc@0.8'
  depends_on 'mpfr@2'
  depends_on 'i386-jos-elf-binutils'

  def install
    binutils = Formula.factory 'i386-jos-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.9'
    ENV['CXX'] = '/usr/local/bin/g++-4.9'
    ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    ENV['LD'] = '/usr/local/bin/gcc-4.9'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-jos-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-jos-elf", prefix/"i386-elf-jos"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
