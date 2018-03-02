require 'rails_helper'

describe 'V1 Private Locations', type: :request do
  let(:base_url) { '/v1/private/evaluate_target' }

  let(:panel_provider) { create(:panel_provider, :with_access_token, pricing_logic: :time_a) }
  let(:token) { panel_provider.access_tokens.first }
  let(:country) { create(:country, panel_provider: panel_provider) }
  let(:target_group) { create(:target_group, countries: [country], panel_provider: panel_provider) }

  let(:country_code) { country.country_code }
  let(:target_group_id) { target_group.external_id }
  let(:locations) { [{ id: 1, panel_size: 20 }, { id: 2, panel_size: 30 }] }
  let(:params) do
    {
      country_code: country_code,
      target_group_id: target_group_id,
      locations: locations
    }
  end

  describe 'POST #create' do
    context 'with valid token' do
      context 'with valid country_code and target_group' do
        before do
          allow_any_instance_of(PricingLogic::TimeA).to receive(:calculate).with(50) { 100 }
          post_with_token(base_url, token, params: params)
        end

        it 'returns 200 status code' do
          expect(response).to have_http_status(200)
        end

        it 'returns price based on panel provider pricing logic' do
          expect(json_body).to eq('price' => 100)
        end

      end

      context 'with invalid country code' do
        let(:country_code) { 'XX' }
        it 'returns 422 status code with errors' do
          post_with_token(base_url, token, params: params)
          expect(response).to have_http_status(422)
          expect(json_body['errors'].keys).to include('country_code') 
        end
      end

      context 'with invalid target_group_id' do
        let(:target_group_id) { '123xxx123' }
        it 'returns 422 status code with errors' do
          post_with_token(base_url, token, params: params)
          expect(response).to have_http_status(422)
          expect(json_body['errors'].keys).to include('target_group_id')
        end
      end
    end

    context 'without token' do
      it 'returns 401 status code' do
        post(base_url)
        expect(response).to have_http_status(401)
        expect(json_body).to have_errors('access_token' => ['is invalid'])
      end
    end

    context 'with expired token' do
      it 'returns 401 status code' do
        token.update(expiration_date: 2.days.ago)
        post_with_token(base_url, token)
        expect(response).to have_http_status(401)
        expect(json_body).to have_errors('access_token' => ['is expired'])
      end
    end
  end
end