class Event < ActiveRecord::Base

  validates_presence_of :occurred_at, :value, :name

  def self.in_duration(from, to)
    now = Time.now
    from_time = (from) ? Time.parse(from) : 1.day.ago
    to_time = (to) ? Time.parse(to) : now

    self.where("occurred_at > ? and occurred_at < ?", from_time, to_time)
  end

  def self.data_missing?
    self.where("created_at > ?", 15.minutes.ago).empty?
  end

  def timestamp
    self.occurred_at.to_f * 1000;
  end

  def occurred_at=(value)
    if !value
      super(value)
    else
      super(value_as_date(value))
    end
  end

  private
  def value_as_date(value)
    string_value = value.to_s
    if (string_value =~ /^\d*$/) == 0
      Time.at(value.to_f/1000)
    else
      value
    end
  end
end
