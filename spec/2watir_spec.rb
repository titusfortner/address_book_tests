require "spec_helper"

describe "Test in Series" do

  let(:browser) { @browser }

  it "Runs in serial with Watir" do
    browser.goto "https://address-book-example.herokuapp.com"
    browser.a(data_test: 'sign-in').click
    browser.a(data_test: 'sign-up').click
    email = "#{rand 10000000}@example.com"
    password = 'test1234'
    browser.text_field(id: "user_email").set email
    browser.text_field(id: "user_password").set password
    browser.button(data_test: 'submit').click
    expect(browser.span(data_test: 'current-user').text).to eq email
    browser.a(data_test: 'sign-out').click
    expect(browser.span(data_test: 'current-user')).not_to be_present
    browser.text_field(id: "session_email").set email
    browser.text_field(id: "session_password").set password
    browser.button(data_test: 'submit').click
    expect(browser.span(data_test: 'current-user')).to be_present
    browser.a(data_test: 'addresses').click
    browser.a(data_test: 'create').click
    browser.text_field(id: 'address_first_name').send_keys "First"
    browser.text_field(id: 'address_last_name').send_keys "Last"
    browser.text_field(id: 'address_line_1').send_keys "123 Main"
    browser.text_field(id: 'address_city').send_keys "London"
    browser.text_field(id: 'address_state').send_keys "Confusion"
    browser.text_field(id: 'address_zip_code').send_keys "0"
    browser.textarea(id: 'address_note').send_keys "Hi Mom"
    browser.button(data_test: 'submit').click
    expect(browser.p(id: 'notice').text).to eq 'Address was successfully created.'
    browser.a(data_test: 'list').click
    expect(browser.tbody.wait_until(&:present?).trs.size).to eq 1
    browser.a(text: 'Edit').click
    browser.text_field(id: 'address_first_name').clear
    browser.text_field(id: 'address_first_name').send_keys "Changed"
    browser.text_field(id: 'address_last_name').clear
    browser.text_field(id: 'address_last_name').send_keys "Name"
    browser.button(data_test: 'submit').click
    expect(browser.p(id: 'notice').text).to eq 'Address was successfully updated.'
    browser.a(data_test: 'list').click
    expect(browser.td.text).to eq "Changed"
    expect(browser.td(index: 1).text).to eq "Name"
    browser.a(text: 'Destroy').click
    browser.alert.ok
    expect(browser.p(id: 'notice').text).to eq 'Address was successfully destroyed.'
    expect(browser.tbody.trs.size).to eq 0
  end

end
