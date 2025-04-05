#!/usr/bin/env ruby

require_relative 'utils'

Utils.run_command('git', 'clone', 'https://github.com/LazyVim/starter ~/.config/nvim')
Utils.run_command('rm', '-rf', '~/.config/nvim/.git')
Utils.terminate
