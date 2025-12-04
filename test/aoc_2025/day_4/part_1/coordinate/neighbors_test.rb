require "test_helper"

class Coordinate::NeighborsTest < Minitest::Test
  def test_neighbors
    assert_equal [
      Coordinate.new(row: -1, col: 0),
      Coordinate.new(row: -1, col: 1),
      Coordinate.new(row: 0, col: 1),
      Coordinate.new(row: 1, col: 1),
      Coordinate.new(row: 1, col: 0),
      Coordinate.new(row: 1, col: -1),
      Coordinate.new(row: 0, col: -1),
      Coordinate.new(row: -1, col: -1)
    ], Coordinate.new(row: 0, col: 0).neighbors
  end
end
