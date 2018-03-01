require 'rails_helper'

describe 'V1 Private Authorization', type: :request do
  let(:panel_provider) { create(:panel_provider) }

  describe 'POST #create' do
    context 'with valid code' do
      before { post('/v1/private/authorization', params: { code: panel_provider.code }) }

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns new access token' do
        expect(json_body['token']).to be_present
        expect(DateTime.parse(json_body['expiration_date'])).to be > Time.now
      end
    end

    context 'with invalid code' do
      it 'returns 404 status code' do
        post('/v1/private/authorization', params: { code: 'xxxx' })
        expect(response).to have_http_status(404)
      end
    end
  end

end