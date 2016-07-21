class Migration < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_many :old_resources, -> { where(type: 'OldResource') }, inverse_of: :migration, class_name: 'OldResource'
  has_many :new_resources, -> { where(type: 'NewResource') }, inverse_of: :migration, class_name: 'NewResource'

  validates :name, presence: true
  validates :from_url, presence: true
  validates :to_url, presence: true

  before_validation :normalize_url

  enum state: [ :inputing_urls, :fetching_url_data, :matching_redirects ]

  def to_param
    "#{self.id}-#{self.name}".parameterize
  end

  private

  def normalize_url
    self.from_url = self.from_url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
    self.to_url = self.to_url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

end
