class BatteryBank
  attr_accessor :batteries

  def initialize(batteries)
    self.batteries = batteries
  end

  # Find the first highest number in the array and its index
  # Determine if there is anything after that number in the array
  #   If yes, find the highest number after it. Done.
  #   If no, find the highest number before it. Done.
  def highest_joltage
    return 0 if batteries.empty?

    if batteries_after_highest_joltage.any?
      [highest_battery_joltage, batteries_after_highest_joltage.max].join.to_i
    else
      [batteries_before_highest_joltage.max, highest_battery_joltage].join.to_i
    end
  end

  private

  def batteries_after_highest_joltage
    batteries[highest_battery_joltage_index.next..]
  end

  def batteries_before_highest_joltage
    batteries[...highest_battery_joltage_index]
  end

  def highest_battery_joltage
    batteries.max
  end

  def highest_battery_joltage_index
    batteries.index highest_battery_joltage
  end
end
