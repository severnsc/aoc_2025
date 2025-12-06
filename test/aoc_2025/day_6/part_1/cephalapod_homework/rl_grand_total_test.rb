require "test_helper"

class CephalapodHomework::RlGrandTotalTest < Minitest::Test
  def setup
    @homework = CephalapodHomework.new
  end

  def test_empty_returns_zero
    @homework.numbers = []
    @homework.operators = ""

    assert @homework.rl_grand_total.zero?
  end

  def test_single_line_addition
    @homework.numbers = ["11"]
    @homework.operators = "+"

    assert_equal 2, @homework.rl_grand_total
  end

  def test_single_line_multiplication
    @homework.numbers = ["21"]
    @homework.operators = "*"

    assert_equal 2, @homework.rl_grand_total
  end

  def test_multiline_addition
    @homework.numbers = ["11 11"]
    @homework.operators = "+ +"

    assert_equal 4, @homework.rl_grand_total
  end

  def test_multiline_multiplication
    @homework.numbers = ["23 11"]
    @homework.operators = "*  *"

    assert_equal 7, @homework.rl_grand_total
  end

  def test_mixed_operators
    @homework.numbers = ["43 21"]
    @homework.operators = "+  *"

    assert_equal 9, @homework.rl_grand_total
  end

  def test_aoc_example
    @homework.numbers = ["123 328  51 64 ",
                         " 45 64  387 23 ",
                         "  6 98  215 314"]
    @homework.operators = "*   +   *   + "

    assert_equal 3_263_827, @homework.rl_grand_total
  end
end
