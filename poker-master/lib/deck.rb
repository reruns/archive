class Deck
  def self.all_cards
    cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  attr_reader :cards

  def count
    @cards.count
  end

  def draw(n)
    raise "not enough cards in deck" if n > count
    @cards.shift(n)
  end

  def put_back(received_cards)
    @cards += received_cards
  end

  def shuffle
    @cards.shuffle!
  end

end
