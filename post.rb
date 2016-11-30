require 'qiita'
require 'erb'

class Post
  def initialize
    @body = ""
  end

  def create_json(data)
    template = ERB.new(open(File.dirname(__FILE__) + '/template.erb').read, nil, '-')
    @body = template.result(binding)
    self
  end

  def exec
    client = Qiita::Client.new(access_token: ENV['QIITA_TOKEN'])
    client.post(
      "/api/v2/items",
      title: "【毎日自動更新】昨日投稿された Qiita Advent Calendar まとめ【しません】",
      body: @body,
      private: true,
      tags: [{"name": "qiita"}]
    )
  end
end
