# frozen_string_literal: true

class ProfileInstrument < ApplicationRecord
  self.table_name = "profiles_instruments"

  validates :profile, presence: true
  validates :instrument, presence: true
  validates :profile, uniqueness: {scope: :instrument}

  belongs_to :profile
  belongs_to :instrument
end
