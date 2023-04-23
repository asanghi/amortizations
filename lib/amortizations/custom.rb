module Amortizations
  class Custom < Base

    attr_accessor :schedule

    def generate_schedule
      balance = finance_amount
      schedule.map.with_index do |payment, index|
        interest = balance * interest_rate / 12.0
        principal = payment - interest
        balance -= principal
        {
          month: index + 1,
          payment: payment,
          interest: interest,
          principal: principal,
          balance: balance
        }
      end
    end
  end
end