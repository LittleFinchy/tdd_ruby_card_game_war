require_relative "war_player"
require_relative "card_deck"
require_relative "war_game_round"

class WarGame
  attr_accessor :player1, :player2

  def initialize
    @player1 = Player.new(["Stephen", "Bob"].sample, [])
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
    if @player1.cards_left < 1
      @player2
    elsif @player2.cards_left < 1
      @player1
    else
      nil
    end
  end

  def play_round
    war_game_round(@player1, @player2)
  end
end
