# frozen_string_literal: true

require 'active_model'
require 'xirr'

require_relative "amortizations/version"
require_relative 'amortizations/amortization'
require_relative 'amortizations/standard'
require_relative 'amortizations/interest_only'
require_relative 'amortizations/balloon'
require_relative 'amortizations/graduated_payment'
require_relative 'amortizations/step_up'
require_relative 'amortizations/arm'
require_relative 'amortizations/bullet'
require_relative 'amortizations/negative'
require_relative 'amortizations/seasonal'
require_relative 'amortizations/custom'

module Amortizations
  class Error < StandardError; end
  # Your code goes here...
end
