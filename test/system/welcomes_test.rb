require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url
  
    assert_selector "h1", text: "Event List"
  end
end
