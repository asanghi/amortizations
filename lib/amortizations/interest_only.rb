module Amortizations
  class InterestOnly < Base

    attr_accessor :interest_only_period

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest = balance * interest_rate / 12.0

      (1..tenure).each do |month|
        if month <= interest_only_period
          payment = monthly_interest
        else
          payment = calculate_monthly_payment(balance, interest_rate)
        end

        interest = balance * interest_rate / 12.0
        principal = payment - interest
        balance -= principal

        schedule << {
          month: month,
          payment: payment,
          interest: interest,
          principal: principal,
          balance: balance
        }
      end

      schedule
    end

    private

    def calculate_monthly_payment(balance, monthly_interest_rate)
      (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** tenure)) /
        (((1 + monthly_interest_rate) ** tenure) - 1)
    end
  end
end