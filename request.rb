require 'net/http'

number_of_requests = 20

uri = URI('http://localhost:1234/post')
req = Net::HTTP::Post.new(uri)
req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')

number_of_requests.times do  |id|

  Thread.new do
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      puts "sending requst"
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      puts "------"
      puts id
      puts res.body
      puts "------"
    else
      res.value
    end
  end
   
end

gets
