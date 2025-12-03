require "test_helper"

class EscalatorPower::TotalOutputTest < Minitest::Test
  def setup
    @escalator_power = EscalatorPower.new []
  end

  def test_outputs_zero_when_no_banks
    assert @escalator_power.total_output.zero?
  end

  def test_outputs_max_joltage_when_one_bank
    bank = BatteryBank.new([1])
    @escalator_power.battery_banks = [bank]

    assert_equal bank.highest_joltage, @escalator_power.total_output
  end

  def test_aoc_example
    battery_bank_specs = [
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1],
      [8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9],
      [2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8],
      [8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1]
    ]
    battery_banks = battery_bank_specs.map { |spec| BatteryBank.new spec }
    @escalator_power.battery_banks = battery_banks

    assert_equal 357, @escalator_power.total_output
  end
end
