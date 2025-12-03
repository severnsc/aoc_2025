require "test_helper"

class BatteryBankTest < Minitest::Test
  def test_sets_batteries
    bank = BatteryBank.new [1, 2, 3]

    assert_equal [1, 2, 3], bank.batteries
  end
end
