require 'test_helper'

class AlertTest < ActiveSupport::TestCase
  test "checks for existing alerts" do
    assert(Alert.open_alerts?(:foobar), "No open alerts")
  end

  test "clears open alerts" do
    Alert.clear_open_alerts(:foobar)
    assert_not(Alert.open_alerts?(:foobar), "Still open alerts after clearing")
  end
end
