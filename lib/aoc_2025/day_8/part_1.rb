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

    def self.solve_part_two
      graph = Graph.new(points:)
      all_distances = graph.calculate_all_pair_distances
      sorted = all_distances.keys.sort
      circuits = initial_circuits
      index = 0
      while circuits.length > 1
        distance = sorted[index]
        pair = all_distances[distance]
        circuits_to_combine = circuits.filter { |circuit| circuit.contains_any? [pair.a, pair.b] }
        index += 1
        next unless circuits_to_combine.length == 2

        circuits_to_combine.each { |circuit| circuits.delete circuit }
        combined_circuit = circuits_to_combine[0].connect_to circuits_to_combine[1]
        circuits << combined_circuit
      end
      last_pair = all_distances[sorted[index - 1]]
      p last_pair.a.x * last_pair.b.x
    end

    def self.coordinates
      lines = File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
      lines.map do |line|
        line.split(",").map(&:to_i)
      end
    end

    def self.points
      coordinates.map { |coordinates| Point.from_3d_coordinates coordinates }
    end

    def self.initial_circuits
      points.map { |point| Circuit.new [point] }
    end

    def self.aoc_input
      [
        [162, 817, 812],
        [57, 618, 57],
        [906, 360, 560],
        [592, 479, 940],
        [352, 342, 300],
        [466, 668, 158],
        [542, 29, 236],
        [431, 825, 988],
        [739, 650, 466],
        [52, 470, 668],
        [216, 146, 977],
        [819, 987, 18],
        [117, 168, 530],
        [805, 96, 715],
        [346, 949, 466],
        [970, 615, 88],
        [941, 993, 340],
        [862, 61, 35],
        [984, 92, 344],
        [425, 690, 689]
      ]
    end

    def self.aoc_points
      aoc_input.map { |coordinates| Point.from_3d_coordinates coordinates }
    end

    def self.aoc_circuits
      aoc_points.map { |point| Circuit.new [point] }
    end
  end
end
