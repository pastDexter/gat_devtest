require 'rails_helper'

describe PanelProvider do

  describe '#.pricing_logic_class' do
    it 'returns corresponding pricing_logic class' do
      subject.pricing_logic = :time_a
      expect(subject.pricing_logic_class).to eq PricingLogic::TimeA
    end
  end

end