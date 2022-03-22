require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
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
      expect(page).to have_text I18n.t("action.title")
    end

    scenario "has tasks list body" do
      task = create(:task)
      visit root_path
      expect(page).to have_text "task test"
      expect(page).to have_text "this is task test"
      expect(page).to have_text "2022/03/18 at 12:00AM"
      expect(page).to have_text "2022/03/19 at 12:00AM"
      expect(page).to have_text "進行中"
      expect(page).to have_text "高"
      expect(page).to have_text "test"
    end

    scenario "has link to new task page" do
      visit root_path
      find("a[href='#{new_task_path}']").click
      expect(page).to have_text I18n.t("page.new_page")
    end

    scenario "edit task" do
      task = create(:task)
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
      task = create(:task)
      visit root_path
      expect(page).to have_text "task test"
      find("a[href='#{task_path(task)}']").click
      expect(page).to have_text I18n.t("notice.delete")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).not_to have_text "task test"
    end
  end

  context "new task page" do
    scenario "create task" do
      user = create(:user)
      visit new_task_path
      fill_in 'task_title', with: 'test title'
      fill_in 'task_user_id', with: user.id
      click_button I18n.t("button.submit")
      expect(page).to have_text I18n.t("notice.new")
      expect(page).to have_text I18n.t("page.index_page")
      expect(page).to have_text "test title"
    end
  end
end
