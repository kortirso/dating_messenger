RSpec.describe Task, type: :model do
    it { should have_many(:profiles).dependent(:destroy) }
    it { should validate_presence_of :url }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :message }

    it 'should be valid' do
        task = create :task

        expect(task).to be_valid
    end
end
