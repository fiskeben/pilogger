class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :api_key
      t.string :api_secret

      t.timestamps null: false
    end
  end
end
