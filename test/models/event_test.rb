require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "checks for missing data" do
    assert_not Event.data_missing?, "No events in last 15 minutes"
  end

  test "sets occurred_at from timestamp" do
    e = Event.new
    e.occurred_at = 1442042000266
    assert(e.occurred_at.is_a?(ActiveSupport::TimeWithZone), "occurred_at is of wrong class")
    assert(e.occurred_at.strftime('%Y-%m-%d %H:%M:%S') == '2015-09-12 07:13:20', "Timestamp does not match expected time")
  end

  test "sets occurred_at from Time" do
    e = Event.new
    now = Time.now
    e.occurred_at = now
    assert(e.occurred_at.is_a?(ActiveSupport::TimeWithZone), "occurred_at is of wrong class")
    assert(e.occurred_at == now, "Times do not match")
  end
end
