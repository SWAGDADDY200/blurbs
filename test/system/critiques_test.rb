require "application_system_test_case"

class CritiquesTest < ApplicationSystemTestCase
  setup do
    @critique = critiques(:one)
  end

  test "visiting the index" do
    visit critiques_url
    assert_selector "h1", text: "Critiques"
  end

  test "should create critique" do
    visit critiques_url
    click_on "New critique"

    click_on "Create Critique"

    assert_text "Critique was successfully created"
    click_on "Back"
  end

  test "should update Critique" do
    visit critique_url(@critique)
    click_on "Edit this critique", match: :first

    click_on "Update Critique"

    assert_text "Critique was successfully updated"
    click_on "Back"
  end

  test "should destroy Critique" do
    visit critique_url(@critique)
    click_on "Destroy this critique", match: :first

    assert_text "Critique was successfully destroyed"
  end
end
