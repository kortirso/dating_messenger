class ScrapeController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]

    def index; end

    def create
        ScrapeServiceJob.perform_later(scrape_params)
    end

    private

    def scrape_params
        params.permit(:url, :email, :password, :message).to_h
    end
end
