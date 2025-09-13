#!/usr/bin/env ruby

require_relative 'utils'
#todo -check if mate is installed
current_binding = Utils.catch_command('dconf', 'list', '/org/mate/desktop/keybindings/')
custom_zero = '/org/mate/desktop/keybindings/custom0/'
if !current_binding.include?('/custom0')
  Utils.terminate
else
  #todo - prefer full path!
  Utils.run_command('dconf', 'write', "#{custom_zero}name",
                    "'Run ghostty'")
  Utils.run_command('dconf', 'write', "#{custom_zero}action",
                    "'ghostty'")
  Utils.run_command('dconf', 'write', "#{custom_zero}binding",
                    "'<Super>t'")
  Utils.terminate
