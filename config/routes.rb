Rails.application.routes.draw do


  resources :cats
  resources :cat_rental_requests

  post '/cat_rental_requests/:id/approve' => 'cat_rental_requests#approve!',
        as: "approve_rental"
  post '/cat_rental_requests/:id/deny' => 'cat_rental_requests#deny!',
        as: "deny_rental"

  root 'cats#index'
end
