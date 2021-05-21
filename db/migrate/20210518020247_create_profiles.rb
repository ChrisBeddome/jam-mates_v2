# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, null: false

      t.timestamps
    end
  end
end
