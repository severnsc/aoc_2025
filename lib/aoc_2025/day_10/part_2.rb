module DayTen
  module PartTwo
    require_relative "part_2/factory_machine_spec"

    def self.solve
      p specs.sum(&:fewest_joltage_indicator_button_presses)
    end

    def self.specs
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      lines.map do |line|
        joltage_requirements = line.match(/(?<={).+(?=})/)[0].split(",").map(&:to_i)
        button_wiring_schematics = line.match(/(?<=\])[(0-9),\s]+/)[0].strip.split.map do |button|
          button.match(/(?<=\().+(?=\))/)[0].split(",").map(&:to_i)
        end
        FactoryMachineSpec.new button_wiring_schematics:, joltage_requirements:
      end
    end
  end
end
