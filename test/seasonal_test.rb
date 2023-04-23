# frozen_string_literal: true

require "test_helper"

class SeasonalTest < Test::Unit::TestCase
  def setup
    @schedule_generator = Amortizations::Seasonal.new(finance_amount: 100_000, 
                                                      interest_rate: 12, 
                                                      tenure: 12, 
                                                      balloon_payment: 10_000, 
                                                      balloon_period: 10, 
                                                      interest_only_period: 2, 
                                                      seasonal_payments: [20_000, 10_000, 15_000, 5_000, 10_000, 30_000, 10_000, 10_000, 15_000, 5_000, 10_000, 20_000])
    @schedule = @schedule_generator.generate_schedule
  end

  def test_monthly_payment_amount
    assert_in_delta(16_464.95484457897, @schedule[0][:payment], 0.001)
  end

  def test_total_interest_paid
    assert_in_delta(31_759.45, @schedule.sum { |cf| cf[:interest] }, 0.01)
  end

  def test_total_payments
    assert_in_delta(197_579.45, @schedule.sum { |cf| cf[:payment] }, 0.01)
  end

  def test_balloon_payment
    assert_in_delta(10_000, @schedule[10][:payment], 0.01)
  end

  def test_balloon_period_balance
    assert_in_delta(25_937.05, @schedule[10][:balance], 0.01)
  end

  def test_interest_only_period_balance
    assert_in_delta(83_670.85, @schedule[1][:balance], 0.01)
    assert_in_delta(67_373.39, @schedule[2][:balance], 0.01)
  end

  def test_schedule_length
    assert_equal(12, @schedule.length)
  end
end