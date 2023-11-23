Rails.application.routes.draw do
  root 'welcome#index'
  resources :students
  resources :courses do
    member do
      get 'enroll'
      post 'enroll_student'
    end
    member do
    delete 'remove_student/:student_id', to: 'courses#remove_student', as: :remove_student
  end
  end
end
