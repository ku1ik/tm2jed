#!/usr/bin/ruby

require 'ruby-debug'
require 'ostruct'
require 'textmate_theme_reader'
require 'jedit_theme_writer'

src = File.read(ARGV.shift)
reader = TextmateThemeReader.new(src)
theme = reader.get_theme
writer = JEditThemeWriter.new(theme)
dst = writer.get_theme
puts
puts dst
dst_filename = ARGV.size > 0 ? ARGV.shift+"/#{theme.name}.jedit-scheme" : "#{ENV['HOME']}/.jedit/schemes/#{theme.name}.jedit-scheme"
File.open(dst_filename, "w") do |f|
  f.write(dst)
end

