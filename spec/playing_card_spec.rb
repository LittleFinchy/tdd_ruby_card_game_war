require_relative "../lib/playing_card"

describe "PlayingCard" do
  context "class" do
    it "has a set of valid ranks" do
      expect(PlayingCard::RANKS).to match_array %w(A 2 3 4 5 6 7 8 9 10 J Q K)
    end
  end

  it "two cards are not eq" do
    deck = CardDeck.new()
    card = deck.deal
    card2 = deck.deal
    expect(card == card2).to eq false
  end
end
