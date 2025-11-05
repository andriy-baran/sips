require "test_helper"

class Manage::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_account = manage_accounts(:one)
  end

  test "should get index" do
    get manage_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_account_url
    assert_response :success
  end

  test "should create manage_account" do
    assert_difference("Manage::Account.count") do
      post manage_accounts_url, params: { manage_account: {} }
    end

    assert_redirected_to manage_account_url(Manage::Account.last)
  end

  test "should show manage_account" do
    get manage_account_url(@manage_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_account_url(@manage_account)
    assert_response :success
  end

  test "should update manage_account" do
    patch manage_account_url(@manage_account), params: { manage_account: {} }
    assert_redirected_to manage_account_url(@manage_account)
  end

  test "should destroy manage_account" do
    assert_difference("Manage::Account.count", -1) do
      delete manage_account_url(@manage_account)
    end

    assert_redirected_to manage_accounts_url
  end
end
