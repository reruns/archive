describe Hand do
  let(:cards) { [Card.new(:deuce, :clubs),  Card.new(:three, :hearts)] }
  let(:deck) { Deck.new }
  let(:bad_hand) { Hand.new([Card.new(:jack, :clubs), Card.new(:three, :diamonds),
                   Card.new(:ace, :spades), Card.new(:four, :hearts),
                   Card.new(:six, :clubs)]) }

  describe "initialize" do
    it "should initialize cards from an array" do
      expect(Hand.new(cards).cards).to eq(cards)
    end
  end

  describe 'deal' do
    it 'deals a new hand of 5 from the deck' do
      hand = Hand.new(cards)
      hand.deal(deck)
      expect(hand.cards.count).to eq(5)
    end
  end

  describe 'straight?' do
    it 'true when cards are in sequence' do
      hand = Hand.new([Card.new(:deuce, :clubs), Card.new(:three, :diamonds),
                       Card.new(:four, :spades), Card.new(:five, :hearts),
                       Card.new(:six, :clubs)])
      expect(hand.straight?).to eq(true)
    end

    it 'works when cards are out of order' do
      hand = Hand.new([Card.new(:seven, :clubs), Card.new(:three, :diamonds),
                       Card.new(:four, :spades), Card.new(:five, :hearts),
                       Card.new(:six, :clubs)])
      expect(hand.straight?).to eq(true)
    end

    it 'works with aces' do
      hand = Hand.new([Card.new(:king, :clubs), Card.new(:queen, :diamonds),
                       Card.new(:ace, :spades), Card.new(:jack, :hearts),
                       Card.new(:ten, :clubs)])
      expect(hand.straight?).to eq(true)
      hand = Hand.new([Card.new(:deuce, :clubs), Card.new(:three, :diamonds),
                       Card.new(:ace, :spades), Card.new(:four, :hearts),
                       Card.new(:five, :clubs)])
      expect(hand.straight?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.straight?).to eq(false)
    end
  end

  describe 'flush?' do
    it 'identifies flushes' do
      hand = Hand.new([Card.new(:deuce, :clubs), Card.new(:three, :clubs),
                       Card.new(:four, :clubs), Card.new(:five, :clubs),
                       Card.new(:six, :clubs)])
      expect(hand.flush?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.flush?).to eq(false)
    end
  end

  describe 'quadruple?' do
    it 'true if there are four of a kind' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:jack, :spades), Card.new(:jack, :hearts),
                       Card.new(:four, :clubs)])
      expect(hand.quadruple?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.quadruple?).to eq(false)
    end
  end

  describe "two_pair?" do
    it 'true if there are two pairs' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:five, :spades), Card.new(:five, :hearts),
                       Card.new(:four, :clubs)])
      expect(hand.two_pair?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.two_pair?).to eq(false)
    end
  end

  describe "triple?" do
    it 'true if there are two pairs' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:jack, :spades), Card.new(:five, :hearts),
                       Card.new(:four, :clubs)])
      expect(hand.triple?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.triple?).to eq(false)
    end
  end

  describe "one_pair?" do
    it 'true if there are two pairs' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:queen, :spades), Card.new(:five, :hearts),
                       Card.new(:four, :clubs)])
      expect(hand.one_pair?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.one_pair?).to eq(false)
    end
  end

  describe "full_house?" do
    it 'true if there is a full house' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:jack, :spades), Card.new(:five, :hearts),
                       Card.new(:five, :clubs)])
      expect(hand.full_house?).to eq(true)
    end

    it 'no false positives' do
      expect(bad_hand.full_house?).to eq(false)
    end
  end

  describe '<=>' do
    it 'full house beats high card' do
      hand = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:jack, :spades), Card.new(:five, :hearts),
                       Card.new(:five, :clubs)])
      expect(hand <=> bad_hand).to eq(1)
    end

    it 'two equal straights tie' do
      hand1 = Hand.new([Card.new(:deuce, :spades), Card.new(:three, :hearts),
                       Card.new(:four, :clubs), Card.new(:five, :diamonds),
                       Card.new(:six, :spades)])
      hand2 = Hand.new([Card.new(:deuce, :clubs), Card.new(:three, :diamonds),
                       Card.new(:four, :spades), Card.new(:five, :hearts),
                       Card.new(:six, :clubs)])
      expect(hand1 <=> hand2).to eq(0)
    end

    it 'hands of the same type evaluated correctly' do
      hand1 = Hand.new([Card.new(:jack, :clubs), Card.new(:jack, :diamonds),
                       Card.new(:jack, :spades), Card.new(:five, :hearts),
                       Card.new(:five, :clubs)])
      hand2 = Hand.new([Card.new(:queen, :clubs), Card.new(:queen, :diamonds),
                       Card.new(:queen, :spades), Card.new(:six, :hearts),
                       Card.new(:six, :clubs)])
      expect(hand1 <=> hand2).to eq(-1)
    end

  end
end
