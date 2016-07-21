class NewResource < Resource

  has_many :redirect_matches, class_name: 'OldResource', foreign_key: 'redirect_match_id'

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "new_resources_#{Rails.env}"

  def base_url
    "http://#{self.migration.to_url}"
  end

end