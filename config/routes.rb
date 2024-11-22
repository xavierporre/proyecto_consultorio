Rails.application.routes.draw do
  # Rutas de Devise para psicólogos
  devise_for :psicologos, controllers: { sessions: 'psicologos/sessions' }

  # Rutas para la comprobación de estado de la aplicación (útil para monitoreo)
  get "up" => "rails/health#show", as: :rails_health_check

  # Rutas para el PWA (Progressive Web App)
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Rutas para citas disponibles
  resources :citas_disponibles do
    resources :reservas, only: [:new, :create,]
  end
  resources :reservas, only: [:index]
  # Rutas para los horarios
  resources :horarios, only: [:index, :new, :create, :update, :destroy]

  # Ruta raíz
  root 'citas_disponibles#index'
end
