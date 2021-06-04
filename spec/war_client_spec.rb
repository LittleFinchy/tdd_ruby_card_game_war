require_relative "../lib/war_client"
require_relative "../lib/war_socket_server"

describe "WarClient" do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    @client1 = WarClient.new(@server.port_number)
    @clients.push(@client1)
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  # it "provide_input works" do
  #   @client1.provide_input("y")
  #   @server.create_game_if_possible
  #   expect(@server.round_ready?(@server.games.keys[0])).to eq true
  # end

  # it "capture_output works" do
  #   expect(0).to eq 0
  # end
end
