class IncomingDataMonitorStrategy < AbstractStrategy

  def run
    Event.data_missing? && Alert.open_alerts?(:incoming)
  end

  def alert_name
    'incoming_data'
  end
end
