class Link < ApplicationRecord
  validates :url, presence: true, url: true
  validates :shortcode, presence: true, uniqueness: true
end
