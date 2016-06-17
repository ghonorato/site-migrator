class Migration < ApplicationRecord
  has_one :current_site, dependent: :destroy, class_name: 'Site', inverse_of: :migration
  has_one :new_site, dependent: :destroy, class_name: 'Site', inverse_of: :migration

  validates :name, presence: true

  accepts_nested_attributes_for :current_site
  accepts_nested_attributes_for :new_site
end
