require_relative "../lib/war_game_round"

describe "WarGameRound" do
  let(:player1) { WarPlayer.new("Bill", [PlayingCard.new("2", "D")]) }
  let(:player2) { WarPlayer.new("Bob", [PlayingCard.new("5", "H")]) }

  it "play a round of war" do
    round = WarGameRound.new(player1, player2)
    output = round.play
    expect(output).to eq output
  end
end
