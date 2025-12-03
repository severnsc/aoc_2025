module DayThree
  module PartTwo
    require_relative "part_1/battery_bank"
    require_relative "part_1/escalator_power"

    def self.solve
      escalator_power = EscalatorPower.new battery_banks
      p escalator_power.total_output
    end

    def self.battery_banks
      battery_bank_specs.map { |spec| BatteryBank.new batteries: spec, battery_limit: 12 }
    end

    def self.battery_bank_specs
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      file.each_line.map do |line|
        line.chomp.split("").map(&:to_i)
      end
    end
  end
end
