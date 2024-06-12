require 'test_helper'
require 'capybara/cuprite'
require 'webdrivers'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  Webdrivers::Chromedriver.required_version = '125.0.6422.141' # Aggiungi questa riga
end
