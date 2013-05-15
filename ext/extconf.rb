# Command-Line Plugin Installer
# From https://github.com/Watson1978/motion-doc/blob/master/ext/extconf.rb

require 'fileutils'

filename = "generate.rb"

dir = File.expand_path("~/Library/RubyMotion/command/")
src = File.expand_path(File.join(File.dirname(__FILE__), "../command/#{filename}"))
dst = File.join(dir, filename)

FileUtils.mkdir_p(dir) unless File.exist?(dir)
FileUtils.rm dst if File.exist?(dst)
FileUtils.ln_s src, dst


### dummy ###
require 'mkmf'
create_makefile('')
