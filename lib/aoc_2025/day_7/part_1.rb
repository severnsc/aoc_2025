module DaySeven
  module PartOne
    require_relative "part_1/tachyon_manifold"

    def self.solve
      p mainfold.total_beam_splits
    end

    def self.solve_part_two
      p manifold.total_timelines
    end

    def self.diagram
      File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
    end

    def self.manifold
      TachyonManifold.new diagram:, beam: "|", empty: ".", splitter: "^", start: "S"
    end
  end
end
