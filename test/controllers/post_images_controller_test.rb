require 'test_helper'

class PostImagesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
