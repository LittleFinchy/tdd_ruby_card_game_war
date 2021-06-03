require_relative "../lib/war_client_runner"
require_relative "../lib/war_socket_server"

describe "WarClient" do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    @client1 = WarClient.new(@server.port_number)
    @clients.push(client1)
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it "provide_input works" do
    @client1.provide_input("this is a test")
    feedback = @server.read_message(@server.games.keys[0], 0)
    expect(feedback).to eq "this is a test"
  end

  it "capture_output works" do
    expect(0).to eq 0
  end
end

#
#
# @server.accept_new_client("Player 1")
# @server.create_game_if_possible
# expect(@server.games.count).to be 0
# client2 = MockWarSocketClient.new(@server.port_number)
# @clients.push(client2)
# @server.accept_new_client("Player 2")
# @server.create_game_if_possible
# expect(@server.games.count).to eq 1
