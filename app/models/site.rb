class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_one :migration

  before_validation :normalize_url
  after_commit :crawl, on: :create

  validates :url, presence: true

  def crawl
    c = Cobweb.new(
      processing_queue: "CrawlerPerformJob",   
      internal_urls: ["http://#{self.url}/*"],
      queue_system: :sidekiq,
      crawl_id: self.id
    )
    c.start("http://#{self.url}/")
  end

  def normalize_url
    self.url = self.url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

end
