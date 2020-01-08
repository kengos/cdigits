# frozen_string_literal: true

module Cdigits
  module Luhn
    class Placeholder
      DEFAULT_PLACEHOLDER = '+########?'
      NON_ZERO_SYMBOL = '+'
      NUMERIC_SYMBOL = '#'
      CHECK_DIGIT_SYMBOL = '?' # any good idia?

      def initialize(placeholder: nil, modulus: nil)
        @placeholder = placeholder || DEFAULT_PLACEHOLDER
        @modulus = modulus || 10 # TODO: support modulus > 10
      end

      def call
        # TODO: validate placeholder string
        chars = []
        @placeholder.chars.each do |char|
          digit = generate_digit(char)
          chars << (digit.nil? ? char : nil)
        end

        fill_check_digit
        generate_identifier(chars, store.histories)
      end

      private

      def store
        @store ||= ::Cdigits::Store.new(@modulus)
      end

      def generate_identifier(chars, digits)
        chars.map do |char|
          char || digits.shift.to_s
        end.join
      end

      def generate_digit(char)
        case char
        when NON_ZERO_SYMBOL
          store.append_non_zero_number
        when NUMERIC_SYMBOL
          store.append_number
        when CHECK_DIGIT_SYMBOL
          store.initialize_check_digit
        when /\d/
          store.append(char.to_i)
        end
      end

      def fill_check_digit
        sum = calculate_sum(store.histories)
        pos = store.histories.size - store.position # reversed position that starts with 1
        store.check_digit = calculate_check_digit(sum, pos.odd?)
      end

      def calculate_check_digit(sum, odd)
        mod = sum % @modulus
        return 0 if mod.zero?

        check_digit = @modulus - mod
        return check_digit if odd

        check_digit += @modulus - 1 if check_digit.odd?
        check_digit / 2
      end

      def calculate_sum(digits)
        sum = 0
        digits.reverse.each_with_index do |digit, i|
          if (i + 1).even?
            digit *= 2
            digit = (digit / @modulus).to_i + (digit % @modulus) if digit >= @modulus
          end
          sum += digit
        end
        sum
      end
    end
  end
end
