require "application_system_test_case"

class Manage::PointOfSalesTest < ApplicationSystemTestCase
  setup do
    @manage_point_of_sale = manage_point_of_sales(:one)
  end

  test "visiting the index" do
    visit manage_point_of_sales_url
    assert_selector "h1", text: "Manage/Point Of Sales"
  end

  test "creating a Point of sale" do
    visit manage_point_of_sales_url
    click_on "New Manage/Point Of Sale"

    click_on "Create Point of sale"

    assert_text "Point of sale was successfully created"
    click_on "Back"
  end

  test "updating a Point of sale" do
    visit manage_point_of_sales_url
    click_on "Edit", match: :first

    click_on "Update Point of sale"

    assert_text "Point of sale was successfully updated"
    click_on "Back"
  end

  test "destroying a Point of sale" do
    visit manage_point_of_sales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Point of sale was successfully destroyed"
  end
end
