require 'watir'

# service for scraping sites
class ScrapingService
    attr_reader :url, :email, :password, :browser

    def initialize(args = {})
        @url = args[:url]
        @email = args[:email]
        @password = args[:password]
    end

    def scrape
        @browser = Watir::Browser.start url
        browser.link(text: /LOGIN/).click
        browser.text_field(name: 'email').set email
        browser.text_field(name: 'password').set password
        browser.button(value: 'login').click

        Watir::Wait.until { !browser.elements(class: 'button-ghost').empty? }
        browser.button(class: 'button-ghost').click

        browser.elements(class: 'contact-normal').each do |elem|
            profile_id = elem.id.split('_')[-1]
            Profile.create profile_id: profile_id, from_site: url
        end

        browser.elements(class: 'onlinee').each do |elem|
            profile_id = elem.href.split('/')[-1].split('?')[0]
            Profile.create profile_id: profile_id, from_site: url
        end
    end

    private

    def send_message
        # click on user's link
        # TODO: change it to real link's text
        browser.link(text: 'EGDCFF83, 31').click

        # wait send message button and click
        Watir::Wait.until { !browser.elements(class: 'start-chat').empty? }
        browser.elements(class: 'start-chat').first.click

        # set message
        browser.div(class: 'popup-send-message').textarea.set 'Hi, I want to chat with you'

        # click for sending message
        browser.elements(class: 'button-primary').last.click

        # return to main page
        browser.elements(class: 'ourLogo').first.click
    end

    def save_to_file(from_scrape)
        filename = "#{Rails.root}/public/uploads/index.html"
        File.write(filename, from_scrape)
    end
end
