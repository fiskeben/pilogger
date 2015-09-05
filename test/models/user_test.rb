require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can authenticate" do
    date = Time.parse("2015-08-30 12:34:56 UTC")
    travel_to date

    digest = 'f24304f9ac8125bcc58686ac90267b4d24d342d3'
    date_string = date.strftime('%a, %e %b %Y %H:%M:%S %Z')
    assert users(:one).authenticate_digest(digest, date_string)
  end
end
