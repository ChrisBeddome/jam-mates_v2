# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:user) { create :user }
  let(:token_for_user) { AuthenticationTokenService.encode(user_id: user.id) }

  describe "POST /create" do
    before(:each) do
      post("/profiles",
           headers: {Authorization: auth_header},
           params: {profile: profile_params})
    end

    subject { response }

    context "when no access token given" do
      let(:profile_params) { nil }
      let(:auth_header) { nil }
      it { is_expected.to have_http_status :unauthorized }
    end

    context "when invalid access token given" do
      let(:profile_params) { nil }
      let(:auth_header) { "INVALID_TOKEN" }
      it { is_expected.to have_http_status :unauthorized }
    end

    context "when valid access token given" do
      let(:auth_header) { "Bearer #{token_for_user}" }
      context "when no profile param passed" do
        let(:profile_params) { nil }
        it { is_expected.to have_http_status :unprocessable_entity }
      end

      # context "when profile params passed" do
      #   let(:valid_profile_params) {
      #     {
      #       user_id: user.id,
      #       first_name: "Tony",
      #       birth_date: "17/11/1990",
      #       latitude: 45,
      #       longitude: 90
      #     }
      #   }

      #   context "with valid params" do
      #     let(:profile_params) { valid_user_params }
      #     it { is_expected.to have_http_status :created }
      #     it "contains correct data in response body" do
      #       expect(JSON.parse(response.body)).to eq({
      #                                                 "user" => {
      #                                                   "email" => "test@user.com",
      #                                                   "id" => User.last.id,
      #                                                   "profile" => nil
      #                                                 }
      #                                               })
      #     end
      #     it "creates a new record" do
      #       expect { post("/auth/register", params: {user: user_params.merge(email: "test@user2.com")}) }.to change {
      #                                                                                                          User.count
      #                                                                                                        }.by(1)
      #     end
      #   end
      # end
    end
  end
end
