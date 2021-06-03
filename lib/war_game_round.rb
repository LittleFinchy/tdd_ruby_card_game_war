class WarRound
  @cards_in_play = []

  def war_game_round(player1, player2, cards_in_play = [])
    card1 = player1.play_card
    card2 = player2.play_card
    cards_in_play.concat([card1, card2])
    if card1.value != card2.value # there is no tie
      if card1.value > card2.value # winner is player 1
        # cards = cards_in_play
        # cards_in_play = []
        handle_winner(player1, cards_in_play)
      else # winner is player 2
        # cards = cards_in_play
        # cards_in_play = []
        handle_winner(player2, cards_in_play)
      end
    else # there is a tie
      3.times do # draw 3 cards for tie
        cards_in_play.push(player1.play_card)
        cards_in_play.push(player2.play_card)
      end

      if player1.cards_left > 1 && player2.cards_left > 1
        war_game_round(player1, player2, cards_in_play)
      end
    end
  end

  def message_players_by_game(player, cards, output = "")
    output += "Tie Round! " if cards.length > 2
    output += "#{player.name} won these cards: "
    cards.each do |card|
      output += "#{card.rank} of #{card.suit}, "
    end
    output
  end

  def handle_winner(winning_player, cards)
    winning_player.take_cards([cards].flatten!.shuffle!)
    message = message_players_by_game(winning_player, cards)
  end
end
