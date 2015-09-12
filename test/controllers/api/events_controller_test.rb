require 'test_helper'

class Api::EventsControllerTest < ActionController::TestCase

  test "should get events from last 24 hours" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
    assert_equal 2, assigns(:events).length
  end

  test "should get events newer than" do
    get :index, {from: Time.now - 90.minutes}
    assert_response :success
    assert_not_nil assigns(:events)
    assert_equal 1, assigns(:events).length
  end

  test "should get events within duration" do
    get :index, {from: Time.now - 30.hours, to: Time.now - 20.hours}
    assert_response :success
    assert_not_nil assigns(:events)
    assert_equal 1, assigns(:events).length
  end

  test "should create event" do
    authenticate_user

    assert_difference('Event.count') do
      post(:create, {event: {name: 'temperature', occurred_at: Time.now, value: 12.3}})
    end
    assert_response :success
  end

  test "should update event" do
    authenticate_user

    put(:create, {event: {id: 1, name: 'temperature', occurred_at: Time.now, value: 2.3}})
    assert_response :success
  end

  test "should delete event" do
    authenticate_user

    assert_difference('Event.count', -1) do
      delete(:destroy, id: 1)
    end
  end

  test "should create event with timestamp" do
    authenticate_user

    timestamp = 1441558027345

    post(:create, {event: {name: 'foo', occurred_at: timestamp, value: 12.3}})
    assert_not_nil(assigns[:event].occurred_at)
  end

  def authenticate_user
    now = Time.now
    date_string = now.strftime('%a, %e %b %Y %H:%M:%S %Z')
    authentication_token = Digest::SHA1.hexdigest("abc\n123\n#{date_string}")
    @request.headers["HTTP_DATE"] = date_string
    @request.headers["HTTP_AUTHORIZATION"] = "Token token=abc:#{authentication_token}"
  end
end
