#!/usr/bin/env ruby

require_relative 'utils'

puts "#{Utils::COLOURS[:green]}Starting yay installation on Arch Linux...#{Utils::COLOURS[:reset]}"

yay_dir = "/tmp/yay"
unless Dir.exist?(yay_dir)
  puts "#{Utils::COLOURS[:green]}Cloning yay repository...#{Utils::COLOURS[:reset]}"
  run_command("git clone https://aur.archlinux.org/yay.git #{yay_dir}")
else
  puts "#{Utils::COLOURS[:yellow]}yay repository already cloned, pulling latest changes...#{Utils::COLOURS[:reset]}"
  run_command("cd #{yay_dir} && git pull")
end

puts "#{Utils::COLOURS[:green]}Building and installing yay...#{Utils::COLOURS[:reset]}"
Dir.chdir(yay_dir) do
  run_command("makepkg", "-si", "--noconfirm")
end

if system("yay --version > /dev/null 2>&1")
  puts "#{Utils::COLOURS[:green]}yay installed successfully!#{Utils::COLOURS[:reset]}"
else
  puts "#{Utils::COLOURS[:red]}Failed to install yay. Please check the output above for errors.#{Utils::COLOURS[:reset]}"
end

# Clean up
puts "#{Utils::COLOURS[:green]}Cleaning up temporary files...#{Utils::COLOURS[:reset]}"
run_command("rm -rf #{yay_dir}")

puts "#{Utils::COLOURS[:teal]}Installation complete! You can now use yay to install AUR packages.#{Utils::COLOURS[:reset]}"
