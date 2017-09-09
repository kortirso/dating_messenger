Rails.application.routes.draw do
    resources :scrape, only: %i[index create]

    root to: 'scrape#index'
end
