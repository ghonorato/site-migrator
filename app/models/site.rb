class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_one :migration

  before_validation :normalize_url

  validates :url, presence: true

  def normalize_url
    self.url = self.url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

  def full_url
    "http://#{self.url}"
  end

  def relativize_url(url)
    uri = URI.parse(url)
    uri = uri.route_from(self.full_url).to_s unless uri.relative?
    uri.to_s
  end

end
