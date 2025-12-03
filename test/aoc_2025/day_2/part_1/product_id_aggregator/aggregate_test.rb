require "test_helper"

class ProductIdAggregator::AggregateTest < Minitest::Test
  def setup
    @aggregator = ProductIdAggregator.new ProductIdValidator
  end

  def test_empty_returns_zero
    assert_equal 0, @aggregator.aggregate([])
  end

  def test_single_invalid_id_returns_invalid_id
    assert_equal 11, @aggregator.aggregate([11..12])
  end

  def test_multiple_invalid_ids_returns_invalid_ids_sum
    assert_equal 33, @aggregator.aggregate([11..22])
  end

  def test_aoc_example
    ranges = [11..22, 95..115, 998..1012, 1_188_511_880..1_188_511_890, 222_220..222_224,
              1_698_522..1_698_528, 446_443..446_449, 38_593_856..38_593_862, 565_653..565_659,
              824_824_821..824_824_827, 2_121_212_118..2_121_212_124]
    assert_equal 1_227_775_554, @aggregator.aggregate(ranges)
  end
end
