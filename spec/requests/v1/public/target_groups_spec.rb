require 'rails_helper'

describe 'V1 Public Target Groups', type: :request do
  let(:base_url) { '/v1/public/target_groups' }

  let(:country1) { create(:country) }
  let(:country2) { create(:country) }

  describe 'GET #index' do
    before do
      root = create(:target_group, :with_panel_provider, countries: [country1])
      child = create(:target_group, parent: root)
      create(:target_group, parent: child)

      create(:target_group, :with_panel_provider, countries: [country2])
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

      it 'includes necessary attributes' do
        expect(json_body.first.keys).to contain_exactly('id', 'name', 'parent_id')
      end

      it 'includes parent_id which corresponds to its parent' do
        eids = json_body.map { |r| r['id'] }
        parent_eids = json_body.map { |r| r['parent_id'] }.compact
        expect(eids).to include(*parent_eids)
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
