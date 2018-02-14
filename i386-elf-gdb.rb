require 'formula'

class I386ElfGdb < Formula
  url 'https://mirrors.peers.community/mirrors/gnu/gdb/gdb-8.1.tar.gz'

  depends_on 'i386-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
    end
  end
end
