# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authentication, path: :auth do
    collection do
      post :register
    end
  end
end
