require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:url) { 'https://tanhuitian.com' }

  it 'is valid if given a url' do
    link = Link.new(url: url)
    expect(link).to be_valid
  end

  it 'is invalid if not given a url' do
    link = Link.new(url: nil)
    expect(link).not_to be_valid
  end

  it 'is invalid if given an invalid url' do
    link = Link.new(url: 'invalid')
    expect(link).not_to be_valid
  end
end
