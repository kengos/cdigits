# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cdigits::Luhn::RandomTable do
  let(:random_table) { described_class.new(modulus: modulus) }

  describe '#pick_non_zero' do
    subject { random_table.pick_non_zero }
    let(:modulus) { 2 }

    it { is_expected.to eq 1 }
  end

  describe '#pick' do
    subject { random_table.pick(exclude: exclude) }
    let(:modulus) { 10 }

    context 'exclude: [0..8]' do
      let(:exclude) { (0..8).to_a }

      it { is_expected.to eq 9 }
    end
  end

  describe '#table' do
    subject(:table) { random_table.send(:table, exclude) }

    let(:exclude) { [] }

    context 'when modulus: 9' do
      let(:modulus) { 9 }
      {
        nil => (0..8).to_a,
        0 => (0..7).to_a,
        1 => (0..8).to_a,
        2 => (0..8).to_a,
        3 => (0..8).to_a,
        4 => (0..8).to_a,
        5 => (0..8).to_a,
        6 => (0..8).to_a,
        7 => (0..8).to_a,
        8 => (1..8).to_a
      }.each do |previsous, expected|
        it "When previsous is #{previsous}, should #{expected}" do
          random_table.previsous = previsous
          expect(table).to eq expected
        end
      end
    end

    context 'when modulus: 10' do
      let(:modulus) { 10 }
      {
        nil => (0..9).to_a,
        0 => (0..8).to_a,
        1 => (0..9).to_a,
        2 => (0..9).to_a - [2],
        3 => (0..9).to_a - [3],
        4 => (0..9).to_a - [4],
        5 => (0..9).to_a - [5],
        6 => (0..9).to_a - [6],
        7 => (0..9).to_a - [7],
        8 => (0..9).to_a,
        9 => (1..9).to_a
      }.each do |previsous, expected|
        it "When previsous is #{previsous}, should #{expected}" do
          random_table.previsous = previsous
          expect(table).to eq expected
        end
      end
    end

    context 'when modulus: 13' do
      let(:modulus) { 13 }
      {
        nil => (0..12).to_a,
        0 => (0..11).to_a, # doubled: 0
        1 => (0..12).to_a, # doubled: 3
        2 => (0..12).to_a, # doubled: 6
        3 => (0..12).to_a - [3], # doubled: 9
        4 => (0..12).to_a - [4], # doubled: 12
        5 => (0..12).to_a - [5], # doubled: 15
        6 => (0..12).to_a - [6], # doubled: 18
        7 => (0..12).to_a - [7], # doubled: 9
        8 => (0..12).to_a - [8], # doubled: 12
        9 => (0..12).to_a - [9], # doubled: 15
        10 => (0..12).to_a - [10], # doubled: 18
        11 => (0..12).to_a, # doubled: 21
        12 => (1..12).to_a # doubled: 24
      }.each do |previsous, expected|
        it "When previsous is #{previsous}, should #{expected}" do
          random_table.previsous = previsous
          expect(table).to eq expected
        end
      end
    end

    context 'when modulus: 16' do
      let(:modulus) { 16 }
      {
        nil => (0..15).to_a,
        0 => (0..14).to_a, # doubled: 0
        1 => (0..15).to_a, # doubled: 3
        2 => (0..15).to_a, # doubled: 6
        3 => (0..15).to_a - [3], # doubled: 9
        4 => (0..15).to_a - [4], # doubled: 12
        5 => (0..15).to_a - [5], # doubled: 15
        6 => (0..15).to_a - [6], # doubled: 18
        7 => (0..15).to_a - [7], # doubled: 21
        8 => (0..15).to_a - [8], # doubled: 9
        9 => (0..15).to_a - [9], # doubled: 12
        10 => (0..15).to_a - [10], # doubled: 15
        11 => (0..15).to_a - [11], # doubled: 18
        12 => (0..15).to_a - [12], # doubled: 21
        13 => (0..15).to_a, # doubled: 24
        14 => (0..15).to_a, # doubled: 27
        15 => (1..15).to_a # doubled: 30
      }.each do |previsous, expected|
        it "When previsous is #{previsous}, should #{expected}" do
          random_table.previsous = previsous
          expect(table).to eq expected
        end
      end
    end
  end
end
