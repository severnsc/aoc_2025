module DayTwelve
  module PartOne
    require_relative "part_1/christmas_tree"

    def self.solve
      christmas_tree = ChristmasTree.new
      christmas_tree.present_shapes = shapes
      tests.filter do |test|
        christmas_tree.dimensions = test[0]
        christmas_tree.fits_presents? test[1]
      end.count
    end

    def self.shapes
      rows = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__)))[..28].map(&:chomp).reject do |line|
        line.length < 3
      end
      shapes = []
      6.times do |n|
        shapes << rows[n * 3..n * 3 + 2]
      end
      shapes
    end

    def self.tests
      tests = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__)))[30..].map(&:chomp)
      tests.map do |test|
        dimensions, quantities = test.split(": ")
        rows, cols = dimensions.split "x"
        shape_quantities = quantities.split(" ").map(&:to_i)
        [{ width: rows.to_i, length: cols.to_i }, shape_quantities]
      end
    end
  end
end

p DayTwelve::PartOne.solve
