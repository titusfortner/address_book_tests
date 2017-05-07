class AddressShow < WatirDrops::PageObject

  page_url { |address| "https://address-book-example.herokuapp.com/addresses/#{address.id}" }

  element(:list) { browser.a(data_test: 'list') }
  element(:edit) { browser.a(data_test: 'edit') }

  element(:notice) { browser.p(id: 'notice') }
  element(:first_name) { browser.span(data_test: 'first_name') }
  element(:last_name) { browser.span(data_test: 'last_name') }
  element(:line_1) { browser.span(data_test: 'line_1') }
  element(:line_2) { browser.span(data_test: 'line_2') }
  element(:city) { browser.span(data_test: 'city') }
  element(:state) { browser.span(data_test: 'state') }
  element(:zip_code) { browser.span(data_test: 'zip_code') }
  element(:country) { browser.span(data_test: 'country') }
  element(:birthday) { browser.span(data_test: 'birthday') }
  element(:note) { browser.span(data_test: 'note') }

  def follow_list
    list.click
  end

  def updated_message?
    notice.text == "Address was successfully updated."
  end

  def created_message?
    notice.text == "Address was successfully created."
  end

  def address?(address)
    on_page? && address == to_address
  end

  def to_address
    hash = Address.keys.each_with_object({}) do | sym, hash |
      hash[sym] = send(sym).text
    end
    Address.new hash
  end

  def on_page?
    list.present?
  end
end


