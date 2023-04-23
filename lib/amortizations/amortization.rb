module Amortizations
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :finance_amount, :interest_rate, :tenure

    validates :finance_amount, :interest_rate, :tenure, presence: true
    validates :finance_amount, :interest_rate, numericality: { greater_than: 0 }
    validates :tenure, numericality: { only_integer: true, greater_than: 0 }

    def generate_schedule
      raise NotImplementedError, 'generate_schedule must be implemented in a subclass'
    end
  end
end