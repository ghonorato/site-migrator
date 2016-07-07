require 'test_helper'

class UrlMatchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get url_match_index_url
    assert_response :success
  end

end
