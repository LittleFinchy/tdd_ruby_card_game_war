require_relative "../lib/war_game_round"

describe "WarGame" do
  let(:player1) { Player.new("Bill", [PlayingCard.new("2", "D")]) }
  let(:player2) { Player.new("Bob", [PlayingCard.new("5", "H")]) }

  it "play a round of war" do
    round = WarRound.new(player1, player2)
    output = round.war_game_round
    expect(output).to eq output
  end
end
