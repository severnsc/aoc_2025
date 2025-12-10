module DayNine
  module PartTwo
    require_relative "part_2/polygon"

    def self.solve
      tile_floor = TileFloor.new points
      p tile_floor.largest_red_green_rectangle_area
    end

    def self.coordinates
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      lines.map do |line|
        line.split(",").map(&:to_i)
      end
    end

    def self.points
      coordinates.map { |coordinates| Point.from_2d_coordinates coordinates }
    end
  end
end
