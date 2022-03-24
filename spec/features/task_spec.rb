require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let(:tasks) { create_list(:task, 2) }

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
      expect(page).to have_text Task.human_attribute_name(:tag)
      expect(page).to have_text Task.human_attribute_name(:created_at)
      expect(page).to have_text I18n.t("action.title")
    end

    scenario "has tasks list body" do
      visit root_path
      expect(page).to have_text "task test"
      expect(page).to have_text "this is task test"
      expect(page).to have_text "2022/03/18 at 12:00AM"
      expect(page).to have_text "2022/03/19 at 12:00AM"
      expect(page).to have_text "進行中"
      expect(page).to have_text "高"
      expect(page).to have_text "test"
      expect(page).to have_text "2022/03/17 at 12:00AM"
    end

    scenario "has link to new task page" do
      visit root_path
      find("a[href='#{new_task_path}']").click
      expect(page).to have_text I18n.t("page.new_page")
    end

    scenario "edit task" do
      visit root_path
      find("a[href='#{edit_task_path(task)}']").click
      expect(page).to have_content I18n.t("page.edit_page")
      expect(page).to have_field("task_title", with: "task test")
      fill_in "task_title", with: "edit task name"
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.update")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).to have_text "edit task name"
    end

    scenario "delete task" do
      visit root_path
      expect(page).to have_text "task test"
      find("a[href='#{task_path(task)}']").click
      expect(page).to have_text I18n.t("notice.delete")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).not_to have_text "task test"
    end

  end

  context "sort by different ways" do
    scenario "sorted by created time" do
      travel_to(Time.new(2100, 1, 1, 0, 0, 0)){ create(:task, title: "title1")}
      travel_to(Time.new(2100, 1, 2, 0, 0, 0)){ create(:task, title: "title2") }

      visit root_path
      click_link Task.human_attribute_name(:created_at)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "task test")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "title1")
      expect(page).to have_css("#task_table tr:nth-child(4) td:nth-child(1)", :text => "title2")
    end

    scenario "sorted by end time" do
      tasks[0].update(end_time: DateTime.now+1.hour, title: 'title1')
      tasks[1].update(end_time: DateTime.now+2.hour, title: 'title2')
      task.update(end_time: DateTime.now)

      visit root_path
      click_link Task.human_attribute_name(:end_time)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "task test")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "title1")
      expect(page).to have_css("#task_table tr:nth-child(4) td:nth-child(1)", :text => "title2")
    end

    scenario "sorted by priority" do
      tasks[0].update(priority: 1, title: 'title1')
      tasks[1].update(priority: 0, title: 'title2')
      task.update(priority: 2)
        #.map{[t("priority.#{}"),]}
      visit root_path
      click_link Task.human_attribute_name(:priority)
      expect(page).to have_css("#task_table tr:nth-child(2) td:nth-child(1)", :text => "title2")
      expect(page).to have_css("#task_table tr:nth-child(3) td:nth-child(1)", :text => "title1")
      expect(page).to have_css("#task_table tr:nth-child(4) td:nth-child(1)", :text => "task test")
    end
  end

  context "new task page" do
    scenario "create task" do
      visit new_task_path
      fill_in 'task_title', with: 'test title'
      fill_in 'task_user_id', with: user.id
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.new")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).to have_text "test title"
    end

    scenario "create task requires title" do
      visit new_task_path
      fill_in 'task_user_id', with: user.id
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.title_require")
      expect(page).to have_text I18n.t("page.new_page")
    end
  end
end
