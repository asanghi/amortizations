# frozen_string_literal: true

require "test_helper"

class BulletTest < Test::Unit::TestCase
  def test_bullet_amortization
    amortization = Amortizations::Bullet.new(
      finance_amount: 100000,
      tenure: 60,
      interest_rate: 0.05,
      bullet_payments: [
        { month: 12, amount: 10000 },
        { month: 24, amount: 20000 },
      ]
    )
    schedule = amortization.generate_schedule

    assert_equal 60, schedule.length
    assert_in_delta 100000, schedule.map { |payment| payment[:principal] }.sum, 0.01
    assert_in_delta 416.67, schedule.first[:payment], 0.01
    assert_in_delta 416.67, schedule.first[:interest], 0.01
    assert_equal 0, schedule.first[:principal]
    assert_in_delta 10416.67, schedule[12][:payment], 0.01
    assert_in_delta 416.67, schedule[12][:interest], 0.01
    assert_in_delta 10000, schedule[12][:principal], 0.01
    assert_in_delta 20416.67, schedule[24][:payment], 0.01
    assert_in_delta 416.67, schedule[24][:interest], 0.01
    assert_in_delta 20000, schedule[24][:principal], 0.01
  end
end