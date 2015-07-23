#!/usr/bin/env ruby
# built using Ruby 2.2.1

# chmod +x to run this in your local directory

require 'json'
require 'fileutils'


directory_name = "20jsonfiles"
Dir.mkdir(directory_name) unless File.exists?(directory_name)

# File.new("20files.json",  "w+")



class RandomJson

  attr_reader :version, :build, :tested, :notes

  def initialize
    @version = random_integer
    @build   = :build
    @tested  = :tested
    @notes   = random_string
  end
  
  
  # defining my own to_s to format in to desired json output
  def to_s
    "{ version: #{self.version}, \n" \
      "build:  #{self.build},   \n" \
      "tested: #{self.tested},  \n" \
      "notes:  #{self.notes}    \n" \
    "}"
  end

  
  private
  
  
  LOWERCASE_LETTERS = ('a'..'z').to_a
  
  def random_string
    (5+rand(8)).times.map{ LOWERCASE_LETTERS.sample }.join
  end
  
  def random_integer
    (1..57).to_a.sample
  end
  

end


