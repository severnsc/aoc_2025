require "test_helper"

class DAG::PathsBetweenTest < Minitest::Test
  def setup
    @dag = DAG.new
  end

  def test_one_edge
    @dag.edges = [%i[a b]]

    assert_equal 1, @dag.paths_between(:a, :b)
  end

  def test_two_paths
    @dag.edges = [%i[a b], %i[b d], %i[a c], %i[c d]]

    assert_equal 2, @dag.paths_between(:a, :d)
  end

  def test_two_paths_with_one_edge_to_destination
    @dag.edges = [%i[a b], %i[a c], %i[b d], %i[c d], %i[d e]]

    assert_equal 2, @dag.paths_between(:a, :e)
  end

  def test_starting_from_middle
    @dag.edges = [%i[a b], %i[b d], %i[a c], %i[c d]]

    assert_equal 1, @dag.paths_between(:c, :d)
  end

  def test_aoc_input
    @dag.edges = aoc_input

    assert_equal 5, @dag.paths_between(:you, :out)
  end

  private

  def aoc_input
    [
      %i[aaa you],
      %i[aaa hhh],
      %i[you bbb],
      %i[you ccc],
      %i[bbb ddd],
      %i[bbb eee],
      %i[ccc ddd],
      %i[ccc eee],
      %i[ccc fff],
      %i[ddd ggg],
      %i[eee out],
      %i[fff out],
      %i[ggg out],
      %i[hhh ccc],
      %i[hhh fff],
      %i[hhh iii],
      %i[iii out]
    ]
  end
end
