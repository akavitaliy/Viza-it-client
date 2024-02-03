require 'ferrum'
require 'socket'

class MyWebScraper
  def initialize    
    @browser = Ferrum::Browser.new(
    browser_path: '/usr/bin/google-chrome', 
    headless: false, 
    browser_options: { "disable-blink-features": "AutomationControlled", 'no-sandbox':nil, 'incognito':nil }, 
    process_timeout: 160,
    window_size: [1366, 768]   
)
  end

  def login_and_continue(url, username, password)
    @browser.go_to(url)
    gets
    fill_login_form(username, password)
    wait_for_signal
    # Продолжайте выполнение других действий после получения сигнала
    # Например, можно перейти на другую страницу и извлечь информацию.
  end

  private

  def fill_login_form(username, password)
    page = @browser
    page.at_css('input[name=email]').type(username)
    sleep 2
    page.at_css('input[name=pwd]').type(password, :Enter)
  end

  def wait_for_signal
    # Здесь можно реализовать ожидание сигнала от другого скрипта
    # Например, ждать определенного элемента на странице или другого события.
    # В данном примере, просто подождем 5 секунд:
    sleep 5
  end
end

# Пример использования:
scraper = MyWebScraper.new
scraper.login_and_continue('https://visa-it.tlscontact.com/by/msq/login.php', 'akavitaminman1@gmail.com', '123456123aKa!')
scraper.quit