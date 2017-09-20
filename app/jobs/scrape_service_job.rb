# Perform scrape service
class ScrapeServiceJob < ApplicationJob
    queue_as :default

    def perform(task)
        ScrapingService.new(task: task).scrape
    end
end
