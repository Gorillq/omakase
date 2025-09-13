#!/usr/bin/env ruby

require_relative "utils"

home_dir = ENV["HOME"]
unless home_dir
  puts "#{Utils::Utils::COLOURS[:red]} Error:#{Utils::Utils::COLOURS[:lblue]} Could not determine home dir.#{Utils::Utils::COLOURS[:teal]} Is HOME set?#{Utils::Utils::COLOURS[:reset]}"
  exit 1
end

nvim_config = File.join(home_dir, ".config", "nvim")

Utils.run_command("yay", "-S", "--needed",
 "librewolf-bin",
 "nvim-lazy")

if Dir.exist?(nvim_config)
  puts "#{Utils::COLOURS[:lblue]}Existing configuration found. #{Utils::COLOURS[:green]} Backing up..#{Utils::COLOURS[:reset]}"
  backup = "#{nvim_config}.backup_#{Time.now.strftime('%Y%m%d-%H%M%S')}"
  Utils.run_command("mv", nvim_config, backup)
  puts "#{Utils::COLOURS[:teal]} Backup at #{backup}#{Utils::COLOURS[:reset]}"
end
#lazyvim
Utils.run_command('nvim', "+qall")
Utils.run_command("git", "clone", "https://github.com/LazyVim/starter", nvim_config)
Utils.run_command('rm', '-rf', File.join(nvim_config, ".git"))
Utils.run_command("nvim", "+Lazy intall", "+qa")
Utils.run_command('nvim', '+LazyHealth', "+qall")
Utils.run_command('sleep', '12')
Utils.run_command('clear')
#Server firmware
choice = ""

until ["Y", "N"].include?(choice)
  print "Server firmware, install? ('Y' or 'N') "
  choice = gets.chomp.upcase
end

if choice == "Y"
  Utils.run_command('yay', '-S', '--needed',
	'ast-firmware',
 	'aic94xx-firmware',
 	'wd719x-firmware',
 	'linux-firmware-qlogic')
end

Utils.terminate
