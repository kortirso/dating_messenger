# represents tasks
class Task < ApplicationRecord
    has_many :profiles, dependent: :destroy

    validates :url, :email, :password, :message, presence: true
    validates :status, presence: true, inclusion: { in: %w[active scraped failed] }

    after_commit :scrape_profiles, on: :create

    def profiles_count
        profiles.count
    end

    def scraped_profiles_count
        profiles.scraped.count
    end

    def scrape_progress
        return 'none' if profiles_count.zero?
        "#{scraped_profiles_count * 100 / profiles_count} %"
    end

    def current_status
        return 'preparing' if status == 'active' && profiles_count.zero?
        status
    end

    def complete
        self.status = 'scraped'
        save
    end

    private

    def scrape_profiles
        ScrapeServiceJob.perform_later(self)
    end
end
