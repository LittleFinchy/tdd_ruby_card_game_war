require_relative "war_client"

client = WarClient.new(3335)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  client.provide_input(gets.chomp)
end
