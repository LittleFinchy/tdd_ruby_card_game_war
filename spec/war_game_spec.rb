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

  it "plays two rounds" do
    game.player1.take_cards([PlayingCard.new("3", "H"), PlayingCard.new("7", "C")])
    game.player2.take_cards([PlayingCard.new("5", "D"), PlayingCard.new("J", "D")])
    game.play_round
    expect(game.player2.cards_left - game.player1.cards_left).to eq 2
    game.play_round
    expect(game.player2.cards_left - game.player1.cards_left).to eq 4
  end

  it "shows that ace beats everything" do
    game.player1.take_cards([PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H"), PlayingCard.new("A", "H")])
    game.player2.take_cards([PlayingCard.new("K", "H"), PlayingCard.new("Q", "H"), PlayingCard.new("J", "H"), PlayingCard.new("10", "H"), PlayingCard.new("9", "H"), PlayingCard.new("8", "H"), PlayingCard.new("7", "H"), PlayingCard.new("6", "H"), PlayingCard.new("5", "H"), PlayingCard.new("4", "H"), PlayingCard.new("3", "H"), PlayingCard.new("2", "H")])
    12.times do
      game.play_round
    end
    expect(game.winner).to eq game.player1.name
  end

  it "a tie will play again" do
    game.player1.take_cards([PlayingCard.new("5", "H"), PlayingCard.new("5", "H"), PlayingCard.new("3", "H"), PlayingCard.new("7", "H"), PlayingCard.new("7", "H")])
    game.player2.take_cards([PlayingCard.new("5", "H"), PlayingCard.new("5", "H"), PlayingCard.new("5", "H"), PlayingCard.new("5", "H"), PlayingCard.new("5", "H")])
    game.play_round
    expect(game.winner).to eq nil
  end

  it "a tie will play again" do
    game.player1.take_cards([PlayingCard.new("5", "H"), PlayingCard.new("5", "H"), PlayingCard.new("3", "H"), PlayingCard.new("7", "H"), PlayingCard.new("7", "H")])
    game.player2.take_cards([PlayingCard.new("5", "H")])
    game.play_round
    expect(game.winner).to eq nil
  end
end
