class MonitorMailer < ApplicationMailer
  def notify(recipients, monitor_name)
    @name = monitor_name
    mail(to: recipients, subject: "#{monitor_name} seems to be down")
  end
end
