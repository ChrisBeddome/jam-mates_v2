# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    first_name      { "Test" }
    last_name       { "User" }
    user            { build(:user) }
  end
end
