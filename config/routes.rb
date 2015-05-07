Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users

  resources :students do
    resources :long_term_goals do
      resources :short_term_goals
    end
  end
end
