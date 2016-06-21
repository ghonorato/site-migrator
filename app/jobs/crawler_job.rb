class CrawlerJob
  
  include Sidekiq::Worker
  
  def perform(site_id)
    site = Site.find(site_id)
    
    c = CobwebCrawler.new(
      internal_urls: ["http://#{site.url}/*"],
      thread_count: 5
    )

    c.crawl("http://#{site.url}") do |page|
      r = Resource.find_or_create_by(url: page[:url], site_id: site_id )
      r.http_code = page[:status_code]
      r.content = page[:body]
      r.save
    end
  end
end