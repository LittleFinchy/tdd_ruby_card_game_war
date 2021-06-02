require "socket"
require_relative "war_game"

class WarSocketServer
  attr_accessor :games, :clients, :message

  def initialize
    @games = []
    @clients = []
    @message = ""
  end

  def port_number
    3336
  end

  def read_input
    @clients.each do |client|
      @message = client.read_nonblock(1000).chomp
      puts "made it here to read input"
      puts @message
    end
  rescue IO::WaitReadable
    @output = ""
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = "Random Player")
    client = @server.accept_nonblock # returns a TCPSocket
    @clients.push(client)
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    if @clients.length == 2
      @clients.each do |client|
        client.puts "Started"
      end
      @games.push(WarGame.new())
    end
  end

  def stop
    @server.close if @server
  end
end

# change @clients to @people
# make a person class that holds: client, player_name, messages
