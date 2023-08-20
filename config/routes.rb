Rails.application.routes.draw do
root 'facts#index'

resources :facts
end
