class IngredientsDb
  include ActiveModel::Model

  attr_accessor :fresh_ranges

  def fresh?(ingredient_id)
    fresh_ranges.any? { |range| range.include? ingredient_id }
  end
end
