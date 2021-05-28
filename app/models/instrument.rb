# frozen_string_literal: true

class Instrument < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: {maximum: 64}

  has_many :profile_instruments, dependent: :destroy, class_name: "::ProfileInstrument"
  has_many :profiles, through: :profile_instruments
end
