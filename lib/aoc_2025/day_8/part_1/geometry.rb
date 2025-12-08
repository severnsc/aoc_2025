Point = Struct.new :x, :y, :z do
  def self.from_coordinates(coordinates)
    new x: coordinates[0], y: coordinates[1], z: coordinates[2]
  end

  def distance_from(point)
    (x - point.x)**2 + (y - point.y)**2 + (z - point.z)**2
  end
end
ClosestPairResult = Struct.new :distance, :points
Pair = Struct.new :a, :b

class Graph
  include ActiveModel::Model

  attr_accessor :points

  def calculate_all_pair_distances
    distances = {}
    points.each_with_index do |point, index|
      (index.next..(points.length - 1)).each do |n|
        distances[point.distance_from points[n]] = Pair.new(a: point, b: points[n])
      end
    end
    distances
  end

  def find_closest_pair
    return ClosestPairResult.new distance: Float::INFINITY, points: [] if points.nil? || points.length < 2

    recursively_find_closest_pair points, 0, points.length
  end

  private

  def recursively_find_closest_pair(points, left, right)
    return brute_force_find_closest_pair(points[left...right]) if right - left <= 3

    # Find the middle point
    mid = (left + right) / 2
    mid_point = points[mid]

    # Recursively find the minimum distance of each half
    left_result = recursively_find_closest_pair(points, left, mid)
    right_result = recursively_find_closest_pair(points, mid, right)

    # Find the minimum of the two distances
    closest_result = if left_result.distance < right_result.distance
                       left_result
                     else
                       right_result
                     end
    # Build a strip of points within closest_result.distance of middle line
    strip = []
    (left...right).each do |n|
      strip << points[n] if (points[n].x - mid_point.x).abs < closest_result.distance
    end

    # Find the minimum distance within the strip
    strip_result = find_closest_pair_in_strip strip, closest_result.distance

    # Return overall min
    if strip_result.distance < closest_result.distance
      strip_result
    else
      closest_result
    end
  end

  def brute_force_find_closest_pair(points)
    min_distance = Float::INFINITY
    closest_pair = nil
    limit = points.length - 1

    (0...limit).each do |n|
      rest = points[n.next..]
      distances = rest.map { |point| point.distance_from points[n] }
      min_from_n = distances.min
      if min_from_n < min_distance
        min_distance = min_from_n
        closest_pair = [points[n], points[distances.index(min_from_n) + 1]]
      end
    end

    ClosestPairResult.new distance: min_distance, points: closest_pair
  end

  def find_closest_pair_in_strip(strip, distance)
    min_distance = distance
    closest_pair = nil

    strip.sort_by!(&:y)

    # For each point, check at most 7 subsequent points
    (0...strip.length).each do |n|
      i = n + 1
      while i < strip.length && (strip[i].y - strip[n].y) < min_distance
        distance = strip[i].distance_from strip[n]
        if distance < min_distance
          min_distance = distance
          closest_pair = [strip[n], strip[i]]
        end
        i += 1
      end
    end

    ClosestPairResult.new distance: min_distance, points: closest_pair
  end
end
