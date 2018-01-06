module AddressBook
  module Model
    class Capabilities < ::ConfigModel

      key(:url) do
        credentials = SauceCredentials.create
        "https://#{credentials.sauce_username}:#{credentials.sauce_access_key}@ondemand.saucelabs.com:443/wd/hub"
      end

      key(:browser_name) { "chrome" }
      key(:version) {  }
      key(:platform) { "Windows 10" }

      key(:name) { "Unknown Test at #{Time.now.to_i}" }
      key(:build) { ENV['BUILD_TAG'] || "Unknown Build" }
      key(:tags) {  }

      key(:selenium_version) {  }
      key(:chromedriver_version) {  }
      key(:iedriver_version) {  }
      key(:passed) {  }
      key(:custom_data	) {  }
      key(:maxDuration) {  }
      key(:commandTimeout) {  }
      key(:idleTimeout) {  }
      key(:prerun) {  }
      key(:timeout) {  }
      key(:tunnelIdentifier) {  }
      key(:parentTunnel) {  }
      key(:screenResolution) {  }
      key(:timeZone) {  }
      key(:avoidProxy) {  }
      key(:public) {  }
      key(:recordVideo) {  }
      key(:videoUploadOnPass) {  }
      key(:recordScreenshots) {  }
      key(:recordLogs) {  }
      key(:captureHtml) {  }
      key(:priority) {  }
      key(:webdriverRemoteQuietExceptions) {  }

    end
  end
end
