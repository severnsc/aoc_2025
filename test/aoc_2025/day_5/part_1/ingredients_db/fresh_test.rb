require "test_helper"

class IngredientsDb::FreshTest < Minitest::Test
  def setup
    @db = IngredientsDb.new fresh_ranges: []
  end

  def test_no_ranges
    refute @db.fresh? 1
  end

  def test_in_only_range
    @db.fresh_ranges = [1..2]

    assert @db.fresh? 2
  end

  def test_in_multiple_ranges
    @db.fresh_ranges = [1..2, 2..3]

    assert @db.fresh? 2
  end
end
