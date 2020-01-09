# frozen_string_literal: true

require 'securerandom'

module Cdigits
  module Luhn
    class Store
      # @return [Array<Integer>]
      attr_reader :digits

      def initialize(modulus:, digits: nil)
        @modulus = modulus
        @digits = digits || []
        @position = nil
      end

      def initialize_check_digit
        @position = @digits.size
        append 0
      end

      def fill_check_digit
        return unless @position

        odd = (@digits.size - @position).odd?
        @digits[@position] = calculate_check_digit(sum, odd)
      end

      def append_non_zero_number
        append random_number(@modulus - 1) + 1
      end

      def append_number
        append random_number(@modulus)
      end

      def append(value)
        @digits << value
        value
      end

      def sum
        digits.reverse.each_with_index.inject(0) do |sum, (value, i)|
          value = double(value) if (i + 1).even?
          sum + value
        end
      end

      private

      def random_number(num)
        ::SecureRandom.random_number(num)
      end

      def calculate_check_digit(value, odd)
        mod = value % @modulus
        return 0 if mod.zero?

        check_digit = @modulus - mod
        return check_digit if odd

        check_digit += @modulus - 1 if check_digit.odd?
        check_digit / 2
      end

      # @example
      #   # num = 6, modulus = 10
      #   # (12 / 10) + (12 % 10) = 3
      #   double(6) # => 3
      # @example
      #   # num = 12, modulus = 16
      #   # (24 / 16) + (24 % 16) = 9
      def double(num)
        num *= 2
        (num / @modulus).to_i + (num % @modulus)
      end
    end
  end
end
