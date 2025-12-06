module DayFive
  module PartOne
    require_relative "part_1/ingredients_db"

    def self.solve
      db = IngredientsDb.new(fresh_ranges:)
      ids_to_test.filter { |id| db.fresh? id }.count
    end

    def self.solve_part_two
      db = IngredientsDb.new(fresh_ranges:)
      db.total_fresh_ingredients_ids
    end

    def self.fresh_ranges
      lines[...separator_index].map do |range_string|
        min, max = range_string.split "-"
        min.to_i..max.to_i
      end
    end

    def self.ids_to_test
      lines[separator_index.next..].map(&:to_i)
    end

    def self.separator_index
      lines.index separator
    end

    def self.lines
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      file.each_line.map(&:chomp)
    end

    def self.separator
      ""
    end
  end
end
