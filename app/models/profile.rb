# represents user profiles
class Profile < ApplicationRecord
    validates :profile_id, :from_site, presence: true
    validates :profile_id, uniqueness: true
end
