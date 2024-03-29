require 'socket'
require './app'


@queue = Queue.new
number_of_process = 5
server = TCPServer.new("0.0.0.0", 1234)

def get_request(con)
  response = ""
  while current_line = con.recv(56)
    response +=current_line
    break if current_line.length < 56
  end 
  response
end

def current_time
  Time.new.strftime("%H:%M:%S")
end


number_of_process.times do
  Thread.new do
    loop do
      if connection = @queue.shift
        puts "connected with client at #{current_time}"
        input  = get_request(connection)
        puts "-------------------------------------"
        puts "INPUT IS"
        puts "#{input}"

        output = App.call(input)

        puts "-------------------------------------"
        puts "OUTPUT is"
        puts "#{output}"
        puts "processed at #{current_time}"
        puts "-------------------------------------"
        connection.puts "#{output}"
        connection.close
      end
    end
  end
end

loop do
  puts "server"
  @queue <<  server.accept
end

gets
