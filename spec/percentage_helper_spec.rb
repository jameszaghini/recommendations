# spec/percentage_helper_spec.rb

require 'percentage_helper'

RSpec.describe PercentageHelper do
  include PercentageHelper

  describe '#calculate_percentage' do
    context 'when denominator is not zero' do
      it 'calculates the correct percentage' do
        numerator = 20
        denominator = 50
        expect(calculate_percentage(numerator, denominator)).to eq(40.0)
      end
    end

    context 'when denominator is zero' do
      it 'returns 0' do
        numerator = 10
        denominator = 0
        expect(calculate_percentage(numerator, denominator)).to eq(0)
      end
    end

    context 'when numerator is zero' do
      it 'returns 0' do
        numerator = 0
        denominator = 100
        expect(calculate_percentage(numerator, denominator)).to eq(0)
      end
    end

    context 'when numerator and denominator are both zero' do
      it 'returns 0' do
        numerator = 0
        denominator = 0
        expect(calculate_percentage(numerator, denominator)).to eq(0)
      end
    end

    context 'when numerator is greater than denominator' do
      it 'calculates the correct percentage' do
        numerator = 75
        denominator = 50
        expect(calculate_percentage(numerator, denominator)).to eq(150.0)
      end
    end

    context 'when numerator is less than denominator' do
      it 'calculates the correct percentage' do
        numerator = 30
        denominator = 100
        expect(calculate_percentage(numerator, denominator)).to eq(30.0)
      end
    end
  end
end