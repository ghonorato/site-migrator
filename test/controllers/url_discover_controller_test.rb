require 'test_helper'

class UrlDiscoverControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get url_discover_index_url
    assert_response :success
  end

end
