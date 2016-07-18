class OldResource < Resource

  def base_url
    "http://#{self.migration.from_url}"
  end

  def match_suggestion
    self.similar(fields: ['url', 'title', 'meta_description'], where: { migration_id: self.migration.id, type: 'NewResource' }).first
  end
  
end