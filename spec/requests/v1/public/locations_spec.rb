require 'rails_helper'

describe 'V1 Public Locations', type: :request do
  let(:base_url) { '/v1/public/locations' }
  let(:country1) { create(:country) }
  let(:country2) { create(:country) }

  let(:location_group1) { create(:location_group, country: country1) }
  let(:location_group2) { create(:location_group, country: country2) }

  describe 'GET #index' do
    before do
      create_list(:location, 3, location_groups: [location_group1])
      create(:location, location_groups: [location_group2])
    end

    context 'with valid country_code' do
      before { get("#{base_url}/#{country1.country_code}") }

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns locations only from given country and panel provider' do
        expect(json_body).to be_an Array
        expect(json_body.size).to eq 3
      end

      it 'includes external_id, name and secret_code attributes' do
        expect(json_body.first.keys).to contain_exactly('external_id', 'name')
      end
    end

    context 'with invalid country code' do
      it 'returns 404 status code' do
        get("#{base_url}/XX")
        expect(response).to have_http_status(404)
      end
    end
  end
end