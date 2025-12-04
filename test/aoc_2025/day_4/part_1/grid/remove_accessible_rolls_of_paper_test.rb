require "test_helper"

class Grid::RemoveAccessibleRollsOfPaperTest < Minitest::Test
  def setup
    @grid = Grid.new roll_of_paper: "@", empty_space: ".", removed_roll_of_paper: "x", max_adjacent_rolls_of_paper: 3
  end

  def test_returns_grid
    assert_instance_of Grid, @grid.remove_accessible_rolls_of_paper
  end

  def test_copies_non_row_attributes
    grid = @grid.remove_accessible_rolls_of_paper
    assert_equal @grid.roll_of_paper, grid.roll_of_paper
    assert_equal @grid.empty_space, grid.empty_space
    assert_equal @grid.removed_roll_of_paper, grid.removed_roll_of_paper
    assert_equal @grid.max_adjacent_rolls_of_paper, grid.max_adjacent_rolls_of_paper
  end

  def test_replaces_accessible_roll_with_removed_roll_of_paper
    @grid.rows = [["@"]]

    assert_equal [["x"]], @grid.remove_accessible_rolls_of_paper.rows
  end

  def test_aoc_part_one_example
    @grid.rows = [
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
    new_grid = @grid.remove_accessible_rolls_of_paper
    grid_string = new_grid.rows.map(&:join).join

    assert_equal 13, grid_string.count(new_grid.removed_roll_of_paper)
  end
end
