RSpec.describe Profile, type: :model do
    it { should validate_presence_of :profile_id }
    it { should validate_presence_of :from_site }
    it { should validate_uniqueness_of :profile_id }

    it 'should be valid' do
        profile = create :profile

        expect(profile).to be_valid
    end
end
