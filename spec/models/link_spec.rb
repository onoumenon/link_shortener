require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:url) { 'https://tanhuitian.com' }
  let(:shortcode) { 'abc123' }
  context 'validations' do
    it 'is valid if given a url and shortcode' do
      link = Link.new(url: url, shortcode: shortcode)
      expect(link).to be_valid
    end

    it 'is invalid if not given a url' do
      link = Link.new(url: nil, shortcode: shortcode)
      expect(link).not_to be_valid
    end

    it 'is invalid if given an invalid url' do
      link = Link.new(url: 'invalid', shortcode: shortcode)
      expect(link).not_to be_valid
    end

    it 'is invalid if not given a shortcode' do
      link = Link.new(url: url, shortcode: nil)
      expect(link).not_to be_valid
    end
  end
end
