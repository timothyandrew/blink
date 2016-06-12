Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "students#index"

  resources :students do
    resources :audits, controller: "student_audits"
    resource :notes, controller: "student_notes"
    member do
      get 'generate_iep_template', controller: 'iep_templates', action: 'generate'
    end

    collection do
      put 'reorder'
    end

    resources :goals do
      collection do
        post :quick_create
        get :tree
        put :reorder
      end

      member do
        resource :duplicate, controller: "duplicate_goals", as: :duplicate_goal
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

  resources :bingo_cards, controller: 'bingo'
  resource :form_generator
  resource :housie, controller: 'housie'
  resources :pictures

  resources :number_name_games do
    member do
      get :play
    end
  end

  resources :picture_comprehension_exercises do
    member do
      put :reorder
      get :play
    end
  end
end
