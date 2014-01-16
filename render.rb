require "erb"
require "open-uri"
require "rss"


@today = Time.now

last = Time.new(2013, 11, 1)

url = 'http://feeds.feedburner.com/HelloAppsdeck?format=xml'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@posts = rss.items.delete_if{|x| x.pubDate < last }

url = 'http://feeds.delicious.com/v2/rss/strass/appsdeck+business'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@articles = rss.items.delete_if{|x| x.pubDate < last }

template = File.read("newsletter.html.erb")
renderer = ERB.new(template)
result = renderer.result(binding)

File.open("#{@today.strftime("%B").downcase}.html", 'w') {|f| f.write(result) }
