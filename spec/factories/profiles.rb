# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    first_name      { "Test" }
    last_name       { "User" }
    birth_date      { Date.current - 20.years }
    bio             { "I'm a musician :D" }
    latitude        { 50 }
    longitude       { 50 }
    user            { build(:user) }
  end
end
