# frozen_string_literal: true

require 'cdigits/luhn/placeholder'

module Cdigits
  module Luhn
    module_function

    # @example
    #   `Cdigits::Luhn.fill` # => '123456782'
    # @example
    #   # NOTE: 2001 => 20/01 (yy/MM)
    #   `Cdigits::Luhn.fill('2***-0***-0***-1**?')`
    # @example
    #   `Cdigits::Luhn::Placeholder.fill('?****')`
    def fill(placeholder = nil)
      ::Cdigits::Luhn::Placeholder.new(placeholder: placeholder, modulus: 10).call
    end
  end
end
