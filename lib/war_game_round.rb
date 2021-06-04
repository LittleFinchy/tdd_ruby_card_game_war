class WarRound
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @cards_in_play = []
  end

  def war_game_round
    card1 = @player1.play_card
    card2 = @player2.play_card
    @cards_in_play.concat([card1, card2])
    compare(card1, card2)
  end

  def build_message(player, output = "")
    output += "Tie Round! " if @cards_in_play.length > 2
    output += "#{player.name} won these cards: "
    @cards_in_play.each do |card|
      output += "#{card.rank} of #{card.suit}, "
    end
    output
  end

  def handle_winner(winning_player)
    winning_player.take_cards([@cards_in_play].flatten!.shuffle!)
    message = build_message(winning_player)
    @cards_in_play = []
    message
  end

  def handle_tie
    3.times do # draw 3 cards for tie
      @cards_in_play.concat([@player1.play_card, @player2.play_card])
    end
    if @player1.cards_left > 1 && @player2.cards_left > 1
      war_game_round
    end
  end

  def handle_no_tie(card1, card2)
    if card1.value > card2.value # winner is player 1
      handle_winner(@player1)
    else # winner is player 2
      handle_winner(@player2)
    end
  end

  def compare(card1, card2)
    if card1.value != card2.value # there is no tie
      handle_no_tie(card1, card2)
    else # there is a tie
      handle_tie
    end
  end
end
