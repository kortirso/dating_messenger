# represents user profiles
class Profile < ApplicationRecord
    validates :profile_id, :from_site, presence: true
    validates :profile_id, uniqueness: true

    def new_one?
        !messaged?
    end

    def send_message
        self.messaged = true
        save
    end
end
