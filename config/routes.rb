Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users

  resources :students do
    resources :goals
  end
end
