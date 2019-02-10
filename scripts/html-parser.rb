#!/usr/bin/ruby -w
=begin
    This script searches the PTC links within the input page and spit them out

    Author: Snake Sanders
    Creation date: Sat Dec 22 19:38:35 CET 2018
    Version: 1.0
=end

require "nokogiri"

if ARGV.length != 1
    puts "It requires the path to the file to parse"
end

in_file =  ARGV[0]
puts "Opening file: #{in_file}"

doc = File.open(in_file) { |f| Nokogiri::XML(f) }


#buttons = doc.css("//a").at_css('[href="integrity"]' select { |s| s.include? 'integrity' }

buttons = doc.search('a[href]').select{ |n| n['href'][/integrity/] }#.map{ |n| n['href'] }
puts buttons