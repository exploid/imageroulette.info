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

  deny_layout :img
  def img
    return %(<img src="#{random_path}" />)
  end

  private
  def random_path
    word = IMAGES[ rand(IMAGES.size) ]
    return "http://#{word}.jpg.to"
  end
end
