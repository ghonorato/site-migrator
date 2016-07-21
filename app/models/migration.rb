class Migration < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_many :old_resources, -> { where(type: 'OldResource') }, class_name: 'OldResource'
  has_many :new_resources, -> { where(type: 'NewResource') }, class_name: 'NewResource'

  validates :name, presence: true
  validates :from_url, presence: true
  validates :to_url, presence: true

  before_validation :normalize_url

  STATE_ROUTES = {
    url_pre_discover: { controller: 'url_discovery', action: 'index' },
    url_discover: { controller: 'url_discovery', action: 'index' },
    url_input: { controller: 'url_input', action: 'index' },
    url_fetch: { controller: 'url_match', action: 'index' },
    url_matching: { controller: 'url_match', action: 'index' } 
  }

  enum state: STATE_ROUTES.keys

  def route
    STATE_ROUTES[self.state.to_sym].merge({migration_id: self.id})
  end

  def to_param
    "#{self.id}-#{self.name}".parameterize
  end

  private

  def normalize_url
    self.from_url = self.from_url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
    self.to_url = self.to_url.sub(/^https?\:\/\//, '').sub(/\/$/,'')
  end

end
