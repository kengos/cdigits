# frozen_string_literal: true

require 'securerandom'

module Cdigits
  class Store
    # @return [Array<Integer>]
    attr_reader :histories
    # @return [Integer]
    attr_reader :position

    def initialize(modulus)
      @modulus = modulus
      @histories = []
      @position = nil
    end

    def initialize_check_digit
      @position = @histories.size
      append 0
    end

    def check_digit
      @histories[@position]
    end

    def check_digit=(value)
      @histories[@position] = value
    end

    def append_non_zero_number
      append random_number(@modulus - 2) + 1
    end

    def append_number
      append random_number(@modulus - 1)
    end

    def append(value)
      @histories << value
      value
    end

    private

    def random_number(num)
      ::SecureRandom.random_number(num)
    end
  end
end
