class ResourcesCreationForm 
  include ActiveModel::Model

  validates :new_site_urls, presence: true
  validates :current_site_urls, presence: true

  attr_accessor :new_site_urls, :current_site_urls

  def initialize(migration = nil, params = nil)
    @migration = migration
    if params
      @current_site_urls = params[:current_site_urls]
      @new_site_urls = params[:new_site_urls]
    end
  end

  def save
    valid? && persist!
  end

  private 

  def persist!
    Resource.transaction do
      @new_site_urls.split(/\r?\n/).each do |url| 
        NewResource.find_or_create_by! url: url, migration: @migration
      end

      @current_site_urls.split(/\r?\n/).each do |url| 
        OldResource.find_or_create_by! url: url, migration: @migration
      end
    end
  end
end