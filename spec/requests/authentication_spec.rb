# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication", type: :request do
  subject { response }

  describe "POST /register" do
    before(:each) do
      post("/auth/register", params: {user: user_params})
    end

    context "when no user params passed" do
      let(:user_params) { nil } 
      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when user param passed" do
      let(:valid_user_params) { {email: "test@user.com", password: "password"} }

      context "with invalid params" do
        let(:user_params) { valid_user_params.merge(password: "a") }
        it { is_expected.to have_http_status :unprocessable_entity }
      end

      context "with valid params" do
        let(:user_params) { valid_user_params }
        it { is_expected.to have_http_status :created }
        it "contains correct data in response body" do
          expect(JSON.parse(response.body)).to eq({
                                                    "user" => {
                                                      "id" => User.last.id,
                                                      "profile" => nil
                                                    }
                                                  })
        end
        it "creates a new record" do
          expect { post("/auth/register", params: {user: user_params.merge(email: "test@user2.com")}) }.to change {
                                                                                                             User.count
                                                                                                           }.by(1)
        end
      end
    end
  end

  describe "POST /login" do
    let!(:user) { create(:user, email: "test@user.com", password: "password") }
    before(:each) do
      post("/auth/login", params: {credentials: credential_params})
    end

    context "when no credential passed" do
      let(:credential_params) { nil }
      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when credentials passed" do
      let(:valid_credentials) { {email: "test@user.com", password: "password"} }

      context "with valid params" do
        let(:credential_params) { valid_credentials }
        it { is_expected.to have_http_status :ok }
        it "contains correct user data in response body" do
          expect(JSON.parse(response.body)["user"]).to eq({ 
                                                            "id" => User.last.id,
                                                            "profile" => nil
                                                          })
        end
        it "contains access token in response body with user id" do
          token = JSON.parse(response.body)["access_token"]
          expect(token).not_to be_nil
          expect(AuthenticationTokenService.decode(token)["user_id"]).to eq(user.id)
        end
      end
    end
  end
end
