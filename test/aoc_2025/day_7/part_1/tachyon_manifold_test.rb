require "test_helper"

class TachyonManifoldTest < Minitest::Test
  def test_sets_diagram
    manifold = TachyonManifold.new diagram: ["S", "."]

    assert_equal ["S", "."], manifold.diagram
  end

  def test_sets_start
    manifold = TachyonManifold.new start: "S"

    assert_equal "S", manifold.start
  end

  def test_sets_empty
    manifold = TachyonManifold.new empty: "."

    assert_equal ".", manifold.empty
  end

  def test_sets_beam
    manifold = TachyonManifold.new beam: "|"

    assert_equal "|", manifold.beam
  end

  def test_sets_splitter
    manifold = TachyonManifold.new splitter: "^"

    assert_equal "^", manifold.splitter
  end
end
