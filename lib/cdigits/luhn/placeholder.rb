# frozen_string_literal: true

require 'cdigits/luhn/store'

module Cdigits
  module Luhn
    class Placeholder
      NON_ZERO_SYMBOL = '+'
      NUMERIC_SYMBOL = '#'
      CHECK_DIGIT_SYMBOL = '?' # any good idia?

      # @param [Array<String>] characters
      def initialize(characters)
        @characters = characters
      end

      # Generate code
      # @param [String] placeholder
      # @return [String]
      def fill(placeholder)
        # TODO: validate placeholder string
        codes = []
        store = build_store(placeholder) do |char, digit|
          codes << (digit.nil? ? char : nil)
        end

        store.fill_check_digit
        generate_code(codes, store.digits)
      end

      # Validate code
      # @param [String] placeholder
      # @return [Boolean]
      def valid?(placeholder)
        store = build_store(placeholder)
        (store.sum % modulus).zero?
      end

      private

      def modulus
        @modulus ||= @characters.size
      end

      def build_store(placeholder)
        store = ::Cdigits::Luhn::Store.new(modulus: modulus)
        placeholder.chars.each do |char|
          digit = generate_digit(char, store)
          yield char, digit if block_given?
        end
        store
      end

      def generate_code(chars, digits)
        chars.map do |char|
          char || @characters[digits.shift]
        end.join
      end

      def generate_digit(char, store)
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
