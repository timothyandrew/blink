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
  resources :notes, controller: "general_notes"
  resources :lesson_plans do
    member do
      get :quick_edit
    end
    resources :items, controller: "lesson_plan_items" do
      collection do
        post :duplicate
      end
    end
  end

  get '/bingo', controller: 'bingo', action: 'generate'
  resource :form_generator

  resources :pictures
end
