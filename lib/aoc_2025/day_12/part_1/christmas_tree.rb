class ChristmasTree
  attr_accessor :dimensions, :present_shapes

  def fits_presents?(shape_quantities)
    return true if shape_quantities.sum * 9 < area

    total_required_tiles = shape_quantities.each_with_index.sum do |quantity, index|
      quantity * required_tile_counts[index]
    end
    total_required_tiles <= area
  end

  private

  def area
    dimensions[:width] * dimensions[:length]
  end

  def required_tile_counts
    present_shapes.map do |shape|
      shape.sum { |str| str.count "#" }
    end
  end
end
