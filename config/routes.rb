# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authentication, only: [], path: :auth do
    collection do
      post :register
      post :login
    end
  end

  resources :profiles, only: %i[show create update destroy]
end
