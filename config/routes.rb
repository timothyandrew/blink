Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users

  resources :students do
    resource :notes, controller: "student_notes"
    resources :goals
  end

  resource :notes, controller: "general_notes"
end
