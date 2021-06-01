class PlayingCard
  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank
    @rank
  end

  def ==(other_card)
    @rank == other_card.rank && @suit == other_card.suit
  end
end
