require_relative "../lib/war_socket_server"

server = WarSocketServer.new()
server.start
until server.create_game_if_possible
  server.accept_new_client
end
puts "Both players joined"
server.games[0].start

until server.games[0].winner
  server.play_round
end
puts "Winner: #{server.games[0].winner.name}"
