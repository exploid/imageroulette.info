[
 # Redirect to a random image from 4chan
 [ "r.jpgnow.info", "/img" ],

 # Redirect to a moustachified random image
 [ "m.jpgnow.info", "/img/moustache" ],

 # Redirect to a random word image.
 [ "jpgto.jpgnow.info", "/img/jpgto" ],

].each do |domain, route|
  Ramaze::Route[domain] = lambda do |path, request|
    if request.host.downcase == domain and path == "/"
      return route
    end
  end
end

Words = [ "google", "arnold", "diehard" ]

class MainController < Ramaze::Controller
  map '/'

  def index
  end

  def img(type=nil)
    case type
    when "moustache" then
      moustache_path = "http://mustachify.me/?src=#{URI.encode(fourchan)}"
      redirect moustache_path, status: 303
    when "jpgto" then
      redirect jpg_to, status: 303
    else
      redirect fourchan, status: 303
    end
  end

  private

  def fourchan
    set = FourChan[ rand(FourChan.size) ]
    urls = $redis.smembers("o")
    url = urls[ rand(urls.size) ]
    return url
  end

  # Hits jpg.to to get a random image path for a keyword and returns the URL to that random image.
  def jpg_to
    word = Words[ rand(Words.size) ]

    # opening a jpg.to link returns this string:
    #     <img src="http://www.aboutbodybuilding.org/wp-content/uploads/2011/09/bodybuilding-arnold-schwarzenegger.jpg" />
    img = open("http://#{word}.jpg.to").read

    return img.scan(/img src="(.*)"/i).flatten.first
  end
end
