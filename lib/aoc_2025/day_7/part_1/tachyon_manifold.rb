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
    traversed_diagram = traverse_diagram(TachyonManifoldDiagram.new(diagram), start_position)
    traversed_diagram.coordinates_for(splitter).filter do |coordinate|
      [beam, start].include? traversed_diagram.object_at(coordinate.above)
    end.count
  end

  private

  def start_position
    Coordinate.new row: 0, col: diagram.first.index(start)
  end

  def traverse_diagram(diagram, position)
    next_position = position.below
    next_position_object = diagram.object_at next_position
    case next_position_object
    when empty
      traverse_diagram diagram.transform_via([[next_position, beam]]), next_position
    when splitter
      traverse_diagram(
        traverse_diagram(diagram.transform_via([[next_position.left, beam], [next_position.right, beam]]),
                         next_position.left), next_position.right
      )
    else
      diagram
    end
  end
end
