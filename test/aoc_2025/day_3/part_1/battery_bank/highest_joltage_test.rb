require "test_helper"

class BatteryBank::HighestJoltageTest < Minitest::Test
  def setup
    @bank = BatteryBank.new []
  end

  def test_empty_bank_returns_zero
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
end
