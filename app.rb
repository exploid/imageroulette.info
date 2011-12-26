$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__))

# Load gems
require "rubygems"
require "bundler/setup"
Bundler.require(:default)

# Load stdlib
require "open-uri"
require "json"

# Load codebase
require "controller/main"

$redis = Redis.new(port: 28765)

fourchan_config = JSON.parse( IO.read("config/4chan.json") )

FourChanSFW = fourchan_config["SFW_SETS"]
FourChanNSFW = fourchan_config["NSFW_SETS"]
FourChan = FourChanSFW + FourChanNSFW
