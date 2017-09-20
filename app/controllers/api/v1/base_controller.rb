module Api
    module V1
        class BaseController < ApplicationController
            protect_from_forgery with: :null_session, if: -> { request.format.json? }
        end
    end
end
