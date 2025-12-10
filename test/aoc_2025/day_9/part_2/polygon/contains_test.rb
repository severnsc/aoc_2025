require "test_helper"

class Polygon::ContainsTest < Minitest::Test
  def setup
    @polygon = Polygon.new []
  end

  def test_a_vertex
    @polygon.verticies = [Point.from_coordinates(0, 0), Point.from_coordinates(1, 0),
                          Point.from_coordinates(1, 1), Point.from_coordinates(0, 1)]

    assert @polygon.contains? Point.from_coordinates(0, 0)
  end

  def test_point_outside
    @polygon.verticies = [Point.from_coordinates(0, 0), Point.from_coordinates(1, 0),
                          Point.from_coordinates(1, 1), Point.from_coordinates(0, 1)]

    refute @polygon.contains? Point.from_coordinates(2, 0)
  end

  def test_face_point
    @polygon.verticies = [Point.from_coordinates(0, 0), Point.from_coordinates(2, 0),
                          Point.from_coordinates(2, 2), Point.from_coordinates(0, 2)]

    assert @polygon.contains? Point.from_coordinates(1, 0)
  end

  def test_enclosed_point
    @polygon.verticies = [Point.from_coordinates(0, 0), Point.from_coordinates(3, 0),
                          Point.from_coordinates(3, 3), Point.from_coordinates(0, 3)]

    assert @polygon.contains? Point.from_coordinates(1, 1)
  end

  def test_point_above
    @polygon.verticies = [Point.from_coordinates(0, 1), Point.from_coordinates(3, 1),
                          Point.from_coordinates(3, 4), Point.from_coordinates(0, 4)]

    refute @polygon.contains? Point.from_coordinates(0, 0)
  end

  def test_adjacent_point
    @polygon.verticies = [Point.from_coordinates(1, 0), Point.from_coordinates(4, 0),
                          Point.from_coordinates(4, 2), Point.from_coordinates(1, 2)]

    refute @polygon.contains? Point.from_coordinates(0, 1)
  end

  def test_intersects_line_of_asymmetric_polygon
    @polygon.verticies = aoc_points

    refute @polygon.contains? Point.from_coordinates(2, 7)
  end

  def test_colinear_point_inside_polygon
    @polygon.verticies = aoc_points

    assert @polygon.contains? Point.from_coordinates(9, 3)
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
