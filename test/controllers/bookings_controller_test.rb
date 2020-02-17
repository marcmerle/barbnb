require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get bookings_show_url
    assert_response :success
  end

  test "should get edit" do
    get bookings_edit_url
    assert_response :success
  end

end
