class AddUserIdToEvent < ActiveRecord::Migration
  def up
    add_column :events, :user_id, :integer
    execute("UPDATE events SET user_id = (SELECT id FROM users LIMIT 1)")
  end

  def down
    remove_column :events, :user_id
  end
end
