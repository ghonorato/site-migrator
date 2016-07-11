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
      c = Cobweb.new
      response = c.get(r.full_url)

      r.status_code = response[:status_code]

      doc = Nokogiri::HTML(response[:body])
      
      r.title = page_title(doc)
      r.meta_description = page_meta_descripiton(doc)
      r.redirect_through = response[:redirect_through]
      r.response_time = response[:response_time]
      r.no_index = no_index?(doc)

      r.save
    end
  end

  def page_title(doc)
    doc.at_css('title')&.text
  end

  def page_meta_descripiton(doc)
    doc.at_css('meta[name=description]')&.attribute('content')
  end

  def no_index?(doc)
    doc.at_css('meta[name=robots]')&.attribute('content')&.split(',')&.reduce(false) do |memo, value|
      memo ||=  ['noindex','nofollow'].include?(value.strip.downcase)
    end
  end
end