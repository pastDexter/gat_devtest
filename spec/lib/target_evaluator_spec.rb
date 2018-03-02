require 'spec_helper'
require_relative '../../lib/target_evaluator'

describe TargetEvaluator do

  let(:pricing_logic) { double(:pricing_logic) }
  let(:locations) { [{ id: 1, panel_size: 20 }] }

  subject { described_class.new(locations, pricing_logic) }

  describe '#initialize' do
    it 'assigns passed arguments as attributes' do
      expect(subject.pricing_logic).to eq pricing_logic
      expect(subject.locations).to eq locations
    end
  end

  describe '#calculate_price' do
    it 'calculates final price based on pricing_logic' do
      expect(pricing_logic).to receive(:calculate).with(20) { 1 }
      expect(subject.calculate_price).to eq 1
    end

    context 'with multiple locations' do
      let(:locations) { [{ id: 1, panel_size: 20 }, { id: 1, panel_size: 30 }] }

      it 'calculates final price based on pricing_logic for total panel size' do
        expect(pricing_logic).to receive(:calculate).with(50) { 1 }
        expect(subject.calculate_price).to eq 1
      end
    end
  end

end