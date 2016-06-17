class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  belongs_to :migration

  before_validation :normalize_url
  after_commit :crawl, on: :create

  validates :url, presence: true

  class NotInternalURIError < StandardError ; end

  def start_crawl
    PageCrawler.perform_async(self.id)
  end

  def external_url?(url_str)
    url = URI.parse(url_str)
    !url.relative? && !Site.normalized_url(url_str).start_with?(self.url)
  end

  def absolutize_url(url)
    raise NotInternalURIError if external_url?(url)
    URI.parse("http://#{self.url}").merge(URI.parse(url)).to_s
  end

  def relativize_url(url_string)
    raise NotInternalURIError if external_url?(url_string)
    url = URI.parse(url_string)

    if !url.relative?
      URI.parse("http://#{self.url}").route_to(url).to_s
    else
      url_string
    end
  end

  def follow_url?(url)
    !url.blank? && !external_url?(url)
  end

  def self.normalized_url(url)
    url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

  def normalize_url
    self.url = Site.normalized_url(self.url)
  end

  def crawl
    PageCrawler.perform_async(self.id)
  end

end
