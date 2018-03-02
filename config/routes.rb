Rails.application.routes.draw do
  namespace :v1 do
    namespace :private do
      resource :authorization, only: :create
      get 'locations/:country_code'     => 'locations#index'
      get 'target_groups/:country_code' => 'target_groups#index'
      post 'evaluate_target'            => 'target_evaluations#create'
    end
    namespace :public do
      get 'locations/:country_code' => 'locations#index'
      get 'target_groups/:country_code' => 'target_groups#index'
    end
  end
end
