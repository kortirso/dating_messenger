class ScrapeController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]

    def index; end

    def create; end
end
