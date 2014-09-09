require 'test_helper'

class TwitchControllerTest < ActionController::TestCase
  test "should get to_twitch" do
    get :to_twitch
    assert_response :success
  end

  test "should get from_twitch" do
    get :from_twitch
    assert_response :success
  end

end
