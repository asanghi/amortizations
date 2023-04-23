# frozen_string_literal: true

require "test_helper"

class NegativeTest < Test::Unit::TestCase
  def test_negative_amortization
    amortization = Amortizations::Negative.new(
      finance_amount: 100000,
      tenure: 360,
      interest_rate: 0.05,
      minimum_payment: 400
    )
    schedule = amortization.generate_schedule

    assert_equal 360, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.01
    assert_in_delta 400, schedule.first[:payment], 0.01
    assert_in_delta 416.67, schedule.first[:interest], 0.01
    assert_in_delta(-16.67, schedule.first[:principal], 0.01)
    assert_in_delta 400, schedule[12][:payment], 0.01
    assert_in_delta 429.38, schedule[12][:interest], 0.01
    assert_in_delta(-29.38, schedule[12][:principal], 0.01)
    assert_in_delta 400, schedule[24][:payment], 0.01
    assert_in_delta 443.04, schedule[24][:interest], 0.01
    assert_in_delta(-43.04, schedule[24][:principal], 0.01)
  end
end