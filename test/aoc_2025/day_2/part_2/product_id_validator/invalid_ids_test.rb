require "test_helper"

module DayTwo::PartTwo
  class ProductIdValidator::InvalidIdsTest < Minitest::Test
    def setup
      @validator = DayTwo::PartTwo::ProductIdValidator.new 0..0
    end

    def test_empty_for_empty_range
      assert_empty @validator.invalid_ids
    end

    def test_single_match
      @validator.product_id_range = 11..12

      assert_equal [11], @validator.invalid_ids
    end

    def test_many_matches
      @validator.product_id_range = 95..115

      assert_equal [99, 111], @validator.invalid_ids
    end
  end
end
