module Amortizations
  class GraduatedPayment < Base
    attr_accessor :graduated_payment_amounts, :graduated_payment_periods

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest_rate = interest_rate / 12.0
      monthly_payments = calculate_monthly_payments(graduated_payment_amounts, graduated_payment_periods)

      (1..tenure).each do |month|
        interest = balance * monthly_interest_rate
        principal = monthly_payments[month - 1] - interest
        balance -= principal

        schedule << {
          month: month,
          payment: monthly_payments[month - 1],
          interest: interest,
          principal: principal,
          balance: balance
        }
      end

      schedule
    end

    private

    def calculate_monthly_payments(amounts, periods)
      payments = []
      remaining_amounts = amounts.dup
      remaining_periods = periods.dup

      (1..tenure).each do |month|
        if remaining_periods.first && month == remaining_periods.first
          payments << remaining_amounts.first
          remaining_periods.shift
          remaining_amounts.shift
        else
          payments << calculate_monthly_payment(finance_amount, interest_rate, remaining_periods.count - 1)
        end
      end

      payments
    end

    def calculate_monthly_payment(balance, monthly_interest_rate, remaining_months)
      (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** remaining_months)) / (((1 + monthly_interest_rate) ** remaining_months) - 1)
    end
  end
end