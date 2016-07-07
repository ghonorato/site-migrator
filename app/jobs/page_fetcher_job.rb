class PageFetcherJob

  include Sidekiq::Worker

  def perform(migration_id)
    migration = Migration.find(migration_id)

    fetch(migration.current_site)
    fetch(migration.new_site)

    migration.matching_redirects!
  end

  private

  def fetch(site)
    site.resources.find_each do |r| 
      response = Net::HTTP.get_response(site.url, r.url)

      r.http_code = response.code

      case response
        when Net::HTTPSuccess then r.content = Nokogiri::HTML(response.body).text
        when Net::HTTPRedirection then r.redirect_location = response['location']
      end

      r.save
    end
  end
end