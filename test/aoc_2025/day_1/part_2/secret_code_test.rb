require "test_helper"

module DayOne::PartTwo
  class SecretCodeTest < Minitest::Test
    def setup
      @safe = Safe.new dial_range: 0..99, dial_pointing_at: 50
    end

    def test_sets_safe
      secret_code = SecretCode.new safe: @safe

      assert_equal @safe, secret_code.safe
    end

    def test_sets_secret_number
      secret_code = SecretCode.new secret_number: 0

      assert_equal 0, secret_code.secret_number
    end
  end
end
