#!/usr/bin/ruby -w
=begin
    This script parsers a json file with some info and uses a rhtml template file
    to convert it into html.

    Author: Snake Sanders
    Creation date: Sun Dec 23 00:08:37 CET 2018
    Version: 2.0
=end

require "erb"
require "json"

READ_ONLY_DBG = false
DBG = true

# raw data/json file containing ptc document IDs and descriptions
json_file       = "template/ptc.json"

# file where the json data previously read will be injected to
template_file   = "ptc.rhtml"

# file where the html output is stored
out_file        = "out/ptc.html"

def store_to_file( data, out_file )

    begin
        puts "Saving the output in #{out_file}"
        file = nil

        if File.exist?(out_file) then
            file = File.open(out_file, 'w')
        else
            file = File.new(out_file, 'w')
        end

        file.write(data)
        puts "File saved"
    rescue IOError => e
        puts "Error: Fail to save."
        puts e
    ensure
        file.close unless file.nil?
    end
end

puts "Reading data from json config file: #{json_file}"
json = JSON.parse(File.open(json_file).read) # returns a hash

puts "Loading projects:..."
projects = json.keys
projects.each { |p| puts p}
puts "..."
puts "Printing content"
projects.each do |pro|
    puts "Project: #{pro}"
    if DBG then
        json[pro]["docs"].each { |d| puts "Title: #{d["title"]}" }
    end
end

if READ_ONLY_DBG then
    puts ""
    puts "Exiting without writting result generated file"
    return 0
end

puts "reading template config"

erb = ERB.new(File.read(template_file))
gen_ptc_tables = erb.result
store_to_file( gen_ptc_tables, out_file )

index_out = "out/web/index.html"
puts "Injecting the ptc documents liste into the indext page: #{index_out}"

# when executing erb.result it will use gen_ptc_tables in the next template to inject the tables
erb = ERB.new(File.read("template/index.rhtml"))
gen_idx_page = erb.result
store_to_file( gen_idx_page, index_out )


