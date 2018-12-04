require 'test_helper'

class Manage::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_product = manage_products(:one)
  end

  test "should get index" do
    get manage_products_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_product_url
    assert_response :success
  end

  test "should create manage_product" do
    assert_difference('Manage::Product.count') do
      post manage_products_url, params: { manage_product: {  } }
    end

    assert_redirected_to manage_product_url(Manage::Product.last)
  end

  test "should show manage_product" do
    get manage_product_url(@manage_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_product_url(@manage_product)
    assert_response :success
  end

  test "should update manage_product" do
    patch manage_product_url(@manage_product), params: { manage_product: {  } }
    assert_redirected_to manage_product_url(@manage_product)
  end

  test "should destroy manage_product" do
    assert_difference('Manage::Product.count', -1) do
      delete manage_product_url(@manage_product)
    end

    assert_redirected_to manage_products_url
  end
end
