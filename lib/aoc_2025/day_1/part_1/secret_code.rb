require "active_model"

class SecretCode
  include ActiveModel::Model

  attr_accessor :safe, :secret_number
  attr_reader :value

  def process_instructions(instructions)
    self.value = 0
    instructions.each do |instruction|
      safe.rotate_dial instruction
      self.value += 1 if safe.dial_pointing_at.zero?
    end
  end

  private

  attr_writer :value
end
