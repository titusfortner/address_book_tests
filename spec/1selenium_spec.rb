require "spec_helper"

describe "Test in Series" do

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
end
