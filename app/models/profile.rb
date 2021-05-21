# frozen_string_literal: true

class Profile < ApplicationRecord
  validates :user, presence: true, uniqueness: true
  validates :first_name, presence: true, length: {maximum: 64}
  validates :last_name, presence: false, length: {maximum: 64}
  validates :birth_date, presence: true
  validates :latitude, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}

  validate :age_of_majority, if: proc {|object| !object.errors.messages.keys.include?(:birth_date) }

  belongs_to :user

  private

  def age_of_majority
    errors.add(:birth_date, "Must be 18 or older") if birth_date > Date.today - 18.years
  end
end
