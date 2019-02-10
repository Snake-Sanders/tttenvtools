#!/usr/bin/ruby -w
=begin
    Rake file to execut commands from the console. See the default command in order to list the features.
    the helper.rb inclues the needed funtions.

    Author: Snake Sanders
    Creation date: Sun Feb 10 10:29:13 CET 2019

    Version: 1.0 Creation
=end

require_relative "scripts/helper"

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
    extensions = "json rhtml"
    `ruby #{SCRIPT_PATH}/backup.rb #{extensions}`
    puts "all data backup: #{extensions}"
end

desc "Move Generated files to the web folder"
task :mvgen do
    NOTES_PATH  = "../notes/"
    WEB_PATH    = "../web/"
    puts "Moving generated files to #{WEB_PATH}"

    if not check_dir_exist(NOTES_PATH) then
        puts "The generated files folder was not found at:#{NOTES_PATH}. \nExiting"
        abort
    end

    check_dir_exist(NOTES_PATH, true)

end

