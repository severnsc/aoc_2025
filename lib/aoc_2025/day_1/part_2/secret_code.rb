module DayOne::PartTwo
  class SecretCode
    include ActiveModel::Model

    attr_accessor :safe, :secret_number
    attr_reader :value

    def process_instructions(instructions)
      self.value = 0
      instructions.each do |instruction|
        direction = instruction[0]
        instruction_distance = instruction[1..].to_i
        while instruction_distance >= safe.numbers_on_dial
          self.value += 1
          instruction_distance -= safe.numbers_on_dial
        end
        if safe.dial_pointing_at != secret_number && instruction_distance >= distance_to_secret_number[direction]
          self.value += 1
        end
        safe.rotate_dial instruction
      end
    end

    private

    def distance_to_secret_number
      safe.distance_to secret_number
    end

    attr_writer :value
  end
end
