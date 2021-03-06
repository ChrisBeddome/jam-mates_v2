# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_28_003547) do

  create_table "instruments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.text "bio"
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "profiles_instruments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "instrument_id", null: false
    t.index ["instrument_id", "profile_id"], name: "index_profiles_instruments_on_instrument_id_and_profile_id"
    t.index ["instrument_id"], name: "index_profiles_instruments_on_instrument_id"
    t.index ["profile_id", "instrument_id"], name: "index_profiles_instruments_on_profile_id_and_instrument_id"
    t.index ["profile_id"], name: "index_profiles_instruments_on_profile_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
