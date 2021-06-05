require "socket"
require_relative "war_game"
# require_relative "war_player"

class WarSocketServer
  attr_accessor :games, :clients_looking

  def initialize
    @games = {}
    @clients_looking = []
  end

  def port_number
    3335
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def welcome_players(client)
    if clients_looking.length == 0
      client.puts "Wait for another player"
    else
      client.puts "Ready to start"
    end
  end

  def client_to_person(client)
    client.puts "Enter your name: "
    name = client.read_nonblock(1000).chomp
    person = Person.new(client, name)
  end

  def accept_new_client
    client = @server.accept_nonblock # returns a TCPSocket
    client_to_person(client)
    welcome_players(client)
    clients_looking.push(client) #push the person
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
    sleep(2)
  end

  def create_game_if_possible
    if clients_looking.length == 2
      game = WarGame.new(client_to_person(clients_looking[0].person), client_to_person(clients_looking[1].person))
      games[game] = clients_looking.shift(2)
      message_players_by_game(game, "Game is starting now")
      game
    end
  end

  def read_message(game, client_index)
    sleep(0.1)
    games[game][client_index].read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def see_if_ready(game, client1_message, client2_message)
    while client1_message != "y" # first player needs to say 'y'
      client1_message = read_message(game, 0)
    end
    while client2_message != "y"
      client2_message = read_message(game, 1) # second player needs to say 'y'
    end
  end

  def round_ready?(game)
    message_players_by_game(game, "Play card? (y/n)")
    client1_message = ""
    client2_message = ""
    see_if_ready(game, client1_message, client2_message)
    true
  end

  def message_players_by_game(game = nil, message)
    if game
      games[game].each { |client| client.puts message }
    else
      clients_looking.each { |client| client.puts message }
    end
  end

  def play_round(game)
    if round_ready?(game) # test without the if
      output = game.play_round
      message_players_by_game(game, output)
    end
  end

  def play_full_game(game)
    game.start
    until game.winner
      play_round(game)
    end
    puts "Winner: #{game.winner.name}"
  end

  def stop
    @server.close if @server
  end
end
