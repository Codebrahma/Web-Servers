require 'socket'
require './app'
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

def start(server)
  loop do
    puts "server"
    connection = server.accept
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

(number_of_process-1).times do
  Thread.new do
    start(server)
  end
end

gets
