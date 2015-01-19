class Array
  def my_uniq
    elements = []
    self.each do |el|
      elements << el unless elements.include?(el)
    end
    elements
  end

  def two_sum
    container = []
    self.each_with_index do |value, index|
      (index + 1).upto(self.size - 1) do |index2|
        container << [index, index2] if value + self[index2] == 0
      end
    end
    container
  end

  def my_transpose
    return self unless self.all? {|row| self.size == row.size}
    new_array = Array.new(self.size) {Array.new(self.size)}
    self.each_index do |i|
      self[i].each_index do |j|
        new_array[i][j] = self[j][i]
      end
    end
    new_array
  end
end

class TowersOfHanoi

  def initialize(size)
    @rods = [(size.downto(1).to_a)] << [] << []
  end

  attr_accessor :rods

  def move(start, finish)
    return if @rods[start].empty?
    if @rods[finish][-1].nil? || @rods[start][-1] < @rods[finish][-1]
      @rods[finish] << @rods[start].pop
    end
  end

  def won?
    if @rods[0].empty? && @rods[1].empty? && @rods[2] == @rods[2][0].downto(1).to_a
      true
    else
      false
    end
  end

  def play
    until won?
      puts "Please enter a move"
      input = get_input
      move(input[0],input[1])
    end
    puts "You won!"
  end

  def get_input
    input = gets.chomp
    input.split(',').map(&:to_i)
  end

end

def stock_picker(arr)
  smallest = nil
  smallest_day = 0
  max_diff = 0
  buy_day, sell_day = 0,0
  arr.each_with_index do |value,day|
    if smallest.nil? or value < smallest
      smallest = value
      smallest_day = day
    elsif value - smallest > max_diff
      max_diff = value - smallest
      buy_day = smallest_day
      sell_day = day
    end
  end
  [buy_day, sell_day]
end
