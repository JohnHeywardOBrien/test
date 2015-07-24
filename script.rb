#!/usr/bin/env ruby
# built using Ruby 2.2.1

# chmod +x to run this in your local directory

require 'json'
require 'fileutils'
require 'securerandom'

require './Models/RandomJson'
require './Models/RandomFileName'
require './Models/FileNametoGUID'

directory_name = %w[Original Modified]
Dir.mkdir(directory_name[0]) unless File.exists?(directory_name[0])
Dir.mkdir(directory_name[1]) unless File.exists?(directory_name[1])

# thought aboutusing method#to_proc for this. I was stumbling around with the best 
# way to do this, and was lead down the road to learing about to_proc
# but I'm not sure how to use unless with it... 
# %w[Original Modified].each(&Dir.method(:mkdir)) #unless File.exists?(%w[Original Modified])


#####
# Models lived here
#####


# loop to create files within /Original folder
1.upto(2) do |i|
  File.open("Original/#{RandomFileName.new.filename.to_s}.json", "w+") do |file|
    file.write("#{RandomJson.new.to_json}")
  end
end


#move and rename
files = Dir["Original/*.json"].collect{|f| File.expand_path(f)}
files.each_with_index do |file, index|
  puts "copying file #{index}"
  FileUtils.cp file, "Modified/#{FileNametoGUID.new.filename.to_s}.json"
end


# open and change 
# this is where I am having the most troubles :/
Dir.glob('Modified/*.json').each do |item|
  file = File.open(item, "r+")
  puts item
  hash = JSON.parse(file.read)
  file.rewind
  hash['version'] += 1
  file.write(JSON.generate(hash))
  file.close
end