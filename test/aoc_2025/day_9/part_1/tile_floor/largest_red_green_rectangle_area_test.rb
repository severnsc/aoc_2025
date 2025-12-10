require "test_helper"

class TileFloor::LargestRedGreenRectangleAreaTest < Minitest::Test
  def setup
    @tile_floor = TileFloor.new []
  end

  def test_aoc_example
    @tile_floor.red_tile_coordinates = aoc_points

    assert_equal 24, @tile_floor.largest_red_green_rectangle_area
  end

  def test_concave_polygon
    input = [
      [0, 0],
      [2, 0],
      [2, 1],
      [1, 1],
      [1, 3],
      [2, 3],
      [2, 4],
      [0, 4]
    ]
    points = input.map { |coordinates| Point.from_2d_coordinates coordinates }
    @tile_floor.red_tile_coordinates = points

    assert_equal 8, @tile_floor.largest_red_green_rectangle_area
  end

  private

  def aoc_input
    [
      [7, 1],
      [11, 1],
      [11, 7],
      [9, 7],
      [9, 5],
      [2, 5],
      [2, 3],
      [7, 3]
    ]
  end

  def aoc_points
    aoc_input.map { |coordinates| Point.from_2d_coordinates coordinates }
  end
end
