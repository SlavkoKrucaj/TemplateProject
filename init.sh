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
        puts(new_path)
        new_contents = text.gsub(/#{pattern_to_replace}/, project_name)
        File.open(new_path, "w") {|file| file.puts new_contents }
      end
    end

    Dir.glob("./**/*.storyboard").each do |new_path|
      text = File.read(new_path)
      new_contents = text.gsub("_#{pattern_to_replace[1..-1]}", project_name)
      File.open(new_path, "w") {|file| file.puts new_contents }
    end
  end
end

class Fabric
  def fill
    api_key, build_secret = collect_values

    replace_fabric_api_key(api_key)
    replace_fabric_build_phase(api_key, build_secret)
  end

  private
  def collect_values
    puts("Setup Crash reporting")

    print("Enter Fabric Api Key: ")
    api_key = gets
    print("Enter Fabric Build Secret: ")
    build_secret = gets

    return api_key, build_secret
  end

  def replace_fabric_api_key(api_key)
    replace("FABRIC_API_KEY", api_key, 'plist')
  end

  def replace_fabric_build_phase(api_key, build_secret)
    replace(script, script_replacement(api_key, build_secret))
  end

  def replace(key, replacement, file_type)
    Dir.glob("./**/*.#{file_type}").reject{ |f| f['/Carthage'] }.each do |new_path|
      if !File.directory? new_path
        text = File.read(new_path)
        new_contents = text.gsub(/#{key}/, replacement)
        File.open(new_path, "w") {|file| file.puts new_contents }
      end
    end
  end

  def script
    '#"${PROJECT_DIR}/Carthage/Build/iOS/Fabric.framework/run" FABRIC_API_KEY BUILD_SECRET'
  end

  def script_replacement(api_key, build_secret)
    "\"${PROJECT_DIR}/Carthage/Build/iOS/Fabric.framework/run\" #{api_key} #{build_secret}"
  end
end

if ARGV.length != 1
  puts 'Usage: ./init [PROJECT NAME]'
  puts "    [PROJECT NAME] is the name of the project you're creating."
else
  system('rm -rf .git')
  Templatizer.new(ARGV[0]).create_project
  Fabric.new.fill
  system('make run')
  system('git init')
  system('git add .')
  system('git commit -m "Initial commit"')
end
