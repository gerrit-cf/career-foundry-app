Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'

  get  'sign_in',  to: 'sessions#new',     as: :login
  post 'sign_in',  to: 'sessions#create'
  get  'sign_out', to: 'sessions#destroy', as: :logout

  resources :products
  resources :orders, only: %i[index show create destroy]

  post 'contact', to: 'static_pages#contact', as: :contact

  # This has to stay the last line in the file to not interfere with other
  # routes. This way, we can avoid the "static_pages" part of the route and turn
  # "/static_pages/about" into "/about"
  get ':static_page_id', to: 'static_pages#index', as: :static_page
end
