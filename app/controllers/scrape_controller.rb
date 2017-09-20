class ScrapeController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]

    def index; end

    def create
        Task.create(scrape_params)
        redirect_to root_path
    end

    private

    def scrape_params
        params.permit(:url, :email, :password, :message)
    end
end
