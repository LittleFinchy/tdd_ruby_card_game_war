require_relative "war_player"
require_relative "card_deck"

class WarGame
  attr_accessor :player1, :player2

  def initialize
    @player1 = Player.new(["Stephen", "Bob"].sample, [])
    @player2 = Player.new("Joe", [])
    @cards_on_table = []
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
    card1 = @player1.play_card
    card2 = @player2.play_card
    if card1.value != card2.value # there is no tie
      if card1.value > card2.value # winner is player 1
        @player1.take_cards([card1, card2, @cards_on_table].flatten!.shuffle!)
        @cards_on_table = []
        "#{@player1.name} won a #{card2.rank} of #{card2.suit} with a #{card1.rank} of #{card1.suit}"
      else # winner is player 2
        @player2.take_cards([card1, card2, @cards_on_table].flatten!.shuffle!)
        @cards_on_table = []
        "#{@player2.name} won a #{card1.rank} of #{card1.suit} with a #{card2.rank} of #{card2.suit}"
      end
    else # there is a tie
      @cards_on_table.concat([card1, card2])

      3.times do # draw 3 cards for tie
        @cards_on_table.push(@player1.play_card)
        @cards_on_table.push(@player2.play_card)
      end

      if @player1.cards_left > 1 && @player2.cards_left > 1
        play_round
      end

      "tie"
    end
  end
end
