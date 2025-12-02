require "test_helper"

module DayOne::PartTwo
  class SecretCode::ProcessInstructionsTest < Minitest::Test
    def setup
      @safe = Safe.new dial_range: 0..99, dial_pointing_at: 50
      @secret_code = SecretCode.new safe: @safe, secret_number: 0
    end

    def test_no_instructions_is_zero
      @secret_code.process_instructions []

      assert_equal 0, @secret_code.value
    end

    def test_points_while_decreasing
      @secret_code.process_instructions ["L68"]

      assert_equal 1, @secret_code.value
    end

    def test_points_twice
      @secret_code.process_instructions %w[L68 L30 R48]

      assert_equal 2, @secret_code.value
    end

    def test_one_full_rotation
      @secret_code.process_instructions ["L100"]

      assert_equal 1, @secret_code.value
    end

    def test_many_full_rotations
      @secret_code.process_instructions ["L200"]

      assert_equal 2, @secret_code.value
    end

    def test_aoc_example
      instructions = %w[L68 L30 R48 L5 R60 L55 L1 L99 R14 L82]
      @secret_code.process_instructions instructions

      assert_equal 6, @secret_code.value
    end
  end
end
