Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'

  get  'sign_up',  to: 'registration#new',   as: :sign_up
  post 'sign_up',  to: 'registration#create'
  get  'sign_in',  to: 'session#new',        as: :sign_in
  post 'sign_in',  to: 'session#create'
  get  'sign_out', to: 'session#destroy',    as: :sign_out

  resources :orders, only: %i[index show create destroy]
  resources :products do
    resources :reviews, only: %i[index create destroy]
  end
  resource  :user, only: %i[show update]

  post 'contact', to: 'static_pages#contact', as: :contact

  # This has to stay the last line in the file to not interfere with other
  # routes. This way, we can avoid the "static_pages" part of the route and turn
  # "/static_pages/about" into "/about"
  get ':static_page_id', to: 'static_pages#index', as: :static_page
end
