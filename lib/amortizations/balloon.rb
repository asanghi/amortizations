module Amortizations
  class Balloon < Base
    attr_accessor :balloon_payment, :balloon_period

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest_rate = interest_rate / 12.0
      monthly_payment = calculate_monthly_payment(balance, monthly_interest_rate, balloon_payment, balloon_period)

      (1..tenure).each do |month|
        interest = balance * monthly_interest_rate
        if month == balloon_period
          principal = balance
          balance -= balloon_payment
          payment = balloon_payment
        elsif month > balloon_period && balance > 0
          principal = monthly_payment - interest
          balance -= principal
          payment = month == tenure ? balance + principal : monthly_payment
        else
          principal = monthly_payment - interest
          balance -= principal
          payment = monthly_payment
        end

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

    def calculate_monthly_payment(balance, monthly_interest_rate, balloon_payment, balloon_period)
      if balloon_period > 0
        (balance - balloon_payment) * (monthly_interest_rate * (1 + monthly_interest_rate) ** (tenure - balloon_period)) / (((1 + monthly_interest_rate) ** (tenure - balloon_period)) - 1)
      else
        (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** tenure)) / (((1 + monthly_interest_rate) ** tenure) - 1)
      end
    end
  end
end
