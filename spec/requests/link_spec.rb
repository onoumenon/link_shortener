require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:url) { 'https://www.google.com' }

  describe 'POST #Create' do
    subject do
      post link_path, params: { url: url }
    end

    context 'valid params' do
      before { subject }
      it do
        expect(response).to have_http_status(:ok)
        expect(body['shortcode'].length).to eq(8)
        expect(body['base_url']).to be_present
      end
    end

    context 'invalid params' do
      let(:url) { 'invalid url' }
      before { subject }

      it do
        expect(response).to have_http_status(:bad_request)
        expect(body['message']).to eq('URL is invalid')
      end
    end

    context 'accepts the same url multiple times' do
      Link.create(url: 'https://www.google.com')
      before { subject }

      it do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #Show' do
    let(:code) { 'abc123' }
    subject do
      Link.create(url: url, shortcode: code)
      get link_path, params: { shortcode: shortcode }
    end
    before { subject }

    # context 'valid shortcode' do
    #   let(:shortcode) { code }

    #   it do
    #     expect(response).to redirect_to url
    #   end
    # end

    context 'invalid shortcode' do
      let(:shortcode) { 'invalid' }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
