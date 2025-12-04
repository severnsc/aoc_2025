require "test_helper"

class Grid::AccessibleRollsOfPaperTest < Minitest::Test
  def setup
    @grid = Grid.new empty_space: ".", roll_of_paper: "@", max_adjacent_rolls_of_paper: 3
  end

  def test_no_accessbile_rolls_of_paper
    @grid.rows = []

    assert_empty @grid.accessible_rows_of_paper
  end

  def test_one_accessible_roll_of_paper
    @grid.rows = [["@"]]

    assert_equal [Coordinate.new(row: 0, col: 0)], @grid.accessible_rows_of_paper
  end

  def test_many_accessible_rolls_of_paper_in_same_row
    @grid.rows = [["@", "@"]]

    assert_equal [Coordinate.new(row: 0, col: 0), Coordinate.new(row: 0, col: 1)], @grid.accessible_rows_of_paper
  end

  def test_inaccessible_roll_of_paper
    @grid.max_adjacent_rolls_of_paper = 0
    @grid.rows = [["@", "@"]]

    assert_empty @grid.accessible_rows_of_paper
  end

  def test_aoc_example
    rows = [
      %w[. . @ @ . @ @ @ @ .],
      %w[@ @ @ . @ . @ . @ @],
      %w[@ @ @ @ @ . @ . @ @],
      %w[@ . @ @ @ @ . . @ .],
      %w[@ @ . @ @ @ @ . @ @],
      %w[. @ @ @ @ @ @ @ . @],
      %w[. @ . @ . @ . @ @ @],
      %w[@ . @ @ @ . @ @ @ @],
      %w[. @ @ @ @ @ @ @ @ .],
      %w[@ . @ . @ @ @ . @ .]
    ]
    @grid.rows = rows

    assert_equal 13, @grid.accessible_rows_of_paper.count
  end
end
