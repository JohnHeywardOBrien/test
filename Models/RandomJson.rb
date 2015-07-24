# Create partially random JSON data
class RandomJson

  attr_reader :version, :build, :tested, :notes

  def initialize
    @version = random_integer
    @build   = :build
    @tested  = :tested
    @notes   = random_string
  end
  
  # Defining my own to_json in my desired output
  def to_json
    JSON.generate({
      'version' => self.version,
      'build'   => self.build,
      'tested'  => self.tested,
      'notes'   => self.notes
    })    
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