class IncomingDataMonitorStrategy < AbstractStrategy

  def run
    should_notify = Event.data_missing? && Alert.open_alerts?(:incoming)
    Alert.clear_open_alerts(:incoming) unless should_notify
    should_notify
  end

end
