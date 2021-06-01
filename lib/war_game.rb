class WarGame
  attr_accessor :player1, :player2

  # def initialize
  #   start
  # end

  def start
    deck = CardDeck.new()
    @player1 = Player.new("Stephen", [])
    @player2 = Player.new("Joe", [])
    until deck.cards_left == 0
      @player1.take_cards([deck.deal])
      @player2.take_cards([deck.deal])
    end
  end

  def winner
    if @player1.cards_left == 0
      @player2.name
    elsif @player2.cards_left == 0
      @player1.name
    else
      nil
    end
  end

  # def play_round
  # end
end
