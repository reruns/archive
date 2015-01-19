describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do
      deduped_cards = all_cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(deduped_cards).to eq(52)
    end
  end

  #Initialize the entire deck of 52 cards
  describe "initialize" do
    it 'returns a full deck if passed nothing' do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end
  end

  #Draw cards from the deck
  describe "draw" do
    it 'returns the right number of cards' do
      expect(Deck.new.draw(3).count).to eq(3)
    end

    it 'draws the right cards' do
      deck = Deck.new
      cards = deck.cards.take(3)
      expect(deck.draw(3)).to eq(cards)
    end

    it 'returns an error if too few cards in deck' do
      deck = Deck.new
      expect{deck.draw(53)}.to raise_error("not enough cards in deck")
    end
  end

  describe "put_back" do

    it "returns cards to the bottom of the stack" do
      cards = [Card.new(:deuce, :clubs),  Card.new(:three, :hearts)]
      deck = Deck.new
      deck.put_back(cards)
      expect(deck.cards[-2..-1]).to eq(cards)
    end
  end

  #Put cards back on the bottom once the hand is over
end
