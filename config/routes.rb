Rails.application.routes.draw do
  namespace :v1 do
    namespace :private do
      get 'locations/:country_code' => 'locations#index'
    end
  end
end
