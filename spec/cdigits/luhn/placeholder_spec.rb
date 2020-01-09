# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn::Placeholder do
  let(:obj) { described_class.new(characters) }

  describe '#fill' do
    subject { obj.fill(placeholder) }

    context 'when characters: numbers' do
      let(:characters) { Cdigits::Luhn::NUMBER_CHARACTERS }

      context 'when placeholder is "AB5?-202001"' do
        let(:placeholder) { 'AB5?-20200109' }

        it { is_expected.to eq 'AB51-20200109' }
      end
    end

    context 'when characters: ["A", "B", "C", "D", "E", "F"]' do
      let(:characters) { %w[A B C D E F] }

      context 'when placeholder is "BABCDEF?"' do
        let(:placeholder) { 'BABCDEF?' }

        it { is_expected.to eq 'BABCDEFC' }
      end
    end
  end

  describe '#valid?' do
    subject { obj.valid?(placeholder) }

    context 'characters: number' do
      let(:characters) { Cdigits::Luhn::NUMBER_CHARACTERS }

      context 'when placeholder is "5975"' do
        let(:placeholder) { '5975' }

        # 5975 => 5 + (1 + 4) + 9 + (1 + 0) = 20
        it { is_expected.to eq true }
      end

      context 'when placeholder is "2583"' do
        let(:placeholder) { '2583' }

        # 3 + (1 + 6) + 5 + 4 = 19
        it { is_expected.to eq false }
      end

      context 'when placeholder is "5C97B5"' do
        let(:placeholder) { '5C97B5' }

        it { is_expected.to eq true }
      end
    end

    context 'when characters: easy' do
      let(:characters) { Cdigits::Luhn::EASY_CHARACTERS }

      context 'when placeholder is "X2"' do
        let(:placeholder) { 'X2' }

        # X2 => 2 + (1 + 26) = 29
        it { is_expected.to eq false }
      end

      context 'when placeholder is "X3"' do
        let(:placeholder) { 'X3' }

        # X3 => 3 + (1 + 26) = 29
        it { is_expected.to eq true }
      end

      context 'when placeholder is "FLXH"' do
        let(:placeholder) { 'FLXH' }

        # FLXH => 14|19|28|16 => 16 + (1 + 26) + 19 + 28 = 90
        # 28 * 2 = 56 ; (56 / 30).to_i + 56 % 30 = 1 + 26
        # 90 % 30 = 0
        it { is_expected.to eq true }
      end
    end
  end
end
