require_relative 'prefix_calculator'

describe PrefixCalculator, "#calculate" do

  it "calculates a single positive integer" do
    result = PrefixCalculator.new.calculate("10")
    result.should eq(10)
  end

  it "zero is a zero" do
    result = PrefixCalculator.new.calculate("0")
    result.should eq(0)
  end

  it "calculates a single negative integer" do
    result = PrefixCalculator.new.calculate("-10")
    result.should eq(-10)
  end

  it "calculates a single float" do
    result = PrefixCalculator.new.calculate("10.3")
    result.should eq(10.3)
  end

  it "calculates a single float with loads of whitespaces" do
    result = PrefixCalculator.new.calculate("              10.3       ")
    result.should eq(10.3)
  end

  it "fails for invalid number input" do 
    result = PrefixCalculator.new.calculate("this_is_not_a_number")
    result.should eq(PrefixCalculator::INVALID_INPUT_MESSAGE)
  end

  it "calculates a single operation" do
    result = PrefixCalculator.new.calculate("+ 3.2 5.4")
    result.should be_within(0.01).of(8.6)
  end

  it "calculates a slightly more difficult case" do
    result = PrefixCalculator.new.calculate("* - 2 / 8 2 -1")
    result.should be_within(0.01).of(2)
  end

  it "calculates a slightly more difficult case with operators together" do
    result = PrefixCalculator.new.calculate("+ + + 2 2 2 2")
    result.should be_within(0.01).of(8)
  end


  it "doesn't calculate for too many operators" do
    result = PrefixCalculator.new.calculate("+ + + 2 2")
    result.should eq(PrefixCalculator::INVALID_INPUT_MESSAGE)
  end


  it "doesn't calculate for too many operands" do
    result = PrefixCalculator.new.calculate("- 2 2 2 2")
    result.should eq(PrefixCalculator::INVALID_INPUT_MESSAGE)
  end

  it "doesn't calculate for operand only" do
    result = PrefixCalculator.new.calculate("/")
    result.should eq(PrefixCalculator::INVALID_INPUT_MESSAGE)
  end

end


describe PrefixCalculator, "#is_operator?" do
  it "contains addition" do
    PrefixCalculator.new.is_operator?("+").should be_true
  end

  it "contains multiplication" do
    PrefixCalculator.new.is_operator?("*").should be_true
  end

  it "contains division" do
    PrefixCalculator.new.is_operator?("/").should be_true
  end

  it "contains subtraction" do
    PrefixCalculator.new.is_operator?("-").should be_true
  end

  it "doesn't contain number and invalid operations" do
    PrefixCalculator.new.is_operator?("").should be_false
    PrefixCalculator.new.is_operator?("22").should be_false
    PrefixCalculator.new.is_operator?("    asd").should be_false
  end

end