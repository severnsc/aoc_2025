require "test_helper"

class TachyonManifold::TotalBeamSplitsTest < Minitest::Test
  def setup
    @manifold = TachyonManifold.new beam: "|", empty: ".", splitter: "^", start: "S"
  end

  def test_zero_splits
    @manifold.diagram = ["S", "."]

    assert @manifold.total_beam_splits.zero?
  end

  def test_one_split
    @manifold.diagram = [".S.", ".^.", "..."]

    assert_equal 1, @manifold.total_beam_splits
  end

  def test_two_splits
    @manifold.diagram = [
      "..S..",
      "..^..",
      ".^...",
      "....."
    ]

    assert_equal 2, @manifold.total_beam_splits
  end

  def test_unused_splitter
    @manifold.diagram = [
      ".S.",
      "^..",
      "..."
    ]

    assert_equal 0, @manifold.total_beam_splits
  end

  def test_aoc_example
    input = ".......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
"
    @manifold.diagram = input.each_line.map(&:chomp)

    assert_equal 21, @manifold.total_beam_splits
  end
end
