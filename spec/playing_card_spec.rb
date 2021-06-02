require_relative "../lib/playing_card"

describe "PlayingCard" do
  it "two cards are not eq" do
    deck = CardDeck.new()
    card = deck.deal
    card2 = deck.deal
    expect(card == card2).to eq false
  end

  it "shows the value of a card" do
    card = PlayingCard.new("7", "H")
    expect(card.value).to eq 5
    card2 = PlayingCard.new("J", "H")
    expect(card2.value).to eq 9
  end
end
