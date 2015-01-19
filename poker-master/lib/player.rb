class Player
  STARTING_MONEY = 100

  def initialize (hand = nil, money = STARTING_MONEY)
    @hand = hand
    @money = money
  end

  attr_accessor :money, :hand

  def discard(deck)
    cards = gets.chomp.split(',').map(&:to_i)
    discarded_cards = []
    cards.each do |index|
      discarded_cards << hand.cards[index]
      hand.cards.delete_at(index)
    end
    hand.cards += deck.draw(cards.count)
    hand.set_value
    discarded_cards
  end


  def place_bet
    user_input = gets.chomp.split(',')
    case user_input[0]
    when "fold"
      [user_input[0].to_sym]
    when "raise"
      [user_input[0].to_sym, user_input[1].to_i]
    when "call"
      [user_input[0].to_sym]
    end
  end

  def send_money(amount)
    raise "not enough money" if @money < amount
    @money -= amount
    amount
  end

  def finish_hand
    cards = @hand.cards
    @hand = nil
    cards
  end

end
