# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /create" do
    before(:each) do
      post("/users", params: {user: user_params})
    end

    subject { response }

    context "when no user param passed" do
      let(:user_params) { nil }
      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when user param passed" do
      let(:valid_user_params) { {first_name: "Test", last_name: "User", email: "test@user.com", password: "password"} }

      context "with valid params" do
        let(:user_params) { valid_user_params }
        it { is_expected.to have_http_status :created }
        it "should contain correct data in response body" do
          expect(JSON.parse(response.body)).to eq({
                                                    user: valid_user_params
                                                  })
        end
      end
    end
  end
end
