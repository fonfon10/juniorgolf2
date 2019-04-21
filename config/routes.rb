Rails.application.routes.draw do
  resources :user_types
  resources :tournaments
  resources :levels
  resources :genders
  resources :categories
  resources :courses
  resources :provinces
  resources :countries
  resources :tours

  root to: "tournaments#index"

      devise_for :users, controllers: {
        sessions: 'users/sessions', 
        registrations: 'users/registrations'
      }


resources :tournaments do 
      member do
        put "registered", to: "tournaments#registered"
        put "in_consideration", to: "tournaments#in_consideration"
        put "wait_listed", to: "tournaments#wait_listed"
        put "donot_attend", to: "tournaments#donot_attend"
      end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
