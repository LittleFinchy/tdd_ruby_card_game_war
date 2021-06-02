require_relative "war_player"
require_relative "card_deck"

class WarGame
  attr_accessor :player1, :player2

  def initialize
    @player1 = Player.new(["Stephen", "Bob"].sample, [])
    @player2 = Player.new("Joe", [])
    @temp_cards = []
  end

  def start
    deck = CardDeck.new()
    until deck.cards_left == 0
      @player1.take_cards([deck.deal])
      @player2.take_cards([deck.deal])
    end
  end

  def winner
    if @player1.cards_left == 0
      @player2
    elsif @player2.cards_left == 0
      @player1
    else
      nil
    end
  end

  def play_round
    card1 = @player1.play_card
    card2 = @player2.play_card
    if card1.value != card2.value # there is no tie
      if card1.value > card2.value
        @player1.take_cards([card1, card2])
        @player1.take_cards(@temp_cards)
        @temp_cards = []
        "player1 won"
      else
        @player2.take_cards([card1, card2])
        @player1.take_cards(@temp_cards)
        @temp_cards = []
        "player2 won"
      end
    else # there is a tie
      @temp_cards.concat([card1, card2])

      3.times do
        if @player1.cards_left > 1
          @temp_cards.push(@player1.play_card)
        end
        if @player2.cards_left > 1
          @temp_cards.push(@player2.play_card)
        end
      end

      play_round
      "tie"
    end
  end
end
