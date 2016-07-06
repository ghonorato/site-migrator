class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_one :migration

  before_validation :normalize_url
  after_commit :crawl, on: :create

  validates :url, presence: true

  def normalize_url
    self.url = self.url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

  def relativize_url(url)
    uri = URI.parse(url)
    uri = uri.route_from("http://#{self.url}").to_s unless uri.relative?
    uri.to_s.sub(/\/$/,'')
  end

end
