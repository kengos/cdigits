# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn::Placeholder do
  let(:obj) { described_class.new(placeholder: placeholder, modulus: modulus) }
  let(:placeholder) { nil }
  let(:modulus) { nil }

  describe '#call' do
    subject { obj.call }

    context 'modulus: 10' do
      context 'when placeholder is nil' do
        let(:placeholder) { nil }

        before do
          allow(SecureRandom).to receive(:random_number).with(8).and_return(0)
          allow(SecureRandom).to receive(:random_number).with(9).and_return(2)
        end

        # 1222222224 => 4 + (2 * 2) + 2 + (2 * 2) + 2 + (2 * 2) + 2 + (2 * 2) + 2 + (1 * 2) = 30
        it { is_expected.to eq '1222222224' }
      end

      context 'when placeholder is "5?-259"' do
        let(:placeholder) { '5?-239' }

        it { is_expected.to eq '54-239' }
      end

      context 'when placeholder is "5?-259"' do
        let(:placeholder) { 'ABC-?5' }

        it { is_expected.to eq 'ABC-75' }
      end

      context 'when placeholder is "24?"' do
        let(:placeholder) { '24?' }

        it { is_expected.to eq '240' }
      end
    end
  end
end
