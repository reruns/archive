describe Card do
  subject(:card) { Card.new(:three, :clubs) }
  describe "#initialize" do
    it 'creates a valid card' do
      expect(card.suit).to eq(:clubs)
      expect(card.value).to eq(:three)
    end

    it 'raises error for bad suit or value' do
      expect{Card.new(:forty,:clubs)}.to raise_error("not a valid suit or value")
    end
  end

  describe "#self.values" do
    it "should return an array of value keys" do
      expect(Card.values).to eq([:deuce, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king,
          :ace])
    end
  end

  describe "#self.suits" do
    it "should return an array of suits" do
      expect(Card.suits).to eq([:clubs, :diamonds, :hearts, :spades])
    end
  end

  describe "#to_s" do
    it "should return a string of the card's value and suit" do
      expect(card.to_s).to eq("3♣")
    end
  end

  let(:card2) { Card.new(:three, :clubs) }
  let(:card3) { Card.new(:seven, :diamonds)}
  describe "#==" do
    it "should compare two cards" do
      expect(card == card2).to eq(true)
      expect(card == card3).to eq(false)
    end
  end

end
