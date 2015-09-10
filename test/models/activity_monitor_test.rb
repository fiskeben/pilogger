require 'test_helper'

class ActivityMonitorTest < ActiveSupport::TestCase

  test "Runs monitors" do
    assert ActivityMonitor.run
  end

end
