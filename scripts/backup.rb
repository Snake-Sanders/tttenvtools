#!/usr/bin/ruby -w
=begin
    This script searches specific files within the current directory and sub-directories and zip them in a backup file
    The type of files (file extension) is passed as parameter. Originally is for markdown note files

    Author: Snake Sanders
    Creation date: Sat Dec 22 15:19:35 CET 2018

    Version: 1.1 Added as input a list of extensions - Wed Jan 30 22:52:35 CET 2019
    Version: 1.0 Creation
=end

require 'rubygems'
require 'zip'
require_relative 'helper'

def gen_zip_file_name()
    timestamp = Time.now.strftime("%Y-%m-%d_%H.%M.%S")
    "bkp_#{timestamp}.zip"
end

if ARGV.length < 1
    puts "It requires the extension of the file to backup. e.g.:"
    puts "ruby backup md"
    puts "It can also receive a list of extensions to zip. .e.g.:"
    puts "ruby backup md rb html"
    exit 0
end

wrk_path        = File.dirname(File.expand_path('..', __FILE__))
out_folder      = "#{wrk_path}/_backup"
in_file_paths   = []

ARGV.each do |file_extension|
    in_file_paths  += Dir["#{wrk_path}/**/*.#{file_extension}"]
end

in_file_paths  += Dir["#{wrk_path}/**/*.plantUml"]
zip_file        = "#{out_folder}/#{gen_zip_file_name()}"

puts "Preparing environment..."
check_dir_exist(out_folder, true)

Zip::File.open(zip_file, Zip::File::CREATE) do |zip|
    puts "Created #{zip_file}"

    in_file_paths.each do |file_full_path|
        file_path, file_name = File.split(file_full_path)
        begin
            print "Adding to zip #{file_name}..."
            # Two arguments:
            # - The name of the file as it will appear in the archive
            # - The original file, including the path to find it
            zip.add(file_name, file_full_path)
            puts "Ok"
        rescue
            parent_dir = file_path.split(File::SEPARATOR)[-1]
            alt_file_name = "#{parent_dir}_#{file_name}"
            puts "\n\t Using alternative name: #{alt_file_name}"
            begin
                zip.add( alt_file_name, file_full_path)
            rescue
                puts "Warning: Too many files with the same name. Ignoring #{alt_file_name}"
            end
        end
    end

    puts "Backup done!"
end
