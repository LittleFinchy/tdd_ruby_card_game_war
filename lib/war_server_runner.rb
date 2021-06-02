require_relative "../lib/war_socket_server"

server = WarSocketServer.new()
server.start
while true
  server.accept_new_client
  server.create_game_if_possible
end

game = server.games[0]
game.start
until game.winner
  puts game.play_round
end
puts "Winner: #{game.winner.name}"
