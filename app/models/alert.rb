class Alert < ActiveRecord::Base

  def self.open_alerts?(type)
    self.where("type = ? and status = ? and created_at < ?", type, :open, Time.now - 24.hours).empty?
  end

  def self.clear_open_alerts(type)
    self.where("type = ? and status = ?", type, :open).update_all(status: :closed)
  end
end
