require 'ferrum'
require 'socket'

class Write
	def initialize(login, password, url)
		@login = login
		@password = password
		@url = url

    @browser = Ferrum::Browser.new(
    browser_path: "/usr/bin/google-chrome", 
    headless: false, 
    browser_options: { "disable-blink-features": "AutomationControlled", 'no-sandbox':nil, 'incognito':nil }, 
    process_timeout: 160,
    window_size: [1366, 768]        
    )
	end

  def write_start
    puts 'Старт'
    @browser.goto(@url)
    sleep 3
	end

  def write_login
    puts 'Вводим логин и пароль'
    loop do
      sleep 1   
      puts @browser.network.status           

      if @browser.at_css('.log_in_Register')           

        @browser.execute("window.scrollBy(0,100)")

        element_login = @browser.at_css('input[name=email]')
        element_login.focus
        element_login.type("#{@login}") 
  
        sleep 1
  
        element_pwd = @browser.at_css('input[name=pwd]')
        element_pwd.focus
        element_pwd.type("#{@password}")
  
        sleep 1
        #@browser.at_xpath('/html/body/div[3]/form/div/div[2]/div[1]').click
        puts "sleep 1 sec"
        sleep 1
        return puts 'Next'
      end
    end
  end

  def  write_login_correct
    if @browser.at_css('#login_form')
      write_login
    else
      puts 'Login: OK'
    end
  end


	def listen	
    puts 'Слушаем сервер'	
		server = TCPServer.new(2000)		
		client = server.accept		
		message = client.gets.chomp 

    index = message.to_i

		if message	
      @browser.at_xpath('/html/body/div[3]/form/div/div[2]/div[1]').click	
      sleep 3	
			@browser.at_css('.take_appointment').css('a')[index].click
		end			
	end
end


parser = Write.new('scoundrel98@gmail.com', '123456123aKa!', 'https://visa-it.tlscontact.com/by/msq/login.php')
parser.write_start
parser.write_login
#parser.write_login_correct
parser.listen