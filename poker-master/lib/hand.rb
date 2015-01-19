class Hand
  HAND_VALUES = {:straight_flush => 9,
                 :quadruple => 8,
                 :full_house => 7,
                 :flush => 6,
                 :straight => 5,
                 :triple => 4,
                 :two_pair => 3,
                 :pair => 2
                 }

  def initialize(cards)
    @cards = cards
    set_value
  end

  attr_reader :value
  attr_accessor :cards

  def deal(deck)
    @cards = deck.draw(5)
  end

  def straight?
    return false if values.uniq.count != 5
    values = self.values
    lists = []
    if values.include?(:ace)
      values -= [:ace]
      values.map!{ |value| Card.poker_value(value) }.sort!
      lists << [1] + values << values + [14]
    else
      lists << values.map!{ |value| Card.poker_value(value) }.sort!
    end

    lists.any? do |list|
      1.upto(4).all? do |i|
        list[i] - list[i - 1] == 1
      end
    end
  end

  def flush?
    cards.map(&:suit).uniq.count == 1
  end

  def quadruple?
    values.count(values.mode) == 4
  end

  def two_pair?
    values.uniq.count == 3 && values.count(values.mode) == 2
  end

  def triple?
    values.uniq.count == 3 && values.count(values.mode) == 3
  end

  def one_pair?
    values.uniq.count == 4
  end

  def full_house?
    values.uniq.count == 2 && values.count(values.mode) == 3
  end

  def values
    values = cards.map(&:value)
  end

  def set_value
    case
    when straight? && flush?
      @value = 9
    when quadruple?
      @value = 8
    when full_house?
      @value = 7
    when flush?
      @value = 6
    when straight?
      @value = 5
    when triple?
      @value = 4
    when two_pair?
      @value = 3
    when one_pair?
      @value = 2
    else
      @value = 1
    end
  end

  def <=>(hand)
    spaceship = self.value <=> hand.value
    return spaceship unless spaceship == 0
    case self.value
    when 9
      self.values.max <=> hand.values.max
    when 8
      self.values.mode <=> hand.values.mode
    when 7
      self.values.mode <=> hand.values.mode
    when 6
      high_card_compare(hand)
    when 5
      self.values.max <=> hand.values.max
    when 4
      self.values.mode <=> hand.values.mode
    when 3
      two_pair_compare(hand)
    when 2
      self.values.mode <=> hand.values.mode
    when 1
      high_card_compare(hand)
    end

  end

  def high_card_compare(hand)
    our_vals = self.values.sort!
    hand_vals = hand.values.sort!
    self.our_vals.each_with_index do |val, i|
      spaceship = val <=> hand_vals[i]
      return spaceship unless spaceship == 0
    end
    0
  end

  def two_pair_compare(hand)
    our_vals = self.values
    hand_vals = hand.values
    our_groups = our_vals.group_by { |val| our_vals.count(val) }
    our_groups[2].sort!.uniq!
    hand_groups = hand_vals.group_by { |val| hand_vals.count(val) }
    hand_groups[2].sort!.uniq!

    our_groups[2].each_with_index do |val, i|
      spaceship = val <=> hand_groups[2][i]
      return spaceship unless spaceship == 0
    end
    our_groups[1] <=> hand_groups[1]
  end

  def ==(hand)
    cards.each_with_index do |card, idx|
      return false unless card == hand.cards[idx]
    end
    true
  end
end

class Array
  def mode
    group_by{|i| i}.max{|x,y| x[1].length <=> y[1].length}[0]
  end
end
