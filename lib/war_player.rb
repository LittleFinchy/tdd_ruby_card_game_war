class Player
  attr_reader :name

  def initialize(name, hand)
    @name = name
    @hand = hand
  end

  def play_card
    @hand.pop
  end

  def take_cards(cards_won)
    @hand = cards_won.concat(@hand)
  end

  def cards_left
    @hand.length
  end
end
