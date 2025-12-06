class CephalapodHomework
  include ActiveModel::Model

  attr_accessor :numbers, :operators

  def grand_total
    total_for numbers, operators, 0
  end

  private

  def integer_pattern
    /[0-9]+/
  end

  def find_next_numbers(numbers)
    numbers.map do |number_string|
      next_integer_start_index = number_string.index next_integer_pattern
      if next_integer_start_index
        number_string[(number_string.index(next_integer_pattern))..]
      else
        ""
      end
    end
  end

  def find_next_operator(operators)
    operators[1..].strip
  end

  def solve_problem(operands, operator)
    case operator
    when "+"
      operands.sum
    when "*"
      operands.reduce(1) { |product, operand| product * operand }
    else
      0
    end
  end

  def total_for(numbers, operators, running_total)
    operands = numbers.map { |number_string| Integer number_string.match(integer_pattern).to_s }
    next_numbers = find_next_numbers numbers
    if next_numbers.all?(&:empty?)
      running_total + solve_problem(operands, operators[0])
    else
      total_for next_numbers, find_next_operator(operators), running_total + solve_problem(operands, operators[0])
    end
  end

  def next_integer_pattern
    /(?<=\s)[0-9]/
  end

  def operator_patttern
    /[+*]/
  end
end
