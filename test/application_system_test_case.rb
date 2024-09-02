####################################### FOR CHROME #######################################

require "test_helper"

WINDOWS_HOST = `cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'`.strip
CHROMEDRIVER_URL = "http://#{WINDOWS_HOST}:59317/"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :selenium_remote_chrome

  Capybara.register_driver :selenium_remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: CHROMEDRIVER_URL
    )
  end

  Capybara.configure do |config|
    # Match what's set for URL options in test.rb so we
    # can test mailers that contain links.
    config.server_host = 'localhost'
    config.server_port = 3000
  end


end

####################################### FOR FIREFOX #######################################

# require 'test_helper'
# require 'capybara/cuprite'

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :selenium_remote_firefox

#   Capybara.register_driver :selenium_remote_firefox do |app|
#     options = Selenium::WebDriver::Firefox::Options.new
#     options.add_argument('--start-maximized')

#     windows_host = `cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`.strip
#     firefoxdriver_url = "http:/127.0.0.1:4444/wd/hub" # Assicurati che questa sia la corretta URL per il WebDriver di Firefox

#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :remote,
#       url: firefoxdriver_url,
#       capabilities: [options]
#     )
#   end

#   Capybara.configure do |config|
#     config.server_host = 'localhost'
#     config.server_port = 3000
#   end
# end

####################################### FOR HEADLESS CHROME #######################################

# require 'test_helper'
# require 'capybara/cuprite'

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :cuprite

#   Capybara.register_driver :cuprite do |app|
#     Capybara::Cuprite::Driver.new(
#       app,
#       headless: true,
#       window_size: [1400, 1400],
#       browser_options: { 'no-sandbox': nil }
#     )
#   end

#   Capybara.configure do |config|
#     config.server_host = 'localhost'
#     config.server_port = 3000
#   end
# end
