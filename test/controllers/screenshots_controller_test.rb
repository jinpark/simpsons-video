require 'test_helper'

class ScreenshotsControllerTest < ActionController::TestCase
  setup do
    @screenshot = screenshots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:screenshots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create screenshot" do
    assert_difference('Screenshot.count') do
      post :create, screenshot: { attachment: @screenshot.attachment, episode_number: @screenshot.episode_number, season: @screenshot.season, time: @screenshot.time }
    end

    assert_redirected_to screenshot_path(assigns(:screenshot))
  end

  test "should show screenshot" do
    get :show, id: @screenshot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @screenshot
    assert_response :success
  end

  test "should update screenshot" do
    patch :update, id: @screenshot, screenshot: { attachment: @screenshot.attachment, episode_number: @screenshot.episode_number, season: @screenshot.season, time: @screenshot.time }
    assert_redirected_to screenshot_path(assigns(:screenshot))
  end

  test "should destroy screenshot" do
    assert_difference('Screenshot.count', -1) do
      delete :destroy, id: @screenshot
    end

    assert_redirected_to screenshots_path
  end
end
