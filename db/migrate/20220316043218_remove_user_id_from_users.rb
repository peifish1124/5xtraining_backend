class RemoveUserIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :user_id
      t.rename :user_name, :name
    end
  end
end
