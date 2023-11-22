Rails.application.routes.draw do
  root 'welcome#index'
  resources :students
  resources :courses do
    member do
      get 'enroll'
      post 'enroll_student'
    end
  end
end
