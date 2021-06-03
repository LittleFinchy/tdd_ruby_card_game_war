require_relative "../lib/war_socket_server"

server = WarSocketServer.new()
server.start
while true
  server.accept_new_client
  game = server.create_game_if_possible
  if game
    Thread.new { server.play_full_game(game) }
  end
end
puts "Both players joined"
