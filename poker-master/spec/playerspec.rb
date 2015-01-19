require 'poker'

describe Player do
  let(:hand) { Hand.new([Card.new(:seven, :clubs), Card.new(:three, :diamonds),
                         Card.new(:four, :spades), Card.new(:five, :hearts),
                         Card.new(:six, :clubs)]) }
  subject(:player) { Player.new(hand, 100) }

  describe "initialize" do
    it 'initializes player with hand and money' do
      expect(subject.hand).to eq(hand)
      expect(subject.money).to eq(100)
    end
  end

  let(:deck) { double('deck', :draw => [Card.new(:nine, :clubs), Card.new(:jack, :hearts)])}
  describe 'discard' do
    it 'discard and draw correct cards' do
      allow(subject).to receive(:gets) {"0,2"}
      subject.discard(deck)
      expect(subject.hand).to eq( Hand.new([Card.new(:three, :diamonds),
                             Card.new(:four, :spades), Card.new(:six, :clubs),
                             Card.new(:nine, :clubs), Card.new(:jack, :hearts)]))
    end
  end

  describe 'place_bet' do
    it "should return an array with a symbol of their action" do
      allow(subject).to receive(:gets) {"fold"}
      expect(subject.place_bet).to eq([:fold])
    end
    it "should return an array with a symbol of their action" do
      allow(subject).to receive(:gets) {"call"}
      expect(subject.place_bet).to eq([:call])
    end
    it "should return an array with a symbol of their action and $" do
      allow(subject).to receive(:gets) {"raise, 50"}
      expect(subject.place_bet).to eq([:raise, 50])
    end

  end

  #fold, call, or raise
end
