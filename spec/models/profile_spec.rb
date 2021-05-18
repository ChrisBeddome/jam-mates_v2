# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { build :profile, attrs }
  let(:valid_attrs) {
    {first_name: "Tony", last_name: "Macaroni", user: build(:user)}
  }

  context "with valid attributes" do
    let(:attrs) { valid_attrs }
    it "is valid" do
      expect(profile).to be_valid
    end
  end

  context "without first_name" do
    let(:attrs) { valid_attrs.merge({first_name: nil}) }
    it "is valid" do
      expect(profile).to be_valid
    end
  end

  context "without last_name" do
    let(:attrs) { valid_attrs.merge({last_name: nil}) }
    it "is valid" do
      expect(profile).to be_valid
    end
  end

  context "without user" do
    let(:attrs) { valid_attrs.merge({user: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end
end
