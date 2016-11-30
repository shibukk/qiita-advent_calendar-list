require "#{File.dirname(__FILE__)}/scraping"
require "#{File.dirname(__FILE__)}/post"

s = Scraping.new
data = s.exec

ps = Post.new
ps.create_json(data).exec
