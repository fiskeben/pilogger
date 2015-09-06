class CreateActivityMonitors < ActiveRecord::Migration
  def change
    create_table :activity_monitors do |t|
      t.string :name
      t.string :strategy
      t.string :recipients

      t.timestamps null: false
    end
  end
end
