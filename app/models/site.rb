class Site < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_one :migration

  before_validation :normalize_url

  validates :url, presence: true


end
