module DayFour
  module PartOne
    require_relative "part_1/coordinate"
    require_relative "part_1/grid"

    def self.solve
      p grid.accessible_rows_of_paper.count
    end

    def self.solve_part_two
      current_grid = grid
      current_grid = current_grid.remove_accessible_rolls_of_paper while current_grid.accessible_rows_of_paper.any?
      p current_grid.rows.map(&:join).join.count current_grid.removed_roll_of_paper
    end

    def self.grid
      Grid.new rows:, roll_of_paper: "@", empty_space: ".", max_adjacent_rolls_of_paper: 3, removed_roll_of_paper: "x"
    end

    def self.rows
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      file.each_line.map(&:chomp).map { |line| line.split "" }
    end
  end
end
