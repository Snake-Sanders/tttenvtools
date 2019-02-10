#!/usr/bin/ruby -w
=begin
    Rake file to execut commands from the console. See the default command in order to list the features.
    the helper.rb inclues the needed funtions.

    Author: Snake Sanders
    Creation date: Sun Feb 10 10:29:13 CET 2019

    Version: 1.0 Creation
=end

require 'fileutils'
require_relative "scripts/helper"

PWD         = __dir__
SCRIPT_PATH = "./scripts"

task :default => :help

task :help do
    puts "Usage:"
    puts "rake -D"
    puts "To show a list of tasks"
end

desc "Generate html from json by calling erb-parser.rb"
task :genptc do
    puts "Generating html with PTC items"
    `ruby #{SCRIPT_PATH}/erb-parser.rb`
end

desc "clear directory"
task :clear do
    puts "Deleting generated directories"
    del_dir("./out")
end

desc "Backs up all the src files by calling backup.rb"
task :bkp do
    extensions = "json rhtml md"
    `ruby #{SCRIPT_PATH}/backup.rb #{extensions}`
    puts "all data backup: #{extensions}"
end

desc "Move Generated html files to the web folder"
task :mvgen do

    NOTES_PATH  = File.join( PWD, "notes")
    WEB_PATH    = File.join( PWD, "out","web", "notes")

    puts "Moving generated files to #{WEB_PATH}"

    if not check_dir_exist(NOTES_PATH) then
        abort
    end

    check_dir_exist(WEB_PATH, true)

    file_extension = "html"
    puts "searching for #{file_extension} files in " + NOTES_PATH

    html_file_paths = []

    # each subfolder is a project which contains similar pages:
    # info.html, todo.html, architecture.html etc.
    Dir.children(NOTES_PATH).each do |prj_dir|
        file_paths = Dir["#{NOTES_PATH}/#{prj_dir}/**/*.#{file_extension}"]
        if file_paths.size > 0 then
            html_file_paths += [prj_dir , file_paths]
            puts "Found #{file_paths.size} files in #{prj_dir}"
            file_paths.each { |f| puts "- " + f }

            puts "Copying files:"
            file_paths.each do |file_path|
                # replace the file name: append the project name to it.
                # e.g.: project_file.html
                new_file_name = "#{prj_dir}_" + File.basename(file_path)
                dst_path = File.join(File.dirname(WEB_PATH), new_file_name)
                puts "#{file_path}, #{dst_path}"
                FileUtils.cp file_path, dst_path #, :verbose => true
            end
        end
    end
end

