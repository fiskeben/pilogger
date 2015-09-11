class RenameTypeToAlertName < ActiveRecord::Migration
  def change
    change_table :alerts do |t|
      t.rename :type, :name
    end
  end
end
