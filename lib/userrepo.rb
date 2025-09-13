#!/usr/bin/env ruby

require_relative "utils"

Utils.run_command("yay", "-S", "--needed", "librewolf-bin", "nvim-lazy")
#lazyvim
Utils.run_command('nvim', '+qall')
Utils.run_command('mkdir', '-p', "/home/goro/.config/nvim")
Utils.run_command('git', 'clone', 'https://github.com/LazyVim/starter' "/home/goro/.config/nvim")
Utils.run_command('rm', '-rf', '~/.config/nvim/.git')
Utils.run_command('nvim', '+LazyHealth', '+qall')
Utils.run_command('clear')
#Server firmware
choice = ""

until ["Y", "N"].include?(choice)
  puts "Server firmware, install? ('Y' or 'N')"
  choice = gets.chomp.upcase
end

if choice == "Y"
  Utils.run_command('yay', '-S', 'ast-firmware', 'aic94xx-firmware', 'wd719x-firmware', 'linux-firmware-qlogic')
end

Utils.terminate
