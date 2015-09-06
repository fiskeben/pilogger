require 'test_helper'

class ActivityMonitorTest < ActiveSupport::TestCase

  test "Runs monitors" do
    ActivityMonitor.run
  end

end
