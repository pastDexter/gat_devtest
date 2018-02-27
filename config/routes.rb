Rails.application.routes.draw do
  namespace :v1 do
    namespace :private do
      resources :locations, only: :index
    end
  end
end
