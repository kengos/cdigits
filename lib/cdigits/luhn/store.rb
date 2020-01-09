# frozen_string_literal: true

require 'securerandom'

module Cdigits
  module Luhn
    class Store
      # @return [Array<Integer>]
      attr_reader :digits

      # @param [Integer] modulus
      # @param [Array<Integer>] digits initial digits (default [])
      def initialize(modulus:, digits: nil)
        @modulus = modulus
        @digits = digits || []
        @position = nil
      end

      # Set check digit position
      def initialize_check_digit
        @position = @digits.size
        append 0
      end

      # Calculate check digit and fill its value into the check digit position
      # @return [Integer] check digit
      def fill_check_digit
        return unless @position

        odd = (@digits.size - @position).odd?
        @digits[@position] = calculate_check_digit(sum, odd)
      end

      # Append random non-zero number to digits array
      # @return [Integer] appended value
      def append_non_zero_number
        append random_number(@modulus - 1) + 1
      end

      # Append random number to digits array
      # @return [Integer] appended value
      def append_number
        append random_number(@modulus)
      end

      # Append passed value to digits array
      # @param [Integer] value
      # @return [Integer] appended value
      def append(value)
        @digits << value
        value
      end

      # sum of digits
      # @return [Integer]
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
      #   double(12) # => 9
      def double(num)
        num *= 2
        (num / @modulus).to_i + (num % @modulus)
      end
    end
  end
end
