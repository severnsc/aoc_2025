module DayTwo
  module PartTwo
    require_relative "part_2/product_id_validator"

    def self.solve
      p ProductIdAggregator.new(ProductIdValidator).aggregate ranges
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
