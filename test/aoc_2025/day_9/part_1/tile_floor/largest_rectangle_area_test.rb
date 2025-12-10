require "test_helper"

class TileFloor::LargestRectangleAreaTest < Minitest::Test
  def setup
    @floor = TileFloor.new []
  end

  def test_no_red_tiles
    assert @floor.largest_rectangle_area.zero?
  end

  def test_one_tile
    @floor.red_tile_coordinates = [Point.from_2d_coordinates([0, 0])]

    assert @floor.largest_rectangle_area.zero?
  end

  def test_two_tiles
    @floor.red_tile_coordinates = [Point.from_2d_coordinates([0, 0]), Point.from_2d_coordinates([1, 1])]

    assert_equal 4, @floor.largest_rectangle_area
  end

  def test_many_tiles
    @floor.red_tile_coordinates = [
      Point.from_2d_coordinates([0, 0]),
      Point.from_2d_coordinates([1, 1]),
      Point.from_2d_coordinates([2, 2])
    ]

    assert_equal 9, @floor.largest_rectangle_area
  end

  def test_aoc_example
    @floor.red_tile_coordinates = aoc_points

    assert_equal 50, @floor.largest_rectangle_area
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
