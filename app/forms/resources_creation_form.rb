class ResourcesCreationForm 
  include ActiveModel::Model

  validates :new_site_urls, presence: true
  validates :current_site_urls, presence: true

  attr_reader :new_site_urls, :current_site_urls

  def initialize(params = {}, current_site = nil, new_site = nil)
    @current_site = current_site
    @new_site = new_site

    @current_site_urls = params[:current_site_urls]
    @new_site_urls = params[:new_site_urls]
  end

  def save
    valid? && persist!
  end

  private 

  def persist!
    Resource.transaction do
      @new_site_urls.split(/\r?\n/).each do |url|
        Resource.find_or_create_by! url: @new_site.relativize_url(url), site: @new_site
      end

      @current_site_urls.split(/\r?\n/).each do |url| 
        Resource.find_or_create_by! url: @current_site.relativize_url(url), site: @current_site
      end
    end
  end
end