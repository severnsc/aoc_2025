class IngredientsDb
  include ActiveModel::Model

  attr_accessor :fresh_ranges

  def fresh?(ingredient_id)
    fresh_ranges.any? { |range| range.include? ingredient_id }
  end

  def total_fresh_ingredients_ids
    sorted_ranges = fresh_ranges.sort do |a, b|
      if a.min == b.min
        a.max <=> b.max
      else
        a.min <=> b.min
      end
    end
    index = 0
    while index < sorted_ranges.length
      range = sorted_ranges[index]
      next_range = sorted_ranges[index.next]
      (index += 1) && next if next_range.nil?

      if range.cover? next_range
        sorted_ranges.delete_at index.next
        next
      elsif range.overlap? next_range
        sorted_ranges[index] = range.min..next_range.min
        sorted_ranges[index.next] = next_range.min.next..next_range.max
      end
      index += 1
    end

    sorted_ranges.sum(&:count)
  end
end
