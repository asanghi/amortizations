module Amortizations
  class Negative < Base

    attr_accessor :minimum_payment

    def generate_schedule
      schedule = []
      @schedule = schedule
      schedule
    end
  end
end