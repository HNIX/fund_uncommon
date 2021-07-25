require "test_helper"

class LeadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lead = leads(:one)
  end

  test "should get index" do
    get leads_url
    assert_response :success
  end

  test "should get new" do
    get new_lead_url
    assert_response :success
  end

  test "should create lead" do
    assert_difference('Lead.count') do
      post leads_url, params: { lead: { account_id: @lead.account_id, address: @lead.address, address2: @lead.address2, address_state: @lead.address_state, city: @lead.city, email: @lead.email, first_name: @lead.first_name, last_name: @lead.last_name, marketing_accepted: @lead.marketing_accepted, phone: @lead.phone, source_id: @lead.source_id, user_id: @lead.user_id, zip_code: @lead.zip_code } }
    end

    assert_redirected_to lead_url(Lead.last)
  end

  test "should show lead" do
    get lead_url(@lead)
    assert_response :success
  end

  test "should get edit" do
    get edit_lead_url(@lead)
    assert_response :success
  end

  test "should update lead" do
    patch lead_url(@lead), params: { lead: { account_id: @lead.account_id, address: @lead.address, address2: @lead.address2, address_state: @lead.address_state, city: @lead.city, email: @lead.email, first_name: @lead.first_name, last_name: @lead.last_name, marketing_accepted: @lead.marketing_accepted, phone: @lead.phone, source_id: @lead.source_id, user_id: @lead.user_id, zip_code: @lead.zip_code } }
    assert_redirected_to lead_url(@lead)
  end

  test "should destroy lead" do
    assert_difference('Lead.count', -1) do
      delete lead_url(@lead)
    end

    assert_redirected_to leads_url
  end
end
