#!/usr/bin/ruby -w
=begin
    Rake file to execut commands from the console. See the default command in order to list the features.
    the helper.rb inclues the needed funtions.

    Author: Snake Sanders
    Creation date: Sun Feb 10 10:29:13 CET 2019

    Version: 1.0 Creation
=end

require 'fileutils'
require 'json'
require_relative "scripts/helper"

PWD         = __dir__
SCRIPT_PATH = "./scripts"

task :default => :help

desc "Show the help"
task :help do
    puts "[Task] Show help"
    puts "Usage:"
    puts "rake -D"
    puts "To show a list of tasks"
end

desc "Generate all"
task :genall => [ "clear", "gennotes", "genptc" ] do
    puts "[Task] Generating all the files"
end

desc "Generate html from json by calling erb-parser.rb"
task :genptc do
    puts "[Task] Generating html with PTC items"
    `ruby #{SCRIPT_PATH}/erb-parser.rb`
end

desc "clear directory"
task :clear do
    puts "[Task] Deleting generated directories"
    del_dir("./out")
    del_dir("./gen")
end

desc "Backs up all the src files by calling backup.rb"
task :bkp do
    puts "[Task] backing all up"
    extensions = "json rhtml md"
    `ruby #{SCRIPT_PATH}/backup.rb #{extensions}`
    puts "all data backup: #{extensions}"
end

desc "Move Generated html files to the web folder"
task :gennotes do

    NOTES_PATH  = File.join( PWD, "notes")
    WEB_PATH    = File.join( PWD, "out","web", "notes")
    GEN_PATH    = File.join( PWD, "gen")

    puts "[Task] Moving generated files to #{WEB_PATH}"

    if not check_dir_exist(NOTES_PATH) then
        abort
    end

    check_dir_exist(WEB_PATH, true)
    check_dir_exist(GEN_PATH, true)

    file_extension = "html"
    puts "searching for #{file_extension} files in " + NOTES_PATH

    note_links_json = {} # json struct where the note links to html are stored

    # each subfolder is a project which contains similar pages:
    # info.html, todo.html, architecture.html etc.
    Dir.children(NOTES_PATH).each do |prj_dir|
        file_paths = Dir["#{NOTES_PATH}/#{prj_dir}/**/*.#{file_extension}"]

        if file_paths.size > 0 then
            puts "Found #{file_paths.size} files in #{prj_dir}"
            file_paths.each { |f| puts "- " + f }

            puts "Copying files:"
            html_links = []
            file_paths.each do |file_path|
                # replace the file name: append the project name to it.
                # e.g.: project_file.html
                new_file_name = "#{prj_dir}_" + File.basename(file_path)
                dst_path = File.join(WEB_PATH, new_file_name)
                puts "#{file_path}, #{dst_path}"
                FileUtils.cp file_path, dst_path #, :verbose => true
                html_links << "../web/notes/#{new_file_name}"
            end
            note_links_json[prj_dir] = html_links
        end
    end
    store_to_file(note_links_json.to_json, File.join(GEN_PATH,"notes.json"))
end

