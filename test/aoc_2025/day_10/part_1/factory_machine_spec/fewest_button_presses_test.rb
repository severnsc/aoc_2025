require "test_helper"

class FactoryMachineSpec::FewestButtonPressesTest < Minitest::Test
  def setup
    @spec = FactoryMachineSpec.new
  end

  def test_one_button_press
    @spec.indicator_lights = [".", ".", "#"]
    @spec.button_wiring_schematics = [[0], [1], [2]]

    assert_equal 1, @spec.fewest_button_presses
  end

  def test_two_button_presses
    @spec.indicator_lights = %w[. # # .]
    @spec.button_wiring_schematics = [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]]

    assert_equal 2, @spec.fewest_button_presses
  end

  def test_three_button_presses
    @spec.indicator_lights = %w[. . . # .]
    @spec.button_wiring_schematics = [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]]

    assert_equal 3, @spec.fewest_button_presses
  end

  def test_another_two_button_presses
    @spec.indicator_lights = %w[. # # # . #]
    @spec.button_wiring_schematics = [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]]

    assert_equal 2, @spec.fewest_button_presses
  end
end
