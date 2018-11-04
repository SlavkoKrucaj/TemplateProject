#!/usr/bin/env ruby

require 'erb'

class Templatizer
  attr_accessor :project_name, :pattern_to_replace

  def initialize(project_name = "TemplateProject")
    @project_name = project_name
    @pattern_to_replace = 'TemplateProject'
  end

  def create_project
    Dir.glob("./**/*").reverse.select {|p| p.include? @pattern_to_replace}.each do |path|
      old_path = File.dirname(path)
      new_path = old_path + '/' + File.basename(path).gsub(@pattern_to_replace, @project_name)
      File.rename(path, new_path)
    end
    Dir.glob("./**/*").reject{ |f| f['/scripts'] || f.end_with?('.png') || f['/Carthage']}.each do |new_path|
      if !File.directory? new_path
        text = File.read(new_path)
        new_contents = text.gsub(/#{@pattern_to_replace}/, @project_name)
        File.open(new_path, "w") {|file| file.puts new_contents }
      end
    end

    Dir.glob("./**/*.storyboard").each do |new_path|
      text = File.read(new_path)
      new_contents = text.gsub("_#{@pattern_to_replace[1..-1]}", @project_name)
      File.open(new_path, "w") {|file| file.puts new_contents }
    end
  end
end

if ARGV.length != 1
  puts 'Usage: ./init [PROJECT NAME]'
  puts "    [PROJECT NAME] is the name of the project you're creating."
else
  system('rm -rf .git')
  Templatizer.new(ARGV[0]).create_project
  system('make run')
  system('git init')
  system('git add .')
  system('git commit -m "Initial commit"')
end
