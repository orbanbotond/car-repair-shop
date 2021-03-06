# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API => "api"

  root "index#welcome"

  scope constraints: lambda { |r| r.env["warden"].user.nil? } do
    get "signup", to: "users#new", as: "signup"
    get "login", to: "sessions#new", as: "login"
    post "login", to: "sessions#create", as: "authenticate"
  end
end
