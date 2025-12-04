module DayFour
  module PartOne
    require_relative "part_1/coordinate"
    require_relative "part_1/grid"

    def self.solve
      grid = Grid.new rows:, roll_of_paper: "@", empty_space: ".", max_adjacent_rolls_of_paper: 3
      p grid.accessible_rows_of_paper.count
    end

    def self.rows
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      file.each_line.map(&:chomp).map { |line| line.split "" }
    end
  end
end
