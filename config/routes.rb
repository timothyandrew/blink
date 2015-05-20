Rails.application.routes.draw do
  root to: "students#index"
  devise_for :users

  resources :students do
    resources :audits, controller: "student_audits"
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
  resources :lesson_plans do
    resources :items, controller: "lesson_plan_items"
  end

  get '/bingo', controller: 'bingo', action: 'generate'

  resources :pictures
end
