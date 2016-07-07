class Migration < ApplicationRecord
  belongs_to :current_site, dependent: :destroy, class_name: 'Site', foreign_key: 'current_site_id'
  belongs_to :new_site, dependent: :destroy, class_name: 'Site', foreign_key: 'new_site_id'

  validates :name, presence: true

  accepts_nested_attributes_for :current_site
  accepts_nested_attributes_for :new_site

  enum state: [ :inputing_urls, :fetching_url_data, :matching_redirects ]

  def to_param
    "#{self.id}-#{self.name}".parameterize
  end
end
