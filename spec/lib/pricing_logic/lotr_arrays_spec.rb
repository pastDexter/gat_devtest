require 'rails_helper'

describe PricingLogic::LotrArrays do
  describe '#calculate' do
    let(:json) do
      {
        foo: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
        bar: {
          baz: [[1], [], [], [], [5], {}, {}, {}, {}, {}, %w[a b c d e f g h i j k l m n]]
        }
      }.to_json
    end
    before do
      stub_request(:get, 'http://openlibrary.org/search.json?q=the+lord+of+the+rings').to_return(body: json)
    end

    it 'multiplies panel_size by the number of arrays with more than 10 elements in LOTR JSON response' do
      expect(subject.calculate(10)).to eq 30
    end
  end
end