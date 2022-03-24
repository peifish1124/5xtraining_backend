require 'rails_helper'
RSpec.describe Task, type: :model do
    describe 'Model Task spec/unit test' do
        let(:new_user) { create(:user) }
        let(:new_task) { create(:task) }
        it 'task should save successfully' do 
            expect(new_task.save).to eq(true)
        end
        it 'should be built by existing user' do
            new_task.user = nil
            expect(new_task.save).to eq(false)  
        end
        it 'task requires title' do
            new_task.title = nil
            expect(new_task.save).to eq(false)  
        end
    end
end