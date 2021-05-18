# frozen_string_literal: true

class Profile < ApplicationRecord
  validates :user, presence: true, uniqueness: true
  belongs_to :user
end
