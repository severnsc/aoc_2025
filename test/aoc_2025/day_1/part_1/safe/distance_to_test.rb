require "test_helper"

class Safe::DistanceToTest < Minitest::Test
  def setup
    @safe = Safe.new dial_range: 0..99, dial_pointing_at: 50
  end

  def test_distance_to_self_is_zero
    assert_equal({ "L" => 0, "R" => 0 }, @safe.distance_to(50))
  end

  def test_distance_to_out_of_bounds_raises_error
    assert_raises RangeError do
      @safe.distance_to 1000
    end
  end

  def test_distance_to_one_less
    assert_equal({ "L" => 1, "R" => 99 }, @safe.distance_to(49))
  end

  def test_distance_to_one_greater
    assert_equal({ "L" => 99, "R" => 1 }, @safe.distance_to(51))
  end
end
