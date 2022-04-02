module Helpers
    def sign_up
        visit sign_up_path
        fill_in 'user_name', with: 'Rail'
        fill_in 'user_email', with: 'rail@gmail.com'
        fill_in 'user_password', with: '1234'
        click_button 'commit'
    end

    def sign_in
        sign_up
        visit login_path
        fill_in 'email', with:'rail@gmail.com'
        fill_in 'password', with:'1234'
        click_button 'commit'
    end

    def create_tasks
        sign_in
        visit new_task_path
        fill_in 'task_title', with: 'first'
        click_button 'commit'

        visit new_task_path
        fill_in 'task_title', with: 'second'
        click_button 'commit'
    end
end