require "socket"
require_relative "../lib/war_socket_server"

class MockWarSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new("localhost", port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000).chomp # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

describe WarSocketServer do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started" do
    expect { MockWarSocketClient.new(@server.port_number) }.to raise_error(Errno::ECONNREFUSED)
  end

  it "accepts new clients and starts a game if possible" do
    @server.start
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    @server.create_game_if_possible
    expect(@server.games.count).to be 0
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible
    expect(@server.games.count).to be 1
  end

  it "both clients get welcome message" do
    @server.start
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    expect(client1.capture_output).to eq "Wait for another player"
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    expect(client2.capture_output).to eq "Ready to start"
  end

  it "both players get starting message" do
    @server.start
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible
    expect(client1.capture_output.include?("Game is starting now")).to eq true
    expect(client2.capture_output.include?("Game is starting now")).to eq true
  end

  it "round ready makes sure both players are ready to play a round" do
    @server.start
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    client1.provide_input("y")
    client2.provide_input("y")
    expect(@server.round_ready?).to eq true
  end

  it "play round will play one round" do
    @server.start
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible
    game = @server.games[0]
    game.start
    client1.provide_input("y")
    client2.provide_input("y")
    @server.play_round(game)
    client1_message = client1.capture_output
    client2_message = client2.capture_output
    expect(client1_message).to_not eq nil
    expect(client2_message).to_not eq nil
  end
end
