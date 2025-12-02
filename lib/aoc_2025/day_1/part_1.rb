module DayOne
  module PartOne
    require_relative "part_1/safe"
    require_relative "part_1/secret_code"

    def self.solve
      file = File.read "part_1/input.csv"
      instructions = file.each_line.map(&:chomp)
      safe = Safe.new dial_range: 0..99, dial_pointing_at: 50
      secret_code = SecretCode.new safe:, secret_number: 0
      secret_code.process_instructions instructions
      p secret_code.value
    end
  end
end
