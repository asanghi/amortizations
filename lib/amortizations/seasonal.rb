module Amortizations
  class Seasonal < Base
    attr_accessor :seasonal_period, :seasonal_emi, :non_seasonal_emi, :seasonal_months

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest_rate = interest_rate / 12.0
      current_month = 1

      while balance > 0
        monthly_payment = calculate_monthly_payment(balance, monthly_interest_rate, current_month)

        interest = balance * monthly_interest_rate

        if seasonal_months.include?(current_month)
          principal = seasonal_emi - interest
          balance -= principal
          payment = seasonal_emi
        else
          principal = non_seasonal_emi - interest
          balance -= principal
          payment = non_seasonal_emi
        end

        schedule << {
          month: current_month,
          payment: payment,
          interest: interest,
          principal: principal,
          balance: balance
        }

        current_month += 1
      end

      schedule
    end

    private

    def calculate_monthly_payment(balance, monthly_interest_rate, current_month)
      if seasonal_months.include?(current_month)
        (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** seasonal_period)) / (((1 + monthly_interest_rate) ** seasonal_period) - 1)
      else
        (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** (tenure - seasonal_period))) / (((1 + monthly_interest_rate) ** (tenure - seasonal_period)) - 1)
      end
    end
  end
end
