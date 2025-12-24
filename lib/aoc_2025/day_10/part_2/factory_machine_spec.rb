require "matrix"

class FactoryMachineSpec
  def initialize(attrs = {})
    self.cache = {}
    super
  end

  def fewest_joltage_indicator_button_presses
    cache.clear
    fewest_button_presses Matrix[joltage_requirements], button_schematic_permutations
  end

  def fewest_button_presses(joltage_requirements, permutations)
    return 0 if joltage_requirements.all?(&:zero?)

    parity = joltage_requirements.map(&:odd?)
    p "cache hit" if cache.dig(parity, joltage_requirements)
    return cache.dig(parity, joltage_requirements) if cache.dig(parity, joltage_requirements)

    permutations_to_test = []
    permutations.each do |permutation|
      next unless permutation[:parity] == parity && permutation[:state].each_with_index.all? do |v, row, col|
        joltage_requirements[row, col] >= v
      end

      permutations_to_test << permutation
    end
    return Float::INFINITY if permutations_to_test.empty?

    min = permutations_to_test.map do |result|
      difference = joltage_requirements - result[:state]
      next_requirements = difference.map { |value| value / 2 }
      2 * fewest_button_presses(next_requirements, permutations) + result[:presses]
    end.min
    if cache[parity]
      cache[parity][joltage_requirements] = min
    else
      cache[parity] = { [joltage_requirements] => min }
    end
    min
  end

  private

  attr_accessor :cache

  def button_schematic_permutations
    permutations = []
    button_wiring_schematics.length.next.times do |n|
      permutations += button_wiring_schematics.combination(n).to_a
    end
    permutations.map do |permutation|
      state = Matrix[Array.new(joltage_requirements.length, 0)]
      permutation.each do |lights|
        lights.each do |light|
          state[0, light] += 1
        end
      end
      { state:, parity: state.map(&:odd?), presses: permutation.length }
    end
  end
end
