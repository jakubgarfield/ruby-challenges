require_relative 'prefix_calculator'

describe PrefixCalculator do

  describe "#calculate" do
    def calculate(string)
      PrefixCalculator.new.calculate(string)
    end

    it "calculates a single positive integer" do
      expect(calculate("10")).to eq 10
    end

    it "zero is a zero" do
      expect(calculate("0")).to eq 0
    end

    it "calculates a single negative integer" do
      expect(calculate("-10")).to eq -10
    end

    it "calculates a single float" do
      expect(calculate("-10.3")).to eq -10.3
    end

    it "calculates a single float with loads of whitespaces" do
      expect(calculate("              10.3       ")).to eq 10.3
    end

    it "fails for invalid number input" do 
      expect { calculate("thisisnotanumber") }.to raise_error(PrefixCalculator::ParseError)
    end

    it "calculates a single operation" do
      expect(calculate("+ 3.2 5.4")).to be_within(0.01).of(8.6)
    end

    it "calculates a slightly more difficult case" do
      expect(calculate("* - 2 / 8 2 -1")).to be_within(0.01).of(2)
    end

    it "calculates a slightly more difficult case with operators together" do
      expect(calculate("+ + + 2 2 2 2")).to be_within(0.01).of(8)
    end

    it "doesn't calculate for too many operators" do
      expect { calculate("+ + + 2 2") }.to raise_error(PrefixCalculator::ParseError)
    end

    it "doesn't calculate for too many operands" do
      expect { calculate("- 2 2 2 2") }.to raise_error(PrefixCalculator::ParseError)
    end

    it "doesn't calculate for operand only" do
      expect { calculate("/") }.to raise_error(PrefixCalculator::ParseError)
    end

  end
end


describe PrefixCalculator, "#is_operator?" do
  def is_operator?(token)
    PrefixCalculator.new.send("is_operator?", token)
  end

  it "contains addition" do
    expect(is_operator?("+")).to be_true
  end

  it "contains multiplication" do
    expect(is_operator?("*")).to be_true
  end

  it "contains division" do
    expect(is_operator?("/")).to be_true
  end

  it "contains subtraction" do
    expect(is_operator?("-")).to be_true
  end

  it "doesn't contain number and invalid operations" do
    expect(is_operator?("")).to be_false
    expect(is_operator?("22")).to be_false
    expect(is_operator?("    asd")).to be_false
  end

end


describe PrefixCalculator, "#to_number!" do
  def to_number!(token)
    PrefixCalculator.new.send("to_number!", token)
  end

  it "converts zero" do
    expect(to_number!("0")).to eq 0.0
    expect(to_number!("0.0")).to eq 0.0
  end

  it "converts valid float" do
    expect(to_number!("-12.52")).to eq -12.52
  end

  it "doesn't convert invalid number" do
    expect { to_number!("string_instead_of_a_number") }.to raise_error(PrefixCalculator::ParseError)
    expect { to_number!("12.invalid") }.to raise_error(PrefixCalculator::ParseError)
    expect { to_number!(" ") }.to raise_error(PrefixCalculator::ParseError)
    expect { to_number!("1.2.3") }.to raise_error(PrefixCalculator::ParseError)
  end
end
