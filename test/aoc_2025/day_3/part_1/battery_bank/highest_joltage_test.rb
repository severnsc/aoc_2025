require "test_helper"

class BatteryBank::HighestJoltageTest < Minitest::Test
  def setup
    @bank = BatteryBank.new batteries: [], battery_limit: 2
  end

  def test_empty_bank_returns_zero
    assert @bank.highest_joltage.zero?
  end

  def test_zero_limit_returns_zero
    @bank.batteries = [1]
    @bank.battery_limit = 0

    assert @bank.highest_joltage.zero?
  end

  def test_single_battery
    @bank.batteries = [1]

    assert_equal 1, @bank.highest_joltage
  end

  def test_two_batteries
    @bank.batteries = [1, 2]

    assert_equal 12, @bank.highest_joltage
  end

  def test_many_batteries_descending_order
    @bank.batteries = [9, 8, 7]

    assert_equal 98, @bank.highest_joltage
  end

  def test_many_batteries_separated
    @bank.batteries = [8, 1, 9]

    assert_equal 89, @bank.highest_joltage
  end

  def test_three_battery_limit
    @bank.batteries = [8, 1, 9]
    @bank.battery_limit = 3

    assert_equal 819, @bank.highest_joltage
  end

  def test_twelve_battery_limit
    @bank.batteries = [8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1]
    @bank.battery_limit = 12

    assert_equal 888_911_112_111, @bank.highest_joltage
  end

  def test_aoc_example
    @bank.batteries = [2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8]
    @bank.battery_limit = 12

    assert_equal 434_234_234_278, @bank.highest_joltage
  end

  def test_aoc_two_digit_example
    @bank.batteries = [8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1]
    @bank.battery_limit = 2

    assert_equal 92, @bank.highest_joltage
  end
end
