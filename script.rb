#!/usr/bin/env ruby
# built using Ruby 2.2.1

# chmod +x to run this in your local directory

require 'json'
require 'fileutils'
require 'securerandom'


directory_name = %w[Original Modified]
Dir.mkdir(directory_name[0]) unless File.exists?(directory_name[0])
Dir.mkdir(directory_name[1]) unless File.exists?(directory_name[1])

# using method#to_proc for this. I was stumbling around with the best way to do
# this, and was lead down the road to learing about to_proc
# %w[Original Modified].each(&Dir.method(:mkdir)) #unless File.exists?(%w[Original Modified])


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
      "build:  #{self.build},    \n" \
      "tested: #{self.tested},   \n" \
      "notes:  #{self.notes}     \n" \
    "}"
  end

  
  private
  
  
  LOWERCASE_LETTERS = ('a'..'z').to_a
  
  
  
  def random_integer
    (1..57).to_a.sample
  end
  
  def random_string
    (5+rand(8)).times.map{ LOWERCASE_LETTERS.sample }.join
  end

end


# creating random string for the filename 
class RandomFileName
  
  def filename
    random_string
  end   

  protected 

  def random_string
    @string ||= "#{SecureRandom.urlsafe_base64}"
  end
end


# loop to create files within /Original folder
1.upto(20) do |i|
  File.open("Original/#{RandomFileName.new.filename.to_s}.json", "w+") do |file| 
    file.write("#{RandomJson.new.to_s}")
  end
end




