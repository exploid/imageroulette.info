require "open-uri"
require 'redis'
require 'json'



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
    sets = JSON.parse(File.open("common.json", 'r').read)
    word = sets['SFW_SETS'][ rand(sets['SFW_SETS'].size) ]
    
    img = open(word)

    return img.scan(/img src="(.*)"/i).flatten.first
  end
end
