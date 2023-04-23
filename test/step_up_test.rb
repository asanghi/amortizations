# frozen_string_literal: true

require "test_helper"

class StepUpTest < Test::Unit::TestCase
  def test_generate_schedule
    loan = Amortizations::StepUp.new(
      finance_amount: 100_000,
      tenure: 24,
      interest_rate: 12,
      periods: [4, 4, 4, 4, 4, 4],
      increases: [1000, 2000, 3000, 4000, 5000, 6000]
    )
    schedule = loan.generate_schedule

    assert_equal(1000.0, schedule[0][:payment].round(2))
    assert_equal(2078.33, schedule[5][:payment].round(2))
    assert_equal(3088.44, schedule[11][:payment].round(2))
    assert_equal(5010.85, schedule[23][:payment].round(2))
  end
end