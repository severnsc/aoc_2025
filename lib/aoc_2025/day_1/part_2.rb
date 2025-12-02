module DayOne
  module PartTwo
    require_relative "part_2/secret_code"

    def self.solve
      safe = Safe.new dial_range: 0..99, dial_pointing_at: 50
      secret_code = SecretCode.new safe:, secret_number: 0
      file = File.read File.expand_path "input.csv", File.dirname(__FILE__)
      instructions = file.each_line.map(&:chomp)
      secret_code.process_instructions instructions
      p secret_code.value
    end
  end
end
