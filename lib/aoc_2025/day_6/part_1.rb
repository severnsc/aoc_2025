module DaySix
  module PartOne
    require_relative "part_1/cephalapod_homework"

    def self.solve
      homework = CephalapodHomework.new(numbers:, operators:)
      p homework.grand_total
    end

    def self.numbers
      lines[...-1]
    end

    def self.operators
      lines.last
    end

    def self.lines
      file = File.read File.expand_path "input.txt", File.dirname(__FILE__)
      file.each_line.map(&:chomp)
    end
  end
end
