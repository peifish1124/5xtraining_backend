require 'rails_helper'
RSpec.describe Task, type: :model do
    describe 'Model Task spec/unit test' do
        let(:new_user) {
            User.new(name: 'Peifish')
        }
        let(:new_task) {
            Task.new(title:'title', content:'content', status: '進行中', tag: 'test', priority: '低', 
                    start_time: DateTime.now, end_time: DateTime.now, user: new_user)
        }
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