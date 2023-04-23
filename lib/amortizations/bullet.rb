module Amortizations
  class Bullet < Base
    attr_accessor :bullet_payment, :bullet_period

    def generate_schedule
      schedule = []
      balance = finance_amount
      monthly_interest_rate = interest_rate / 12.0
      monthly_payment = calculate_monthly_payment(balance, monthly_interest_rate, bullet_payment, bullet_period)

      (1..tenure).each do |month|
        interest = balance * monthly_interest_rate
        if month == bullet_period
          principal = balance
          balance = 0
          payment = bullet_payment
        else
          principal = 0
          balance -= principal
          payment = month == tenure ? balance + interest : monthly_payment
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

    def calculate_monthly_payment(balance, monthly_interest_rate, bullet_payment, bullet_period)
      if bullet_period > 0
        (balance - bullet_payment) * (monthly_interest_rate * (1 + monthly_interest_rate) ** (tenure - bullet_period)) / (((1 + monthly_interest_rate) ** (tenure - bullet_period)) - 1)
      else
        (balance * (monthly_interest_rate * (1 + monthly_interest_rate) ** tenure)) / (((1 + monthly_interest_rate) ** tenure) - 1)
      end
    end  
  end
end