class Grid
  include ActiveModel::Model

  NEIGHBOR_COUNT = 8

  attr_reader :accessible_rows_of_paper, :rows
  attr_accessor :empty_space, :roll_of_paper, :max_adjacent_rolls_of_paper

  def initialize(attrs)
    @rows = attrs[:rows] || []
    super attrs.reject { |key, _| key == "rows" }
    set_rolls_of_paper
    set_accessible_rows_of_paper
  end

  def rows=(rows)
    @rows = rows
    set_rolls_of_paper
    set_accessible_rows_of_paper
  end

  private

  attr_accessor :rolls_of_paper
  attr_writer :accessible_rows_of_paper

  def accessible?(roll)
    empty_space_count = rolls_of_paper_count = 0
    neighbors = roll.neighbors.each
    until empty_space_count == minimum_empty_spaces_for_access || rolls_of_paper_count == too_many_rolls_of_paper
      neighbor = neighbors.next
      rolls_of_paper.include?(neighbor) ? (rolls_of_paper_count += 1) : (empty_space_count += 1)
    end
    rolls_of_paper_count < too_many_rolls_of_paper
  end

  def minimum_empty_spaces_for_access
    NEIGHBOR_COUNT - max_adjacent_rolls_of_paper
  end

  def set_accessible_rows_of_paper
    self.accessible_rows_of_paper = rolls_of_paper.filter { |roll| accessible? roll }
  end

  def set_rolls_of_paper
    self.rolls_of_paper = Set[]
    rows.each_with_index do |row, row_index|
      row.each_with_index do |space, space_index|
        rolls_of_paper << Coordinate.new(row: row_index, col: space_index) if space == roll_of_paper
      end
    end
  end

  def too_many_rolls_of_paper
    max_adjacent_rolls_of_paper.next
  end
end
