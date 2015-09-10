class ActivityMonitor < ActiveRecord::Base

  def self.run
    self.all.each do | monitor |
      monitor.start
    end
  end

  def start
    runner = strategy_instance
    if runner.run
      MonitorMailer.notify(recipients, name).deliver_now
    end
  end

  private
  def strategy_instance
    begin
      strategy.constantize.new
    rescue NameError => e
      Rails.logger.error "Unknown monitoring strategy '#{strategy}'"
      AbstractStrategy.new
    end
  end
end
