require_relative "war_game"

game = WarGame.new
game.start
until game.winner
  puts game.play_round
end
puts "Winner: #{game.winner.name}"
