require "spec_helper"

describe "Test in Series" do

  let(:browser) { @browser }
  let(:driver) { @browser.wd }

  it "Runs in serial with Selenium" do
    driver.get "https://address-book-example.herokuapp.com"
    driver.first(css: "a[data-test='sign-in']").click
    sleep 0.5
    driver.first(css: "a[data-test='sign-up']").click
    email = "#{rand 10000000}@example.com"
    password = 'test1234'
    sleep 0.5
    driver.first(id: "user_email").send_keys email
    driver.first(id: "user_password").send_keys password
    driver.first(css: "input[data-test='submit']").click
    expect(driver.first(css: "span[data-test='current-user']").text).to eq email
    driver.first(css: "a[data-test='sign-out']").click
    expect(driver.all(css: "a[data-test='current-user']")).to be_empty
    driver.first(id: "session_email").send_keys email
    driver.first(id: "session_password").send_keys password
    driver.first(css: "input[data-test='submit']").click
    expect(driver.all(css: "span[data-test='current-user']")).not_to be_empty
    driver.first(css: "a[data-test='addresses']").click
    sleep 0.5
    driver.first(css: "a[data-test='create']").click
    sleep 1
    driver.first(id: 'address_first_name').send_keys "First"
    driver.first(id: 'address_last_name').send_keys "Last"
    driver.first(id: 'address_line_1').send_keys "123 Main"
    driver.first(id: 'address_city').send_keys "London"
    driver.first(id: 'address_state').send_keys "Confusion"
    driver.first(id: 'address_zip_code').send_keys "0"
    driver.first(id: 'address_note').send_keys "Hi Mom"
    driver.first(css: "input[data-test='submit']").click
    expect(driver.first(id: 'notice').text).to eq 'Address was successfully created.'
    driver.first(css: "a[data-test='list']").click
    sleep 0.5
    expect(driver.all(css: 'tbody tr').size).to eq 1
    driver.first(css: 'tbody td:nth-child(6) a').click
    sleep 0.5
    driver.first(id: 'address_first_name').clear
    driver.first(id: 'address_first_name').send_keys "Changed"
    driver.first(id: 'address_last_name').clear
    driver.first(id: 'address_last_name').send_keys "Name"
    driver.first(css: "input[data-test='submit']").click
    expect(driver.first(id: 'notice').text).to eq 'Address was successfully updated.'
    driver.first(css: "a[data-test='list']").click
    sleep 0.5
    expect(driver.first(css: 'td').text).to eql "Changed"
    expect(driver.first(css: 'td:nth-child(2)').text).to eql "Name"
    driver.first(css: 'td:nth-child(7) a').click
    driver.switch_to.alert.accept
    expect(driver.first(id: 'notice').text).to eq 'Address was successfully destroyed.'
    expect(driver.all(css: 'tbody tr')).to be_empty
  end

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

  let(:sign_in_page) { SignIn.new }
  let(:sign_up_page) { SignUp.new }
  let(:nav_bar) { NavBar.new }
  let(:address_list_page) { AddressList.new }
  let(:new_address_page) { NewAddress.new }
  let(:edit_address_page) { EditAddress.new }
  let(:show_address_page) { AddressShow.new }

  it 'uses watir drops' do
    Home.visit.sign_in_link
    sign_in_page.sign_up_link
    user = User.new
    sign_up_page.submit_form(user)
    expect(nav_bar.signed_in_user).to eq user.email

    nav_bar.sign_out_user
    expect(nav_bar.logged_in?).to eq false

    sign_in_page.submit_form(user)
    expect(nav_bar.logged_in?).to eq true

    nav_bar.addresses_link
    address_list_page.new_address_link
    address = new_address_page.submit_form
    expect(show_address_page.created_message?).to eq true
    expect(show_address_page.address?(address)).to eq true

    show_address_page.follow_list
    expect(address_list_page.number_addresses).to eq 1
    expect(address_list_page.present?(address)).to eq true

    address_list_page.follow_edit(address)
    edited_address = edit_address_page.submit_form
    expect(show_address_page.updated_message?).to eq true
    expect(show_address_page.address?(edited_address)).to eq true

    show_address_page.follow_list
    address_list_page.destroy(edited_address)
    expect(address_list_page.destroyed_message?).to eq true
    expect(address_list_page.present?(address)).to eq false
  end

end
