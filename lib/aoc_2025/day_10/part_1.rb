module DayTen
  module PartOne
    require_relative "part_1/factory_machine_spec"

    def self.solve
      p specs.sum(&:fewest_button_presses)
    end

    def self.specs
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      lines.map do |line|
        indicator_lights = line.match(/(?<=\[)[#.]+/)[0].split ""
        button_wiring_schematics = line.match(/(?<=\])[(0-9),\s]+/)[0].strip.split.map do |button|
          button.match(/(?<=\().+(?=\))/)[0].split(",").map(&:to_i)
        end
        FactoryMachineSpec.new button_wiring_schematics:, indicator_lights:
      end
    end
  end
end

DayTen::PartOne.solve
