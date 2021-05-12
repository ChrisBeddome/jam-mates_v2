# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthenticationTokenService do
  let(:payload) { {test_param: 123} }
  let(:token) { described_class.encode(payload, DateTime.now.end_of_hour) }
  let(:decoded_token) {
    JWT.decode(token,
               described_class::SECRET_KEY,
               true,
               {algorithm: described_class::ALGORITHM_TYPE})
  }
  describe ".encode" do
    it "returns an authentication token" do
      expect(decoded_token).to eq([
                                    {"test_param" => 123, "exp" => DateTime.now.end_of_hour.to_i},
                                    {"alg" => "HS256"}
                                  ])
    end
  end
  describe ".decode" do
    it "returns decoded token" do
      expect(described_class.decode(token)).to eq(decoded_token[0])
    end
  end
end
