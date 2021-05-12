# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe ".current_user" do
    let(:user) { create(:user) }
    context "if no authorization header is present" do
      it "should return nil" do
        expect(subject.current_user).to be_nil
      end
    end
    context "if auth header is present" do
      before(:each) { request.headers["Authorization"] = auth_header }
      context "if authorization header is formatted incorrectly" do
        let(:auth_header) { "invalid_format" }
        it "should return nil" do
          expect(subject.current_user).to be_nil
        end
      end
      context "if token in invalid" do
        let(:auth_header) { "Bearer invalid_token" }
        it "should return nil" do
          expect(subject.current_user).to be_nil
        end
      end
      context "if token does not map to a user" do
        let(:token) {
          JWT.encode({user_id: -1}, AuthenticationTokenService::SECRET_KEY,
                     AuthenticationTokenService::ALGORITHM_TYPE)
        }
        let(:auth_header) { "Bearer #{token}" }
        it "should return nil" do
          expect(subject.current_user).to be_nil
        end
      end
      context "if token does map to a user" do
        let(:token) {
          JWT.encode({user_id: user.id}, AuthenticationTokenService::SECRET_KEY,
                     AuthenticationTokenService::ALGORITHM_TYPE)
        }
        let(:auth_header) { "Bearer #{token}" }
        it "should return user" do
          expect(subject.current_user).to eq(user)
        end
      end
    end
  end
end
