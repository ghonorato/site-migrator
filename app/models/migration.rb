class Migration < ApplicationRecord
  belongs_to :current_site, dependent: :destroy, class_name: 'Site', foreign_key: 'current_site_id'
  belongs_to :new_site, dependent: :destroy, class_name: 'Site', foreign_key: 'new_site_id'

  validates :name, presence: true

  accepts_nested_attributes_for :current_site
  accepts_nested_attributes_for :new_site
end
