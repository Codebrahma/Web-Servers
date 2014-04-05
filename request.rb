require 'net/http'


uri = URI('http://localhost:1234/post')
req = Net::HTTP::Post.new(uri)
req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  puts "sending requst"
  http.request(req)
end

case res
when Net::HTTPSuccess, Net::HTTPRedirection
  puts res.body
  # OK
else
  res.value
end
