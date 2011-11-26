require "open-uri"

Ramaze::Route['img.imageroulette.info'] = lambda do |path, request|
  return nil if path == "/favicon.ico"
  return (request.host == "img.imageroulette.info") ? "/img" : nil
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

    img = open(path).read

    response.body = img
    response['Content-Length'] = img.length.to_s
    response['Content-Type'] = "image/jpeg"
    response['Content-Disposition'] = "inline; filename=imageroulette.jpg";

    response.status = 200
  end

  private
  def random_path
    word = Words[ rand(Words.size) ]
    return "http://#{word}.jpg.to"
  end
end
