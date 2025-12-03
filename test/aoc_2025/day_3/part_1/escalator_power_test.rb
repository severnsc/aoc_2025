require "test_helper"

class EscalatorPowerTest < Minitest::Test
  def test_sets_battery_banks
    banks = [BatteryBank.new(batteries: [1])]
    escalator_power = EscalatorPower.new banks

    assert_equal banks, escalator_power.battery_banks
  end
end
