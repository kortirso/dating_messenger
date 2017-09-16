require 'watir'

# service for scraping sites
class ScrapingService
    attr_reader :url, :email, :password, :message, :browser

    def initialize(args = {})
        @url = args[:url]
        @email = args[:email]
        @password = args[:password]
        @message = args[:message]
        @profiles = []
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
            find_profile(profile_id)
        end

        browser.elements(class: 'onlinee').each do |elem|
            profile_id = elem.href.split('/')[-1].split('?')[0]
            find_profile(profile_id)
        end

        @profiles.each do |profile|
            send_message(profile)
        end
    end

    private

    def find_profile(profile_id)
        profile = Profile.find_or_create_by(profile_id: profile_id, from_site: url)
        if profile.new_one?
            profile.send_message
            @profiles.push(profile_id)
        end
    end

    def send_message(profile_id, online = false)
        # redirect to user profile
        link = "https://app2.c-date.com/index.html#/profile/#{profile_id}"
        link += '?from=Online' if online
        browser.goto(link)

        # wait send message button and click
        Watir::Wait.until { browser.div(class: 'state-profile').exists? }
        browser.elements(class: 'start-chat').first.click

        # set message
        browser.div(class: 'popup-send-message').textarea.set message

        # click for sending message
        browser.elements(class: 'button-primary').last.click

        # browser.goto('https://app2.c-date.com/index.html#')
        # Watir::Wait.until { !browser.elements(class: 'button-ghost').empty? }

        # wait for next request
        # sleep(5)
    end
end
