require "test_helper"

module DayOne::PartOne
  class SecretCode::ProcessInstructionsTest < Minitest::Test
    def setup
      @safe = Safe.new dial_range: 0..99, dial_pointing_at: 0
      @secret_code = SecretCode.new safe: @safe, secret_number: 0
    end

    def test_no_instructions_sets_value_to_zero
      @secret_code.process_instructions []

      assert_equal 0, @secret_code.value
    end

    def test_reach_secret_number_once_sets_value_to_one
      @secret_code.process_instructions ["L0"]

      assert_equal 1, @secret_code.value
    end

    def test_aoc_first_example
      @safe.dial_pointing_at = 50
      instructions = %w[L68 L30 R48 L5 R60 L55 L1 L99 R14 L82]
      @secret_code.process_instructions instructions

      assert_equal 3, @secret_code.value
    end
  end
end
