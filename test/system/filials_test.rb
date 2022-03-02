require "application_system_test_case"

class FilialsTest < ApplicationSystemTestCase
  setup do
    @filial = filials(:one)
  end

  test "visiting the index" do
    visit filials_url
    assert_selector "h1", text: "Filials"
  end

  test "should create filial" do
    visit filials_url
    click_on "New filial"

    fill_in "Address", with: @filial.address
    fill_in "Name", with: @filial.name
    click_on "Create Filial"

    assert_text "Filial was successfully created"
    click_on "Back"
  end

  test "should update Filial" do
    visit filial_url(@filial)
    click_on "Edit this filial", match: :first

    fill_in "Address", with: @filial.address
    fill_in "Name", with: @filial.name
    click_on "Update Filial"

    assert_text "Filial was successfully updated"
    click_on "Back"
  end

  test "should destroy Filial" do
    visit filial_url(@filial)
    click_on "Destroy this filial", match: :first

    assert_text "Filial was successfully destroyed"
  end
end
