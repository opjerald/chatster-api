Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }, skip: [:sessions, :registrations, :passwords]

  devise_scope :user do
    post 'users/sign_in', to: 'sessions#create'
    delete 'users/sign_out', to: 'sessions#destroy'
    put 'users', to: 'registrations#update'
    post 'users', to: 'registrations#create'
  end

  defaults format: :json do
    resources :users, only: [:index, :show]
    resources :rooms, only: [:index, :show, :create]
    resources :messages, only: [:create]
    post 'rooms/private', to: "rooms#create_private"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
