require "test_helper"

class CritiquesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @critique = critiques(:one)
  end

  test "should get index" do
    get critiques_url
    assert_response :success
  end

  test "should get new" do
    get new_critique_url
    assert_response :success
  end

  test "should create critique" do
    assert_difference("Critique.count") do
      post critiques_url, params: { critique: {  } }
    end

    assert_redirected_to critique_url(Critique.last)
  end

  test "should show critique" do
    get critique_url(@critique)
    assert_response :success
  end

  test "should get edit" do
    get edit_critique_url(@critique)
    assert_response :success
  end

  test "should update critique" do
    patch critique_url(@critique), params: { critique: {  } }
    assert_redirected_to critique_url(@critique)
  end

  test "should destroy critique" do
    assert_difference("Critique.count", -1) do
      delete critique_url(@critique)
    end

    assert_redirected_to critiques_url
  end
end
