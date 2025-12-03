require "test_helper"

class ProductIdValidator::InvalidIdsTest < Minitest::Test
  def setup
    @validator = ProductIdValidator.new 0..0
  end

  def test_empty_range_returns_empty
    @validator.product_id_range = 0..0

    assert_empty @validator.invalid_ids
  end

  def test_single_result
    @validator.product_id_range = 11..12

    assert_equal [11], @validator.invalid_ids
  end

  def test_multiple_results
    @validator.product_id_range = 11..22

    assert_equal [11, 22], @validator.invalid_ids
  end

  def test_empty_for_odd_number_of_digits
    @validator.product_id_range = 100..999

    assert_empty @validator.invalid_ids
  end

  def test_first_candidate_less_than_range
    @validator.product_id_range = 25..45

    assert_equal [33, 44], @validator.invalid_ids
  end
end
