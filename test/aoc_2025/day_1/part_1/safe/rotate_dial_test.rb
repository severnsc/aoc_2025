require "test_helper"

class Safe::RotateDialTest < Minitest::Test
  def setup
    @safe = Safe.new dial_range: 0..99, dial_pointing_at: 0
  end

  def test_rotate_zero_leaves_dial_unchanged
    @safe.rotate_dial "L0"

    assert_equal 0, @safe.dial_pointing_at
  end

  def test_rotate_left_decreases_dial_pointing_at
    @safe.dial_pointing_at = 1
    @safe.rotate_dial "L1"

    assert_equal 0, @safe.dial_pointing_at
  end

  def test_rotate_right_increases_dial_pointing_at
    @safe.rotate_dial "R1"

    assert_equal 1, @safe.dial_pointing_at
  end

  def test_rotate_left_from_zero_loops_around
    @safe.rotate_dial "L1"

    assert_equal 99, @safe.dial_pointing_at
  end

  def test_rotate_right_from_ninety_nine_loops_around
    @safe.dial_pointing_at = 99
    @safe.rotate_dial "R1"

    assert_equal 0, @safe.dial_pointing_at
  end

  def test_aoc_first_example
    @safe.dial_pointing_at = 11
    @safe.rotate_dial "R8"

    assert_equal 19, @safe.dial_pointing_at

    @safe.rotate_dial "L19"

    assert_equal 0, @safe.dial_pointing_at
  end

  def test_aoc_second_example
    @safe.dial_pointing_at = 5
    @safe.rotate_dial "L10"

    assert_equal 95, @safe.dial_pointing_at
    @safe.rotate_dial "R5"

    assert_equal 0, @safe.dial_pointing_at
  end
end
