# frozen_string_literal: true

require "test_helper"

class CustomTest < Test::Unit::TestCase
  def setup
    @schedule = [1000, 1500, 2000, 2500, 3000]
    @finance_amount = 10000
    @interest_rate = 0.1
    @tenure = 60
    @schedule_type = "custom"
    @loan = AmortizationFactory.get_amortization_schedule(
      @schedule_type, @finance_amount, @interest_rate, @tenure, schedule: @schedule
    )
  end

  def test_generate_schedule
    result = @loan.generate_schedule
    assert_equal(60, result.size)
    assert_in_delta(166.67, result.first[:payment], 0.01)
    assert_in_delta(3000, result.last[:balance], 0.01)
  end
end