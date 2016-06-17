class Resource < ApplicationRecord
  belongs_to :site

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
end
