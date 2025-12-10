class Polygon
  attr_reader :verticies

  def initialize(verticies)
    @verticies = verticies
    build_line_segments
  end

  def area
    line_segments.map do |line_segment|
      (line_segment.end_points[0].x * line_segment.end_points[1].y) - (line_segment.end_points[1].x * line_segment.end_points[0].y)
    end.sum * 1 / 2
  end

  def verticies=(verticies)
    @verticies = verticies
    build_line_segments
  end

  def contains?(point)
    ray = Ray.new point
    inside = false
    line_segments.each do |line_segment|
      if line_segment.contains? ray.origin
        inside = true
        break
      end
      inside = !inside if ray.intersects_line_segment? line_segment
    end
    inside
  end

  def contains_shape?(shape)
    shape.points.all? { |point| contains? point }
  end

  private

  attr_accessor :line_segments

  def build_line_segments
    segments = []
    (0...verticies.length - 1).each do |n|
      segment = LineSegment.new([verticies[n], verticies[n.next]])
      segments << segment
    end
    if verticies.any?
      last_segment = LineSegment.new([verticies.last, verticies.first])
      segments << last_segment
    end
    self.line_segments = segments
  end
end

LineSegment = Struct.new :end_points do
  def contains?(point)
    x_range.include?(point.x) && y_range.include?(point.y)
  end

  def horizontal?
    end_points[0].y == end_points[1].y
  end

  def min_x
    x_range.min
  end

  def vertical?
    end_points[0].x == end_points[1].x
  end

  def x_range
    minmax = end_points.map(&:x).minmax
    minmax[0]..minmax[1]
  end

  def y_delta
    (end_points[0].y - end_points[1].y).abs
  end

  def y_range
    minmax = end_points.map(&:y).minmax
    minmax[0]..minmax[1]
  end
end

Ray = Struct.new :origin do
  def intersects_line_segment?(line_segment)
    line_segment.vertical? && line_segment.x_range.min >= origin.x && line_segment.y_range.include?(origin.y)
  end
end
