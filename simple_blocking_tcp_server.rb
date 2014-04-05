require 'socket'
require './app'
server = TCPServer.new("0.0.0.0", 1234)

def get_request(con)
  response = ""
  while current_line = con.recv(56)
    response +=current_line
    break if current_line.length < 56
  end 
  response
end
loop do
  connection = server.accept
  puts "connected with client"
  input  = get_request(connection)
  puts "-------------------------------------"
  puts "INPUT IS"
  puts "#{input}"

  output = App.call(input)

  puts "-------------------------------------"
  puts "OUTPUT is"
  puts "#{output}"
  puts "-------------------------------------"
  connection.puts "#{output}"
  connection.close
end

