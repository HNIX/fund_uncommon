require "application_system_test_case"

class LeadsTest < ApplicationSystemTestCase
  setup do
    @lead = leads(:one)
  end

  test "visiting the index" do
    visit leads_url
    assert_selector "h1", text: "Leads"
  end

  test "creating a Lead" do
    visit leads_url
    click_on "New Lead"

    fill_in "Account", with: @lead.account_id
    fill_in "Address", with: @lead.address
    fill_in "Address2", with: @lead.address2
    fill_in "Address state", with: @lead.address_state
    fill_in "City", with: @lead.city
    fill_in "Email", with: @lead.email
    fill_in "First name", with: @lead.first_name
    fill_in "Last name", with: @lead.last_name
    check "Marketing accepted" if @lead.marketing_accepted
    fill_in "Phone", with: @lead.phone
    fill_in "Source", with: @lead.source_id
    fill_in "User", with: @lead.user_id
    fill_in "Zip code", with: @lead.zip_code
    click_on "Create Lead"

    assert_text "Lead was successfully created"
    assert_selector "h1", text: "Leads"
  end

  test "updating a Lead" do
    visit lead_url(@lead)
    click_on "Edit", match: :first

    fill_in "Account", with: @lead.account_id
    fill_in "Address", with: @lead.address
    fill_in "Address2", with: @lead.address2
    fill_in "Address state", with: @lead.address_state
    fill_in "City", with: @lead.city
    fill_in "Email", with: @lead.email
    fill_in "First name", with: @lead.first_name
    fill_in "Last name", with: @lead.last_name
    check "Marketing accepted" if @lead.marketing_accepted
    fill_in "Phone", with: @lead.phone
    fill_in "Source", with: @lead.source_id
    fill_in "User", with: @lead.user_id
    fill_in "Zip code", with: @lead.zip_code
    click_on "Update Lead"

    assert_text "Lead was successfully updated"
    assert_selector "h1", text: "Leads"
  end

  test "destroying a Lead" do
    visit edit_lead_url(@lead)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Lead was successfully destroyed"
  end
end
