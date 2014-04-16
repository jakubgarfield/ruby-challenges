# This is the second challenge - prefix calculator
# Given and input in a form + 3 * 5 + 8 9 is the same as 3 + 5 * (8 + 9) in infix notation
# It should
# 1) handle different kinds of numbers (integers, negative numbers, floats)
# 2) give an reasonable error for the wrong input (e.g. + + 5 5)
# 3) calculate the result of an operation

class PrefixCalculator

  INVALID_INPUT_MESSAGE = "Input was not in the correct format."
  OPERATIONS = 
  {
    "+" => lambda { |x, y| x + y },
    "-" => lambda { |x, y| x - y },
    "/" => lambda { |x, y| x / y },
    "*" => lambda { |x, y| x * y },
  }

  def calculate(input)
    tokens = tokenize(input)
    result_stack = []

    tokens.reverse_each do |token|      
      if is_operator?(token)
        if result_stack.size < 2
          result_stack.push(INVALID_INPUT_MESSAGE)
          break 
        end
        
        first_operand = result_stack.pop
        second_operand = result_stack.pop
        result = OPERATIONS[token].call(first_operand, second_operand)
        result_stack.push(result)
      else
        operand = to_number(token)

        if operand.nan?
          result_stack.push(INVALID_INPUT_MESSAGE)
          break
        end 

        result_stack.push(operand)
      end
    end

    result_stack.size == 1 ? result_stack.pop : INVALID_INPUT_MESSAGE
  end

  def tokenize(input)
    input.split
  end

  def to_number(token)
    if token == "0"
      0.0
    elsif token.to_f != 0
      token.to_f
    else
      Float::NAN
    end
  end

  def is_operator?(token)
    OPERATIONS.has_key?(token)
  end

end