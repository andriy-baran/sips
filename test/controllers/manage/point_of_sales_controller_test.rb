require 'test_helper'

class Manage::PointOfSalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_point_of_sale = manage_point_of_sales(:one)
  end

  test "should get index" do
    get manage_point_of_sales_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_point_of_sale_url
    assert_response :success
  end

  test "should create manage_point_of_sale" do
    assert_difference('Manage::PointOfSale.count') do
      post manage_point_of_sales_url, params: { manage_point_of_sale: {  } }
    end

    assert_redirected_to manage_point_of_sale_url(Manage::PointOfSale.last)
  end

  test "should show manage_point_of_sale" do
    get manage_point_of_sale_url(@manage_point_of_sale)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_point_of_sale_url(@manage_point_of_sale)
    assert_response :success
  end

  test "should update manage_point_of_sale" do
    patch manage_point_of_sale_url(@manage_point_of_sale), params: { manage_point_of_sale: {  } }
    assert_redirected_to manage_point_of_sale_url(@manage_point_of_sale)
  end

  test "should destroy manage_point_of_sale" do
    assert_difference('Manage::PointOfSale.count', -1) do
      delete manage_point_of_sale_url(@manage_point_of_sale)
    end

    assert_redirected_to manage_point_of_sales_url
  end
end
