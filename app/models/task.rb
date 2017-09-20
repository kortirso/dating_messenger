# represents tasks
class Task < ApplicationRecord
    has_many :profiles, dependent: :destroy

    validates :url, :email, :password, :message, presence: true

    after_commit :scrape_profiles, on: :create

    def profiles_count
        profiles.count
    end

    def scraped_profiles_count
        profiles.scraped.count
    end

    def scrape_progress
        return 'failed' if profiles_count == 0
        "#{scraped_profiles_count * 100 / profiles_count} %"
    end

    def status
        return 'failed' if scrape_progress == 'failed'
        return 'scraped' if scrape_progress == '100 %'
        'active'
    end

    private

    def scrape_profiles
        ScrapeServiceJob.perform_later(self)
    end
end
