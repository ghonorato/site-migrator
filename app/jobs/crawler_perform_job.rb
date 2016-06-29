class CrawlerPerformJob
  include Sidekiq::Worker
  sidekiq_options queue: 'crawler_perform_job'

  def perform(page)
    r = Resource.find_or_create_by(url: page['url'], site_id: page['crawl_id'] )
    r.http_code = page['status_code']

    doc = Nokogiri::HTML(page['body'])
    r.content = doc.at('body').inner_text

    r.save!
  end
end