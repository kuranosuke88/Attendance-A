Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get '/modify_basic_information', to: 'users#edit_info'
  
  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy'
  
  # 出勤中社員一覧
  get 'list_of_attendees', to: 'list_of_attendees#index'
  
  # 出勤社員一覧
  resources :bases
  
  resources :users do
      collection { post :import }
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/attendances_log'
      get 'attendances/edit_over_time'
      patch 'attendances/update_over_time'
      get 'attendances/edit_overtime_notice'
      get 'attendances/edit_superior_notice'
      get 'attendances/edit_attendance_notice'
    end
    resources :attendances, only: :update
  end
end
