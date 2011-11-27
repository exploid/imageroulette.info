require "open-uri"

[
 # Redirect to a random image
 [ "r.jpgnow.info", "/img" ],

 # Redirect to a moustachified random image
 [ "m.jpgnow.info", "/img/moustache" ],

].each do |domain, route|
  Ramaze::Route[domain] = lambda do |path, request|
    if request.host.downcase == domain and path == "/"
      return route
    end
  end
end

Words = [
         "google",
         "arnold",
         "diehard",
        ]

class MainController < Ramaze::Controller
  map '/'

  def index
  end

  def img(type=nil)
    case type
    when "moustache" then
      moustache_path = "http://mustachify.me/?src=#{URI.encode(jpg_to)}"
      redirect moustache_path
    else 
      redirect jpg_to
    end
  end

  private
  # Hits jpg.to to get a random image path for a keyword and returns the URL to that random image.
  def jpg_to
    word = Words[ rand(Words.size) ]

    # opening a jpg.to link returns this string:
    #     <img src="http://www.aboutbodybuilding.org/wp-content/uploads/2011/09/bodybuilding-arnold-schwarzenegger.jpg" />
    img = open("http://#{word}.jpg.to").read

    return img.scan(/img src="(.*)"/i).flatten.first
  end
end
