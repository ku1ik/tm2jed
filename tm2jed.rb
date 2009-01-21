#!/usr/bin/ruby

require 'ostruct'
require File.join(File.dirname(__FILE__), 'textmate_theme_reader.rb')
require File.join(File.dirname(__FILE__), 'jedit_theme_writer.rb')

def debug(msg)
  puts msg if DEBUG
end

tm_theme_filename = ARGV.shift
DEBUG = ARGV.shift == '-d'
src = File.read(tm_theme_filename)
reader = TextmateThemeReader.new(src)
theme = reader.get_theme
writer = JEditThemeWriter.new(theme)
dst = writer.get_theme
jed_theme_filename = tm_theme_filename.gsub("tmTheme", "jedit-scheme")
File.open(jed_theme_filename, "w") do |f|
  f.write(dst)
end
