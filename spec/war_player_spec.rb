require_relative "../lib/war_player"

describe "WarPlayer" do
  let(:player1) { WarPlayer.new("Bill", [PlayingCard.new("2", "D"), PlayingCard.new("3", "D")]) }
  let(:player2) { WarPlayer.new("Bob", [PlayingCard.new("5", "H"), PlayingCard.new("6", "H")]) }

  it "cards played come from the top of the player hand" do
    expect(player1.play_card).to eq PlayingCard.new("3", "D")
  end

  it "puts cards won on bottom of hand" do
    card = PlayingCard.new("4", "C")
    card2 = PlayingCard.new("5", "C")
    player1.take_cards([card, card2])
    player1.play_card
    player1.play_card
    expect([player1.play_card, player1.play_card]).to match_array([card, card2])
  end

  it "returns the number of cards left in a players hand" do
    player2.play_card
    expect(player1.cards_left).to eq 2
    expect(player2.cards_left).to eq 1
  end
end
