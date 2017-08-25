Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products
  resources :orders, only: %i[index show create destroy]

  get 'home', to: 'landing_page#index', as: :landing_page

  # This has to stay the last line in the file to not interfere with other
  # routes. This way, we can avoid the "static_pages" part of the route and turn
  # "/static_pages/about" into "/about"
  get ':static_page_id', to: 'static_pages#index', as: :static_page
end
