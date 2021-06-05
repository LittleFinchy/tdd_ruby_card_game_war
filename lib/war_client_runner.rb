require_relative "war_client"

puts "Enter the address"
address = gets.chomp
puts "Enter the port number"
port = gets.chomp
puts "Enter your name"
name = gets.chomp

client = WarClient.new(address, port, name)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  client.provide_input(gets.chomp)
end
