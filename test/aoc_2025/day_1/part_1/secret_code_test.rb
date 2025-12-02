require "test_helper"

class SecretCodeTest < Minitest::Test
  def test_sets_safe
    safe = Safe.new
    secret_code = SecretCode.new(safe:)

    assert_equal safe, secret_code.safe
  end

  def test_sets_secret_number
    secret_code = SecretCode.new secret_number: 0

    assert_equal 0, secret_code.secret_number
  end
end
