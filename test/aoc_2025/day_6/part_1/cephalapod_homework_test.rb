require "test_helper"

class CephalapodHomeworkTest < Minitest::Test
  def test_sets_numbers
    homework = CephalapodHomework.new numbers: %w[1 2 3]

    assert_equal %w[1 2 3], homework.numbers
  end

  def test_sets_operators
    homework = CephalapodHomework.new operators: %w[* +]

    assert_equal %w[* +], homework.operators
  end
end
