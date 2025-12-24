module DayEleven
  module PartOne
    require_relative "part_1/dag"

    def self.solve
      dag = DAG.new
      dag.edges = edges
      p dag.paths_between "you", "out"
    end

    def self.edges
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      edges = []
      lines.each do |line|
        origin, *destinations = line.split(" ").map { |s| s[..2] }
        destinations.each do |destination|
          edges << [origin, destination]
        end
      end
      edges
    end
  end
end

DayEleven::PartOne.solve
