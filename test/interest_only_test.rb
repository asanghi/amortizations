# frozen_string_literal: true

require "test_helper"

class InterestOnlyTest < Test::Unit::TestCase
  def test_interest_only_amortization
    amortization = Amortizations::InterestOnly.new(
      finance_amount: 100000,
      tenure: 360,
      interest_rate: 0.05,
      interest_only_period: 60
    )
    schedule = amortization.generate_schedule

    assert_equal 360, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.1
    assert_in_delta 416.67, schedule.first[:payment], 0.01
    assert_in_delta 416.67, schedule.first[:interest], 0.01
    assert_equal 0, schedule.first[:principal]
    assert_in_delta 4770.83, schedule[61][:payment], 0.01
    assert_in_delta 397.57, schedule[61][:interest], 0.01
    assert_in_delta 4373.26, schedule[61][:principal], 0.01
  end
end