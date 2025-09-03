# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  
  # Page d'accueil et dashboard directeur
  root to: "dashboards#index"
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
  
  # Route pour arrêter l'impersonate depuis n'importe où
  delete :stop_impersonating, to: 'backoffice/schools#stop_impersonating_global'
  
  # Espace directeur
  # (si tu fais simple avec current_school il n'est pas nécessaire de nester sous :schools)
  resources :surveys, only: [ :new, :create, :show ] do
    member do
      patch :launch
      post :remind
      patch :close
      get  :report
    end
  end
  
  resources :teachers do
    collection do
      post :import
      get  :import_preview
    end
  end
  
  resources :school_directors, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      post :invite
      post :resend_invitation
    end
  end
  
  resource :school_settings, only: [ :edit, :update ] do
    patch :toggle_theme
  end
  
  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
end
