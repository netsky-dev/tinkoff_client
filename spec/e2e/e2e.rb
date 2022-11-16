require "webdrivers"
require "selenium-webdriver"

class E2E
  def add_card(path:)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get(path)

    url = driver.current_url
    driver.find_element(id: "card-number__input").send_keys ENV["CARD_NUM"]
    driver.find_element(id: "card-logo").click
    wait.until { driver.find_element(id: "card-expiration__input") }

    driver.find_element(id: "card-expiration__input").send_keys ENV["EXP_DATE"], :return
    wait.until { url != driver.current_url }
    driver.close
  end
end
