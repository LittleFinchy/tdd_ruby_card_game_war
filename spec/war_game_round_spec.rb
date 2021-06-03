require_relative "../lib/war_game_round"

describe "WarGame" do
  let(:player1) { Player.new("Bill", [PlayingCard.new("2", "D")]) }
  let(:player2) { Player.new("Bob", [PlayingCard.new("5", "H")]) }

  it "play a round of war" do
    output = war_game_round(player1, player2)
    expect(output).to eq output
  end
end
