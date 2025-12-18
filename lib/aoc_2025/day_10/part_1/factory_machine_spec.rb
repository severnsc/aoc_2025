class FactoryMachineSpec
  include ActiveModel::Model
  attr_accessor :button_wiring_schematics, :indicator_lights

  def fewest_button_presses
    # final_state = [false, true, true, false]
    done = false
    buttons_to_press = 1
    while buttons_to_press < button_wiring_schematics.length
      permutations = button_wiring_schematics.permutation buttons_to_press
      initial_state = Array.new indicator_lights.length, false
      permutations.each do |permutation|
        test_state = press_buttons initial_state, permutation
        done = test_state == final_state
        break if done
      end
      break if done

      buttons_to_press += 1
    end
    buttons_to_press
  end

  private

  def candidate_buttons
    button_wiring_schematics.filter { |schematic| schematic.intersect? final_state }
  end

  def final_state
    indicator_lights.map { |light| light == "#" }
  end

  def press_buttons(initial_state, buttons)
    final_state = *initial_state
    buttons.each do |button|
      button.each do |light|
        final_state[light] = !final_state[light]
      end
    end
    final_state
  end
end
