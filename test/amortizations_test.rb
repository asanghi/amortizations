# frozen_string_literal: true

require "test_helper"

class AmortizationsTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Amortizations.const_defined?(:VERSION)
    end
  end
end
