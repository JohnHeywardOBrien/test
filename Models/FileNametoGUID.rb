# Create random, protected, GUID
# Will be used upon copy/mv
class FileNametoGUID
  
  def filename
    random_string
  end   

  protected 

  def random_string
    @string ||= "#{SecureRandom.uuid}"
  end
end


