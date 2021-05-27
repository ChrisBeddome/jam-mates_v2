# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_one :profile
end
