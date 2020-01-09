# frozen_string_literal: true

module Cdigits
  module Luhn
    class RandomTable
      attr_accessor :previsous

      def initialize(modulus:)
        @modulus = modulus
        @previsous = nil
      end

      # pick from number table exclude 0
      # @return [Integer]
      def pick_non_zero
        pick(exclude: [0])
      end

      # pick from number table
      # @param exclude [Array<Intger>] exclude numbers
      # @return [Integer]
      def pick(exclude: [])
        table(exclude).sample
      end

      private

      def numbers
        @numbers ||= (0..max).to_a.freeze
      end

      def max
        @modulus - 1
      end

      # @return [Array<Integer>]
      def table(exclude)
        exclude << next_numbers_to_avoid[@previsous]
        table = numbers - exclude.compact
        table.empty? ? numbers : table
      end

      def next_numbers_to_avoid
        @next_numbers_to_avoid ||= build_next_numbers_to_avoid
      end

      def build_next_numbers_to_avoid
        defaults = { 0 => max, max => 0 }
        return defaults unless occure_twin_error?

        defaults.merge(twin_error_values)
      end

      # @note
      #   modulus = 10
      #   twin | doubled value
      #   ---- | -------------
      #   00 | 0
      #   11 | 3
      #   22 | 6
      #   33 | 9
      #   44 | 12
      #   55 | 6
      #   66 | 9
      #   77 | 12
      #   88 | 15
      #   99 | 18
      # @example
      #   # when @modulus = 10
      #   twin_error_values # => { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7 }
      # @return [Hash]
      def twin_error_values
        size = (max / 3).to_i
        start = (@modulus / 2.0).ceil - size
        stop = start + size * 2 - 1
        values = (start..stop).to_a
        values.zip(values).to_h
      end

      def occure_twin_error?
        (max % 3).zero?
      end
    end
  end
end
