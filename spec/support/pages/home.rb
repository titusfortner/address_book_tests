module AddressBook
  class Home < Page::Base

    page_url { "#{Site.base_url}/" }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:current_user) {  }
    element(:logout) {  }

  end
end
