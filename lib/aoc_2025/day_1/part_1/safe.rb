require "active_model"

class Safe
  include ActiveModel::Model

  attr_accessor :dial_range, :dial_pointing_at

  def rotate_dial(instruction)
    direction = instruction[0]
    amount = instruction[1..].to_i
    if direction == "L"
      rotate_dial_left amount
    else
      rotate_dial_right amount
    end
  end

  private

  def numbers_on_dial
    dial_range.count
  end

  def rotate_dial_left(amount)
    self.dial_pointing_at = (dial_pointing_at - amount) % numbers_on_dial
  end

  def rotate_dial_right(amount)
    self.dial_pointing_at = (dial_pointing_at + amount) % numbers_on_dial
  end
end
