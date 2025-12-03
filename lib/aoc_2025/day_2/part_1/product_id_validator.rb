class ProductIdValidator
  attr_reader :product_id_range

  def initialize(product_id_range)
    self.product_id_range = product_id_range
  end

  # We want to cache the candidates after setting the range so that it's cheap to access later
  def product_id_range=(range)
    @product_id_range = range
    # Only numbers with an even number of digits can be invalid
    minmax_candidates = product_id_range.each.filter { |candidate| candidate.digits.length.even? }.minmax
    self.candidates = minmax_candidates.first..minmax_candidates.last
  end

  def invalid_ids
    return [] if candidates.end.nil?

    done = false
    # Start with the lowest candidate, that will set the lower bounds for possible invalid ids. For example, in a range
    # of 1000 - 9999, the first possible invalid id would be 1010.
    digits_to_repeat = candidates.first.digits.reverse[...min_number_of_digits].join
    invalid_ids = []
    until done
      candidate = (digits_to_repeat * 2).to_i
      invalid_ids << candidate if candidates.include? candidate

      # Only have to increment the digits to repeat which shrinks the search space a lot. Only increment if there's room
      # to do so.
      if digits_to_repeat.to_i.succ <= largest_possible_digits_to_repeat
        digits_to_repeat = (digits_to_repeat.to_i + 1).to_s
      else
        done = true
      end
    end

    invalid_ids
  end

  private

  attr_accessor :candidates

  def largest_possible_digits_to_repeat
    ("9" * max_number_of_digits).to_i
  end

  def max_number_of_digits
    candidates.last.digits.length / 2
  end

  def min_number_of_digits
    candidates.first.digits.length / 2
  end
end
