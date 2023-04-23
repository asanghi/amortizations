# frozen_string_literal: true

require "test_helper"

class BalloonTest < Test::Unit::TestCase
  def test_balloon_schedule
    loan = Amortizations::Balloon.new(finance_amount: 100000, 
                                      interest_rate: 0.1, 
                                      tenure: 36, 
                                      balloon_payment: 50000, 
                                      balloon_period: 12)
    schedule = loan.generate_schedule

    assert_equal(36, schedule.size)
    assert_in_delta(2307.25, schedule.first[:payment], 0.01)
    assert_in_delta(2307.25, schedule.last[:payment], 0.01)

    assert_in_delta(833.33, schedule.first[:interest], 0.01)
    assert_in_delta(1473.91, schedule.first[:principal], 0.01)

    assert_in_delta(-151.44, schedule.last[:interest], 0.01)
    assert_in_delta(2458.69, schedule.last[:principal], 0.01)

    assert_in_delta(31062.78, schedule[12][:balance], 0.01)
  end
end