require 'poker'

describe Poker do
  subject(:poker) { Poker.new(Deck.new, [Player.new, Player.new]) }

  describe 'initialize' do

    it 'sets everything up' do
      expect(subject.deck).to_not eq(nil)
      expect(subject.players).to_not eq(nil)
      expect(subject.pot).to eq(0)
    end
  end

  describe 'betting' do
    let(:p1) { double('p1', :place_bet => [:raise, 5], :send_money => 5)}
    let(:p2) { double('p2', :place_bet => [:call], :send_money => 5)}

    it "should change the pot amount" do
      subject.betting([p1, p2])
      expect(subject.pot).to eq(10)
    end
  end
  #shuffles the deck
  #deal cards
  #Keeps track of the deck, initialized with a deck, array of players and the pot
  #Looks at whose turn it is
  #Tracks the pot
  #Runs betting rounds
  #Manages player discards
  #Determines the winner
end
