require "test_helper"

class IngredientsDb::TotalFreshIngredientIdsTest < Minitest::Test
  def setup
    @db = IngredientsDb.new fresh_ranges: []
  end

  def test_zero_when_no_ranges
    assert @db.total_fresh_ingredients_ids.zero?
  end

  def test_range_length_when_one_range
    @db.fresh_ranges = [1..2]

    assert_equal 2, @db.total_fresh_ingredients_ids
  end

  def test_does_not_double_count_overlapping_ranges
    @db.fresh_ranges = [1..2, 2..3]

    assert_equal 3, @db.total_fresh_ingredients_ids
  end

  def test_aoc_example
    @db.fresh_ranges = [3..5, 10..14, 16..20, 12..18]

    assert_equal 14, @db.total_fresh_ingredients_ids
  end

  def test_smaller_range_after_larger_range_same_min
    @db.fresh_ranges = [3..5, 10..14, 16..20, 12..18, 12..14]

    assert_equal 14, @db.total_fresh_ingredients_ids
  end
end
