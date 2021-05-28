# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:user) { create :user }
  let(:token_for_user) { AuthenticationTokenService.encode(user_id: user.id) }
  let(:valid_profile_params) {
    {
      user_id: user.id,
      first_name: "Tony",
      birth_date: "1990-11-17",
      latitude: 45,
      longitude: 90
    }
  }

  subject { response }

  describe "POST" do
    before(:each) do
      post("/profiles",
           headers: {Authorization: auth_header},
           params: {profile: profile_params})
    end

    context "when no access token given" do
      let(:profile_params) { valid_profile_params }
      let(:auth_header) { nil }
      it { is_expected.to have_http_status :unauthorized }
    end

    context "when invalid access token given" do
      let(:profile_params) { valid_profile_params }
      let(:auth_header) { "INVALID_TOKEN" }
      it { is_expected.to have_http_status :unauthorized }
    end

    context "when valid access token given" do
      context "when access token user does not match user_id param" do
        let(:user2) { create :user }
        let(:token_for_user2) { AuthenticationTokenService.encode(user_id: user2.id) }
        let(:profile_params) { valid_profile_params }
        let(:auth_header) { "Bearer #{token_for_user2}" }
        it { is_expected.to have_http_status :unauthorized }
      end

      context "when access token user matches user_id param" do
        let(:auth_header) { "Bearer #{token_for_user}" }
        context "when no profile param passed" do
          let(:profile_params) { nil }
          it { is_expected.to have_http_status :unprocessable_entity }
        end

        context "when profile params passed" do
          context "with valid params" do
            let(:profile_params) { valid_profile_params }
            let(:auth_header) { "Bearer #{token_for_user}" }
            it { is_expected.to have_http_status :created }
            it "contains correct data in response body" do
              expect(JSON.parse(response.body)).to eq({
                                                        "profile" => {
                                                          "id" => user.profile.id,
                                                          "user_id" => user.id,
                                                          "first_name" => "Tony",
                                                          "birth_date" => "1990-11-17",
                                                          "bio" => nil
                                                        }
                                                      })
            end
          end
        end
      end
    end
    context "new_user" do
      let(:user2) { create :user }
      let(:token_for_user2) { AuthenticationTokenService.encode(user_id: user2.id) }
      let(:auth_header) { "Bearer #{token_for_user2}" }
      let(:profile_params) { nil }
      it "creates a new record" do
        expect {
          post("/profiles",
               headers: {Authorization: auth_header},
               params: {profile: valid_profile_params.merge(user_id: user2.id)})
        }.to change {
               Profile.count
             }.by(1)
      end
    end
  end
end
