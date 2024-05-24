require "test_helper"

class SpendingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spending = spendings(:one)
  end

  test "should get index" do
    get vendor_spendings_url
    assert_response :success
  end

  test "should get new" do
    get new_vendor_spending_url
    assert_response :success
  end

  test "should create spending" do
    assert_difference("Spending.count") do
      post vendor_spendings_url,
           params: { spending: { amount: @spending.amount, type: @spending.type, vendor_id: @spending.vendor_id } }
    end

    assert_redirected_to vendor_spending_url(Spending.last)
  end

  test "should show spending" do
    get vendor_spending_url(@spending)
    assert_response :success
  end

  test "should get edit" do
    get edit_vendor_spending_url(@spending)
    assert_response :success
  end

  test "should update spending" do
    patch vendor_spending_url(@spending),
          params: { spending: { amount: @spending.amount, type: @spending.type, vendor_id: @spending.vendor_id } }
    assert_redirected_to vendor_spending_url(@spending)
  end

  test "should destroy spending" do
    assert_difference("Spending.count", -1) do
      delete vendor_spending_url(@spending)
    end

    assert_redirected_to vendor_spendings_url
  end
end
