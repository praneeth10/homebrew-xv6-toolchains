require 'formula'

class I386ElfGdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url 'http://mirrors.kernel.org/sourceware/gdb/releases/gdb-8.1.tar.gz'

  depends_on 'i386-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
    end
  end
end
