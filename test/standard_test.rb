# frozen_string_literal: true

require "test_helper"

class StandardTest < Test::Unit::TestCase

  def test_standard_amortization
    amortization = Amortizations::Standard.new(
      finance_amount: 100000,
      tenure: 360,
      interest_rate: 0.05
    )
    schedule = amortization.generate_schedule

    assert_equal 360, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.01
    assert_in_delta 536.82, schedule.first[:payment], 0.01
    assert_in_delta 416.66, schedule.first[:interest], 0.01
    assert_in_delta 120.15, schedule.first[:principal], 0.01
    assert_in_delta 2.22, schedule.last[:interest], 0.01
    assert_in_delta 534.59, schedule.last[:principal], 0.01
  end
end