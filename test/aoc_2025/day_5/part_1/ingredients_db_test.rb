require "test_helper"

class IngredientsDbTest < Minitest::Test
  def test_sets_fresh_ranges
    db = IngredientsDb.new fresh_ranges: []

    assert_empty db.fresh_ranges
  end
end
