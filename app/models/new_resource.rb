class NewResource < Resource

  def base_url
    "http://#{self.migration.to_url}"
  end

end