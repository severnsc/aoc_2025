class EscalatorPower
  attr_accessor :battery_banks

  def initialize(battery_banks)
    self.battery_banks = battery_banks
  end

  def total_output
    battery_banks.map(&:highest_joltage).sum
  end
end
