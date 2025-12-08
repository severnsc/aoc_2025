class Circuit
  attr_reader :points

  def initialize(points)
    self.points = Set[*points]
  end

  def contains_any?(candidates)
    candidates.any? { |candidate| points.member? candidate }
  end

  def connect_to(circuit)
    Circuit.new points + circuit.points
  end

  def length
    points.length
  end

  private

  attr_writer :points
end

module DayEight
  module PartOne
    require_relative "part_1/geometry"

    def self.solve
      graph = Graph.new(points:)
      all_distances = graph.calculate_all_pair_distances
      shortest = all_distances.keys.min(1000)
      circuits = initial_circuits
      shortest.each do |distance|
        pair = all_distances[distance]
        circuits_to_combine = circuits.filter { |circuit| circuit.contains_any? [pair.a, pair.b] }
        next unless circuits_to_combine.length == 2

        circuits_to_combine.each { |circuit| circuits.delete circuit }
        combined_circuit = circuits_to_combine[0].connect_to circuits_to_combine[1]
        circuits << combined_circuit
      end
      p circuits.map(&:length).max(3).reduce(1) { |product, value| product * value }
    end

    def self.coordinates
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      lines.map do |line|
        line.split(",").map(&:to_i)
      end
    end

    def self.points
      coordinates.map { |coordinates| Point.from_coordinates coordinates }
    end

    def self.initial_circuits
      points.map { |point| Circuit.new [point] }
    end
  end
end
