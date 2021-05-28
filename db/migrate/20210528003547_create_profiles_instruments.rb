# frozen_string_literal: true

class CreateProfilesInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles_instruments do |t|
      t.references :profile, null: false
      t.references :instrument, null: false
      t.index %i[profile_id instrument_id]
      t.index %i[instrument_id profile_id]
    end
  end
end
