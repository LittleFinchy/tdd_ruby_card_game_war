class Person
  attr_accessor :name, :player, :client

  def initialize(client, name)
    @client = client
    @name = name
    @player = WarPlayer.new(name)
  end
end
