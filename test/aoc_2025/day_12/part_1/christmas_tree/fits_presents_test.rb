require "test_helper"

class ChristmasTree::FitsPresentsTest < Minitest::Test
  def setup
    @christmas_tree = ChristmasTree.new
  end

  def test_one_by_one
    @christmas_tree.dimensions = { width: 1, length: 1 }
    @christmas_tree.present_shapes = [["#"]]

    assert @christmas_tree.fits_presents? [1]
  end

  def test_too_large
    @christmas_tree.dimensions = { width: 1, length: 1 }
    @christmas_tree.present_shapes = [["##"]]

    refute @christmas_tree.fits_presents? [1]
  end

  def test_not_fitting_together
    @christmas_tree.dimensions = { width: 4, length: 4 }
    @christmas_tree.present_shapes = [["###", "#..", "###"], ["##", "##"]]

    refute @christmas_tree.fits_presents? [1, 1]
  end
end
