require "test_helper"

class GridTest < Minitest::Test
  def test_sets_rows
    grid = Grid.new rows: [["."], ["."]]

    assert_equal [["."], ["."]], grid.rows
  end

  def test_sets_empty_space
    grid = Grid.new empty_space: "."

    assert_equal ".", grid.empty_space
  end

  def test_sets_roll_of_paper
    grid = Grid.new roll_of_paper: "@"

    assert_equal "@", grid.roll_of_paper
  end

  def test_sets_max_adjacent_rolls_of_paper
    grid = Grid.new max_adjacent_rolls_of_paper: 3

    assert_equal 3, grid.max_adjacent_rolls_of_paper
  end

  def test_sets_removed_roll_of_paper
    grid = Grid.new removed_roll_of_paper: "x"

    assert_equal "x", grid.removed_roll_of_paper
  end
end
