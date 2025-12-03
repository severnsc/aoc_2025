module DayTwo
  # Find the first number in the range with even number of digits
  # Take the first half of the digits from that number
  # Repeat those digits to form the first, lowest contender
  # Check that the contender is less than the range max
  # If it is, then it's in the set. If it's not, exit.
  # Increment the first half of the digits by 1, repeat from step 3

  require_relative "day_2/part_1"
end
