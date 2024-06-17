####################################### FOR CHROME #######################################

# require 'test_helper'
# require 'capybara/cuprite'

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :selenium_remote_chrome

#   Capybara.register_driver :selenium_remote_chrome do |app|
#     options = Selenium::WebDriver::Chrome::Options.new
#     options.add_argument('--start-maximized')

#     windows_host = `cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`.strip
#     chromedriver_url = "http://#{windows_host}:9515/"

#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :remote,
#       url: chromedriver_url,
#       capabilities: [options]
#     )
#   end

#   Capybara.configure do |config|
#     config.server_host = 'localhost'
#     config.server_port = 3000
#   end
# end


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

require 'test_helper'
require 'capybara/cuprite'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite

  Capybara.register_driver :cuprite do |app|
    Capybara::Cuprite::Driver.new(
      app,
      headless: true,
      window_size: [1400, 1400],
      browser_options: { 'no-sandbox': nil }
    )
  end

  Capybara.configure do |config|
    config.server_host = 'localhost'
    config.server_port = 3000
  end
end
