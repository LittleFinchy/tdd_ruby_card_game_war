require_relative "../lib/war_game"

describe "WarGame" do
  # let(:player1) { Player.new([PlayingCard.new("7", "D")]) }
  # let(:player2) { Player.new([PlayingCard.new("5", "H")]) }
  let(:game) { WarGame.new() }

  it "players should have the same number of cards at the start" do
    expect(player1.cards_left == player2.cards_left).to eq true
  end

  # it "player 1 will win" do
  #   expect()
  # end
end

# def start
# end

# def winner
# end

# def play_round
# end
