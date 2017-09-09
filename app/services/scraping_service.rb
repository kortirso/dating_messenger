require 'watir'

# service for scraping sites
class ScrapingService
    attr_reader :url, :email, :password

    def initialize(args = {})
        @url = args[:url]
        @email = args[:email]
        @password = args[:password]
    end

    def scrape
        browser = Watir::Browser.start url
        browser.link(text: /LOGIN/).click
        browser.text_field(name: 'email').set email
        browser.text_field(name: 'password').set password
        browser.button(value: 'login').click

        Watir::Wait.until { !browser.elements(class: 'button-ghost').size.empty? }
        browser.button(class: 'button-ghost').click

        puts "Users online - #{browser.elements(class: 'onlinee').size}"
        puts "Can start chat with users - #{browser.elements(class: 'start-chat').size}"
    end

    private

    def save_to_file(from_scrape)
        filename = "#{Rails.root}/public/uploads/index.html"
        File.write(filename, from_scrape)
    end
end
