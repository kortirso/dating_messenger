# represents user profiles
class Profile < ApplicationRecord
    belongs_to :task

    validates :profile_id, :from_site, :task_id, presence: true
    validates :profile_id, uniqueness: true

    scope :scraped, -> { where(messaged: true) }
    scope :unscraped, -> { where(messaged: false) }

    def new_one?
        !messaged?
    end

    def send_message
        self.messaged = true
        save
    end
end
