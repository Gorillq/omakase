#!/usr/bin/env ruby

require_relative "utils"

Utils.run_command("yay", "-S", "librewolf-bin", "nvim-lazy")
Utils.terminate
