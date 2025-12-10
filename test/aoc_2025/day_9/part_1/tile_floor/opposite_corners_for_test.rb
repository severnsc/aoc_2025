require "test_helper"

class Rectangle::OppositeCornersForTest < Minitest::Test
  def test_points_reversed_for_vertical_line
    points = [Point.from_coordinates(0, 0), Point.from_coordinates(0, 1)]
    corners = Rectangle.opposite_corners_for points

    assert_equal points.reverse, corners
  end

  def test_points_reversed_for_horizontal_line
    points = [Point.from_coordinates(0, 0), Point.from_coordinates(1, 0)]
    corners = Rectangle.opposite_corners_for points

    assert_equal points.reverse, corners
  end

  def test_opposite_corners_positive_slope
    points = [Point.from_coordinates(0, 0), Point.from_coordinates(1, 1)]
    corners = Rectangle.opposite_corners_for points

    assert_equal [Point.from_coordinates(0, 1), Point.from_coordinates(1, 0)], corners
  end

  def test_opposite_corners_negative_slope
    points = [Point.from_coordinates(1, 1), Point.from_coordinates(2, 0)]
    corners = Rectangle.opposite_corners_for points

    assert_equal [Point.from_coordinates(2, 1), Point.from_coordinates(1, 0)], corners
  end
end
