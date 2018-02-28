require 'rails_helper'

describe 'V1 Private Locations', type: :request do
  let(:panel_provider1) { create(:panel_provider) }
  let(:panel_provider2) { create(:panel_provider) }
  let(:country1) { create(:country, panel_provider: panel_provider1) }
  let(:country2) { create(:country, panel_provider: panel_provider2) }

  let(:location_group1) { create(:location_group, country: country1, panel_provider: panel_provider1) }
  let(:location_group2) { create(:location_group, country: country2, panel_provider: panel_provider1) }
  let(:location_group3) { create(:location_group, country: country2, panel_provider: panel_provider2) }

  before do
    create_list(:location, 3, location_groups: [location_group1])
    create(:location, location_groups: [location_group2])
    create(:location, location_groups: [location_group3])
  end

  describe 'GET #index' do

    context 'with valid country_code' do
      before { get "/v1/private/locations/#{country1.country_code}" }

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns locations only from given country and panel provider' do
        expect(json_body).to be_an Array
        expect(json_body.size).to eq 3
      end

      it 'includes external_id, name and secret_code attributes' do
        expect(json_body.first.keys).to contain_exactly('external_id', 'name', 'secret_code')
      end
    end

    context 'with invalid country code' do
      before { get '/v1/private/locations/XX' }

      it 'returns 404 status code' do
        expect(response).to have_http_status(404)
      end

    end
  end

end