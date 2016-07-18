class Resource < ApplicationRecord
  belongs_to :migration

  validates :url, uniqueness: { scope: [:migration, :type] }

  before_save :normalize_url

  searchkick

  def search_data
    {
      url: url,
      title: title,
      meta_description: meta_description,
      type: type,
      migration_id: migration.id
    }
  end

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

  def full_url
    URI.join(base_url, self.url)
  end

  private

  def normalize_url
    uri = URI.parse(self.url)
    uri = uri.route_from(base_url).to_s unless uri.relative?
    self.url = uri.to_s
  end
end
