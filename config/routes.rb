Rails.application.routes.draw do


  get 'dashboards/index'

  get 'home/Index'

  resources :user_types
#  resources :tournaments
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
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }


resources :dashboards do
  member do
    put "toggle_ovga_team", to: "dashboards#toggle_ovga_team"
    put "toggle_rogc_team", to: "dashboards#toggle_rogc_team"
    put "toggle_operator_user", to: "dashboards#toggle_operator_user"
  end
end

post '/tournaments/create_notes' => 'tournaments#create_notes'
get '/tournaments/newnotes' => 'tournaments#newnotes'

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
