module AddressBook
  class Home < AddressBook::Base

    page_url { "http://localhost:3000" }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:current_user) {  }
    element(:logout) {  }

  end
end
