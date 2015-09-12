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
      Alert.create({:status => :open, :name => runner.alert_name, :sent_to => recipients})
    else
      Alert.clear_open_alerts(runner.alert_name)
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
