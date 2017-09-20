# represents tasks
class Task < ApplicationRecord
    has_many :profiles, dependent: :destroy

    after_commit :scrape_profiles, on: :create

    def profiles_count
        profiles.count
    end

    def scraped_profiles_count
        profiles.scraped.count
    end

    def scrape_progress
        scraped_profiles_count * 100 / profiles_count
    end

    private

    def scrape_profiles
        ScrapeServiceJob.perform_later(self)
    end
end
