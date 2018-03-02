require 'rails_helper'

describe PricingLogic::TimeA do
  describe '#calculate' do
    before do
      stub_request(:get, 'http://time.com').to_return(body: 'a' * 200 + 'xxx')
    end

    it "multiplies panel_size by the number of 'a' on the time.com website / 100" do
      expect(subject.calculate(10)).to eq 20
    end
  end
end