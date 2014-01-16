Nightzone::Application.routes.draw do

  controller :user_hints do
    post 'user_hints/', :to => 'user_hints#create'
    delete 'user_hints/:id', :to => 'user_hints#destroy'
  end

  controller :game_tasks do
    post 'game_tasks/', :to => 'game_tasks#create'
    delete 'game_tasks/:id', :to => 'game_tasks#destroy'
  end

  controller :code_compares do
    post 'code_compares/', :to => 'code_compares#create'
    delete 'code_compares/:id', :to => 'code_compares#destroy'
  end

  controller :user_tasks do
    post 'user_tasks/', :to => 'user_tasks#create'
    delete 'user_tasks/:id', :to => 'user_tasks#destroy'
  end

  resources :user_games

  controller :task_hints do
    post 'task_hints/', :to => 'task_hints#create'
    delete 'task_hints/:id', :to => 'task_hints#destroy'
  end

  controller :task_codes do
    post 'task_codes/', :to => 'task_codes#create'
    delete 'task_codes/:id', :to => 'task_codes#destroy'
  end

  resources :tasks

  controller :code_compares do
    post 'code_compares/', :to => 'code_compares#create'
    delete 'code_compares/:id', :to => 'code_compares#destroy'
  end

  controller :game_codes do
    post 'game_codes/', :to => 'game_codes#create'
    delete 'game_codes/:id', :to => 'game_codes#destroy'
  end

  controller :admin_games do
    post 'admin_games/', :to => 'admin_games#create'
    delete 'admin_games/:id', :to => 'admin_games#destroy'
  end

  resources :codes

  resources :hints

  resources :games

  devise_for :users
  get "home/index"
  controller :games do
      get "start_game/:id" => "games#start_game"
      get "finish_game/:id" => "games#finish_game"
  end

  controller :tasks do
    get "raise_hint/:id" => "tasks#raise_hint"
  end

  #get "home/game_tasks_compares"
  #post "home/create_code_compare"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root :to => "home#index"

end
