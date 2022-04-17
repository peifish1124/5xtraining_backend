class CreateTagRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_relations do |t|
      t.integer :tag_id, null: false, foreign_key: true
      t.integer :task_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
