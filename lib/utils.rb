module Utils
  def self.exit_with_error(message)
    $stderr.puts "Error: #{message}"
    exit 1
  end

  def self.terminate(message = "Done!")
    exit_with_error(message)
  end

  def self.run_system_command(*commands)
    system(*command) || exit_with_error("Command failed: #{commands.join(' ')}. Exit code: #{$?.exitstatus}")
  end

  def self.run_command(*commands)
    run_system_command(*commands)
  end
end
