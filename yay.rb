#!/usr/bin/env ruby

require 'open3'

def run_command(command)
  stdout, stderr, status = Open3.capture3(command)
  if status.success?
    puts "Success: #{stdout}"
  else
    puts "Error: #{stderr}"
    exit 1
  end
end

def package_installed?(package)
  system("pacman -Qs #{package} > /dev/null 2>&1")
end

puts "Starting yay installation on Arch Linux..."

=begin
dependencies = ["git", "base-devel"]
dependencies.each do |dep|
  unless package_installed?(dep)
    puts "Installing #{dep}..."
    run_command("sudo pacman -S --noconfirm #{dep}")
  else
    puts "#{dep} is already installed."
  end
end
=end

yay_dir = "/tmp/yay"
unless Dir.exist?(yay_dir)
  puts "Cloning yay repository..."
  run_command("git clone https://aur.archlinux.org/yay.git #{yay_dir}")
else
  puts "yay repository already cloned, pulling latest changes..."
  run_command("cd #{yay_dir} && git pull")
end

puts "Building and installing yay..."
Dir.chdir(yay_dir) do
  run_command("makepkg -si --noconfirm")
end

if system("yay --version > /dev/null 2>&1")
  puts "yay installed successfully!"
else
  puts "Failed to install yay. Please check the output above for errors."
  exit 1
end

# Clean up
puts "Cleaning up temporary files..."
run_command("rm -rf #{yay_dir}")

puts "Installation complete! You can now use yay to install AUR packages."
