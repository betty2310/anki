Rails.application.routes.draw do
  devise_for :users, path: 'auth',
             path_names: { sign_in: 'login', sign_out: 'logout',
                           password: 'secret', confirmation: 'verification',
                           unlock: 'unblock', registration: 'register',
                           sign_up: 'register'
             },
             controllers: { sessions: 'users/sessions',
                            registrations: 'users/registrations'
             }
  resources :decks
end
