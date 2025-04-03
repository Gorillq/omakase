module Utils

  COLOURS = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m",
    lblue: "\e[0;94m",
    teal: "\e[0;96m",
    reset: "\e[0m"
  }

  def self.terminate
    puts "#{COLOURS[:teal]}Done!#{COLOURS[:reset]}"
    exit
  end

  def self.run_system_command(*commands)
    system(*commands) || exit_with_error("#{COLOURS[:yellow]}Command failed:#{COLOURS[:red]} #{commands.join(' ')}.#{COLOURS[:yellow]} Exit code:#{COLOURS[:red]} #{$?.exitstatus}#{COLOURS[:reset]}")
  end

  def self.run_command(*commands)
    run_system_command(*commands)
  end
  
  def self.repository(*packages)
    run_system_command("sudo", "pacman", "-S", "--noconfirm", "--needed", *packages)
  end
  
  def self.package_installed?(package)
    system("pacman -Qs #{package} > /dev/null 2>&1")
  end
end
