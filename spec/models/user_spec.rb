# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build :user, attrs }
  let(:valid_attrs) {
    {email: "tony@macaroni.com", password: "password123"}
  }

  context "with valid attributes" do
    let(:attrs) { valid_attrs }
    it "is valid" do
      expect(user).to be_valid
    end
  end

  context "without email" do
    let(:attrs) { valid_attrs.merge({email: nil}) }
    it "is invalid" do
      expect(user).to be_invalid
    end
  end

  context "with incorrectly formatted email" do
    let(:attrs) { valid_attrs.merge({email: "invalid_email_address"}) }
    it "is invalid" do
      expect(user).to be_invalid
    end
  end

  context "without password" do
    let(:attrs) { valid_attrs.merge({password: nil}) }
    it "is invalid" do
      expect(user).to be_invalid
    end
  end

  context "with password < 6 characters" do
    let(:attrs) { valid_attrs.merge({password: "12345"}) }
    it "is invalid" do
      expect(user).to be_invalid
    end
  end

  describe "#destroy" do
    let!(:user) { create :user }
    let!(:profile) { create(:profile, user: user) }
    it "should destroy associated profile" do
      expect { user.destroy }.to change { Profile.count }.by(-1)
    end
  end
end
