# frozen_string_literal: true

require 'cdigits/luhn/placeholder'

module Cdigits
  module Luhn
    module_function

    NUMBER_CHARACTERS = (0..9).map(&:to_s).freeze

    # Generate code with Luhn mod 10 algorithm
    # @example
    #   `Cdigits::Luhn.number` # => '123456782'
    # @example
    #   `Cdigits::Luhn.number('2###-0###-0###-1##?')` # => 2960-0093-0751-1449
    # @return [String]
    def number(placeholder = nil)
      generate(placeholder, NUMBER_CHARACTERS)
    end

    # Validate code with Luhn mod 10 algorithm
    # @params [String] code
    # @return [Boolean]
    def number?(code)
      valid?(code, NUMBER_CHARACTERS)
    end

    HEX_CHARACTERS = (NUMBER_CHARACTERS + ('a'..'f').to_a).freeze

    # Generate code with Luhn mod 16 algorithm
    # @example
    #   `Cdigits::Luhn.hex` # => 'd6fd358a29'
    # @example
    #   `Cdigits::Luhn.hex('2###-0###-0###-1##?')` # => '2582-08fe-02fe-1d80'
    # @return [String]
    def hex(placeholder = nil)
      generate(placeholder, HEX_CHARACTERS)
    end

    # Validate code with Luhn mod 16 algorithm
    # @params [String] code
    # @return [Boolean]
    def hex?(code)
      valid?(code, HEX_CHARACTERS)
    end

    ALPHANUMERIC_CHARACTERS = (NUMBER_CHARACTERS + ('a'..'z').to_a).freeze

    # Generate code with Luhn mod 36 algorithm
    # @example
    #   `Cdigits::Luhn.alphanumeric` # => 'a0gpmk4ye4'
    # @example
    #   `Cdigits::Luhn.alphanumeric('2###-0###-0###-1##?')` # => '22u3-04s1f-0z9c-1lmo'
    # @return [String]
    def alphanumeric(placeholder = nil)
      generate(placeholder, ALPHANUMERIC_CHARACTERS)
    end

    # Validate code with Luhn mod 36 algorithm
    # @params [String] code
    # @return [Boolean]
    def alphanumeric?(code)
      valid?(code, ALPHANUMERIC_CHARACTERS)
    end

    # Non(hard to)-Misread/Misheard characters
    # any good idea?
    # @note Misread charcters
    #  - 0 and O(óu)
    #  - 0 and D(díː)
    #  - 0 and Q(kjúː)
    #  - 1 and I(ái)
    #  - 2 and Z(zíː)
    # @note Misheard charcters
    #  - D(díː) and B(bíː)
    #  - M(ém) and N(én)
    #  - 9(kyu:) and Q(kjúː)  ... Japanese only
    # @return [Array<String>]
    EASY_CHARACTERS = (NUMBER_CHARACTERS + ('A'..'Z').to_a - %w[D I M O Q Z]).freeze

    # Generate code with Luhn mod 30 algorithm
    # Valid characters are 0 to 9 and A to Z without D/I/M/O/Q/Z
    # @example
    #   `Cdigits::Luhn.easy` # => '5F20603XER'
    # @example
    #   `Cdigits::Luhn.easy('2###-0###-0###-1##?')` # => '2P2M-0191-05XL-1BYN'
    # @return [String]
    def easy(placeholder = nil)
      generate(placeholder, EASY_CHARACTERS)
    end

    # Validate code with Luhn mod 30 algorithm
    # @params [String] code
    # @return [Boolean]
    def easy?(code)
      valid?(code, EASY_CHARACTERS)
    end

    def generate(placeholder, characters)
      placeholder ||= '+########?'
      instance(characters).fill(placeholder)
    end

    # @params [String] code
    # @params [Array<String>] characters
    # @return [Boolean]
    def valid?(code, characters)
      instance(characters).valid?(code)
    end

    # @return [Cdigits::Luhn::Placeholder]
    def instance(characters)
      ::Cdigits::Luhn::Placeholder.new(characters)
    end
  end
end
