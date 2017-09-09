class ScrapeController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]

    def index; end

    def create
        ScrapingService.new(scrape_params).scrape
    end

    private

    def scrape_params
        params.permit(:url, :email, :password)
    end
end
