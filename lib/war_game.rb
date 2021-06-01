class WarGame
  def initialize
    deck = CardDeck.new()
    @player1 = Player.new([])
    @player2 = Player.new([])
    until deck.cards_left == 0
      @player1.hand.push(deck.deal)
      @player1.hand.push(deck.deal)
    end
  end

  # def start
  # end

  # def winner
  # end

  # def play_round
  # end
end
