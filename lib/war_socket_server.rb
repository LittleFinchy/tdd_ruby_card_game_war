require "socket"
require_relative "war_game"

class WarSocketServer
  attr_accessor :games, :players

  def initialize
    @games = []
    @players = []
  end

  def port_number
    3336
  end

  # def games
  #   @games
  # end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = "Random Player")
    @players.push(0)
    client = @server.accept_nonblock
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    if @players.length == 2
      @games.push(WarGame.new())
      @players = []
    end
  end

  def stop
    @server.close if @server
  end
end
