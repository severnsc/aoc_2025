class BatteryBank
  include ActiveModel::Model
  attr_accessor :batteries, :battery_limit

  def highest_joltage
    return 0 if batteries.empty? || battery_limit.zero?
    return batteries.join.to_i if batteries.length < battery_limit

    find_highest_joltage batteries, Float::INFINITY, []
  end

  private

  # Find the highest digit. Does this digit complete the sequence?
  #   Yes, add it to digits. Return. Done.
  #   No. Are there enough digits after it to meet the limit?
  #     Exactly enough, take the rest of the digits. Add to digits. Return. Done.
  #     Yes, take the digit and repeat with the numbers after.
  #     No, look for next highest digit before highest one. Repeat from top.
  def find_highest_joltage(batteries, less_than, digits)
    highest_joltage_battery = batteries.max if less_than.infinite?
    highest_joltage_battery ||= batteries.filter { |battery| battery < less_than }.max
    highest_joltage_battery_index = batteries.index highest_joltage_battery
    if digits.length + 1 == battery_limit
      [*digits, highest_joltage_battery].join.to_i
    elsif batteries[highest_joltage_battery_index..].length == battery_limit - digits.length
      (digits + batteries[highest_joltage_battery_index..]).join.to_i
    elsif batteries[highest_joltage_battery_index..].length > battery_limit - digits.length
      find_highest_joltage batteries[highest_joltage_battery_index.next..], Float::INFINITY,
                           [*digits, highest_joltage_battery]
    else
      find_highest_joltage batteries, highest_joltage_battery, digits
    end
  end
end
