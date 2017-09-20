require 'watir'

# service for scraping sites
class ScrapingService
    attr_reader :task, :browser, :profiles

    def initialize(args = {})
        @task = args[:task]
        @profiles = []
    end

    def scrape
        @browser = Watir::Browser.new :chrome, headless: true

        # login
        browser.goto(task.url)
        browser.link(text: /LOGIN/).click
        browser.text_field(name: 'email').set task.email
        browser.text_field(name: 'password').set task.password
        browser.button(value: 'login').click

        # get all profiles
        Watir::Wait.until { !browser.elements(class: 'button-ghost').empty? }
        browser.button(class: 'button-ghost').click

        # select left side profiles
        browser.elements(class: 'contact-normal').each do |elem|
            profile_id = elem.id.split('_')[-1]
            find_profile(profile_id)
        end

        # select right side profiles
        browser.elements(class: 'onlinee').each do |elem|
            profile_id = elem.href.split('/')[-1].split('?')[0]
            find_profile(profile_id)
        end

        profiles.sample(2).each do |profile|
            send_message(profile)
        end

        task.complete
    end

    private

    def find_profile(profile_id)
        profile = Profile.find_by(profile_id: profile_id, from_site: task.url)
        if profile.nil?
            profile = Profile.create(profile_id: profile_id, from_site: task.url, task_id: task.id)
            profiles.push(profile)
        end
    end

    def send_message(profile)
        # redirect to user profile
        link = "https://app2.c-date.com/index.html#/profile/#{profile.profile_id}"
        browser.goto(link)

        # wait send message button and click
        Watir::Wait.until { browser.div(class: 'state-profile').exists? }
        browser.elements(class: 'start-chat').first.click

        # set message
        browser.div(class: 'popup-send-message').textarea.set task.message

        # click for sending message
        browser.elements(class: 'button-primary').last.click

        # update profile
        profile.send_message

        # wait for next request
        sleep(3 + rand(3))
    end
end
