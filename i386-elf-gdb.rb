require 'formula'

class I386ElfGdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.8.2.tar.xz'
  sha256 '605954d5747d5f08ea4b7f48e958d1ebbf39265e18f7f36738deeabb83744485'

  depends_on 'i386-elf-binutils'
  depends_on 'i386-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
    end
  end
end
