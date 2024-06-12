require 'test_helper'
require 'application_system_test_case'
class CompanyTest < ApplicationSystemTestCase
  # test "should get index" do
  #   visit companies_url
  #   assert_selector "h1", text: "Companies"
  # end

  # # Add more tests for other actions or scenarios as needed
  # test "create company" do
  #   post companies_url, params: { company: { name: "Company 1" } }
  #   assert_response :success
  # end

  test "should create company" do
    visit companies_path
    click_on "New company"
    fill_in "Name", with: "Company 1"
    click_on "Create Company"
    assert_text "Company was successfully created"
    click_on "Back to companies"
  end

  test "should update company" do
    visit companies_path
    click_on "New company"
    fill_in "Name", with: "Company 1"
    click_on "Back to companies"
    click_on "Show this company"
    click_on "Edit this company"
    fill_in "Name", with: "Paperino"
    click_on "Update Company"
    assert_text "Paperino"
    click_on "Back to companies"
  end
end
