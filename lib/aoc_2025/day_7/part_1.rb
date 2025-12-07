module DaySeven
  module PartOne
    require_relative "part_1/tachyon_manifold"

    def self.solve
      mainfold = TachyonManifold.new diagram:, beam: "|", empty: ".", splitter: "^", start: "S"
      p mainfold.total_beam_splits
    end

    def self.diagram
      File.readlines(File.expand_path("input.txt", File.dirname(__FILE__))).map(&:chomp)
    end
  end
end
