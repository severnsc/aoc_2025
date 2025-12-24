require "test_helper"

class FactoryMachineSpec::FewestJoltageIndicatorButtonPressesTest < Minitest::Test
  def setup
    @spec = FactoryMachineSpec.new
  end

  def test_one_button_press
    @spec.button_wiring_schematics = [[0], [1], [2]]
    @spec.joltage_requirements = [1, 0, 0]

    assert_equal 1, @spec.fewest_joltage_indicator_button_presses
  end

  def test_two_button_presses
    @spec.button_wiring_schematics = [[0], [1], [2]]
    @spec.joltage_requirements = [2, 0, 0]

    assert_equal 2, @spec.fewest_joltage_indicator_button_presses
  end

  def test_ten_button_presses
    @spec.button_wiring_schematics = [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]]
    @spec.joltage_requirements = [3, 5, 4, 7]

    assert_equal 10, @spec.fewest_joltage_indicator_button_presses
  end

  def test_twelve_button_presses
    @spec.button_wiring_schematics = [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]]
    @spec.joltage_requirements = [7, 5, 12, 7, 2]

    assert_equal 12, @spec.fewest_joltage_indicator_button_presses
  end

  def test_eleven_button_presses
    @spec.button_wiring_schematics = [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]]
    @spec.joltage_requirements = [10, 11, 11, 5, 10, 5]

    assert_equal 11, @spec.fewest_joltage_indicator_button_presses
  end
end
