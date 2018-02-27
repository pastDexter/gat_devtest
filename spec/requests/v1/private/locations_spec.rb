require 'rails_helper'

describe 'V1 Private Locations', type: :request do

  describe 'GET #index' do
    it 'returns 200 status code' do
      get '/v1/private/locations'
      expect(response).to have_http_status(200)
    end
  end

end