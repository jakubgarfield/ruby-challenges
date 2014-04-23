# This is the second challenge - prefix calculator
# Given and input in a form + 3 * 5 + 8 9 is the same as 3 + 5 * (8 + 9) in infix notation
# It should
# 1) handle different kinds of numbers (integers, negative numbers, floats)
# 2) give an reasonable error for the wrong input (e.g. + + 5 5)
# 3) calculate the result of an operation

class PrefixCalculator
  ParseError = Class.new(StandardError)

  OPERATIONS = {
    "+" => -> (x, y) { x + y },
    "-" => -> (x, y) { x - y },
    "/" => -> (x, y) { x / y },
    "*" => -> (x, y) { x * y },
  }

  def calculate(input)
    tokens = tokenize(input)
    result_stack = []

    tokens.reverse_each do |token|      
      if is_operator?(token)
        raise ParseError if result_stack.size < 2
        result = OPERATIONS[token].call(result_stack.pop, result_stack.pop)
        result_stack.push(result)
      else
        result_stack.push(to_number!(token))
      end
    end

    raise ParseError unless result_stack.size == 1
    result_stack.pop
  end

  
  private

    def tokenize(input)
      input.split
    end

    def to_number!(token)
      raise ParseError unless token =~ /^[-]?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?$/
      token.to_f
    end

    def is_operator?(token)
      OPERATIONS.has_key?(token)
    end

end