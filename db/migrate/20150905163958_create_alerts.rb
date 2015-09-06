class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :status
      t.string :type
      t.string :sent_to

      t.timestamps null: false
    end
  end
end
