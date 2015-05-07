Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users
end
