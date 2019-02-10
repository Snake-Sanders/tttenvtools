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
require "fileutils"
require_relative "helper"


READ_ONLY_DBG = false
DBG = true
DBG_SHOW_INPUT = false

puts "Current working dir #{__dir__}" unless not DBG

PWD = __dir__

# raw data/json file containing ptc document IDs and descriptions
json_file       = "#{PWD}/../data/ptc.json"

# dir location of the tamplates rhml files
template_path   = "#{PWD}/../templates"

# dir location of the generated output files
output_path     = "#{PWD}/../out"

# file where the html output is stored
out_file        = "#{output_path}/ptc.html"

# make sure that the output folder is created
check_dir_exist(output_path ,true)
check_dir_exist(File.join(output_path, "web") ,true)

puts "Reading data from json config file: #{json_file}"
json = JSON.parse(File.open(json_file).read) # returns a hash

puts "Loading projects:"
projects = json.keys
projects.each { |p| puts " - #{p}"}

if DBG_SHOW_INPUT then
    puts "..."
    puts "Printing content"
    projects.each do |pro|
        puts "Project: #{pro}"
        json[pro]["docs"].each { |d| puts "Title: #{d["title"]}" }
    end
end

if READ_ONLY_DBG then
    puts ""
    puts "Exiting without writting result generated file"
    abort
end

puts "reading template config"

# file where the json data previously read will be injected to
erb = ERB.new(File.read("#{template_path}/ptc.rhtml"))
gen_ptc_tables = erb.result
store_to_file( gen_ptc_tables, out_file ) unless DBG

index_out = "#{output_path}/web/index.html"
puts "Injecting the ptc documents list into the indext page: #{index_out}"

# when executing erb.result it will use gen_ptc_tables in the next template to inject the tables
erb = ERB.new(File.read("#{template_path}/index.rhtml"))
gen_idx_page = erb.result
store_to_file( gen_idx_page, index_out )

# copy vendor files to web dir

output_web_path ="#{output_path}/web"
dst_js_dir      = "#{output_web_path}/js"
dst_css_dir     = "#{output_web_path}/css"

boostrap_dir = "#{PWD}/../vendor/bootstrap"
copy_dir(File.join(boostrap_dir, "js")  , dst_js_dir)
copy_dir(File.join(boostrap_dir, "css") , dst_css_dir)

clipboar_dir = "#{PWD}/../vendor/clipboard/clipboard.min.js"
FileUtils.copy_file(clipboar_dir , File.join(dst_js_dir, "clipboard.min.js"))




