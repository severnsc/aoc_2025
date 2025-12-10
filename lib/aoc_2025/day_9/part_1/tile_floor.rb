class TileFloor
  attr_accessor :red_tile_coordinates

  def initialize(red_tile_coordinates)
    self.red_tile_coordinates = red_tile_coordinates
  end

  def largest_rectangle_area
    return 0 unless red_tile_coordinates.length >= 2

    areas = []
    stop = red_tile_coordinates.length - 1
    (0...stop).each do |i|
      (i.next..stop).each do |j|
        areas << Rectangle.from_opposite_corners([
                                                   Point.from_2d_coordinates(red_tile_coordinates[i]),
                                                   Point.from_2d_coordinates(red_tile_coordinates[j])
                                                 ]).tiles_covered
      end
    end
    areas.max
  end

  def largest_red_green_rectangle_area
    return 0 unless red_tile_coordinates.length >= 2

    # Compress our coordinate space to make searching more efficient
    x_map, y_map = coordinate_maps
    condensed = red_tile_coordinates.map do |coordinate|
      Point.from_coordinates x_map[coordinate.x], y_map[coordinate.y]
    end
    # Can use the compressed space for the polygon containment
    polygon = Polygon.new condensed
    polygon_area = polygon.area
    areas = []
    stop = red_tile_coordinates.length - 1
    (0...stop).each do |i|
      (i.next..stop).each do |j|
        # Use compressed coordinates at first
        first = [x_map[red_tile_coordinates[i].x], y_map[red_tile_coordinates[i].y]]
        second = [x_map[red_tile_coordinates[j].x], y_map[red_tile_coordinates[j].y]]
        condensed_points = [Point.from_2d_coordinates(first), Point.from_2d_coordinates(second)]
        rectangle = Rectangle.from_opposite_corners condensed_points
        next if rectangle.area > polygon_area

        # Two verticies in a vertical/horizontal line are connected by all green tiles
        line_segment = LineSegment.new condensed_points
        if line_segment.horizontal? || line_segment.vertical?
          areas << rectangle.tiles_covered
          next
        end

        # If all the corners are not in the polygon, the rectangle isn't in the polygon
        points_to_check = Rectangle.opposite_corners_for condensed_points
        next unless points_to_check.all? { |point| polygon.contains? point }

        next unless polygon.contains_shape? rectangle

        rectangle = Rectangle.from_opposite_corners([
                                                      Point.from_2d_coordinates(red_tile_coordinates[i]),
                                                      Point.from_2d_coordinates(red_tile_coordinates[j])
                                                    ])
        areas << rectangle.tiles_covered
      end
    end
    areas.max
  end

  private

  def coordinate_maps
    x_values = []
    y_values = []
    red_tile_coordinates.each do |coordinate|
      x_values << coordinate.x
      y_values << coordinate.y
    end
    [build_coordinate_map(x_values), build_coordinate_map(y_values)]
  end

  def build_coordinate_map(values)
    map = {}
    sorted = values.sort.uniq
    offset = 0
    if sorted.first.positive?
      map[...sorted.first] = 0
      offset = 1
    end
    sorted.each_with_index do |value, index|
      map[value] = index + offset
      if (value.next...sorted[index.next]).size.positive?
        map[value.next...sorted[index.next]] = index + offset + 1
        offset += 1
      end
    end
    map
  end
end

Rectangle = Struct.new :top_left, :height, :width do
  def self.opposite_corners_for(points)
    line_segment = LineSegment.new points
    if line_segment.vertical? || line_segment.horizontal?
      points.reverse
    else
      lower = points.min_by(&:y)
      higher = points.max_by(&:y)
      [
        Point.from_coordinates(lower.x, lower.y + line_segment.y_delta),
        Point.from_coordinates(higher.x, higher.y - line_segment.y_delta)
      ]
    end
  end

  def self.from_opposite_corners(points)
    width = (points[0].x - points[1].x).abs
    height = (points[0].y - points[1].y).abs
    top_left = Point.from_coordinates(points.min_by(&:x).x, points.min_by(&:y).y)
    new top_left:, width:, height:
  end

  def area
    width * height
  end

  def max_x
    top_left.x + width
  end

  def max_y
    top_left.y + height
  end

  def points
    points = []
    (top_left.x..max_x).each do |x|
      (top_left.y..max_y).each do |y|
        points << Point.from_coordinates(x, y)
      end
    end
    points
  end

  def tiles_covered
    (top_left.x..max_x).size * (top_left.y..max_y).size
  end
end
