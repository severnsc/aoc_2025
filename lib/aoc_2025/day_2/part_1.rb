module DayTwo
  module PartOne
    require_relative "part_1/product_id_validator"
    require_relative "part_1/product_id_aggregator"

    def self.solve
      p ProductIdAggregator.new.aggregate ranges
    end

    def self.ranges
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      range_strings = file.split(",")
      range_strings.map do |range_string|
        min, max = range_string.split("-").map(&:to_i)
        min..max
      end
    end
  end
end

DayTwo::PartOne.solve
