module Amortizations
  class ARM < Base

    attr_accessor :initial_interest_rate, :initial_fixed_period
    attr_accessor :annual_rate_adjustment, :adjustment_period
    attr_accessor :rate_cap_structure, :index_rate_changes

    def generate_schedule
      num_payments = tenure * 12

      # Assuming a fixed interest rate for an initial period and then annual adjustments
      initial_fixed_period = initial_fixed_period.to_i
      annual_rate_adjustment = annual_rate_adjustment.to_f / 100

      schedule = []

      remaining_balance = finance_amount
      (1..num_payments).each do |payment|
        current_year = ((payment - 1) / 12).floor
        current_interest_rate = interest_rate + (current_year > initial_fixed_period ? (current_year - initial_fixed_period) * annual_rate_adjustment : 0)
        monthly_interest_rate = (current_interest_rate / 100) / 12

        interest_payment = remaining_balance * monthly_interest_rate
        principal_payment = monthly_payment - interest_payment
        remaining_balance -= principal_payment

        schedule << {
          payment: payment,
          principal_payment: principal_payment,
          interest_payment: interest_payment,
          remaining_balance: remaining_balance,
          current_interest_rate: current_interest_rate
        }
      end

      @schedule = schedule
      schedule
    end

    def calculate_irr
      cash_flows = []
      cash_flows << { amount: -finance_amount, date: Date.today }

      schedule.each_with_index do |payment, index|
        cash_flows << {
          amount: payment[:principal_payment] + payment[:interest_payment],
          date: Date.today + (index + 1).months
        }
      end

      xirr = Xirr.new(cash_flows)
      xirr.rate * 100
    end

  end
end