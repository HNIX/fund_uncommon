require "application_system_test_case"

class PipelinesTest < ApplicationSystemTestCase
  setup do
    @pipeline = pipelines(:one)
  end

  test "visiting the index" do
    visit pipelines_url
    assert_selector "h1", text: "Pipelines"
  end

  test "creating a Pipeline" do
    visit pipelines_url
    click_on "New Pipeline"

    fill_in "Account", with: @pipeline.account_id
    fill_in "Name", with: @pipeline.name
    fill_in "User", with: @pipeline.user_id
    click_on "Create Pipeline"

    assert_text "Pipeline was successfully created"
    assert_selector "h1", text: "Pipelines"
  end

  test "updating a Pipeline" do
    visit pipeline_url(@pipeline)
    click_on "Edit", match: :first

    fill_in "Account", with: @pipeline.account_id
    fill_in "Name", with: @pipeline.name
    fill_in "User", with: @pipeline.user_id
    click_on "Update Pipeline"

    assert_text "Pipeline was successfully updated"
    assert_selector "h1", text: "Pipelines"
  end

  test "destroying a Pipeline" do
    visit edit_pipeline_url(@pipeline)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Pipeline was successfully destroyed"
  end
end
