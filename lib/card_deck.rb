require_relative "playing_card"

class CardDeck
  def build_deck
    suits = ["H", "D", "C", "S"]
    ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits.each do |suit|
      ranks.each do |rank|
        @cards.push(PlayingCard.new(rank, suit))
      end
    end
  end

  def initialize
    @cards = []
    build_deck
    shuffle
    @cards_left = @cards.length
  end

  def cards_left
    @cards_left
  end

  def deal
    @cards_left -= 1
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end
end
