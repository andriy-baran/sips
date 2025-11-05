require "application_system_test_case"

class Manage::AccountsTest < ApplicationSystemTestCase
  setup do
    @manage_account = manage_accounts(:one)
  end

  test "visiting the index" do
    visit manage_accounts_url
    assert_selector "h1", text: "Accounts"
  end

  test "should create account" do
    visit manage_accounts_url
    click_on "New account"

    click_on "Create Account"

    assert_text "Account was successfully created"
    click_on "Back"
  end

  test "should update Account" do
    visit manage_account_url(@manage_account)
    click_on "Edit this account", match: :first

    click_on "Update Account"

    assert_text "Account was successfully updated"
    click_on "Back"
  end

  test "should destroy Account" do
    visit manage_account_url(@manage_account)
    click_on "Destroy this account", match: :first

    assert_text "Account was successfully destroyed"
  end
end
