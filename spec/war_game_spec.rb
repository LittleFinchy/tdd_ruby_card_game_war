require_relative "../lib/war_game"

describe "WarGame" do
  let(:game) { WarGame.new() }

  it "players should have the same number of cards at the start" do
    game.start
    expect(game.player2.cards_left > 0).to eq true
    expect(game.player1.cards_left == game.player2.cards_left).to eq true
  end

  it "player 1 will win" do
    game.start
    26.times do
      game.player2.play_card
    end
    expect(game.winner).to eq game.player1.name
  end

  it "plays a round" do
    game.start
    game.play_round
    expect((game.player1.cards_left - game.player2.cards_left).abs).to eq 2
    game.play_round
    expect((game.player1.cards_left - game.player2.cards_left).abs).to eq 4 || 0
  end
end
