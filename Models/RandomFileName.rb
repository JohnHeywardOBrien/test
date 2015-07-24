# creating random string for the filename 
class RandomFileName
  
  NUMBERS = (1..9).to_a
  
  def filename
    random_string
  end   

  protected 

  def random_string
    (5+rand(8)).times.map{ NUMBERS.sample }.join
  end
end