require "test_helper"

class Graph::FindClosestPairTest < Minitest::Test
  def setup
    @graph = Graph.new
  end

  def test_no_points_is_infinite
    result = @graph.find_closest_pair

    assert result.distance.infinite?
    assert_empty result.points
  end

  def test_one_point_is_infinite
    @graph.points = [Point.new(x: 0, y: 0, z: 0)]
    result = @graph.find_closest_pair

    assert result.distance.infinite?
    assert_empty result.points
  end

  def test_two_points
    @graph.points = [Point.new(x: 0, y: 0, z: 0), Point.new(x: 1, y: 0, z: 0)]
    result = @graph.find_closest_pair

    assert_equal @graph.points.first.distance_from(@graph.points[1]), result.distance
    assert_equal @graph.points, result.points
  end

  def test_three_points
    @graph.points = [Point.new(x: 0, y: 0, z: 0), Point.new(x: 3, y: 0, z: 0), Point.new(x: 1, y: 0, z: 0)]
    result = @graph.find_closest_pair

    assert_equal @graph.points.first.distance_from(@graph.points[2]), result.distance
    assert_equal [@graph.points[0], @graph.points[2]], result.points
  end

  def test_many_points
    @graph.points = [
      Point.new(x: 1, y: 2, z: 0),
      Point.new(x: 3, y: 4, z: 0),
      Point.new(x: 5, y: 1, z: 0),
      Point.new(x: 7, y: 3, z: 0),
      Point.new(x: 9, y: 6, z: 0),
      Point.new(x: 11, y: 2, z: 0),
      Point.new(x: 12, y: 7, z: 0),
      Point.new(x: 15, y: 5, z: 0)
    ]
    result = @graph.find_closest_pair

    assert_equal @graph.points.first.distance_from(@graph.points[1]), result.distance
    assert_equal [@graph.points[2], @graph.points[3]], result.points
  end

  def test_aoc_example
    input = [
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
    @graph.points = input.map { |coordinates| Point.new x: coordinates[0], y: coordinates[1], z: coordinates[2] }
    result = @graph.find_closest_pair

    assert_equal [@graph.points.last, @graph.points.first], result.points
  end
end
