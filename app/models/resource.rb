class Resource < ApplicationRecord
  belongs_to :site

  validates :url, uniqueness: { scope: :site_id }

  before_save :normalize_url

  def error?
    self.http_code >= 400
  end

  def redirect?
    self.http_code >= 300 && self.http_code <= 399
  end

  def ok?
    self.http_code >= 200 && self.http_code <= 299
  end

  def fresh?
    self.updated_at && self.created_at && self.updated_at > self.created_at && self.updated_at > 3.hours.ago && !error?
  end 

  private

  def normalize_url
    self.url = site.relativize_url(url)
  end
end
