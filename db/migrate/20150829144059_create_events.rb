class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.timestamp :occurred_at
      t.float :value

      t.timestamps null: false
    end
  end
end
