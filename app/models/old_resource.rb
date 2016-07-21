class OldResource < Resource
  
  belongs_to :redirect_match, class_name: 'NewResource', optional: true

  def base_url
    "http://#{self.migration.from_url}"
  end

  def update_redirect_match!
    query = {
      query: {
        bool: {
          must: {
            query_string: {
              query: escape(self.title)
            }
          },
          filter: {
            term: { migration_id: self.migration.id }
          }
        }
      }
    }    
    self.redirect_match = NewResource.search(query).records.to_a.first
    save!
  end

  def escape(value)
    value.gsub(/([#{Regexp.escape('\\+-&|!(){}[]^~*?:/')}])/, '\\\\\1')
  end
  
end