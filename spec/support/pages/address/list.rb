module AddressBook
  class AddressList < Page::Base

    page_url { "http://localhost:3000/addresses" }


    # Define elements representing contents of page
    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }


  end
end
