#!/usr/bin/env ruby

if ENV["XDG_CURRENT_DESKTOP"]&.include?("MATE")
  exec('ruby', 'yay.rb')
else
  system("sudo pacman -S --noconfirm xorg xorg-server")
  system("sudo pacman -S --noconfirm mate mate-extra")
  system("sudo pacman -S --noconfirm lightdm")
  system("sudo pacman -S --noconfirm lightdm-gtk-greeter")
  system("sudo systemctl enable lightdm")
  puts "System will reboot soon, run script again after login"
  system("sudo reboot 1")
end
