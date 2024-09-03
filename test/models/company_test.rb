require "test_helper"
require "capybara/rails"

class CompanyTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @company = companies(:one)
    visit aziende_index_path
  end

  test "the page works" do
    visit aziende_index_path
    assert page.has_content?("New Company")
  end
end
