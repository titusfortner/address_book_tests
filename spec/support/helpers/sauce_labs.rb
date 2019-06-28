require 'sauce_whisk'

module SauceLabs
  def initialize_driver(name = nil)
    @name = name || "Unknown Test at #{Time.now.to_i}"

    opts = {url: "https://ondemand.saucelabs.com:443/wd/hub",
            platform_name: 'macOS 10.14',
            browser_name: 'firefox',
            browser_version: 'latest',
            'sauce:options' => {name: name,
                                build: build_name,
                                username: ENV['SAUCE_USERNAME'],
                                access_key: ENV['SAUCE_ACCESS_KEY'],
                                selenium_version: '3.141.59'}}

    @browser = Watir::Browser.new :firefox, opts
  end

  def submit_results(browser, result)
    SauceWhisk::Jobs.change_status(browser.wd.session_id, result)
  end

  def build_name
   # return "Test Address Book Tests: Parallel"
    if ENV['TRAVIS_REPO_SLUG']
      "#{ENV['TRAVIS_REPO_SLUG'][%r{[^/]+$}]}: #{ENV['TRAVIS_JOB_NUMBER']}"
    else
      "Test Address Book Tests: Local-#{ENV['SAUCE_START_TIME'].to_i || Time.now.to_i}"
    end
  end
end
