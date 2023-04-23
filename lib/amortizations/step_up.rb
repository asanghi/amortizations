module Amortizations
  class StepUp < Base
    attr_accessor :steps

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest_rate = interest_rate / 12.0
      monthly_payment = calculate_monthly_payment(balance, monthly_interest_rate)

      (1..tenure).each do |month|
        interest = balance * monthly_interest_rate
        if steps[month]
          monthly_payment = calculate_monthly_payment(balance, steps[month] / 12.0)
        end

        principal = monthly_payment - interest
        balance -= principal

        schedule << {
          month: month,
          payment: monthly_payment,
          interest: interest,
          principal: principal,
          balance: balance
        }
      end

      schedule
    end

    private

    def calculate_monthly_payment(balance, monthly_interest_rate)
      (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** tenure)) / (((1 + monthly_interest_rate) ** tenure) - 1)
    end
  end
end