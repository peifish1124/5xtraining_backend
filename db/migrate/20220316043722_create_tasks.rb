class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :priority
      t.string :status
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
