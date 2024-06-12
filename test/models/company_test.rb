require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "new company" do
    company = companies(:one)
    assert company.valid?
  end

  test "the page works" do
    visit aziende_url
    assert page.has_content?("New Company")
  end
end
