require "test_helper"

class ProductIdValidatorTest < Minitest::Test
  def test_sets_product_id_range
    validator = ProductIdValidator.new 0..1

    assert_equal 0..1, validator.product_id_range
  end
end
