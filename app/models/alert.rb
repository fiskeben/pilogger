class Alert < ActiveRecord::Base

  def self.open_alerts?(type)
    !self.where("name = ? and status = ? and created_at > ?", type, :open, 24.hours.ago).empty?
  end

  def self.clear_open_alerts(type)
    self.where("name = ? and status = ?", type, :open).update_all(status: :closed)
  end
end
