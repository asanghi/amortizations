# frozen_string_literal: true

require "test_helper"

class GraduatedPaymentTest < Test::Unit::TestCase
  def test_graduated_payment_amortization
    amortization = Amortizations::GraduatedPayment.new(
      finance_amount: 100000,
      tenure: 360,
      interest_rate: 0.05,
      graduation_period: 60,
      graduation_frequency: 12,
      graduation_rate: 0.02
    )
    schedule = amortization.generate_schedule

    assert_equal 360, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.01
    assert_in_delta 500, schedule.first[:payment], 0.01
    assert_in_delta 240.31, schedule.first[:interest], 0.01
    assert_in_delta 259.69, schedule.first[:principal], 0.01
    assert_in_delta 530.65, schedule[12][:payment], 0.01
    assert_in_delta 223.57, schedule[12][:interest], 0.01
    assert_in_delta 307.08, schedule[12][:principal], 0.01
  end
end
