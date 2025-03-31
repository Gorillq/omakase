#!/usr/bin/env ruby

require_relative "utils"

if ENV["XDG_CURRENT_DESKTOP"]&.include?("MATE")
  Utils.terminate
else
  Utils.run_command("sudo", "pacman", "-S", "--noconfirm", "--needed", "xorg", "xorg-server", "mate", "mate-extra", "lightdm", "lightdm-gtk-greeter")
  Utils.run_command("sudo", "systemctl", "enable", "lightdm")
end
