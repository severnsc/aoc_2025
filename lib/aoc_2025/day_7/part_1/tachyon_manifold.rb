class TachyonManifoldDiagram
  attr_reader :state

  def initialize(state)
    self.state = state
  end

  def coordinates_for(object)
    coordinates = []
    state.each_with_index do |row, row_index|
      row.each_char.each_with_index do |char, char_index|
        coordinates << Coordinate.new(row: row_index, col: char_index) if char == object
      end
    end
    coordinates
  end

  def object_at(coordinate)
    return nil if coordinate.row >= state.length

    state[coordinate.row][coordinate.col]
  end

  def transform_via(instructions)
    next_state = state
    instructions.each do |instruction|
      next_state[instruction[0].row][instruction[0].col] = instruction[1]
    end

    TachyonManifoldDiagram.new next_state
  end

  private

  attr_writer :state
end

class TachyonManifold
  include ActiveModel::Model

  attr_accessor :beam, :diagram, :empty, :splitter, :start

  def total_beam_splits
    counts = Array.new(diagram.first.length, 0)
    counts[diagram.first.index(start)] = 1
    tachyon_diagram = TachyonManifoldDiagram.new diagram
    position = start_position.below
    object = tachyon_diagram.object_at position
    beam_splits = 0
    while object
      case object
      when empty
        position = Coordinate.new row: position.row + 1, col: counts.index(1)
      when splitter
        if counts[position.col].positive?
          beam_splits += 1
          counts[position.col - 1] = 1
          counts[position.col.next] = 1
          counts[position.col] = 0
        end
        next_splitter_col = diagram[position.row][(position.col + 2)..].index(splitter)
        position = if next_splitter_col
                     Coordinate.new row: position.row, col: next_splitter_col + position.col + 2
                   else
                     Coordinate.new row: position.row, col: counts.index(1)
                   end
      end
      object = tachyon_diagram.object_at position
    end
    beam_splits
  end

  def total_timelines
    counts = Array.new(diagram.first.length, 0)
    counts[diagram.first.index(start)] = 1
    tachyon_diagram = TachyonManifoldDiagram.new diagram
    position = start_position.below
    object = tachyon_diagram.object_at position
    while object
      case object
      when empty
        position = Coordinate.new row: position.row + 1, col: counts.index(1)
      when splitter
        if counts[position.col].positive?
          counts[position.col - 1] += counts[position.col]
          counts[position.col.next] += counts[position.col]
          counts[position.col] = 0
        end
        next_splitter_col = diagram[position.row][(position.col + 2)..].index(splitter)
        position = if next_splitter_col
                     Coordinate.new row: position.row, col: next_splitter_col + position.col + 2
                   else
                     Coordinate.new row: position.row, col: counts.index(1)
                   end
      end
      object = tachyon_diagram.object_at position
    end
    counts.sum
  end

  private

  def start_position
    Coordinate.new row: 0, col: diagram.first.index(start)
  end
end
