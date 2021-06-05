class WarGameRound
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def play(cards_in_play = [])
    card1 = player1.play_card
    card2 = player2.play_card
    cards_in_play.concat([card1, card2])
    compare(card1, card2, cards_in_play)
  end

  def build_message(player, output = "", cards_in_play)
    output += "Tie Round! " if cards_in_play.length > 2
    output += "#{player.name} won these cards: "
    cards_in_play.each do |card|
      output += "#{card.rank} of #{card.suit}, "
    end
    output
  end

  def handle_winner(winning_player, cards_in_play)
    winning_player.take_cards([cards_in_play].flatten!.shuffle!)
    message = build_message(winning_player, cards_in_play)
    cards_in_play = [] # test without this line
    message
  end

  def handle_tie(cards_in_play)
    3.times do # draw 3 cards for tie
      cards_in_play.concat([player1.play_card, player2.play_card])
    end
    if player1.cards_left > 1 && player2.cards_left > 1
      play(cards_in_play)
    end
  end

  def handle_no_tie(card1, card2, cards_in_play)
    if card1.value > card2.value # winner is player 1
      handle_winner(player1, cards_in_play)
    else # winner is player 2
      handle_winner(player2, cards_in_play)
    end
  end

  def compare(card1, card2, cards_in_play)
    if card1.value != card2.value # there is no tie
      handle_no_tie(card1, card2, cards_in_play)
    else # there is a tie
      handle_tie(cards_in_play)
    end
  end
end
