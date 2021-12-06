require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:body) { JSON.parse(response.body) }

  describe 'POST #Create' do
    subject do
      post link_path, params: { url: url }
    end
    before { subject }

    context 'valid params' do
      let(:url) { 'https://www.google.com' }

      it do
        expect(response).to have_http_status(:ok)
        expect(body['shortcode'].length).to eq(8)
        expect(body['short_url']).to be_present
      end
    end

    context 'invalid params' do
      let(:url) { 'invalid url' }

      it do
        expect(response).to have_http_status(:bad_request)
        expect(body['message']).to eq('URL is invalid')
      end
    end
  end
end
