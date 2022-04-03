RSpec.shared_context 'user' do 
    let(:user_params) do
      {name: 'Rail', 
       email: 'rail@gmail.com', 
       password: '1234'}
    end
  
    def sign_up
      visit sign_up_path
      fill_in 'user[name]', with: user_params[:name]
      fill_in 'user[email]', with: user_params[:email]
      fill_in 'user[password]', with: user_params[:password]
      click_button 'commit'
    end 
  
    def login
      visit login_path
      fill_in 'email', with: user_params[:email]
      fill_in 'password', with: user_params[:password]
      click_button 'commit'
   end
  
   def create_tasks
      visit new_task_path
      fill_in 'task[title]', with: 'first'
      click_button 'commit'
  
      visit new_task_path
      fill_in 'task[title]', with: 'second'
      click_button 'commit'
   end
  end