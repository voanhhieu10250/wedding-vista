require "application_system_test_case"

class AddressesTest < ApplicationSystemTestCase
  setup do
    @address = addresses(:one)
  end

  test "visiting the index" do
    visit addresses_url
    assert_selector "h1", text: "Addresses"
  end

  test "should create address" do
    visit addresses_url
    click_on "New address"

    fill_in "District", with: @address.district
    fill_in "Full address", with: @address.full_address
    fill_in "Latitude", with: @address.latitude
    fill_in "Longitude", with: @address.longitude
    fill_in "Phone", with: @address.phone
    fill_in "Province", with: @address.province
    fill_in "Service", with: @address.service_id
    click_on "Create Address"

    assert_text "Address was successfully created"
    click_on "Back"
  end

  test "should update Address" do
    visit address_url(@address)
    click_on "Edit this address", match: :first

    fill_in "District", with: @address.district
    fill_in "Full address", with: @address.full_address
    fill_in "Latitude", with: @address.latitude
    fill_in "Longitude", with: @address.longitude
    fill_in "Phone", with: @address.phone
    fill_in "Province", with: @address.province
    fill_in "Service", with: @address.service_id
    click_on "Update Address"

    assert_text "Address was successfully updated"
    click_on "Back"
  end

  test "should destroy Address" do
    visit address_url(@address)
    click_on "Destroy this address", match: :first

    assert_text "Address was successfully destroyed"
  end
end
