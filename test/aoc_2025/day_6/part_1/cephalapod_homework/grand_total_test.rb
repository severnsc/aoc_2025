require "test_helper"

class CephalapodHomework::GrandTotalTest < Minitest::Test
  def setup
    @homework = CephalapodHomework.new
  end

  def test_empty_returns_zero
    @homework.numbers = []
    @homework.operators = ""

    assert @homework.grand_total.zero?
  end

  def test_single_line_addition
    @homework.numbers = %w[1 1]
    @homework.operators = "+"

    assert_equal 2, @homework.grand_total
  end

  def test_single_line_multiplication
    @homework.numbers = %w[2 1]
    @homework.operators = "*"

    assert_equal 2, @homework.grand_total
  end

  def test_multiline_addition
    @homework.numbers = ["1 1", "1   1"]
    @homework.operators = "+ +"

    assert_equal 4, @homework.grand_total
  end

  def test_multiline_multiplication
    @homework.numbers = ["2 1", "3   1"]
    @homework.operators = "*  *"

    assert_equal 7, @homework.grand_total
  end

  def test_mixed_operators
    @homework.numbers = ["4   3", "2  1"]
    @homework.operators = "+  *"

    assert_equal 9, @homework.grand_total
  end

  def test_aoc_example
    @homework.numbers = ["123 328  51 64",
                         "45 64  387 23",
                         "6 98  215 314"]
    @homework.operators = "*   +   *   + "

    assert_equal 4_277_556, @homework.grand_total
  end
end
