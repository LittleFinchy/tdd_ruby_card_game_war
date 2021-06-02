require_relative "../lib/war_socket_server"

clients = []
server = WarSocketServer.new()
server.start
until server.create_game_if_possible
  clients.push(server.accept_new_client)
end
puts "game started"

clients[0].puts "start"
# game = server.games[0]
# game.start
