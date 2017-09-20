Rails.application.routes.draw do
    resources :scrape, only: %i[index create]

    namespace :api do
        namespace :v1 do
            resources :tasks, only: %i[index]
        end
    end

    root to: 'scrape#index'
end
