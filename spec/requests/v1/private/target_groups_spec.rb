require 'rails_helper'

describe 'V1 Private Target Groups', type: :request do
  let(:base_url) { '/v1/private/target_groups' }

  let(:panel_provider1) { create(:panel_provider, :with_access_token) }
  let(:token) { panel_provider1.access_tokens.first }
  let(:panel_provider2) { create(:panel_provider) }
  let(:country1) { create(:country, panel_provider: panel_provider1) }
  let(:country2) { create(:country, panel_provider: panel_provider2) }

  describe 'GET #index' do
    before do
      root = create(:target_group, countries: [country1], panel_provider: panel_provider1)
      child = create(:target_group, parent: root)
      create(:target_group, parent: child)

      create(:target_group, countries: [country1], panel_provider: panel_provider2)
      create(:target_group, countries: [country2], panel_provider: panel_provider1)
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
          expect(json_body.first.keys).to contain_exactly('id', 'name', 'secret_code', 'parent_id')
        end

        it 'includes parent_id which corresponds to its parent' do
          eids = json_body.map { |r| r['id'] }
          parent_eids = json_body.map { |r| r['parent_id'] }.compact
          expect(eids).to include(*parent_eids)
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
        expect(json_body).to eq('error' => 'Invalid access token')
      end
    end

    context 'with expired token' do
      it 'returns 401 status code' do
        token.update(expiration_date: 2.days.ago)
        get_with_token("#{base_url}/XX", token)
        expect(response).to have_http_status(401)
        expect(json_body).to eq('error' => 'Access token expired')
      end
    end
  end
end