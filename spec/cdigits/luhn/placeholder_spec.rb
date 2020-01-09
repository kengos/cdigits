# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn::Placeholder do
  let(:obj) { described_class.new(placeholder: placeholder, characters: characters) }

  describe '#fill' do
    subject { obj.fill }

    context 'when characters: numbers' do
      let(:characters) { Cdigits::Luhn::NUMBER_CHARACTERS }

      context 'placeholder: +###?' do
        let(:placeholder) { '+###?' }

        before do
          allow(SecureRandom).to receive(:random_number).with(9).and_return(0)
          allow(SecureRandom).to receive(:random_number).with(10).and_return(4, 5, 6)
        end

        it { is_expected.to eq '14563' }
      end

      context 'when placeholder is "5?-202001"' do
        let(:placeholder) { 'AB5?-20200109' }

        it { is_expected.to eq 'AB51-20200109' }
      end
    end

    context 'when characters: ["A", "B", "C", "D", "E", "F"]' do
      let(:characters) { %w[A B C D E F] }

      context 'placeholder: +######?' do
        let(:placeholder) { '+######?' }

        before do
          allow(SecureRandom).to receive(:random_number).with(5).and_return(0)
          allow(SecureRandom).to receive(:random_number).with(6).and_return(0, 1, 2, 3, 4, 5)
        end

        it { is_expected.to eq 'BABCDEFC' }
      end
    end
  end
end
