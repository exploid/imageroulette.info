$LOAD_PATH.unshift("./")
require "app"

$stdout.reopen( ::IO.popen("/home/vince/bin/cronolog /home/vince/www/imageroulette.info/logs/stdout.%Y-%m-%d.log", "w") )
$stderr.reopen( ::IO.popen("/home/vince/bin/cronolog /home/vince/www/imageroulette.info/logs/stderr.%Y-%m-%d.log", "w") )

Ramaze.start(:file => __FILE__, :started => true)
run Ramaze
