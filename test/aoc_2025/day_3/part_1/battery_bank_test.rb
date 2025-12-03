require "test_helper"

class BatteryBankTest < Minitest::Test
  def test_sets_batteries
    bank = BatteryBank.new batteries: [1, 2, 3]

    assert_equal [1, 2, 3], bank.batteries
  end

  def test_sets_battery_limit
    bank = BatteryBank.new battery_limit: 2

    assert_equal 2, bank.battery_limit
  end
end
