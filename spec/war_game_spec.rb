require_relative "../lib/war_game"

describe "WarGame" do
  let(:game) { WarGame.new() }

  it "players should have the same number of cards at the start" do
    expect(game.player2.cards_left > 0).to eq true
    expect(game.player1.cards_left == game.player2.cards_left).to eq true
  end

  it "player 1 will win" do
    26.times do
      game.player2.play_card
    end
    expect(game.winner).to eq player1.name
  end
end

# def start
# end

# def winner
# end

# def play_round
# end
