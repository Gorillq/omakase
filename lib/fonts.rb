#!/usr/bin/env ruby

require_relative 'utils'

#japanese
Utils.repository("noto-fonts-cjk", "noto-fonts-emoji", "noto-fonts", "otf-ipafont", "ttf-hanazono")
#nerds
Utils.repository("ttf-nerd-fonts-symbols")
#optional/extra
# <- todo fancy fonts kiss
Utils.terminate
