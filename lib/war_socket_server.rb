require "socket"
require_relative "war_game"

class WarSocketServer
  attr_accessor :games, :clients

  def initialize
    @games = []
    @clients = []
  end

  def port_number
    3335
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = "Random Player")
    client = @server.accept_nonblock # returns a TCPSocket
    if @clients.length == 0
      client.puts "Wait for another player"
    else
      client.puts "Ready to start"
    end
    @clients.push(client)
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    if @clients.length == 2
      @clients.each do |client|
        client.puts "Game is starting now"
      end
      @games.push(WarGame.new())
    end
  end

  def read_message(client_index)
    sleep(0.1)
    @clients[client_index].read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def round_ready?
    client1_message = ""
    client2_message = ""
    while client1_message != "y"
      client1_message = read_message(0) # first player
    end
    while client2_message != "y"
      client2_message = read_message(1) # second player
    end
    true
  end

  def play_round
    if round_ready?
      output = @games[0].play_round
      @clients.each do |client|
        client.puts output
      end
      #add way to show num of cards left
    end
  end

  def stop
    @server.close if @server
  end
end
