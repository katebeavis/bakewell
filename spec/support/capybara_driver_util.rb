class CapybaraDriverUtil
  class << self
    # register a Selenium driver for the given browser to run on the localhost
    def register_selenium_local_driver(browser)
      Capybara.register_driver "selenium_#{browser}".to_sym do |app|
        Capybara::Selenium::Driver.new(app, browser: browser)
      end
    end

    # register a Selenium driver for the given browser to run with a Selenium
    # Server on another host
    def register_selenium_remote_driver(browser)
      Capybara.register_driver "selenium_remote_#{browser}".to_sym do |app|
        Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://#{ENV['SELENIUM_SERVER']}:4444/wd/hub", desired_capabilities: browser)
      end
    end

    def selenium_remote?
      !(Capybara.current_driver.to_s =~ /\Aselenium_remote/).nil?
    end

    # The ip address at which our test server is accessible by a remote agent like Selenium
    def test_server_ip
      ip = `hostname -i`
      ip.gsub("\n", "")
    end

    # The port at which our test server is accessible
    def test_server_port
      3000
    end
  end
end
