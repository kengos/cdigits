# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn do
  describe '.number' do
    subject { described_class.number }

    it { is_expected.to match(/^\d+/) }
  end

  describe '.number?' do
    subject { described_class.number?(code) }

    context 'when valid code' do
      let(:code) { described_class.number }

      it { is_expected.to eq true }
    end

    context 'when invalid code' do
      let(:code) { '1111' }

      it { is_expected.to eq false }
    end
  end

  describe '.hex' do
    subject { described_class.hex }

    it { is_expected.to match(/^[0-9a-f]+/) }
  end

  describe '.hex?' do
    subject { described_class.hex?(code) }

    context 'when valid code' do
      let(:code) { described_class.hex }

      it { is_expected.to eq true }
    end

    context 'when invalid code' do
      let(:code) { '1111' }

      it { is_expected.to eq false }
    end
  end

  describe '.alphanumeric' do
    subject { described_class.alphanumeric }

    it { is_expected.to match(/^[0-9a-z]+/) }
  end

  describe '.alphanumeric?' do
    subject { described_class.alphanumeric?(code) }

    context 'when valid code' do
      let(:code) { described_class.alphanumeric }

      it { is_expected.to eq true }
    end

    context 'when invalid code' do
      let(:code) { '1111' }

      it { is_expected.to eq false }
    end
  end

  describe '.easy' do
    subject { described_class.easy }

    it { is_expected.to match(/^[0-9ABCEFGHJKLNPRSTUVWXY]+/) }
  end

  describe '.easy?' do
    subject { described_class.easy?(code) }

    context 'when valid code' do
      let(:code) { described_class.easy }

      it { is_expected.to eq true }
    end

    context 'when invalid code' do
      let(:code) { '1111' }

      it { is_expected.to eq false }
    end
  end
end
