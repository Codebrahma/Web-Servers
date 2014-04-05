require 'stringio'
require 'webrick'
class App
  def self.call(input)
    req = parse(input)
    process req.body
  end

  def self.parse(input)
    req = WEBrick::HTTPRequest.new(WEBrick::Config::HTTP)
    req.parse(StringIO.new(input))
    req 
  end

  def self.process(input)
    res = WEBrick::HTTPResponse.new(WEBrick::Config::HTTP)
    res.status=200
    sleep 3
    res.body = input.reverse
    res.to_s
  end
end

