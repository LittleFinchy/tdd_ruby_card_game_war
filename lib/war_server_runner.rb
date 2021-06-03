require_relative "../lib/war_socket_server"

server = WarSocketServer.new()
server.start
until server.create_game_if_possible
  server.accept_new_client
end
puts "Both players joined"

game = server.games[0]
game.start

until game.winner
  server.play_round(game)
end
puts "Winner: #{game.winner.name}"
