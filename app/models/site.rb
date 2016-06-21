class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_one :migration

  before_validation :normalize_url
  after_commit :crawl, on: :create

  validates :url, presence: true

  def crawl
    CrawlerJob.perform_async(self.id)
  end

end
