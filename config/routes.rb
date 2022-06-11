Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'pages#home'

  get 'search', to: 'questionnaires#search'
  resources :questionnaires, except: [:show]
  scope 'questionnaires' do
    get ':id', to: 'questionnaires#show', as: 'quest'
    post ':id/score', to: 'student_grades#save_score'
    get ':id/grades', to: 'questionnaires#grades', as: 'grades'
    patch ':id/grades', to: 'questionnaires#grades_update', as: 'gradesedit'
  end
end
