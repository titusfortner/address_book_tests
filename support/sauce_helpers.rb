module SauceHelpers
  def initialize_driver(name)
    @name = name
    capabilities = {name: @name,
                    build: ENV['BUILD_TAG'] ||= "Unknown Build - #{Time.now.to_i}"}
    capabilities[:browserName] = ENV['browserName'] if ENV['browserName']

    capabilities[:platform] = ENV['platform'] if ENV['platform']
    capabilities[:version] = ENV['version'] if ENV['version']

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    @browser = Watir::Browser.new :remote, {url: url,
                                            desired_capabilities: capabilities}
  end

  def submit_results(session_id, result)
    SauceWhisk::Jobs.change_status(session_id, result)
  end

  def start_applitools
    return unless ENV['APPLITOOLS_ACCESS_KEY']
    require 'eyes_selenium'
    @eyes = Applitools::Eyes.new.tap { |eyes| eyes.api_key = ENV['APPLITOOLS_ACCESS_KEY'] }
  end

  def stop_applitools
    return if @eyes.nil?
    @eyes.test(app_name: 'Applitools',
               test_name: @name,
               viewport_size: {width: 1008, height: 615},
               driver: @browser.wd) do
      # Visual validation point #1
      @eyes.check_window('Main Page')
    end
  end
end
