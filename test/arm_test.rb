# frozen_string_literal: true

require "test_helper"

class ARMTest < Test::Unit::TestCase
  def test_arm_amortization
    amortization = Amortizations::ARM.new(
      finance_amount: 100000,
      tenure: 360,
      initial_interest_rate: 0.045,
      adjustment_period: 12,
      rate_cap_structure: {
        lifetime_cap: 0.06,
        periodic_cap: 0.02,
        floor_rate: 0.03
      },
      index_rate_changes: [
        { month: 12, new_rate: 0.05 },
        { month: 24, new_rate: 0.03 },
      ]
    )
    schedule = amortization.generate_schedule

    assert_equal 360, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.01
    assert_in_delta 516.31, schedule.first[:payment], 0.01
    assert_in_delta 231.58, schedule.first[:interest], 0.01
    assert_in_delta 284.73, schedule.first[:principal], 0.01
    assert_in_delta 545.20, schedule[12][:payment], 0.01
    assert_in_delta 216.67, schedule[12][:interest], 0.01
    assert_in_delta 328.53, schedule[12][:principal], 0.01
    assert_in_delta 491.91, schedule[24][:payment], 0.01
    assert_in_delta 202.78, schedule[24][:interest], 0.01
    assert_in_delta 289.13, schedule[24][:principal], 0.01
  end
end