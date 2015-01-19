require './array_lib'

describe Array do
  describe "#my_uniq" do
    subject(:arr) {[1, 2, 3, 1, 2]}

    it "removes duplicates" do
        expect(arr.my_uniq).to eq([1,2,3])
    end

    it "doesn't call Array#uniq" do
      expect(arr).not_to receive(:uniq)
      arr.my_uniq
    end
  end

  describe "#two_sum" do
    subject(:arr) {[-1, 0, 2, -2, 1]}
    let(:arr1) {[0,0]}

    it "should return indices of elements that sum to zero" do
      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "includes pairs of zeroes" do
      expect(arr1.two_sum).to eq([[0,1]])
    end
  end

  let(:arr2) { [[0, 1, 2],[3, 4, 5],[6, 7, 8]] }
  let(:arr3) { [[0, 3, 6],[1, 4, 7],[2, 5, 8]] }
  let(:arr4) {[-1, 0, 2, -2, 1]}
  describe "#my_transpose" do

    it "should flip the indices" do
      expect(arr2.my_transpose).to eq(arr3)
    end

    it "does nothing if the arrays aren't square" do
      expect(arr4.my_transpose).to eq(arr4)
    end

    it "should not modify the original array" do
      arr2.my_transpose
      expect(arr2).to eq([[0, 1, 2],[3, 4, 5],[6, 7, 8]])
    end


  end


end
#
describe TowersOfHanoi do
  subject (:towers) { TowersOfHanoi.new(3) }
  let (:towers2) { TowersOfHanoi.new(5) }

  describe "#new" do
    it "creates initial stacks of the right size" do
      expect(towers.rods).to eq([[3,2,1],[],[]])
      expect(towers2.rods).to eq([[5,4,3,2,1],[],[]])
    end
  end

  describe "#move" do
    it "performs valid moves" do
      towers.move(0,1)
      expect(towers.rods).to eq([[3,2],[1],[]])
    end

    it "doesn't let larger discs stack onto smaller ones" do
      towers.move(0,1)
      expect(towers.rods).to eq([[3,2],[1],[]])
      towers.move(0,1)
      expect(towers.rods).to eq([[3,2],[1],[]])
    end

    it "doesn't do anything when given an empty start" do
      towers.move(2,1)
      expect(towers.rods).to eq([[3,2,1],[],[]])
    end
  end

  describe "#won?" do
    it "returns true when the game is won" do
      towers.rods = [[], [], [3,2,1]]
      expect(towers.won?).to eq(true)
    end

    it "returns false when the game is not won" do
      expect(towers.won?).to eq(false)
    end
  end

  describe "#get_input" do
    it "Turns user input into an array" do
      allow(towers).to receive(:gets) {"0,1"}
      expect(towers.get_input).to eq([0,1])
    end
  end

  let (:towers3){ TowersOfHanoi.new(1) }
  describe "#play" do
    it "Goes until the game is over" do
      allow(towers3).to receive(:gets) {"0,2"}
      expect(STDOUT).to receive(:puts).with("Please enter a move")
      expect(STDOUT).to receive(:puts).with("You won!")
      towers3.play
    end
  end
end

describe "#stock_picker" do
  let(:arr1) {[1,2,10,20,5,4]}

  it "should return the indices of the best days to buy sell" do
    expect(stock_picker(arr1)).to eq([0,3])
  end

  let(:arr2) {[5, 10, 1, 7]}
  it "should not sell before buying" do
    expect(stock_picker(arr2)).to eq([2,3])
  end
end
