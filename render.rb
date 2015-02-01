require "erb"
require "open-uri"
require "rss"


@today = Time.new(2015, 1, 30)

last = Time.new(2014, 6, 1)

url = 'http://feeds.feedburner.com/HelloAppsdeck?format=xml'
url = 'http://blog.scalingo.com/rss'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@posts = rss.items.select{|x| x.pubDate > last }

url = 'http://feeds.delicious.com/v2/rss/strass/appsdeck+business'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@articles = rss.items.select{|x| x.pubDate > last }

template = File.read("newsletter.html.erb")
renderer = ERB.new(template)
result = renderer.result(binding)

File.open("#{@today.strftime("%B").downcase}.html", 'w') {|f| f.write(result) }
