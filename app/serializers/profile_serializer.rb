# frozen_string_literal: true

class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :birth_date, :bio 
end
