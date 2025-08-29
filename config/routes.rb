# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  # Page d'accueil et dashboard directeur
  root to: "pages#home"
  get "dashboard", to: "dashboards#control"
  
  # Lien public professeur (par token)
  get  "/r/:token",        to: "responses#show",   as: :respond
  post "/r/:token/answer", to: "responses#answer", as: :answer
  
  authenticate :user, ->(u) { u.admin? } do
    mount Trestle::Engine => "/admin", as: :trestle_admin  # 👈 change le nom ici
  end
  # Admin "classique" (si tu n'utilises pas Trestle monté sur /admin)
  namespace :backoffice do
    resources :schools do
      member do
        post   :impersonate
        delete :stop_impersonating
      end
    end
    resources :themes do
      resources :questions
    end
    resources :message_templates
  end
  
  # Espace directeur
  # (si tu fais simple avec current_school il n'est pas nécessaire de nester sous :schools)
  resources :surveys, only: [ :new, :create, :show ] do
    member do
      post :launch
      post :remind
      post :close
      get  :report
    end
  end
  
  resources :teachers do
    collection do
      post :import
      get  :import_preview
    end
  end
  
  resource :school_settings, only: [ :edit, :update ]
  
  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
end
