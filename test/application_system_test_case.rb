require 'test_helper'
require 'capybara/cuprite'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_remote_chrome

  Capybara.register_driver :selenium_remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')

    windows_host = `cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`.strip
    chromedriver_url = "http://#{windows_host}:9515/"

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: chromedriver_url,
      capabilities: [options]
    )
  end

  Capybara.configure do |config|
    config.server_host = 'localhost'
    config.server_port = 3000
  end
end
