# Perform scrape service
class ScrapeServiceJob < ApplicationJob
    queue_as :default

    def perform(scrape_params)
        ScrapingService.new(scrape_params).scrape
    end
end
