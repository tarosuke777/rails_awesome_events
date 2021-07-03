require "test_helper"

class StatusControllerTest < ActionDispatch::IntegrationTest
  test "GET /status" do
    get "/status"
    assert_response(:success)
    assert_equal({ status: "ok"}.to_json, @response_body)
    assert_equal("application/json: ok", @response_media_type)
  end
end
