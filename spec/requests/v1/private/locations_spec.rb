require 'rails_helper'

describe 'V1 Private Locations', type: :request do
  let(:base_url) { '/v1/private/locations' }

  let(:panel_provider1) { create(:panel_provider, :with_access_token) }
  let(:token) { panel_provider1.access_tokens.first }
  let(:panel_provider2) { create(:panel_provider) }
  let(:country1) { create(:country, panel_provider: panel_provider1) }
  let(:country2) { create(:country, panel_provider: panel_provider2) }

  let(:location_group1) { create(:location_group, country: country1, panel_provider: panel_provider1) }
  let(:location_group2) { create(:location_group, country: country2, panel_provider: panel_provider1) }
  let(:location_group3) { create(:location_group, country: country2, panel_provider: panel_provider2) }

  describe 'GET #index' do
    before do
      create_list(:location, 3, location_groups: [location_group1])
      create(:location, location_groups: [location_group2])
      create(:location, location_groups: [location_group3])
    end

    context 'with valid token' do
      context 'with valid country_code' do
        before { get_with_token("#{base_url}/#{country1.country_code}", token) }

        it 'returns 200 status code' do
          expect(response).to have_http_status(200)
        end

        it 'returns locations only from given country and panel provider' do
          expect(json_body).to be_an Array
          expect(json_body.size).to eq 3
        end

        it 'includes necessary attributes' do
          expect(json_body.first.keys).to contain_exactly('id', 'name', 'secret_code', 'location_groups')
        end
      end

      context 'with invalid country code' do
        it 'returns 404 status code' do
          get_with_token("#{base_url}/XX", token)
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'without token' do
      it 'returns 401 status code' do
        get("#{base_url}/PL")
        expect(response).to have_http_status(401)
        expect(json_body).to have_errors('access_token' => ['is invalid'])
      end
    end

    context 'with expired token' do
      it 'returns 401 status code' do
        token.update(expiration_date: 2.days.ago)
        get_with_token("#{base_url}/XX", token)
        expect(response).to have_http_status(401)
        expect(json_body).to have_errors('access_token' => ['is expired'])
      end
    end
  end
end