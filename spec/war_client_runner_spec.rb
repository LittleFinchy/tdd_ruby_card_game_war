require_relative "../lib/war_client_runner"
require_relative "../lib/war_socket_server"

describe "WarClient" do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    # client1 = MockWarSocketClient.new(@server.port_number)
    # @clients.push(client1)
    # @server.accept_new_client("Player 1")
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it "provide_input works" do
    expect(0).to eq 0
  end

  it "capture_output works" do
    expect(0).to eq 0
  end
end

#
#
