#!/usr/bin/env ruby

# built using Ruby 2.2.1

# chmod +x to run this in your local directory

require 'json'
require 'fileutils'
require 'securerandom'

require './Models/RandomJson'
require './Models/RandomFileName'
require './Models/FileNametoGUID'



DIR_NAMES = %w[Original Modified]
DIR_NAMES.each do |dname|
  if File.exists?(dname)
    abort("The specified folders already exist. 
           No further action will be taken.")
  else
    Dir.mkdir(dname)
    puts "Starting creation of folders"
  end
end


# loop to create files within Original folder
1.upto(20) do |i|
  File.open("Original/#{RandomFileName.new.filename.to_s}.json", "w+") do |file|
    file.write("#{RandomJson.new.to_json}")
    puts 
  end
end


# move and rename
files = Dir["Original/*.json"].collect{|f| File.expand_path(f)}
  files.each_with_index do |file, index|
    puts "copying file #{index}"
    FileUtils.cp file, "Modified/#{FileNametoGUID.new.filename.to_s}.json"
  end


# open and change in new location 
Dir.glob('Modified/*.json').each do |item|
  File.open(item, "r+") do |file|
    hash = JSON.parse(file.read)
    file.rewind
    hash['version'] += 1
    file.write(JSON.generate(hash))
  end
end