require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  context "home page" do
    scenario "has home page title" do
      visit root_path
      expect(page).to have_text "任務列表"
    end

    scenario "has tasks list header" do
      visit root_path
      expect(page).to have_text "標題"
      expect(page).to have_text "內容"
      expect(page).to have_text "開始時間"
      expect(page).to have_text "結束時間"
      expect(page).to have_text "狀態"
      expect(page).to have_text "優先順序"
      expect(page).to have_text "分類標籤"
      expect(page).to have_text "處理"
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
      expect(page).to have_text "新增任務"
    end

    scenario "edit task" do
      task = create(:task)
      visit root_path
      find("a[href='#{edit_task_path(task)}']").click
      expect(page).to have_content "編輯任務"
      expect(page).to have_field("標題", with: "task test")
      fill_in "標題", with: "edit task name"
      click_button "Update Task"
      expect(page).to have_text "任務更新成功！"
      expect(page).to have_text "任務列表"
      expect(page).to have_text "edit task name"
    end

    scenario "delete task" do
      task = create(:task)
      visit root_path
      expect(page).to have_text "task test"
      find("a[href='#{task_path(task)}']").click
      expect(page).to have_text "任務已刪除！"
      expect(page).to have_text "任務列表"
      expect(page).not_to have_text "task test"
    end
  end

  context "new task page" do
    scenario "create task" do
      user = create(:user)
      visit new_task_path
      fill_in '標題', with: 'test title'
      fill_in '使用者序號', with: user.id
      click_button 'Create Task'
      expect(page).to have_text "新增任務成功！"
      expect(page).to have_text "任務列表"
      expect(page).to have_text "test title"
    end
  end
end
