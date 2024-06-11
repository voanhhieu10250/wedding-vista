require "test_helper"

class ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tools_index_url
    assert_response :success
  end

  test "should get checklist" do
    get tools_checklist_url
    assert_response :success
  end

  test "should get budget" do
    get tools_budget_url
    assert_response :success
  end
end
