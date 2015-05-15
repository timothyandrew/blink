Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users

  resources :students do
    resource :notes, controller: "student_notes"
    resources :goals do
      member do
        put :complete
        put :uncomplete
      end
    end
  end

  resources :goals, controller: "goals_summary"
  resource :notes, controller: "general_notes"
end
