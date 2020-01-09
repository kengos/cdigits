# frozen_string_literal: true

require 'cdigits/luhn/store'

module Cdigits
  module Luhn
    class Placeholder
      NON_ZERO_SYMBOL = '+'
      NUMERIC_SYMBOL = '#'
      CHECK_DIGIT_SYMBOL = '?' # any good idia?

      def initialize(placeholder:, characters:)
        @placeholder = placeholder
        @characters = characters
      end

      def fill
        # TODO: validate placeholder string
        codes = []
        @placeholder.chars.each do |char|
          digit = generate_digit(char)
          codes << (digit.nil? ? char : nil)
        end

        store.fill_check_digit
        generate_code(codes, store.digits)
      end

      private

      def modulus
        @modulus ||= @characters.size
      end

      def store
        @store ||= ::Cdigits::Luhn::Store.new(modulus: modulus)
      end

      def generate_code(chars, digits)
        chars.map do |char|
          char || @characters[digits.shift]
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
        when *@characters
          store.append(@characters.index(char))
        end
      end
    end
  end
end
