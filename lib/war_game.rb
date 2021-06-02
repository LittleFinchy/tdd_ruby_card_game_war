class WarGame
  attr_accessor :player1, :player2

  def initialize
    @player1 = Player.new("Stephen", [])
    @player2 = Player.new("Joe", [])
  end

  def start
    deck = CardDeck.new()
    until deck.cards_left == 0
      @player1.take_cards([deck.deal])
      @player2.take_cards([deck.deal])
    end
  end

  def winner
    #might need to make the return just the player and not the name
    if @player1.cards_left == 0
      @player2.name
    elsif @player2.cards_left == 0
      @player1.name
    else
      nil
    end
  end

  def play_round
    temp_cards = []
    card1 = @player1.play_card
    card2 = @player2.play_card
    if card1.value != card2.value
      if card1.value > card2.value
        @player1.take_cards([card1, card2])
      else
        @player2.take_cards([card1, card2])
      end
    else
      temp_cards.concat([card1, card2])
      temp_cards.push(@player1.play_card * 3)
      temp_cards.push(@player2.play_card * 3)

      play_round
    end
  end
end
