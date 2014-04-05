require 'socket'
require './app'
server = TCPServer.new("0.0.0.0", 1234)

loop do
  connection = server.accept
  puts "connected with client"
  inputline  = connection.gets

  output = App.call(inputline)

  connection.puts "Output is #{output}"
  connection.close
end
