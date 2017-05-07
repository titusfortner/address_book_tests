class NewAddress < WatirDrops::PageObject

  page_url { "https://address-book-example.herokuapp.com/addresses/new" }

  element(:first_name) { browser.text_field(id: 'address_first_name') }
  element(:last_name) { browser.text_field(id: 'address_last_name') }
  element(:line_1) { browser.text_field(id: 'address_line_1') }
  element(:city) { browser.text_field(id: 'address_city') }
  element(:state) { browser.text_field(id: 'address_state') }
  element(:zip_code) { browser.text_field(id: 'address_zip_code') }
  element(:note) { browser.textarea(id: 'address_note') }
  element(:submit) { browser.button(data_test: 'submit') }

  def submit_form(address = nil)
    address ||= Address.new
    fill_form(address)
    submit.click
    browser.wait_while { on_page? }
    address.tap { |a| a.id = browser.url[/\d+$/]}
  end

  def on_page?
    browser.url == page_url
  end
end



