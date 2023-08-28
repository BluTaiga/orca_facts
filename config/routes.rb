Rails.application.routes.draw do
root 'facts#random_fact'

resources :facts

get '/random_fact', to: 'facts#random_fact'
end
