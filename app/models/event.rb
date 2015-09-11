class Event < ActiveRecord::Base

  def self.in_duration(from, to)
    now = Time.now
    from_time = (from) ? Time.parse(from) : now - 1.day
    to_time = (to) ? Time.parse(to) : now

    self.where("occurred_at > ? and occurred_at < ?", from_time, to_time)
  end

  def self.data_missing?
    self.where("occurred_at > ?", 15.minutes.ago).empty?
  end

  def timestamp
    self.occurred_at.to_f * 1000;
  end

  def occurred_at=(value)
    if value && (value =~ /^\d*$/) == 0
      some_date = Time.at(value.to_f/1000)
      super(some_date)
    else
      super(value)
    end
  end
end
