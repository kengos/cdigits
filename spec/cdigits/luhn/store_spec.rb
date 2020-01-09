# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn::Store do
  let(:obj) { described_class.new(modulus: modulus, digits: digits) }
  let(:modulus) { 10 }
  let(:digits) { nil }

  describe '#sum' do
    subject { obj.sum }

    context 'when modulus = 10, digits = [7, 8, 9]' do
      let(:modulus) { 10 }
      let(:digits) { [7, 8, 9] }

      it { is_expected.to eq 9 + (1 + 6) + 7 }
    end

    context 'when modulus = 6, digits = [3, 4, 5]' do
      let(:modulus) { 6 }
      let(:digits) { [3, 4, 5] }

      it { is_expected.to eq 5 + (1 + 2) + 3 }
    end

    context 'when modulus = 16, digits = [10, 11, 12, 13, 14, 15]' do
      let(:modulus) { 16 }
      let(:digits) { [10, 11, 12, 13, 14, 15] }

      it { is_expected.to eq 15 + (1 + 12) + 13 + (1 + 8) + 11 + (1 + 4) }
    end
  end

  describe '#double' do
    subject { obj.send(:double, num) }

    context 'when modulus = 10' do
      let(:modulus) { 10 }

      context 'when num = 1' do
        let(:num) { 1 }

        it { is_expected.to eq 2 }
      end

      context 'when num = 5' do
        let(:num) { 5 }

        it { is_expected.to eq 1 + 0 }
      end

      context 'when num = 6' do
        let(:num) { 6 }

        it { is_expected.to eq 1 + 2 }
      end
    end

    context 'when modulus = 16' do
      let(:modulus) { 16 }

      context 'when num = 8' do
        let(:num) { 8 }

        it { is_expected.to eq 1 + 0 }
      end

      context 'when num = 14' do
        let(:num) { 14 }

        it { is_expected.to eq 1 + 12 }
      end
    end

    context 'when modulus = 6' do
      let(:modulus) { 6 }

      context 'when num = 3' do
        let(:num) { 3 }

        it { is_expected.to eq 1 + 0 }
      end

      context 'when num = 4' do
        let(:num) { 4 }

        it { is_expected.to eq 1 + 2 }
      end
    end
  end

  describe '#calculate_check_digit' do
    subject { obj.send(:calculate_check_digit, value, odd) }

    context 'when modulus = 10' do
      let(:modulus) { 10 }

      context 'when value is odd' do
        let(:value) { 43 }

        context 'when odd = true' do
          let(:odd) { true }

          it { is_expected.to eq 7 }
        end

        context 'when odd = false' do
          let(:odd) { false }
          # 8 * 2 = 16 => 1 + 6 = 7
          it { is_expected.to eq 8 }
        end
      end

      context 'when value is even' do
        let(:value) { 47 }

        context 'when odd = true' do
          let(:odd) { true }

          it { is_expected.to eq 3 }
        end

        context 'when odd = false' do
          let(:odd) { false }

          # 6 * 2 = 12 => 1 + 2 = 3
          it { is_expected.to eq 6 }
        end
      end
    end

    context 'when modulus = 16' do
      let(:modulus) { 16 }

      context 'when value is odd' do
        let(:value) { 19 }

        context 'when odd = true' do
          let(:odd) { true }

          it { is_expected.to eq 13 }
        end

        context 'when odd = false' do
          let(:odd) { false }
          # 14 * 2 = 28 => 1 + 12 = 13
          it { is_expected.to eq 14 }
        end
      end

      context 'when value is even' do
        let(:value) { 20 }

        context 'when odd = true' do
          let(:odd) { true }

          it { is_expected.to eq 12 }
        end

        context 'when odd = false' do
          let(:odd) { false }

          # 6 * 2 = 12
          it { is_expected.to eq 6 }
        end
      end
    end
  end

  describe '#double' do
    shared_examples_for 'doubled value' do |modulus, num, expected|
      it "when mod: #{modulus}, num: #{num} then #{expected}" do
        expect(described_class.new(modulus: modulus).send(:double, num)).to eq expected
      end
    end

    it_behaves_like 'doubled value', 5, 2, 4
    it_behaves_like 'doubled value', 5, 3, 1 + 1
    it_behaves_like 'doubled value', 5, 4, 1 + 3
    it_behaves_like 'doubled value', 6, 3, 1 + 0
    it_behaves_like 'doubled value', 6, 4, 1 + 2
    it_behaves_like 'doubled value', 6, 5, 1 + 4
    it_behaves_like 'doubled value', 7, 4, 1 + 1
    it_behaves_like 'doubled value', 7, 5, 1 + 3
    it_behaves_like 'doubled value', 10, 7, 1 + 4
    it_behaves_like 'doubled value', 10, 8, 1 + 6
  end
end
