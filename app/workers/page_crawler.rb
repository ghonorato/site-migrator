class PageCrawler
  include Sidekiq::Worker
  def perform(site_id, url = '/', image: false)
    site = Site.find(site_id)
    
    r = Resource.find_or_create_by(site_id: site_id, url: url)

    unless r.fresh?
      begin
        response = Net::HTTP.get_response(site.url, url)
        r.content = response.body
      rescue Net::HTTPClientError => e
      end

      r.http_code = response.code
      r.redirect_location = response['location'] if r.redirect?
      r.save

      if r.ok?
        doc = Nokogiri::HTML(r.content)
        links(site, doc).each do |url|
          PageCrawler.perform_async(site_id, site.relativize_url(url))
        end
      elsif r.redirect?
        PageCrawler.perform_async(site_id, site.relativize_url(r.redirect_location)) if site.follow_url?(r.redirect_location)
      end
    end
  end

  def links(site, doc)
    links = doc.css('a')
    links.map { |link| link.attribute('href').to_s }.uniq.delete_if { |href| !site.follow_url?(href) }
  end
end