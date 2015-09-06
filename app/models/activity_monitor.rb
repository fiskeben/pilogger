class ActivityMonitor < ActiveRecord::Base

  def self.run
    self.all.each do | monitor |
      monitor.start
    end
  end

  def start
    runner = strategy.constantize
    if runner.run
      MonitorMailer.notify(recipients, name).deliver_now
    end
  end
end
