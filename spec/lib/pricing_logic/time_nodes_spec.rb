require 'rails_helper'

describe PricingLogic::TimeNodes do
  describe '#calculate' do
    let(:html) do
      <<-HTML
        <html>
          <body>
            <h1>Test</h1>
            <h2>Pricing Logic</h2>
            <ul>
              <li>Case 1</li>
              <li>Case 2</li>
              <li>Case 3</li>
              <li>Case 4</li>
              <li>Case 5</li>
          </body>
        </html>
      HTML
    end
    before do
      stub_request(:get, 'http://time.com').to_return(body: html)
    end

    it 'multiplies panel_size by the number of html nodes on the time.com website / 100' do
      expect(subject.calculate(200)).to eq 20
    end
  end
end