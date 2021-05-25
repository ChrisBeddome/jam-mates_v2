# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:user) { create :user }
  let(:profile) { build :profile, attrs }
  let(:valid_attrs) {
    {
      first_name: "Tony",
      last_name: "Macaroni",
      birth_date: Date.new(1990),
      latitude: 30,
      longitude: -50,
      user: user
    }
  }

  context "with valid attributes" do
    let(:attrs) { valid_attrs }
    it "is valid" do
      expect(profile).to be_valid
    end
  end

  context "without first_name" do
    let(:attrs) { valid_attrs.merge({first_name: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "first name too long" do
    let(:attrs) { valid_attrs.merge({first_name: (0..65).map {|_x| "a" }.join}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "without last_name" do
    let(:attrs) { valid_attrs.merge({last_name: nil}) }
    it "is valid" do
      expect(profile).to be_valid
    end
  end

  context "last name too long" do
    let(:attrs) { valid_attrs.merge({last_name: (0..65).map {|_x| "a" }.join}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "without birth_date" do
    let(:attrs) { valid_attrs.merge({birth_date: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "with bio" do
    context "bio too long" do
      let(:attrs) { valid_attrs.merge({bio: (1..1501).map {|_x| "a" }.join}) }
      it "is invalid" do
        expect(profile).to be_invalid
      end
    end
    context "with valid bio" do
      let(:attrs) { valid_attrs.merge({bio: (1..1500).map {|_x| "a" }.join}) }
      it "is valid" do
        expect(profile).to be_valid
      end
    end
  end

  context "birth_date less than 18 years ago" do
    let(:attrs) { valid_attrs.merge({birth_date: Date.today - 17.years}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "without latitude" do
    let(:attrs) { valid_attrs.merge({latitude: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "latitude out of range" do
    invalid_lats = [-91, 91, 500, 500_000, -5535.55453, "pickle"]
    invalid_lats.each do |lat|
      let(:attrs) { valid_attrs.merge({latitude: lat}) }
      it "is invalid" do
        expect(profile).to be_invalid
      end
    end
  end

  context "without longitude" do
    let(:attrs) { valid_attrs.merge({longitude: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "longitude out of range" do
    invalid_longs = [-181, 180.1, 500, 500_000, -5535.55453, "pickle"]
    invalid_longs.each do |long|
      let(:attrs) { valid_attrs.merge({longitude: long}) }
      it "is invalid" do
        expect(profile).to be_invalid
      end
    end
  end

  context "without user" do
    let(:attrs) { valid_attrs.merge({user: nil}) }
    it "is invalid" do
      expect(profile).to be_invalid
    end
  end

  context "with user already taken" do
    let(:attrs) { valid_attrs }
    it "is invalid" do
      profile.save
      expect(build(:profile, valid_attrs)).to be_invalid
    end
  end
end
