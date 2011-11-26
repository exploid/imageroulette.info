require "open-uri"

Ramaze::Route['r.*.imageroulette.info'] = lambda do |path, request|
  if request.host.match(/^r\..*\.imageroulette.info/) and path == "/"
    return "/img"
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

  def img
    # opening random_path returns this string:
    #     <img src="http://www.aboutbodybuilding.org/wp-content/uploads/2011/09/bodybuilding-arnold-schwarzenegger.jpg" />
    path = open(random_path).read.scan(/img src="(.*)"/i).flatten.first

    redirect path
  end

  private
  def random_path
    word = Words[ rand(Words.size) ]
    return "http://#{word}.jpg.to"
  end
end
