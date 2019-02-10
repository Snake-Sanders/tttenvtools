#!/usr/bin/ruby -w
=begin
    This script searches the PTC links within the input page and spit them out
    json validator: https://jsonformatter.curiousconcept.com/

    Author: Snake Sanders
    Creation date: Sat Dec 22 19:38:35 CET 2018
    Version: 1.0
=end

require "rubygems"
require "json"

if ARGV.length != 1
    puts "It requires the path to the file to parse"
end

in_file = ARGV[0]
puts "Opening file: #{in_file}"

json = JSON.parse(File.open(in_file).read) # returns a hash

project = "motionwise"
puts "showing items for project: #{project}"
puts json[project].each { |p| p["title"].to_s}