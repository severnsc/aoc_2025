class CephalapodHomework
  include ActiveModel::Model

  attr_accessor :numbers, :operators

  def grand_total
    total_for numbers, operators, 0
  end

  def rl_grand_total
    rl_total_for numbers, operators.strip, 0
  end

  private

  def chars_to_take(numbers)
    rl_significant_digits(numbers).max.digits.length
  end

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

  def find_next_operators(operators)
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
      total_for next_numbers, find_next_operators(operators), running_total + solve_problem(operands, operators[0])
    end
  end

  def n_chars_from_end_pattern(chars_to_take)
    /[0-9\s]{#{chars_to_take}}$/
  end

  def next_integer_pattern
    /(?<=\s)[0-9]/
  end

  def rl_total_for(numbers, operators, running_total)
    operands = rl_find_operands numbers
    next_numbers = rl_find_next_numbers numbers
    if next_numbers.all?(&:empty?)
      running_total + solve_problem(operands, operators[-1])
    else
      rl_total_for next_numbers, rl_find_next_operators(operators),
                   running_total + solve_problem(operands, operators[-1])
    end
  end

  def rl_find_operands(numbers)
    return [] if numbers.empty?

    chars_to_take = chars_to_take(numbers)
    significant_digit_strings = numbers.map do |number_string|
      number_string.match(n_chars_from_end_pattern(chars_to_take)).to_s
    end
    operands = []
    chars_to_take.times do |n|
      operand = ""
      significant_digit_strings.each do |significant_digit_string|
        operand << significant_digit_string[n]
      end
      operands << operand.to_i
    end
    operands
  end

  def rl_find_next_numbers(numbers)
    return [] if numbers.empty?

    chars_to_take = chars_to_take(numbers)
    numbers.map do |number_string|
      if number_string.length == chars_to_take
        ""
      else
        number_string[...(number_string.length - chars_to_take.next)]
      end
    end
  end

  def rl_find_next_operators(operators)
    next_operator_index = operators.index rl_operator_pattern
    operators[..next_operator_index]
  end

  def rl_integer_pattern
    /[0-9]+\s*$/
  end

  def rl_next_integer_pattern
    /[0-9](?=\s+[0-9])/
  end

  def rl_operator_pattern
    /[*+](?=\s+[*+]$)/
  end

  def rl_significant_digits(numbers)
    numbers.map { |number_string| Integer number_string.match(rl_integer_pattern).to_s }
  end
end
