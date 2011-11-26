require "open-uri"
IMAGES = [
          "google",
          "arnold",
          "diehard",
         ]
class MainController < Ramaze::Controller
  layout '/layout'
  map '/'
  
  def index
  end

  def img
    respond open(random_path).read
  end

  private
  def random_path
    word = IMAGES[ rand(IMAGES.size) ]
    return "http://#{word}.jpg.to"
  end
end
