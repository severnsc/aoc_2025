Coordinate = Struct.new :row, :col do
  def neighbors
    [above, upper_right, right, lower_right, below,
     lower_left, left, upper_left]
  end

  def above
    Coordinate.new row: row - 1, col: col
  end

  def upper_right
    Coordinate.new row: row - 1, col: col + 1
  end

  def right
    Coordinate.new row: row, col: col + 1
  end

  def lower_right
    Coordinate.new row: row + 1, col: col + 1
  end

  def below
    Coordinate.new row: row + 1, col: col
  end

  def lower_left
    Coordinate.new row: row + 1, col: col - 1
  end

  def left
    Coordinate.new row: row, col: col - 1
  end

  def upper_left
    Coordinate.new row: row - 1, col: col - 1
  end

  def ==(other)
    other.class == self.class && other.row == row && other.col == col
  end
end
