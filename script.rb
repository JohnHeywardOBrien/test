#!/usr/bin/env ruby

# Built using Ruby 2.2.1

# chmod +x to run this in your local directory

require 'json'
require 'fileutils'
require 'securerandom'

require './models/random_json'
require './models/random_file_name'
require './models/guid'


puts "Starting creation of folders..."
DIR_NAMES = %w[Original Modified]
DIR_NAMES.each do |dname|
  if File.exists?(dname)
    abort("The specified folders already exist. No further action will be taken.")
  else
    Dir.mkdir(dname)
  end
end
puts "Folders created"


# Loop to create files within Original folder
20.times do
  File.open("Original/#{RandomFileName.new.filename.to_s}.json", "w+") do |file|
    file.write("#{RandomJson.new.to_json}")
  end
end
puts "Files created"


# Move and rename
# Used 'cp' command here instead of 'mv' to show that files were actually
# Created instead of just made in the new folder
files = Dir["Original/*.json"].collect{|f| File.expand_path(f)}
  files.each do |file, index|
    FileUtils.cp file, "Modified/#{GUID.new.filename.to_s}.json"
  end
puts "Files copied"


# Open and change in new location 
Dir.glob('Modified/*.json').each do |item|
  File.open(item, "r+") do |file|
    hash = JSON.parse(file.read)
    file.rewind
    hash['version'] += 1
    file.write(JSON.generate(hash))
  end
end
puts "Version of each file updated by 1"