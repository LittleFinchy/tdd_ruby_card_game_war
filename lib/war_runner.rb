require_relative "../lib/war_game"
require_relative "../lib/person"

p1 = Person.new(0, "Stephen")
p2 = Person.new(0, "Mary")

game = WarGame.new(p1.player, p2.player)
game.start
until game.winner
  puts game.play_round
end
puts "Winner: #{game.winner.name}"
