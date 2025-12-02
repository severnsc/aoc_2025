require "test_helper"

class SafeTest < Minitest::Test
  def test_sets_dial_range
    safe = Safe.new dial_range: 0..99

    assert_equal 0..99, safe.dial_range
  end

  def test_sets_dial_pointing_at
    safe = Safe.new dial_pointing_at: 50

    assert_equal 50, safe.dial_pointing_at
  end
end
