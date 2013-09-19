require "erb"
require "open-uri"
require "rss"


@today = Time.now

url = 'http://feeds.feedburner.com/HelloAppsdeck?format=xml'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@posts = rss.items

url = 'http://feeds.delicious.com/v2/rss/strass/appsdeck+business'
uri = URI.parse(url)
feed = uri.read
rss = RSS::Parser.parse(feed, false, true)
@articles = rss.items

template = File.read("newsletter.html.erb")
renderer = ERB.new(template)
result = renderer.result(binding)

File.open("#{@today.strftime("%B").downcase}.html", 'w') {|f| f.write(result) }