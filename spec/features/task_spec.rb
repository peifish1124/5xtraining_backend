require 'rails_helper'
require './spec/shared/user'

RSpec.configure do |c|
  c.include_context "user"
end

RSpec.feature "Tasks", type: :feature do

  before do 
    sign_up
    login
    create_tasks
  end

  context "home page" do    
    scenario "has home page title" do
      visit root_path
      expect(page).to have_text I18n.t("page.index_page")
    end

    scenario "has tasks list header" do
      visit root_path
      expect(page).to have_text Task.human_attribute_name(:title)
      expect(page).to have_text Task.human_attribute_name(:content)
      expect(page).to have_text Task.human_attribute_name(:start_time)
      expect(page).to have_text Task.human_attribute_name(:end_time)
      expect(page).to have_text Task.human_attribute_name(:status)
      expect(page).to have_text Task.human_attribute_name(:priority)
      expect(page).to have_text I18n.t("tag")
      expect(page).to have_text Task.human_attribute_name(:created_at)
      expect(page).to have_text I18n.t("action.update_status")
      expect(page).to have_text I18n.t("action.title")
    end

    scenario "has tasks list body" do
      visit root_path
      expect(page).to have_text "first"
    end

    scenario "has link to new task page" do
      visit root_path
      find("a[href='#{new_task_path}']").click
      expect(page).to have_text I18n.t("page.new_page")
    end

    scenario "edit task" do
      task = Task.find_by(title: 'first').id
      visit root_path
      find("a[href='#{edit_task_path(task)}']").click
      expect(page).to have_content I18n.t("page.edit_page")
      expect(page).to have_field("task_title", with: "first")
      fill_in "task_title", with: "edit task name"
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.update")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).to have_text "edit task name"
    end

    scenario "delete task" do
      task = Task.find_by(title: 'first').id
      visit root_path
      expect(page).to have_text "first"
      find("a[href='#{task_path(task)}']").click
      expect(page).to have_text I18n.t("notice.delete")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).not_to have_text "first"
    end

  end

  context "search by different ways" do
    scenario "search by title" do
      visit root_path

      fill_in 'q_title_cont_any', with: 'first'
      click_button 'commit'

      expect(page).not_to have_text('second')
    end

    scenario "search by status" do
      task1 = Task.find_by(title: 'first')
      task2 = Task.find_by(title: 'second') 
      task1.update(status: 'pending')
      task2.update(status: 'done')
      visit root_path 
      find(:css , '#q_status_eq_pending').click
      click_button 'commit'

      expect(page).not_to have_text('second')
    end
  end

  context "sort by different ways" do
    scenario "sorted by created time" do
      visit root_path
      click_link Task.human_attribute_name(:created_at)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "first")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "second")
    end

    scenario "sorted by end time" do
      task1 = Task.find_by(title: 'first')
      task2 = Task.find_by(title: 'second')
      task1.update(end_time: DateTime.now+1.hour)
      task2.update(end_time: DateTime.now+2.hour)

      visit root_path
      click_link Task.human_attribute_name(:end_time)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "first")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "second")
    end

    scenario "sorted by priority" do
      task1 = Task.find_by(title: 'first')
      task2 = Task.find_by(title: 'second')
      task1.update(priority: 0)
      task2.update(priority: 1)
        
      visit root_path
      click_link Task.human_attribute_name(:priority)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "first")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "second")

    end
  end

  context "new task page" do
    scenario "create task" do
      visit new_task_path
      fill_in 'task_title', with: 'test title'
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.new")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).to have_text "test title"
    end

    scenario "create task requires title" do
      visit new_task_path
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.title_require")
      expect(page).to have_text I18n.t("page.new_page")
    end
  end
end
